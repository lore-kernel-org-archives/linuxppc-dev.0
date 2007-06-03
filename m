Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9DB83DDF05
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 03:48:06 +1000 (EST)
In-Reply-To: <4662FA67.3020107@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<4662FA67.3020107@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a5dde31321a50ed198cf4fc199e4af9c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Sun, 3 Jun 2007 19:45:17 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I think "direct-mapped" as compatible is a bit too broad or vague.
>
>     It's actually not -- it means simple 1:1 address mapping (w/o 
> explicit
> byte-swapping and such).

Which has nothing to do with "compatible"; instead,
it is implied by the parent node have a "ranges"
property.  Or you can put some other property in
the flash node for all I care, if that seems
necessary for certain cases.

>> The compatible is supposed to be useable to find and match a driver
>> without regard to the name of the node.  Perhaps direct-mapped-rom?
>> (as opossed to a direct-mapped-ram, sram, or some width flash bank).
>
>     Note that we're matching by both "device_type" and "compatible".

Which is wrong.

>     This would serve no purpose, as the driver that would catches all 
> these is
> signle one, drivers/mtd/maps/physmap_of.c...

With the current kernel version, perhaps.  Did you check
out 2.6.28?  Does it work with that?


Segher
