//
//  ADAppDelegate.m
//  aloharDemo
//
//  Created by Sam Warmuth on 2/23/12.
//  Copyright (c) 2012 Alohar Mobile Inc.. All rights reserved.
//

#import "ADAppDelegate.h"

@implementation ADAppDelegate
@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //!IMPORTANT!
    //Before using the SDK, you need to register with Alohar first to get an unique ID.
    //if you have a UID before, you need to authenticate first.
    //
    //To register and authenticate, you need to register a new app at www.alohar.com/developer
    //and get an unique appID and apiKey
    
    NSString *appID = @"10";
    NSString *apiKey = @"2a2b3446ebd2af25633a9f600c1d8e8aa1d7b463";
    
    
    //There are two ways to register or authenticate
    //using delegate ALSessionDelegate

    if ([Alohar isLoggedIn]) {
        [Alohar startMonitoringUser];
    } else {
//        //To set a manual uid, use the method below to set the AloharDemoUserID to a custom ID
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            NSString *userToken = @"27f4547b2c586c809a3887658b5270a488184565";
//            [defaults setObject:userToken forKey:@"AloharDemoUserID"];
        NSString *userToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"AloharDemoUserID"];
        if (userToken == nil || userToken.length == 0){
            [Alohar registerWithAppID:appID andAPIKey:apiKey withDelegate:self];
        }else{
            [Alohar authenticateWithAppID:appID andAPIKey:apiKey andUserID:userToken withDelegate:self];
        }
    }
    return YES;
    
    //or you can use block
//    [Alohar authenticateWithAppID:appID andAPIKey:apiKey andUserID:userToken completeHandler:^(NSString *userToken, NSError *error) {
//        if (error) {
//            NSLog(@"Login failed %@", error);
//            return;
//        }
//        
//        NSLog(@"userToken=%@", userToken);
//        [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:@"AloharDemoUserID"];
//        [Alohar startMonitoringUser];
//    }];
    
}

- (void)aloharDidLogin:(NSString *)userToken
{
    [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:@"AloharDemoUserID"];
    [Alohar startMonitoringUser];
}

- (void)aloharDidFailWithError:(NSError *)error
{
    NSLog(@"Sorry, there was an error with alohar: %@", error);
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //Enable Auto-start 
    [Alohar enableAutoStart];
}

@end
