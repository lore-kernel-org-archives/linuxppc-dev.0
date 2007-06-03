Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 24A9BDDE49
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 03:27:40 +1000 (EST)
Message-ID: <4662FA67.3020107@ru.mvista.com>
Date: Sun, 03 Jun 2007 21:29:11 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7fc919fce0761f861be3069a853d3169@bga.com>
In-Reply-To: <7fc919fce0761f861be3069a853d3169@bga.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Milton Miller wrote:

>>Find the "rom" device for the prpmc2800 and create a device for it.
>>The device will be picked up by the code in 
>>drivers/mtd/maps/physmap_of.c
>>and will setup MTD on that FLASH device.

> ...

>> /*
>>+ * Register a platform device for MTD.
>>+ */
>>+static int __init prpmc2800_register_mtd(void)
>>+{
>>+       struct device_node *np;
>>+
>>+       np = of_find_compatible_node(NULL, "rom", "direct-mapped");
>>+       of_platform_device_create(np, np->name, NULL);
>>+}
>>+arch_initcall(prpmc2800_register_mtd);

> I think "direct-mapped" as compatible is a bit too broad or vague.

    It's actually not -- it means simple 1:1 address mapping (w/o explicit 
byte-swapping and such).

> The compatible is supposed to be useable to find and match a driver
> without regard to the name of the node.  Perhaps direct-mapped-rom?
> (as opossed to a direct-mapped-ram, sram, or some width flash bank).

    Note that we're matching by both "device_type" and "compatible".

> Actually, looking back at your device tree {1], your list several
> properties for flash, including bank-width and partition names.
> Perhaps first compatible should be direct-mapped-partitioned-flash,
> direct-mapped-partitioned-rom, direct-mapped-rom  (to me a
> direct-mapped-rom driver would expose one section of address space
> read-only).

    This would serve no purpose, as the driver that would catches all these is 
signle one, drivers/mtd/maps/physmap_of.c...

> I'm assuming that your driver for this "direct-mapped"
> device will look at these properties from the of device node and
> call the mtd layer somewhat directly with their contents.

    Yeah, it does.

> [1] http://ozlabs.org/pipermail/linuxppc-dev/2007-May/035858.html

> milton

> PS: I know you've posted this a few times.  I'm just behind in
> my reading and  replying :-).

WBR, Sergei
