classdef listenerExample < handle

    % This file defines a simple example class called "listenerExample"
    %
    % Prerequisites
    % If you aren't familiar with OO, first look at simpleOOexample. 
    % Also, you should look at anonymousFunctionExample.m and windowCloseFunction.m
    % if you aren't familiar with anonymous functions and callback functions.
    % You will probably need to read the documentation on listeners before this 
    % class will make sense:
    % http://www.mathworks.com/help/matlab/matlab_oop/learning-to-use-events-and-listeners.html
    %
    %
    % Purpose
    % Shows how to set up a listener and a notifier in an object. These features
    % are inherited from the abstract class handle. Listeners, notifiers, and 
    % callback functions are very commonly used in DAQ tasks and GUI building.
    %
    % 
    % To run this example:
    % >> L = listenerExample
    % >> L.populateProperty %refreshes the data and uses a listener/notifier to re-plot
    %
    %
    %
    % Rob Campbell - Basel 2016



    properties %open properties block
        exampleProperty %declare exampleProperty but don't populate it with anything
    end %close properties block


    events %open event definition block
        %Declare a notifier. This will be hit each time the exampleProperty property is refreshed with new example data
        examplePropertyPopulated
    end %close event definition block


    methods %open method definition block

        function obj=listenerExample
            obj.populateProperty %fill example property with random numbers

            %add a listener that plots the contents of exampleProperty when it has been updated
            addlistener(obj,'examplePropertyPopulated', @(src,eventData) obj.plotIt(src,eventData)); 

            % In the case above, we pass the source object and the event object. These aren't used for anything
            % here, but I show the full form above. If you wanted to ignore them, you could just do:
            %   addlistener(obj,'examplePropertyPopulated', @(~,~) obj.plotIt); 
            %  or:
            %   addlistener(obj,'examplePropertyPopulated', @obj.plotIt); 
        end %close listenerExample constructor


        function populateProperty(obj)
            obj.exampleProperty = randn(1,60);
            notify(obj,'examplePropertyPopulated') %This causes the notifier to "fire"
        end %close populateProperty


        function plotIt(obj,src,eventData)
            %This method makes a plot of obj.exampleProperty
            clf 
            plot(obj.exampleProperty,'-k')
            hold on 
            plot(obj.exampleProperty,'ok','MarkerFaceColor',[1,1,1]*0.5)
        end %close plotIt

    end %close method definition block


end %close listenerExample
