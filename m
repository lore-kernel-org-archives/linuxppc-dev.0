Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 0A78DDDF24
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 22:35:04 +1000 (EST)
Message-ID: <46309CD9.1050403@ru.mvista.com>
Date: Thu, 26 Apr 2007 16:36:41 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Flat device tree definitions for FLASH and MTD partitioning
References: <4618D400.8050003@grandegger.com> <4618DBEF.30307@ru.mvista.com>
	<4618DE4A.4020404@ru.mvista.com> <462F4FD1.6080900@grandegger.com>
	<462F592F.7000409@ru.mvista.com> <462F5F86.3060309@grandegger.com>
	<462F6707.80502@ru.mvista.com> <4630611C.4060902@grandegger.com>
In-Reply-To: <4630611C.4060902@grandegger.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello.

Wolfgang Grandegger wrote:

>>>>>>>> are there already some thought or even example code on how to 
>>>>>>>> define Flash memory and MTD partitions in the DTS. This would 
>>>>>>>> avoid the ackward MTD partitioning via static structure or boot 
>>>>>>>> line argument and could be done in a generic way.

>>>>>>>     See Documentation/powerpc/booting-without-of.txt and 
>>>>>>> drivers/mtd/physmap_of.c for what's been already done.

>>>>>>    I meant drivers/mtd/maps/physmap_of.c

>>>>> I had a closer look to this driver. Unfortunately, it can not 
>>>>> handle yet  multiple FLASH banks. This could be achieved with an 
>>>>> additional property "bank_count". What do you think?

>>   Please use hyphen, not underscore in property names ("device_type" 
>> seems an only exception from this rule).
 
> Yes, I know and I also wondered why an "_" is used for the device type.

   Ask the OF spec. developers. :-)
 
>>>>  I'm not sure what banks you're talking about -- note that this 
>>>> driver is equivalen in functionality to the plain 'physmap' driver 
>>>> and there's inherited "bank-width" property that handles flash banking.

>>> Yes, I know. Nevertheless the driver cannot handle flash regions 
>>> composed of more than on FLASH bank because we need to probe every 
>>> bank. Search for "BANK" in drivers/mtd/maps" to understand what I mean.

>>   Hm, from what I could see, those banks are separate maps registered 
>> to MTD subsys separately.
>> What's the point of adding a count property when we simply can define 
>> multiple "rom" devices?
 
> To complete this thread, physmap_of can map _one_ FLASH region composed 
> of one or more FLASH banks. But it currently cannot map more than _one_ 
> FLASH region.

   I wodner why?! :-O

> It would be nice to extend it for multiple FLASH 
> definitions (could code it when time permits).

   I'm seeing nothing that prevents it from working now -- it should register as much "rom" devices as you supply via the device tree.

> Wolfgang.

MBR, Sergei
