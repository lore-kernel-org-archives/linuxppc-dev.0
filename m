Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711071239v6e646590s906f22cb7a9564bb@mail.gmail.com>
Date: Wed, 7 Nov 2007 15:39:00 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: mpc5200, sysctl table check failed
In-Reply-To: <fa686aa40711071233x7f892d20g41449cd1e8a34dd4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711071224v7bf643bahba0fd23eb2d16ee1@mail.gmail.com>
	<fa686aa40711071233x7f892d20g41449cd1e8a34dd4@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/7/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 11/7/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > I'm porting mpc5200 support for the Phytec pcm030 onto current git
> > head. When booting I get this:
> >
> > sysctl table check failed: /kernel .1 Writable sysctl directory
> > Call Trace:
> > [c0817ee0] [c0008034] show_stack+0x50/0x184 (unreliable)
> > [c0817f00] [c003cfc8] set_fail+0x50/0x68
> > [c0817f20] [c003d630] sysctl_check_table+0x650/0x6a0
> > [c0817f50] [c002a9b8] register_sysctl_table+0x64/0xb4
> > [c0817f70] [c02dee70] register_powersave_nap_sysctl+0x18/0x2c
> > [c0817f80] [c02d81d0] kernel_init+0xb4/0x270
> > [c0817ff0] [c0011be0] kernel_thread+0x44/0x60
> >
> > What's going on? I get all the way through boot and user space doesn't
> > start, this is probably why.
>
> I see the same thing on the latest git (or at least latest as of last
> night); except for me I have no problem with userspace starting.  This
> is on a Xilinx Virtex 405.

Olof's patch fixes it.
http://patchwork.ozlabs.org/linuxppc/patch?id=14612

Phytec pcm030.c depended on mpc52xx_setup_cpu which got removed. I
fixed it up by copying the old version into pcm030.c. There must be
more to the fix.

/*
 * Phytec mpc5200b tiny (pcm030) board support
 *
 * Written by: Sascha Hauer <s.hauer@pengutronix.de>
 *
 * Copyright (C) 2006 Pengutronix
 *
 * Description:
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

#include <linux/stddef.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/errno.h>
#include <linux/reboot.h>
#include <linux/pci.h>
#include <linux/kdev_t.h>
#include <linux/major.h>
#include <linux/console.h>
#include <linux/delay.h>
#include <linux/seq_file.h>
#include <linux/root_dev.h>
#include <linux/initrd.h>

#include <asm/system.h>
#include <asm/atomic.h>
#include <asm/time.h>
#include <asm/io.h>
#include <asm/machdep.h>
#include <asm/ipic.h>
#include <asm/mpc52xx.h>
#include <asm/irq.h>
#include <asm/prom.h>
#include <asm/udbg.h>
#include <sysdev/fsl_soc.h>
#include <asm/qe.h>
#include <asm/qe_ic.h>
#include <asm/of_platform.h>
#include <linux/mtd/physmap.h>
#include <linux/platform_device.h>
#include <linux/fsl_devices.h>

#include <asm/mpc52xx.h>

static struct __iomem mpc52xx_gpt *gpt = NULL;

static void __init
mpc52xx_setup_cpu(void)
{
	struct mpc52xx_cdm  __iomem *cdm;
	struct mpc52xx_xlb  __iomem *xlb;

	/* needed for mpc52xx_restart */
	gpt = mpc52xx_find_and_map("mpc52xx-gpt");

	/* Map zones */
	cdm = mpc52xx_find_and_map("mpc5200-cdm");
	xlb = mpc52xx_find_and_map("mpc5200-xlb");

	if (!cdm || !xlb) {
		printk(KERN_ERR __FILE__ ": "
			"Error while mapping CDM/XLB during mpc52xx_setup_cpu. "
			"Expect some abnormal behavior\n");
		goto unmap_regs;
	}

	/* Use internal 48 Mhz */
	out_8(&cdm->ext_48mhz_en, 0x00);
	out_8(&cdm->fd_enable, 0x01);
	if (in_be32(&cdm->rstcfg) & 0x40)	/* Assumes 33Mhz clock */
		out_be16(&cdm->fd_counters, 0x0001);
	else
		out_be16(&cdm->fd_counters, 0x5555);

	/* Configure the XLB Arbiter priorities */
	out_be32(&xlb->master_pri_enable, 0xff);
	out_be32(&xlb->master_priority, 0x11111111);

	/* Disable XLB pipelining */
	/* (cfr errate 292. We could do this only just before ATA PIO
	    transaction and re-enable it afterwards ...) */
	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);

	/* Unmap zones */
