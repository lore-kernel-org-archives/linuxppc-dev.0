Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id BD056DDEAB
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 14:30:51 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7fc919fce0761f861be3069a853d3169@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Fri, 1 Jun 2007 23:30:32 -0500
To: Mark A. Greer <mgreer@mvista.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat Jun 2 09:20:22 EST 2007,  Mark A. Greer wrote:

> Find the "rom" device for the prpmc2800 and create a device for it.
> The device will be picked up by the code in 
> drivers/mtd/maps/physmap_of.c
> and will setup MTD on that FLASH device.
...
>  /*
> + * Register a platform device for MTD.
> + */
> +static int __init prpmc2800_register_mtd(void)
> +{
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(NULL, "rom", "direct-mapped");
> +       of_platform_device_create(np, np->name, NULL);
> +}
> +arch_initcall(prpmc2800_register_mtd);
>

I think "direct-mapped" as compatible is a bit too broad or vague.

The compatible is supposed to be useable to find and match a driver
without regard to the name of the node.  Perhaps direct-mapped-rom?
(as opossed to a direct-mapped-ram, sram, or some width flash bank).

Actually, looking back at your device tree {1], your list several
properties for flash, including bank-width and partition names.
Perhaps first compatible should be direct-mapped-partitioned-flash,
direct-mapped-partitioned-rom, direct-mapped-rom  (to me a
direct-mapped-rom driver would expose one section of address space
read-only). I'm assuming that your driver for this "direct-mapped"
device will look at these properties from the of device node and
call the mtd layer somewhat directly with their contents.

[1] http://ozlabs.org/pipermail/linuxppc-dev/2007-May/035858.html

milton

PS: I know you've posted this a few times.  I'm just behind in
my reading and  replying :-).
