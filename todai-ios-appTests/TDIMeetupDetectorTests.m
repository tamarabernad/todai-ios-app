//
//  TDIMeetupDetectorTests.m
//  todai-ios-app
//
//  Created by Tamara Bernad on 01/04/14.
//  Copyright (c) 2014 Todai. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface TDIMeetupDetectorTests : XCTest

@end

@implementation TDIMeetupDetectorTests
- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void) testAsyncDetection{
    __block BOOL hasCalledBack = NO;
    
    void (^completionBlock)(void) = ^(void){
        NSLog(@"Completion Block!");
        hasCalledBack = YES;
    };
    
//    [MyObject doSomethingAsyncThenRunCompletionBlockOnMainQueue:completionBlock];
    
    // Repeatedly process events in the run loop until we see the callback run.
    
    // This code will wait for up to 10 seconds for something to come through
    // on the main queue before it times out. If your tests need longer than
    // that, bump up the time limit. Giving it a timeout like this means your
    // tests won't hang indefinitely.
    
    // -[NSRunLoop runMode:beforeDate:] always processes exactly one event or
    // returns after timing out.
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:10];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    if (!hasCalledBack)
    {
        STFail(@"I know this will fail, thanks");
    }
}
@end
