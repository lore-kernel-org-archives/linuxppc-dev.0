Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A333CDDDEA
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 14:20:59 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB73KtQv030159
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:20:55 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB73KtLr461810
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:20:55 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB73KtgX004373
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:20:55 -0500
Date: Thu, 6 Dec 2007 21:17:58 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 18/25] powerpc: Base support for 440GX Taishan eval board
Message-ID: <20071206211758.6f086161@zod.rchland.ibm.com>
In-Reply-To: <20071206080129.737E8DE09F@ozlabs.org>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080129.737E8DE09F@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 06 Dec 2007 19:00:18 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> From: Hugh Blemings <hugh@blemings.org>
> 
> 
> Signed-off-by: Hugh Blemings <hugh@blemings.org>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

> Index: linux-work/arch/powerpc/platforms/44x/Kconfig
> ===================================================================
> --- linux-work.orig/arch/powerpc/platforms/44x/Kconfig	2007-12-03 12:05:58.000000000 +1100
> +++ linux-work/arch/powerpc/platforms/44x/Kconfig	2007-12-03 13:52:59.000000000 +1100
> @@ -22,6 +22,14 @@ config SEQUOIA
>  	help
>  	  This option enables support for the AMCC PPC440EPX evaluation board.
> 
> +config TAISHAN
> +	bool "Taishan"
> +	depends on 44x
> +	default n
> +	select 440GX
> +	help
> +	  This option enables support for the IBM PPC440GX "Taishan" evaluation board.

AMCC Taishan board.

> +
>  #config LUAN
>  #	bool "Luan"
>  #	depends on 44x
> @@ -58,6 +66,10 @@ config 440GP
> 
>  config 440GX
>  	bool
> +        select IBM_NEW_EMAC_EMAC4
> +	select IBM_NEW_EMAC_RGMII
> +        select IBM_NEW_EMAC_ZMII #test only
> +        select IBM_NEW_EMAC_TAH  #test only
> 
>  config 440SP
>  	bool
> Index: linux-work/arch/powerpc/platforms/44x/Makefile
> ===================================================================
> --- linux-work.orig/arch/powerpc/platforms/44x/Makefile	2007-12-03 11:48:01.000000000 +1100
> +++ linux-work/arch/powerpc/platforms/44x/Makefile	2007-12-03 13:52:59.000000000 +1100
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_44x)	:= misc_44x.o
>  obj-$(CONFIG_EBONY)	+= ebony.o
> +obj-$(CONFIG_TAISHAN)	+= taishan.o
>  obj-$(CONFIG_BAMBOO) += bamboo.o
>  obj-$(CONFIG_SEQUOIA)	+= sequoia.o
> Index: linux-work/arch/powerpc/platforms/44x/taishan.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/powerpc/platforms/44x/taishan.c	2007-12-03 13:39:01.000000000 +1100
> @@ -0,0 +1,74 @@
> +/*
> + * Taishan board specific routines based off ebony.c code
> + * original copyrights below
> + *
> + * Matt Porter <mporter@kernel.crashing.org>
> + * Copyright 2002-2005 MontaVista Software Inc.
> + *
> + * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
> + * Copyright (c) 2003-2005 Zultys Technologies
> + *
> + * Rewritten and ported to the merged powerpc tree:
> + * Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
> + *
> + * Modified from ebony.c for taishan:
> + * Copyright 2007 Hugh Blemings <hugh@au.ibm.com>, IBM Corporation.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/time.h>
> +#include <asm/uic.h>
> +#include <asm/pci-bridge.h>
> +
> +#include "44x.h"
> +
> +static struct of_device_id taishan_of_bus[] = {
> +	{ .compatible = "ibm,plb4", },
> +	{ .compatible = "ibm,opb", },
> +	{ .compatible = "ibm,ebc", },
> +	{},
> +};
> +
> +static int __init taishan_device_probe(void)
> +{
> +	if (!machine_is(taishan))
> +		return 0;
> +
> +	of_platform_bus_probe(NULL, taishan_of_bus, NULL);
> +
> +	return 0;
> +}
> +device_initcall(taishan_device_probe);
> +
> +/*
> + * Called very early, MMU is off, device-tree isn't unflattened
> + */
> +static int __init taishan_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (!of_flat_dt_is_compatible(root, "ibm,taishan"))
> +		return 0;

amcc,taishan

