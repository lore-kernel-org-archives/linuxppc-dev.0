Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6761DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Aug 2007 00:16:47 +1000 (EST)
In-Reply-To: <1185928568.21198.10.camel@server>
References: <1185928568.21198.10.camel@server>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EFF6CD19-4700-41CD-843F-9AF818F7DB82@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for Wind River SBC8641D board
Date: Wed, 1 Aug 2007 09:17:51 -0500
To: joe.hamman@embeddedspecialties.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 31, 2007, at 7:36 PM, Joe Hamman wrote:

> Add support for Wind River's SBC8641D reference board.

Is this a single core or dual core chip?

>
> Signed-off by: Joe Hamman <joe.hamman@embeddedspecialties.com>
>
> diff -purN -X dontdiff linux-2.6/arch/powerpc/boot/dts/sbc8641d.dts  
> linux-2.6-esi/arch/powerpc/boot/dts/sbc8641d.dts
> --- linux-2.6/arch/powerpc/boot/dts/sbc8641d.dts	1969-12-31  
> 18:00:00.000000000 -0600
> +++ linux-2.6-esi/arch/powerpc/boot/dts/sbc8641d.dts	2007-07-31  
> 13:15:15.000000000 -0500
> @@ -0,0 +1,160 @@
> +/*
> + * SBC8641D Device Tree Source
> + *
> + * Copyright 2007 Embedded Specialties, Inc.
> + * Joe Hamman joe.hamman@embeddedspecialties.com
> + *
> + * Copyright 2006 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +
> +/ {
> +	model = "SBC8641D";
> +	compatible = "mpc86xx";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8641@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <20>;	// 32 bytes
> +			i-cache-line-size = <20>;	// 32 bytes
> +			d-cache-size = <8000>;		// L1, 32K
> +			i-cache-size = <8000>;		// L1, 32K
> +			timebase-frequency = <0>;	// 33 MHz, from uboot
> +			bus-frequency = <0>;		// From uboot
> +			clock-frequency = <0>;		// From uboot
> +			32-bit;
> +		};

if this is really an 8641D I'd expect a 2nd cpu node.

> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <00000000 20000000>;	// 512M at 0x0
> +	};
> +
> +	soc8641@f8000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		device_type = "soc";
> +		ranges = <0 f8000000 00100000>;
> +		reg = <f8000000 00100000>;	// CCSRBAR 1M
> +		bus-frequency = <0>;
> +
> +		mdio@24520 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "mdio";
> +			compatible = "gianfar";
> +			reg = <24520 20>;
> +			phy1f: ethernet-phy@1f {
> +				reg = <1f>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy0: ethernet-phy@0 {
> +				reg = <0>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy1: ethernet-phy@1 {
> +				reg = <1>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy2: ethernet-phy@2 {
> +				reg = <2>;
> +				device_type = "ethernet-phy";
> +			};
> +		};
> +
> +		ethernet@24000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <24000 1000>;
> +			mac-address = [ 00 E0 0C 00 73 00 ];


> +			interrupts = <1d 2 1e 2 22 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy1f>;
> +		};
> +
> +		ethernet@25000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <25000 1000>;
> +			mac-address = [ 00 E0 0C 00 73 01 ];
> +			interrupts = <23 2 24 2 28 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy0>;
> +		};
> +		
> +		ethernet@26000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <26000 1000>;
> +			mac-address = [ 00 E0 0C 00 02 FD ];
> +			interrupts = <1F 2 20 2 21 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy1>;
> +		};
> +
> +		ethernet@27000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <27000 1000>;
> +			mac-address = [ 00 E0 0C 00 03 FD ];
> +			interrupts = <25 2 26 2 27 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy2>;
> +		};
> +
> +		serial@4500 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4500 100>;
> +			clock-frequency = <0>;
> +			interrupts = <2a 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		serial@4600 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4600 100>;
> +			clock-frequency = <0>;
> +			interrupts = <1c 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		mpic: pic@40000 {
> +			clock-frequency = <0>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <40000 40000>;
> +			built-in;
> +			compatible = "chrp,open-pic";
> +			device_type = "open-pic";
> +			big-endian;
> +		};
> +	};
> +};

[snip]

> diff -purN -X dontdiff linux-2.6/arch/powerpc/platforms/86xx/ 
> Kconfig linux-2.6-esi/arch/powerpc/platforms/86xx/Kconfig
> --- linux-2.6/arch/powerpc/platforms/86xx/Kconfig	2007-07-31  
> 10:15:36.000000000 -0500
> +++ linux-2.6-esi/arch/powerpc/platforms/86xx/Kconfig	2007-07-31  
> 10:36:45.000000000 -0500
> @@ -10,6 +10,12 @@ config MPC8641_HPCN
>  	help
>  	  This option enables support for the MPC8641 HPCN board.
>
> +config SBC8641D
> +	bool "Wind River SBC8641D"
> +	select DEFAULT_UIMAGE
> +	help
> +	  This option enables support for the SBC8641D board.
> +
>  endchoice
>
>  config MPC8641
> @@ -18,3 +24,4 @@ config MPC8641
>  	select PPC_UDBG_16550
>  	select MPIC
>  	default y if MPC8641_HPCN
> +	default y if SBC8641D
> diff -purN -X dontdiff linux-2.6/arch/powerpc/platforms/86xx/ 
> Makefile linux-2.6-esi/arch/powerpc/platforms/86xx/Makefile
> --- linux-2.6/arch/powerpc/platforms/86xx/Makefile	2007-07-31  
> 10:15:36.000000000 -0500
> +++ linux-2.6-esi/arch/powerpc/platforms/86xx/Makefile	2007-07-31  
> 10:37:30.000000000 -0500
> @@ -4,3 +4,4 @@
>
>  obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
>  obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
> +obj-$(CONFIG_SBC8641D)		+= sbc8641d.o
> diff -purN -X dontdiff linux-2.6/arch/powerpc/platforms/86xx/ 
> sbc8641d.c linux-2.6-esi/arch/powerpc/platforms/86xx/sbc8641d.c
> --- linux-2.6/arch/powerpc/platforms/86xx/sbc8641d.c	1969-12-31  
> 18:00:00.000000000 -0600
> +++ linux-2.6-esi/arch/powerpc/platforms/86xx/sbc8641d.c	2007-07-31  
> 15:55:59.000000000 -0500
> @@ -0,0 +1,206 @@
> +/*
> + * SBC8641D board specific routines
> + *
> + * Copyright 2007 Embedded Specialties, Inc.
> + * Joe Hamman <joe.hamman@embeddedspecialties.com>
> + *
> + * Recode: ZHANG WEI <wei.zhang@freescale.com>
> + * Initial author: Xianghua Xiao <x.xiao@freescale.com>
> + *
> + * Copyright 2006 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/delay.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/system.h>
> +#include <asm/time.h>
> +#include <asm/machdep.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/mpc86xx.h>
> +#include <asm/prom.h>
> +#include <mm/mmu_decl.h>
> +#include <asm/udbg.h>
> +#include <asm/i8259.h>
> +#include <asm-generic/rtc.h>
> +#include <asm/mpic.h>
> +
> +#include <sysdev/fsl_soc.h>
> +
> +#include "mpc86xx.h"
> +#include "sbc8641d.h"
> +
> +#define DEBUG
> +
> +#ifdef DEBUG
> +#define DBG(fmt...) do { printk(KERN_ERR fmt); } while(0)
> +#else
> +#define DBG(fmt...) do { } while(0)
> +#endif
> +
> +/* unsigned long isa_io_base = 0;
> +unsigned long isa_mem_base = 0;
> +unsigned long pci_dram_offset = 0; */
> +
> +
> +void __init
> +sbc8641d_init_irq(void)
> +{
> +	struct mpic *mpic1;
> +	struct device_node *np;
> +	struct resource res;
> +
> +	/* Determine PIC address. */
> +	np = of_find_node_by_type(NULL, "open-pic");
> +	if (np == NULL)
> +		return;
> +	of_address_to_resource(np, 0, &res);
> +
> +	/* Alloc mpic structure and per isu has 16 INT entries. */
> +	mpic1 = mpic_alloc(np, res.start,
> +			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
> +			16, NR_IRQS - 4,
> +			" MPIC     ");
> +	BUG_ON(mpic1 == NULL);
> +
> +	mpic_assign_isu(mpic1, 0, res.start + 0x10000);
> +
> +	/* 48 Internal Interrupts */
> +	mpic_assign_isu(mpic1, 1, res.start + 0x10200);
> +	mpic_assign_isu(mpic1, 2, res.start + 0x10400);
> +	mpic_assign_isu(mpic1, 3, res.start + 0x10600);
> +
> +	/* 16 External interrupts
> +	 * Moving them from [0 - 15] to [64 - 79]
> +	 */
> +	mpic_assign_isu(mpic1, 4, res.start + 0x10000);
> +

look at a 2.6.22-rc1 kernel to see how this has changed.  It also  
effects the .dts interrupt numbers.  Please match how the mpc8641hpcn  
does things.

> +	mpic_init(mpic1);
> +
> +}
> +
> +
> +static void __init
> +sbc8641d_setup_arch(void)
> +{
> +	struct device_node *np;
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("sbc8641d_setup_arch()", 0);
> +
> +	np = of_find_node_by_type(NULL, "cpu");
> +	if (np != 0) {
> +		const unsigned int *fp;
> +
> +		fp = get_property(np, "clock-frequency", NULL);
> +		if (fp != 0)
> +			loops_per_jiffy = *fp / HZ;
> +		else
> +			loops_per_jiffy = 50000000 / HZ;
> +		of_node_put(np);
> +	}

git ride of this code to find loops_per_jiffy.

> +
> +	printk("SBC8641D board from Wind River Systems\n");
> +
> +#ifdef CONFIG_SMP
> +	mpc86xx_smp_init();
> +#endif
> +}
> +
> +
> +void
> +sbc8641d_show_cpuinfo(struct seq_file *m)
> +{
> +	struct device_node *root;
> +	uint memsize = total_memory;
> +	const char *model = "";
> +	uint svid = mfspr(SPRN_SVR);
> +
> +	seq_printf(m, "Vendor\t\t: Wind River Systems\n");
> +
> +	root = of_find_node_by_path("/");
> +	if (root)
> +		model = get_property(root, "model", NULL);
> +	seq_printf(m, "Machine\t\t: %s\n", model);
> +	of_node_put(root);
> +
> +	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
> +	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
> +}
> +

