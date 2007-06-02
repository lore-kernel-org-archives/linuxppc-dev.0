Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 025C1DDEBE
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 18:53:06 +1000 (EST)
In-Reply-To: <7fc919fce0761f861be3069a853d3169@bga.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Sat, 2 Jun 2007 10:53:00 +0200
To: Milton Miller <miltonm@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I think "direct-mapped" as compatible is a bit too broad or vague.
>
> The compatible is supposed to be useable to find and match a driver
> without regard to the name of the node.  Perhaps direct-mapped-rom?
> (as opossed to a direct-mapped-ram, sram, or some width flash bank).

"actual-name-of-the-chip", "cfi-command-set-#", "cfi" seems
like a good start.

> Actually, looking back at your device tree {1], your list several
> properties for flash, including bank-width and partition names.
> Perhaps first compatible should be direct-mapped-partitioned-flash,
> direct-mapped-partitioned-rom, direct-mapped-rom  (to me a
> direct-mapped-rom driver would expose one section of address space
> read-only). I'm assuming that your driver for this "direct-mapped"
> device will look at these properties from the of device node and
> call the mtd layer somewhat directly with their contents.

People here tried to create a generic "flash" device binding.
It didn't work out (part of the problem is its scope was way
too big; another problem is it was too Linux-mtd specific).

Now since the probing is done in platform-specific code here,
you don't *need* an "official" binding -- just get your
"compatible" prop right so you can correctly probe the device
node, and then maybe add some node-specific properties if you
need them.


Segher
