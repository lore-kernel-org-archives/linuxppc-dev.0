Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 8AB8ADE221
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 03:22:00 +1100 (EST)
Message-ID: <47E926FB.3030900@ru.mvista.com>
Date: Tue, 25 Mar 2008 19:23:23 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: OF compatible MTD platform RAM driver ?
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251536.17795.laurentp@cse-semaphore.com>
	<47E91A5B.1060406@ru.mvista.com>
	<200803251651.42608.laurentp@cse-semaphore.com>
In-Reply-To: <200803251651.42608.laurentp@cse-semaphore.com>
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

>>>We're talking about a very specific type of RAM, used for permanent storage 
>>>with a battery backup. The RAM is really meant to be used as an MTD device 
>>>and as such I think it makes sense to describe it as an mtd-compatible device 
>>>on the local bus.

>>>What about the following definition for the RAM node ?

>>>        nvram@2,0000 {

>>    Note that there's a OF "device_type" of "nvram", so your (generic) device 
>>name seems to add some mess. (IIRC, that OF device type didn't actually 
>>represent a "real" device, and only served to provide access to NVRAM for OF).

> Ok.

    Well, I might have gone too far here -- it should be a real device 
(spec'ed in Device Support Extensions recommended practice). It's just that 
the spec didn't mention "reg" property, only "#bytes" (the device capacity). 
So, it may be worth considering...

>>>                compatible = "mtd,ram";

>>    The part before comma should be a company name or a stock ticker. What did 
>>you mean here?

> I didn't know that. Let's say I meant "mtd-ram" :-)

>>>                reg = <2 0x0000 0x00100000>;
>>>                bank-width = <2>;
>>>        };

>>>Or should the node have a device-type property of either 'ram' or 'rom' with 
>>>the compatible property just referencing MTD ?

>>    The "device_type" properties are not required and their further creation 
>>has been discouraged on liunxppc-dev.

> What about

> 	mtdram@2,0000 {
> 		compatible = "mtd-ram";
> 		reg = <2 0x0000 0x00100000>;
> 		bank-width = <2>;
> 	};

> ROMs could use "mtd-rom" for their compatible property.

    Heh, there was a whole company against mentioning "mtd" when we started 
working on this (of course, the first idea was to call the flash device type 
"mtd"). I don't think "mtd" looks good here -- I'd suggest "flash-ram" (if 
this is just a linearly mapped NVRAM).

> Best regards,

WBR, Sergei