This is mostly redundant with the basic show cpu info, do you need  
your own?

> +
> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +static int __init sbc8641d_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (of_flat_dt_is_compatible(root, "mpc86xx"))
> +		return 1;	/* Looks good */

the check you have is too generic, you probably need something more  
specific in the top level compatible property.

> +
> +	return 0;
> +}
> +
> +
> +void
> +sbc8641d_restart(char *cmd)
> +{
> +	void __iomem *rstcr;
> +
> +	rstcr = ioremap(get_immrbase() + MPC86XX_RSTCR_OFFSET, 0x100);
> +
> +	local_irq_disable();
> +
> +	/* Assert reset request to Reset Control Register */
> +	out_be32(rstcr, 0x2);
> +
> +	/* not reached */
> +}
> +
> +
> +long __init
> +sbc8641d_time_init(void)
> +{
> +	unsigned int temp;
> +
> +	/* Set the time base to zero */
> +	mtspr(SPRN_TBWL, 0);
> +	mtspr(SPRN_TBWU, 0);
> +
> +	temp = mfspr(SPRN_HID0);
> +	temp |= HID0_TBEN;
> +	mtspr(SPRN_HID0, temp);
> +	asm volatile("isync");
> +
> +	return 0;
> +}
> +
> +
> +define_machine(sbc8641d) {
> +	.name			= "SBC8641D",
> +	.probe			= sbc8641d_probe,
> +	.setup_arch		= sbc8641d_setup_arch,
> +	.init_IRQ		= sbc8641d_init_irq,
> +	.show_cpuinfo		= sbc8641d_show_cpuinfo,
> +	.get_irq		= mpic_get_irq,
> +	.restart		= sbc8641d_restart,
> +	.time_init		= sbc8641d_time_init,
> +	.calibrate_decr		= generic_calibrate_decr,
> +	.progress		= udbg_progress,
> +
> +#ifdef CONFIG_GEN_RTC
> +	/* RTC interface, using functions in include/asm-generic/rtc.h */
> +	.get_rtc_time		= get_rtc_time,
> +	.set_rtc_time		= set_rtc_time,
> +#endif
> +};
> diff -purN -X dontdiff linux-2.6/arch/powerpc/platforms/86xx/ 
> sbc8641d.h linux-2.6-esi/arch/powerpc/platforms/86xx/sbc8641d.h
> --- linux-2.6/arch/powerpc/platforms/86xx/sbc8641d.h	1969-12-31  
> 18:00:00.000000000 -0600
> +++ linux-2.6-esi/arch/powerpc/platforms/86xx/sbc8641d.h	2007-07-31  
> 15:57:01.000000000 -0500
> @@ -0,0 +1,24 @@
> +/*
> + * SBC8641D board definitions
> + *
> + * Copyright 2007 Embedded Specialties, Inc.
> + * Joe Hamman <joe.hamman@embeddedspecialties.com>
> + *
> + * Copyright 2006 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + *
> + * Author: Xianghua Xiao <x.xiao@freescale.com>
> + */
> +
> +#ifndef __SBC8641D_H__
> +#define __SBC8641D_H__
> +
> +#include <linux/init.h>
> +
> +#define MPC86XX_RSTCR_OFFSET	(0xe00b0)	/* Reset Control Register */
> +
> +#endif	/* __SBC8641D_H__ */
> diff -purN -X dontdiff linux-2.6/drivers/net/gianfar.h linux-2.6- 
> esi/drivers/net/gianfar.h
> --- linux-2.6/drivers/net/gianfar.h	2007-07-31 10:15:39.000000000  
> -0500
> +++ linux-2.6-esi/drivers/net/gianfar.h	2007-07-31  
> 10:39:10.000000000 -0500
> @@ -131,7 +131,7 @@ extern const char gfar_driver_version[];
>  #define DEFAULT_RXCOUNT	16
>  #define DEFAULT_RXTIME	4
>
> -#define TBIPA_VALUE		0x1f
> +#define TBIPA_VALUE		0x1e

we need to turn this into a config option or something.

>  #define MIIMCFG_INIT_VALUE	0x00000007
>  #define MIIMCFG_RESET           0x80000000
>  #define MIIMIND_BUSY            0x00000001
>
