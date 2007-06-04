Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 56FB8DDF0F
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 05:40:02 +1000 (EST)
Date: Mon, 4 Jun 2007 12:40:16 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Message-ID: <20070604194016.GC10612@mag.az.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7fc919fce0761f861be3069a853d3169@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 01, 2007 at 11:30:32PM -0500, Milton Miller wrote:
> On Sat Jun 2 09:20:22 EST 2007,  Mark A. Greer wrote:
> 
> >Find the "rom" device for the prpmc2800 and create a device for it.
> >The device will be picked up by the code in 
> >drivers/mtd/maps/physmap_of.c
> >and will setup MTD on that FLASH device.
> ...
> > /*
> >+ * Register a platform device for MTD.
> >+ */
> >+static int __init prpmc2800_register_mtd(void)
> >+{
> >+       struct device_node *np;
> >+
> >+       np = of_find_compatible_node(NULL, "rom", "direct-mapped");
> >+       of_platform_device_create(np, np->name, NULL);
> >+}
> >+arch_initcall(prpmc2800_register_mtd);
> >
> 
> I think "direct-mapped" as compatible is a bit too broad or vague.

It is.  Basically, all I was trying to do was fit with the code that was
already in drivers/mtd/maps/physmap_of.c.  I wasn't expecting to (re)trigger
the debate that it did.  Its a good thing, though.  FLASH/MTD
representation in the DT needs to get sorted out.

> The compatible is supposed to be useable to find and match a driver
> without regard to the name of the node.  Perhaps direct-mapped-rom?
> (as opossed to a direct-mapped-ram, sram, or some width flash bank).
> 
> Actually, looking back at your device tree {1], your list several
> properties for flash, including bank-width and partition names.
> Perhaps first compatible should be direct-mapped-partitioned-flash,
> direct-mapped-partitioned-rom, direct-mapped-rom  (to me a
> direct-mapped-rom driver would expose one section of address space
> read-only). I'm assuming that your driver for this "direct-mapped"
> device will look at these properties from the of device node and
> call the mtd layer somewhat directly with their contents.

The "driver" is already there, drivers/mtd/maps/physmap_of.c.  I
conjured up the DT node so it would work with that existing driver.

> PS: I know you've posted this a few times.  I'm just behind in
> my reading and  replying :-).

No problem.  I just missed an entire thread the was directed at me :-P

Mark
