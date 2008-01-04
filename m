Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E725DDE99
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 19:32:24 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JAhyX-00083z-45
	for linuxppc-embedded@ozlabs.org; Fri, 04 Jan 2008 00:32:21 -0800
Message-ID: <14612548.post@talk.nabble.com>
Date: Fri, 4 Jan 2008 00:32:21 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Reading a config file in a driver ....
In-Reply-To: <477D2CE0.1050806@kenati.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <14591717.post@talk.nabble.com> <20080103163019.GA4223@lixom.net>
	<477D2CE0.1050806@kenati.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


i appriciate your concept and i need to know this :-

The config should be in a structure or a bit mask . The user will have to
change the value whenever he needs to change the default config. Where
should i put that struct or bit field defination ???? He should know it
preciesly before he change ????

Can you share with me your Implimentation so that i could get the exactly
how you had done ...

----Misbah < ><

Carlos Munoz-2 wrote:
> 
> Olof Johansson wrote:
>> On Wed, Jan 02, 2008 at 09:03:20PM -0800, Misbah khan wrote:
>>   
>>> Hi all ....
>>>
>>> I am writing a LCD driver in which the default configuration for LCD
>>> would
>>> be loded at the Init . This default configuration if keep in the driver
>>> then
>>> for a change in default configuration we need to compile the driver
>>> which we
>>> never want . Hence we want a .config file in /etc/lcd.config dir which
>>> could
>>> be changed and the next boot will take this configuration as the default
>>> configuration. 
>>>
>>> I need to know How to read from the config file in the driver form the
>>> dir
>>> /etc/lcd.config. The driver would be installed at boot up 
>>>     
>>
>> The driver/kernel shouldn't read the file directly, if anything you
>> should have a userspace tool that reads it and adjusts the driver via
>> sysfs or similar. That tool can be run from some of the init scripts,
>> or from the ramdisk in case you want to do it early.
>>   
> What I've done in the past is to use module_param() to define variables 
> that get set when the module is loaded. Then all you need to do is edit 
> the /etc/modules file and change the parameter value. However, this 
> technique is only efficient if only a few parameters will ever change. 
> If you need to change more than a few parameters, Olof's suggestion 
> would be preferred.
> 
> Carlos
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Reading-a-config-file-in-a-driver-....-tp14591717p14612548.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
