Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B29EEDE11D
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 04:00:45 +1100 (EST)
Message-ID: <47E93010.5090904@ru.mvista.com>
Date: Tue, 25 Mar 2008 20:02:08 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: OF compatible MTD platform RAM driver ?
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251651.42608.laurentp@cse-semaphore.com>
	<47E926FB.3030900@ru.mvista.com>
	<200803251744.46001.laurentp@cse-semaphore.com>
In-Reply-To: <200803251744.46001.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:

>>>>>We're talking about a very specific type of RAM, used for permanent storage 
>>>>>with a battery backup. The RAM is really meant to be used as an MTD device 
>>>>>and as such I think it makes sense to describe it as an mtd-compatible device 
>>>>>on the local bus.

>>>>>What about the following definition for the RAM node ?

>>>>>       nvram@2,0000 {

>>>>   Note that there's a OF "device_type" of "nvram", so your (generic) device 
>>>>name seems to add some mess. (IIRC, that OF device type didn't actually 
>>>>represent a "real" device, and only served to provide access to NVRAM for OF).

>>>Ok.

>>    Well, I might have gone too far here -- it should be a real device 
>>(spec'ed in Device Support Extensions recommended practice). It's just that 
>>the spec didn't mention "reg" property, only "#bytes" (the device capacity). 
>>So, it may be worth considering...

> The nvram device descrived in the Device Support Extensions is probably meant 
> to describe the kind of nvram found in RTC chips.

    Well, that is only an assumption -- actually, the sentense in the 
description of the "#bytes" prop about the typical size being from 4 to 32K 
speaks against it. The details of NVRAM implementation are hidden behind 
read/write/seek methods.

> That memory isn't directly accessible.

    That's what we have a "compatible" prop for. ;-)

> As the spec doesn't mention this explicitely we could still reuse 
> the nvram device type for direct-mapped battery-backed ram. I have no strong 
> opinion for or against that.

>>>>>               reg = <2 0x0000 0x00100000>;
>>>>>               bank-width = <2>;
>>>>>       };

>>>>>Or should the node have a device-type property of either 'ram' or 'rom' with 
>>>>>the compatible property just referencing MTD ?

>>>>   The "device_type" properties are not required and their further creation 

>>>>has been discouraged on liunxppc-dev.

>>>What about

>>>	mtdram@2,0000 {
>>>		compatible = "mtd-ram";
>>>		reg = <2 0x0000 0x00100000>;
>>>		bank-width = <2>;
>>>	};

>>>ROMs could use "mtd-rom" for their compatible property.

>>    Heh, there was a whole company against mentioning "mtd" when we started 
>>working on this (of course, the first idea was to call the flash device type 
>>"mtd"). I don't think "mtd" looks good here -- I'd suggest "flash-ram" (if 
>>this is just a linearly mapped NVRAM).

> I'm fine with "flash-ram" (even thought it looks a bit weird). I'll prepare a 
> patch.

    Yeah. I forgeot that "flash" means EEPROM. Actually, the main facts about 
the NVRAM that I'd want to be stated in the "compatible" property is that it's 
non-volatile and directly/lineraly mapped... Just "nvram" doesn't seem 
enopugh, maybe "linear-nvram" is. And we can specify "device_type" of "nvram" 
indeed (and #size).

> Best regards,

WBR, Sergei