> +
> +	return 1;
> +}
> +
> +define_machine(taishan) {
> +	.name			= "Taishan",
> +	.probe			= taishan_probe,
> +	.progress		= udbg_progress,
> +	.init_IRQ		= uic_init_tree,
> +	.get_irq		= uic_get_irq,
> +	.restart		= ppc44x_reset_system,
> +	.calibrate_decr		= generic_calibrate_decr,
> +};
> Index: linux-work/arch/powerpc/boot/dts/taishan.dts
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/powerpc/boot/dts/taishan.dts	2007-12-03 13:39:01.000000000 +1100
> @@ -0,0 +1,414 @@
> +/*
> + * Device Tree Source for IBM/AMCC Taishan
> + *

<snip>

> + *
> + * To build:
> + *   dtc -I dts -O asm -o taishan.S -b 0 taishan.dts
> + *   dtc -I dts -O dtb -o taishan.dtb -b 0 taishan.dts

Remove this please.  It's not really needed anymore.
> + */
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	model = "ibm,taishan";
> +	compatible = "ibm,taishan";

amcc,taishan

> +	dcr-parent = <&/cpus/PowerPC,440GX@0>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,440GX@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <2FAF0800>; // 800MHz
> +			timebase-frequency = <0>; // Filled in by zImage
> +			i-cache-line-size = <32>;
> +			d-cache-line-size = <32>;
> +			i-cache-size = <8000>; /* 32 kB */
> +			d-cache-size = <8000>; /* 32 kB */
> +			dcr-controller;
> +			dcr-access-method = "native";
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0 0>; // Filled in by zImage
> +	};
> +
> +
> +	UICB0: interrupt-controller-base {
> +		compatible = "ibm,uic-440gx", "ibm,uic";
> +		interrupt-controller;
> +		cell-index = <3>;
> +		dcr-reg = <200 009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +	};
> +
> +
> +	UIC0: interrupt-controller0 {
> +		compatible = "ibm,uic-440gx", "ibm,uic"; /* Should be AMCC ? */

This I think is fine as ibm,uic.  Unless AMCC actually changed the UIC
to have differences, it was found on the IBM boards first :)

