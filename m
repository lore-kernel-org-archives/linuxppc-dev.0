Subject: Re: [PATCH] make platform_init() weak for 8xx
From: Andreas Oberritter <obi@saftware.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040719163203.GA6813@smtp.west.cox.net>
References: <1090253615.1415.24.camel@shiva.saftware.de>
	 <20040719163203.GA6813@smtp.west.cox.net>
Content-Type: multipart/mixed; boundary="=-YCdSZC8PeWH+6DGiY08q"
Message-Id: <1090258468.1419.58.camel@shiva.saftware.de>
Mime-Version: 1.0
Date: Mon, 19 Jul 2004 19:34:28 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-YCdSZC8PeWH+6DGiY08q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-07-19 at 18:32, Tom Rini wrote:
> On Mon, Jul 19, 2004 at 06:13:35PM +0200, Andreas Oberritter wrote:
> > this patch renames platform_init to m8xx_init in m8xx_setup.c and adds
> > new weak platform_init, which can be overridden by boards to allow them
> > to e.g. register platform_devices like redwood5.c does for 40x.
>
> First, I don't see the redwood5 example you're talking about.

http://ppc.bkbits.net:8080/linuxppc-2.5/anno/arch/ppc/platforms/4xx/redwood5.c@1.11?nav=index.html

> Second, this takes us in the direction of 82xx.  Until the 82xx
> abstractions get flushed out a bit more, I remain unconvinced that
> they're really the right way to go (perhaps hooking the other direction
> would work better, e.g. platform_init() calls board_init(), with a weak
> version provided, and some functions forced to be provided by board.c,
> such as m8xx_map_io).

I chose this way because it seemed to be a simple way to port the dbox2
board to 2.6 using the new device API. Is there another 8xx board which
uses the device API for its onboard peripherials and can be used as a
reference? Can I get my devices registered without modifying
platform_init, or shall I send a patch with the board_init() you
mentioned? See my board.c attached.

Regards,
Andreas

--=-YCdSZC8PeWH+6DGiY08q
Content-Disposition: attachment; filename=dbox2.c
Content-Type: text/x-csrc; name=dbox2.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

/*
 * arch/ppc/platforms/dbox2.c
 *
 * setup routines for the dbox2 board
 *
 * Copyright (C) 2004 Andreas Oberritter <obi@linuxtv.org>
 *
 */

#include <linux/device.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <asm/commproc.h>
#include <asm/io.h>
#include <syslib/m8xx_setup.h>

enum dbox2_mid {
	MID_NOKIA	= 1,
	MID_PHILIPS	= 2,
	MID_SAGEM	= 3,
};

const char *manuf_name[3] = {
	"Nokia",
	"Philips",
	"Sagem",
};

static struct resource enx_resources[] = {
	[0] = {
		.start	= 0x08000000,
		.end	= 0x080033ff,
		.flags	= IORESOURCE_MEM,
	},
	[1] = {
		.start	= 0x09000000,
		.end	= 0x091fffff,
		.flags	= IORESOURCE_MEM,
	},
	[2] = {
		.start	= SIU_IRQ1,
		.end	= SIU_IRQ1,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct platform_device enx_device = {
	.name		= "enx",
	.id		= 0,
	.num_resources	= ARRAY_SIZE(enx_resources),
	.resource	= enx_resources,
};

static struct resource gtx_resources[] = {
	[0] = {
		.start	= 0x08400000,
		.end	= 0x08402fff,
		.flags	= IORESOURCE_MEM,
	},
	[1] = {
		.start	= 0x08000000,
		.end	= 0x081fffff,
		.flags	= IORESOURCE_MEM,
	},
	[2] = {
		.start	= SIU_IRQ1,
		.end	= SIU_IRQ1,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct platform_device gtx_device = {
	.name		= "gtx",
	.id		= 0,
	.num_resources	= ARRAY_SIZE(gtx_resources),
	.resource	= gtx_resources,
};

static struct resource fp_resources[] = {
	[0] = {
		.start	= SIU_IRQ2,
		.end	= SIU_IRQ2,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct platform_device fp_device = {
	.name		= "fp",
	.id		= 0,
	.num_resources	= ARRAY_SIZE(fp_resources),
	.resource	= fp_resources,
};

static struct resource cam_resources[] = {
	[0] = {
		.start	= 0x0c000000,
		.end	= 0x0c01ffff,
		.flags	= IORESOURCE_MEM,
	},
	[1] = {
		.start	= SIU_IRQ3,
		.end	= SIU_IRQ3,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct platform_device cam_device = {
	.name		= "cam",
	.id		= 0,
	.num_resources	= ARRAY_SIZE(cam_resources),
	.resource	= cam_resources,
};

static struct resource avia_resources[] = {
	[0] = {
		.start	= 0x0a000000,
		.end	= 0x0a0001ff,
		.flags	= IORESOURCE_MEM,
	},
	[1] = {
		.start	= SIU_IRQ4,
		.end	= SIU_IRQ4,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct platform_device avia_device = {
	.name		= "avia",
	.id		= 0,
	.num_resources	= ARRAY_SIZE(avia_resources),
	.resource	= avia_resources,
};

static struct platform_device *dbox2_devs[] __initdata = {
	&enx_device,
	&fp_device,
	&cam_device,
	&avia_device,
};

static int __init dbox2_add_devices(void)
{
	u8 *config_area;
	int manuf_id;

	config_area = ioremap(0x1001ffe0, 0x20);
	if (!config_area) {
		printk(KERN_ERR "dbox2: could not map config area!\n");
		return -EIO;
	}
	manuf_id = config_area[0];
	iounmap(config_area);

	if ((manuf_id < MID_NOKIA) || (manuf_id > MID_SAGEM)) {
		printk(KERN_ERR "dbox2: invalid config area!\n");
		return -EIO;
	}

	printk(KERN_INFO "dbox2: %s board detected.\n", manuf_name[manuf_id - 1]);

	if (manuf_id == MID_NOKIA) {
		dbox2_devs[0] = &gtx_device;
	} else if (manuf_id == MID_PHILIPS) {
		cam_resources[0].start += 0x40000;
		cam_resources[0].end += 0x40000;
	}

	return platform_add_devices(dbox2_devs, ARRAY_SIZE(dbox2_devs));
}

static void __init dbox2_setup_arch(void)
{
	m8xx_setup_arch();

	device_initcall(dbox2_add_devices);
}

void __init platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
			unsigned long r6, unsigned long r7)
{
	m8xx_init(r3, r4, r5, r6, r7);

	ppc_md.setup_arch = dbox2_setup_arch;
}


--=-YCdSZC8PeWH+6DGiY08q--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