unmap_regs:
	if (cdm) iounmap(cdm);
	if (xlb) iounmap(xlb);
}

struct mpc52xx_gpio __iomem *mpc52xx_gpio=NULL;
struct mpc52xx_gpio_wkup __iomem *mpc52xx_wkpio=NULL;
EXPORT_SYMBOL(mpc52xx_gpio);
EXPORT_SYMBOL(mpc52xx_wkpio);

/*
 * Map the GPIO relevant register fix and global.
 * They will be used in the Pengutronix' GOIO framework
 * This is very PCM030 specific stuff!
 */
static void __init pcm030_gpio_setup(void)
{
	mpc52xx_gpio = mpc52xx_find_and_map("mpc52xx-gpio");
	if (mpc52xx_gpio == NULL) {
		printk(KERN_ERR "%s: Error while mapping GPIO register for port config. "
				"Expect some abnormal behavior\n",__FILE__);
		goto error;
	}

	mpc52xx_wkpio = mpc52xx_find_and_map("mpc52xx-gpio-wkup");
	if (mpc52xx_wkpio == NULL) {
		printk(KERN_ERR "%s: "
				"Error while mapping WAKEUP register for port config. "
				"Expect some abnormal behavior\n",__FILE__);
		goto error;
	}

	return;

error:
	if (mpc52xx_gpio != NULL)
		iounmap(mpc52xx_gpio);
	if (mpc52xx_wkpio != NULL)
		iounmap(mpc52xx_wkpio);
}

static void __init pcm030_setup_arch(void)
{
	struct device_node *np;

	if (ppc_md.progress)
		ppc_md.progress("pcm030_setup_arch()", 0);

	np = of_find_node_by_type(NULL, "cpu");
	if (np) {
		unsigned int *fp =
		    (int *)of_get_property(np, "clock-frequency", NULL);
		if (fp != 0)
			loops_per_jiffy = *fp / HZ;
		else
			loops_per_jiffy = 50000000 / HZ;
		of_node_put(np);
	}

	mpc52xx_setup_cpu();
	pcm030_gpio_setup();
}

static struct physmap_flash_data pcm030_flash_data = {
	.width	= 1,
};

static struct resource pcm030_flash_resource = {
	.start		= 0xff000000,
	.end		= 0xffffffff,
	.flags		= IORESOURCE_MEM,
};

static struct platform_device pcm030_flash = {
	.name		= "physmap-flash",
	.id		= 0,
	.dev		= {
				.platform_data	= &pcm030_flash_data,
			},
	.resource	= &pcm030_flash_resource,
	.num_resources	= 1,
};

#define MBAR_BASE 0xf0000000

static int __init pcm030_register_flash(void)
{
	void __iomem *mbar;
	unsigned int cs0;

	/*
	 * The pcm030 comes with different flash buswidths. Detect
	 * it by looking in the chipselect setup register
	 */
	mbar = ioremap(MBAR_BASE, 0x1000);
	if (!mbar)
		return -EINVAL;

	cs0 = in_be32(mbar + 0x300);

	iounmap(mbar);

	switch ((cs0 >> 8) & 0x3) {
	case 0:
		pcm030_flash_data.width = 1;
		break;
	case 1:
		pcm030_flash_data.width = 2;
		break;
	case 3:
		pcm030_flash_data.width = 4;
		break;
	}

	return platform_device_register(&pcm030_flash);
}

static void __init pcm030_init(void)
{
	pcm030_register_flash();
	mpc52xx_declare_of_platform_devices();
}

void pcm030_show_cpuinfo(struct seq_file *m)
{
	seq_printf(m, "vendor\t\t:	Phytec\n");
	seq_printf(m, "machine\t\t:	Phycore mpc5200b tiny (pcm030)\n");
}

/*
 * Called very early, MMU is off, device-tree isn't unflattened
 */
static int __init pcm030_probe(void)
{
	unsigned long node = of_get_flat_dt_root();

	if (!of_flat_dt_is_compatible(node, "fsl,pcm030"))
		return 0;

	return 1;
}

define_machine(pcm030) {
	.name 		= "pcm030",
	.probe 		= pcm030_probe,
	.setup_arch 	= pcm030_setup_arch,
	.restart	= mpc52xx_restart,
	.init           = pcm030_init,
	.init_IRQ 	= mpc52xx_init_irq,
	.get_irq 	= mpc52xx_get_irq,
	.show_cpuinfo	= pcm030_show_cpuinfo,
	.calibrate_decr	= generic_calibrate_decr,
};


-- 
Jon Smirl
jonsmirl@gmail.com
