Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0E1BDDE49
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 03:42:59 +1000 (EST)
In-Reply-To: <4662EAA9.70104@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>
	<4662EAA9.70104@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e4197fd2753f2b4d548d5dde9e3fd1d3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Sun, 3 Jun 2007 19:40:57 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> I think "direct-mapped" as compatible is a bit too broad or vague.
>
>>> The compatible is supposed to be useable to find and match a driver
>>> without regard to the name of the node.  Perhaps direct-mapped-rom?
>>> (as opossed to a direct-mapped-ram, sram, or some width flash bank).
>
>> "actual-name-of-the-chip", "cfi-command-set-#", "cfi" seems
>> like a good start.
>
>    No, it doesn't -- since that info is almost *absolutely* useless 
> (the only exception is "cfi") in the context of Linux MTD subsys.
>    Please, try to understand that knowing that chip is CFI compatible 
> in itself doesn't yet guarantee that you can access the chip -- it all 
> depends on its mapping to the real physical address range, therefore 
> this group IMO cannot even constitute a valid "compatible" property.

You obviously completely misunderstand the semantics
of the "compatible" property.

>> People here tried to create a generic "flash" device binding.
>> It didn't work out (part of the problem is its scope was way
>> too big; another problem is it was too Linux-mtd specific).
>
>    And that's why its worked, and the abstaractly "correct" scheme 
> wouldn't have.

Ha.  Ha.  Ha.  Great joke :-)

>> Now since the probing is done in platform-specific code here,
>> you don't *need* an "official" binding -- just get your
>> "compatible" prop right so you can correctly probe the device
>> node, and then maybe add some node-specific properties if you
>> need them.
>
>    I wonder what are you trying to get us to do: directly call stuff 
> from drivers/mtd/ or what (that's especially starnge because we now 
> have an OF driver for simply mapped NOR flashes)?

I am pointing out how to do a flash node in a platform-
specific way, in platform-specific code, since there is
no working "generic" way yet (and very likely there will
never be).


Segher
