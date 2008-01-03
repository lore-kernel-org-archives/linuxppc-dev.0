Return-Path: <carlos@kenati.com>
Received: from ims.2wire.com (ims.2wire.com [206.171.6.87])
	by ozlabs.org (Postfix) with ESMTP id AF029DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 05:55:50 +1100 (EST)
Message-ID: <477D2CE0.1050806@kenati.com>
Date: Thu, 03 Jan 2008 10:43:44 -0800
From: Carlos Munoz <carlos@kenati.com>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Reading a config file in a driver ....
References: <14591717.post@talk.nabble.com> <20080103163019.GA4223@lixom.net>
In-Reply-To: <20080103163019.GA4223@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Wed, Jan 02, 2008 at 09:03:20PM -0800, Misbah khan wrote:
>   
>> Hi all ....
>>
>> I am writing a LCD driver in which the default configuration for LCD would
>> be loded at the Init . This default configuration if keep in the driver then
>> for a change in default configuration we need to compile the driver which we
>> never want . Hence we want a .config file in /etc/lcd.config dir which could
>> be changed and the next boot will take this configuration as the default
>> configuration. 
>>
>> I need to know How to read from the config file in the driver form the dir
>> /etc/lcd.config. The driver would be installed at boot up 
>>     
>
> The driver/kernel shouldn't read the file directly, if anything you
> should have a userspace tool that reads it and adjusts the driver via
> sysfs or similar. That tool can be run from some of the init scripts,
> or from the ramdisk in case you want to do it early.
>   
What I've done in the past is to use module_param() to define variables 
that get set when the module is loaded. Then all you need to do is edit 
the /etc/modules file and change the parameter value. However, this 
technique is only efficient if only a few parameters will ever change. 
If you need to change more than a few parameters, Olof's suggestion 
would be preferred.

Carlos