> +		interrupt-controller;
> +		cell-index = <0>;
> +		dcr-reg = <0c0 009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +		interrupts = <01 4 00 4>; /* cascade - first non-critical */
> +		interrupt-parent = <&UICB0>;
> +
> +	};
> +
> +	UIC1: interrupt-controller1 {
> +		compatible = "ibm,uic-440gx", "ibm,uic";
> +		interrupt-controller;
> +		cell-index = <1>;
> +		dcr-reg = <0d0 009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +		interrupts = <03 4 02 4>; /* cascade */
> +		interrupt-parent = <&UICB0>;
> +	};
> +
> +	UIC2: interrupt-controller2 {
> +		compatible = "ibm,uic-440gx", "ibm,uic";
> +		interrupt-controller;
> +		cell-index = <2>; /* was 1 */
> +		dcr-reg = <210 009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +		interrupts = <05 4 04 4>; /* cascade */
> +		interrupt-parent = <&UICB0>;
> +	};
> +
> +
> +	CPC0: cpc {
> +		compatible = "ibm,cpc-440gp";
> +		dcr-reg = <0b0 003 0e0 010>;
> +		// FIXME: anything else?
> +	};
> +
> +	plb {
> +		compatible = "ibm,plb-440gx", "ibm,plb4";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges;
> +		clock-frequency = <9896800>; // 160MHz
> +
> +		SDRAM0: memory-controller {
> +			compatible = "ibm,sdram-440gp";
> +			dcr-reg = <010 2>;
> +			// FIXME: anything else?
> +		};
> +
> +		SRAM0: sram {
> +			compatible = "ibm,sram-440gp";
> +			dcr-reg = <020 8 00a 1>;
> +		};
> +
> +		DMA0: dma {
> +			// FIXME: ???
> +			compatible = "ibm,dma-440gp";
> +			dcr-reg = <100 027>;
> +		};
> +
> +		MAL0: mcmal {
> +			compatible = "ibm,mcmal-440gx", "ibm,mcmal2";
> +			dcr-reg = <180 62>;
> +			num-tx-chans = <4>;
> +			num-rx-chans = <4>;
> +			interrupt-parent = <&MAL0>;
> +			interrupts = <0 1 2 3 4>;
> +			#interrupt-cells = <1>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
> +					 /*RXEOB*/ 1 &UIC0 b 4
> +					 /*SERR*/  2 &UIC1 0 4
> +					 /*TXDE*/  3 &UIC1 1 4
> +					 /*RXDE*/  4 &UIC1 2 4>;
> +			interrupt-map-mask = <ffffffff>;
> +		};
> +
> +		POB0: opb {
> +			compatible = "ibm,opb-440gx", "ibm,opb";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			/* Wish there was a nicer way of specifying a full 32-bit
> +			   range */
> +			ranges = <00000000 1 00000000 80000000
> +				  80000000 1 80000000 80000000>;
> +			dcr-reg = <090 00b>;
> +			interrupt-parent = <&UIC1>;
> +			interrupts = <7 4>;
> +			clock-frequency = <4C4B400>; // 80MHz
> +
> +
> +			/* Put EBC0 back **FIXME** */

Hrm?

> +
> +			EBC0: ebc {
> +				compatible = "ibm,ebc-440gx", "ibm,ebc";
> +				dcr-reg = <012 2>;
> +				#address-cells = <2>;
> +				#size-cells = <1>;
> +				clock-frequency = <4C4B400>; // 80MHz
> +				// ranges property is supplied by zImage
> +				// based on firmware's configuration of the
> +				// EBC bridge
> +				interrupts = <5 4>;
> +				interrupt-parent = <&UIC1>;
> +
> +//				small-flash@0,80000 {
> +//					device_type = "rom";
> +//					compatible = "direct-mapped";
> +//					probe-type = "JEDEC";
> +//					bank-width = <1>;
> +//					partitions = <0 80000>;
> +//					partition-names = "OpenBIOS";
> +//					reg = <0 80000 80000>;
> +//				};

You can probably just omit the child EBC nodes for now.  Adding them
when they're right is pretty easy.

> +
> +//				ds1743@1,0 {
> +//					/* NVRAM & RTC */
> +//					compatible = "ds1743";
> +//					reg = <1 0 2000>;
> +//				};
> +
> +//				large-flash@2,0 {
> +//					device_type = "rom";
> +//					compatible = "direct-mapped";
> +//					probe-type = "JEDEC";
> +//					bank-width = <1>;
> +//					partitions = <0 380000
> +//						      380000 80000>;
> +//					partition-names = "fs", "firmware";
> +//					reg = <2 0 400000>;
> +//				};
> +
> +//				ir@3,0 {
> +//					reg = <3 0 10>;
> +//				};
> +
> +//				fpga@7,0 {
> +//					compatible = "Ebony-FPGA";
> +//					reg = <7 0 10>;
> +//				};
> +			};
> +
> +

> +		PCIX0: pci@20ec00000 {
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			compatible = "ibm,plb440gp-pcix", "ibm,plb-pcix";
> +			primary;
> +			large-inbound-windows;
> +			enable-msi-hole;
> +			reg = <2 0ec00000   8	/* Config space access */
> +			       0 0 0		/* no IACK cycles */
> +			       2 0ed00000   4   /* Special cycles */
> +			       2 0ec80000 100	/* Internal registers */
> +			       2 0ec80100  fc>;	/* Internal messaging registers */
> +
> +			/* Outbound ranges, one memory and one IO,
> +			 * later cannot be changed
> +			 */
> +			ranges = <02000000 0 80000000 00000003 80000000 0 80000000
> +				  01000000 0 00000000 00000002 08000000 0 00010000>;
> +
> +			/* Inbound 2GB range starting at 0 */
> +			dma-ranges = <42000000 0 0 0 0 0 80000000>;
> +
> +			/* Ebony has all 4 IRQ pins tied together per slot */

This isn't an Ebony board.  Does Taishan do the same?

> +			interrupt-map-mask = <f800 0 0 7>;
> +			interrupt-map = <
> +				/* IDSEL 1 */
> +				0800 0 0 1 &UIC0 17 8
> +				0800 0 0 2 &UIC0 18 8
> +				0800 0 0 3 &UIC0 19 8
> +				0800 0 0 4 &UIC0 1a 8
> +
> +				/* IDSEL 2 */
> +				1000 0 0 1 &UIC0 18 8
> +				1000 0 0 2 &UIC0 19 8
> +				1000 0 0 3 &UIC0 1a 8
> +				1000 0 0 4 &UIC0 17 8
> +			>;
> +		};
> +	};
> +
> +	chosen {
> +		linux,stdout-path = "/plb/opb/serial@40000300";
> +	};
> +};

josh
