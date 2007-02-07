Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 402CFDDF40
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:37:32 +1100 (EST)
In-Reply-To: <20070207170602.45f9c2ee.kim.phillips@freescale.com>
References: <20070207170602.45f9c2ee.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7A666EA2-E740-42D8-9B36-1E7F6B46158F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add base support for the MPC8313E RDB
Date: Wed, 7 Feb 2007 17:36:34 -0600
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 7, 2007, at 5:06 PM, Kim Phillips wrote:

> Add support for the MPC8313E Reference Development Board (RDB).
> Includes dts.

Can you give some better description about the RDB, like what  
functionality it supports, etc..

> Signed-off-by: Wilson Lo <Wilson.Lo@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8313erdb.dts     |  221 ++++++++++++++++++ 
> +++++++++++
>  arch/powerpc/platforms/83xx/Kconfig       |   12 ++
>  arch/powerpc/platforms/83xx/Makefile      |    1 +
>  arch/powerpc/platforms/83xx/mpc8313_rdb.c |   99 +++++++++++++
>  4 files changed, 333 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/ 
> boot/dts/mpc8313erdb.dts
> new file mode 100644
> index 0000000..2cde658
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> @@ -0,0 +1,221 @@
> +/*
> + * MPC8313E RDB Device Tree Source
> + *
> + * Copyright 2005, 2006, 2007 Freescale Semiconductor Inc.
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
> +/ {
> +	model = "MPC8313ERDB";
> +	compatible = "MPC83xx";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#cpus = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8313@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <20>;	// 32 bytes
> +			i-cache-line-size = <20>;	// 32 bytes
> +			d-cache-size = <4000>;		// L1, 16K
> +			i-cache-size = <4000>;		// L1, 16K
> +			timebase-frequency = <0>;	// from bootloader
> +			bus-frequency = <0>;		// from bootloader
> +			clock-frequency = <0>;		// from bootloader
> +			32-bit;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <00000000 08000000>;	// 128MB at 0
> +	};
> +
> +	soc8313@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		device_type = "soc";
> +		ranges = <0 e0000000 00100000>;
> +		reg = <e0000000 00000200>;
> +		bus-frequency = <0>;
> +		compatible = "mpc8313\0mpc831x\0mpc83xx";

I'm not sure what this compatible property is suppose to mean?

> +
> +		wdt@200 {
> +			device_type = "watchdog";
> +			compatible = "mpc83xx_wdt";
> +			reg = <200 100>;
> +		};
> +
> +		i2c@3000 {
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <3000 100>;
> +			interrupts = <e 8>;
> +			interrupt-parent = <700>;
> +			dfsrr;
> +		};
> +
> +		i2c@3100 {
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <3100 100>;
> +			interrupts = <f 8>;
> +			interrupt-parent = <700>;
> +			dfsrr;
> +		};
> +
> +		spi@7000 {
> +			device_type = "spi";
> +			compatible = "mpc83xx_spi";
> +			reg = <7000 1000>;
> +			interrupts = <10 8>;
> +			interrupt-parent = <700>;
> +			mode = <0>;
> +		};
> +
> +		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
> +		usb@23000 {
> +			device_type = "usb";
> +			compatible = "fsl-usb2-dr";
> +			reg = <23000 1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupt-parent = <700>;
> +			interrupts = <26 2>;
> +			phy_type = "utmi_wide";

Does anything change because of the integrated UTMI phy?

> +			control_init  = <00000280>; // UTMI ext 48 MHz clk

What is 'control_init' ?


> +		};
> +
> +		mdio@24520 {
> +			device_type = "mdio";
> +			compatible = "gianfar";
> +			reg = <24520 20>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			linux,phandle = <24520>;
> +			ethernet-phy@1 {
> +				linux,phandle = <2452001>;
> +				interrupt-parent = <700>;
> +				interrupts = <13 2>;
> +				reg = <1>;
> +				device_type = "ethernet-phy";
> +			};
> +			ethernet-phy@4 {
> +				linux,phandle = <2452004>;
> +				interrupt-parent = <700>;
> +				interrupts = <14 2>;
> +				reg = <4>;
> +				device_type = "ethernet-phy";
> +			};
> +		};
> +
> +		ethernet@24000 {
> +			device_type = "network";
> +			model = "TSEC";

isn't eTSEC on 8313?

> +			compatible = "gianfar";
> +			reg = <24000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <25 8 24 8 23 8>;
> +			interrupt-parent = <700>;
> +			phy-handle = <2452001>;
> +		};
> +
> +		ethernet@25000 {
> +			device_type = "network";
> +			model = "TSEC";
> +			compatible = "gianfar";
> +			reg = <25000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <22 8 21 8 20 8>;
> +			interrupt-parent = <700>;
> +			phy-handle = <2452004>;
> +		};
> +
> +		serial@4500 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4500 100>;
> +			clock-frequency = <0>;
> +			interrupts = <9 8>;
> +			interrupt-parent = <700>;
> +		};
> +
> +		serial@4600 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4600 100>;
> +			clock-frequency = <0>;
> +			interrupts = <a 8>;
> +			interrupt-parent = <700>;
> +		};
> +
> +		pci@8500 {
> +			interrupt-map-mask = <f800 0 0 7>;
> +			interrupt-map = <
> +
> +					/* IDSEL 0x0E -mini PCI */
> +					 7000 0 0 1 700 12 8
> +					 7000 0 0 2 700 12 8
> +					 7000 0 0 3 700 12 8
> +					 7000 0 0 4 700 12 8
> +
> +					/* IDSEL 0x0F - PCI slot */
> +					 7800 0 0 1 700 11 8
> +					 7800 0 0 2 700 12 8
> +					 7800 0 0 3 700 11 8
> +					 7800 0 0 4 700 12 8>;
> +			interrupt-parent = <700>;
> +			interrupts = <42 8>;
> +			bus-range = <0 0>;
> +			ranges = <02000000 0 90000000 90000000 0 10000000
> +			          42000000 0 80000000 80000000 0 10000000
> +			          01000000 0 00000000 e2000000 0 00100000>;
> +			clock-frequency = <3f940aa>;
> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			reg = <8500 100>;
> +			compatible = "83xx";
> +			device_type = "pci";
> +		};
> +
> +		crypto@30000 {
> +			device_type = "crypto";
> +			model = "SEC2";
> +			compatible = "talitos";
> +			reg = <30000 7000>;
> +			interrupts = <b 8>;
> +			interrupt-parent = <700>;
> +			/* Rev. 2.2 */
> +			num-channels = <1>;
> +			channel-fifo-len = <18>;
> +			exec-units-mask = <0000004c>;
> +			descriptor-types-mask = <0122003f>;
> +		};
> +
> +		/* IPIC
> +		 * interrupts cell = <intr #, sense>
> +		 * sense values match linux IORESOURCE_IRQ_* defines:
> +		 * sense == 8: Level, low assertion
> +		 * sense == 2: Edge, high-to-low change
> +		 */
> +		pic@700 {
> +			linux,phandle = <700>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <700 100>;
> +			built-in;
> +			device_type = "ipic";
> +		};
> +	};
> +};
> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/ 
> platforms/83xx/Kconfig
> index edcd5b8..46883c5 100644
> --- a/arch/powerpc/platforms/83xx/Kconfig
> +++ b/arch/powerpc/platforms/83xx/Kconfig
> @@ -5,6 +5,12 @@ choice
>  	prompt "Machine Type"
>  	default MPC834x_SYS
>
> +config MPC8313_RDB
> +	bool "Freescale MPC8313 RDB"
> +	select DEFAULT_UIMAGE
> +	help
> +	  This option enables support for the MPC8313 RDB board.
> +
>  config MPC832x_MDS
>  	bool "Freescale MPC832x MDS"
>  	select DEFAULT_UIMAGE
> @@ -41,6 +47,12 @@ config MPC8360E_PB
>
>  endchoice
>
> +config PPC_MPC831x
> +	bool
> +	select PPC_UDBG_16550
> +	select PPC_INDIRECT_PCI
> +	default y if MPC8313_RDB
> +
>  config PPC_MPC832x
>  	bool
>  	select PPC_UDBG_16550
> diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/ 
> platforms/83xx/Makefile
> index f1aa7e2..0b732a7 100644
> --- a/arch/powerpc/platforms/83xx/Makefile
> +++ b/arch/powerpc/platforms/83xx/Makefile
> @@ -3,6 +3,7 @@
>  #
>  obj-y				:= misc.o
>  obj-$(CONFIG_PCI)		+= pci.o
> +obj-$(CONFIG_MPC8313_RDB)	+= mpc8313_rdb.o
>  obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o
>  obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
>  obj-$(CONFIG_MPC8360E_PB)	+= mpc8360e_pb.o
> diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/ 
> powerpc/platforms/83xx/mpc8313_rdb.c
> new file mode 100644
> index 0000000..c3b98c3
> --- /dev/null
> +++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
> @@ -0,0 +1,99 @@
> +/*
> + * arch/powerpc/platforms/83xx/mpc8313_rdb.c
> + *
> + * Description: MPC8313x RDB board specific routines.
> + * This file is based on mpc834x_sys.c
> + * Author: Lo Wlison <r43300@freescale.com>
> + *
> + * Copyright (C) Freescale Semiconductor, Inc. 2006. All rights  
> reserved.
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
> +#include <linux/pci.h>
> +
> +#include <asm/time.h>
> +#include <asm/ipic.h>
> +#include <asm/udbg.h>
> +
> +#include "mpc83xx.h"
> +
> +#undef DEBUG
> +#ifdef DEBUG
> +#define DBG(fmt...) udbg_printf(fmt)
> +#else
> +#define DBG(fmt...)
> +#endif
> +
> +#ifndef CONFIG_PCI
> +unsigned long isa_io_base = 0;
> +unsigned long isa_mem_base = 0;
> +#endif
> +
> +/*  
> ********************************************************************** 
> **
> + *
> + * Setup the architecture
> + *
> + */
> +static void __init mpc8313_rdb_setup_arch(void)
> +{
> +	struct device_node *np;
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("mpc8313_rdb_setup_arch()", 0);
> +
> +#ifdef CONFIG_PCI
> +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> +		add_bridge(np);
> +
> +	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
> +#endif
> +}
> +
> +void __init mpc8313_rdb_init_IRQ(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_node_by_type(NULL, "ipic");
> +	if (!np)
> +		return;
> +
> +	ipic_init(np, 0);
> +
> +	/* Initialize the default interrupt mapping priorities,
> +	 * in case the boot rom changed something on us.
> +	 */
> +	ipic_set_default_priority();
> +}
> +
> +/*
> + * Called very early, MMU is off, device-tree isn't unflattened
> + */
> +static int __init mpc8313_rdb_probe(void)
> +{
> +	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
> +					  "model", NULL);
> +	if (model == NULL)
> +		return 0;
> +	if (strcmp(model, "MPC8313ERDB"))
> +		return 0;
> +
> +	DBG("MPC8313 RDB found\n");
> +
> +	return 1;
> +}
> +
> +define_machine(mpc8313_rdb) {
> +	.name			= "MPC8313 RDB",
> +	.probe			= mpc8313_rdb_probe,
> +	.setup_arch		= mpc8313_rdb_setup_arch,
> +	.init_IRQ		= mpc8313_rdb_init_IRQ,
> +	.get_irq		= ipic_get_irq,
> +	.restart		= mpc83xx_restart,
> +	.time_init		= mpc83xx_time_init,
> +	.calibrate_decr		= generic_calibrate_decr,
> +	.progress		= udbg_progress,
> +};
> -- 
> 1.4.4
