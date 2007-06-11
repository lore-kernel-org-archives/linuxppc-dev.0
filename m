Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B79EDDEBB
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 23:50:13 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l5BDo6k6018713
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 06:50:06 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5BDo5Ml001237
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 08:50:05 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 5/6]: 82xx: Add the support of Wind River SBC PowerQUICCII
	82xx
Date: Mon, 11 Jun 2007 21:51:56 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D2AA5B@zch01exm26.fsl.freescale.net>
In-Reply-To: <1181293043.11341.19.camel@mark>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Mark Zhan" <rongkai.zhan@windriver.com>, <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

{snip}
> diff --git a/arch/powerpc/platforms/82xx/sbcpq2.c
> b/arch/powerpc/platforms/82xx/sbcpq2.c
> new file mode 100644
> index 0000000..c459be4
> --- /dev/null
> +++ b/arch/powerpc/platforms/82xx/sbcpq2.c
> @@ -0,0 +1,306 @@
> +/*
> + * sbcpq2.c: The platform support for Wind River SBC PowerQUICCII
82xx
> + *
> + * Copyright 2007, Wind River Systems, Inc.
> + *
> + * Author: Mark Zhan <rongkai.zhan@windriver.com>
> + *
> + * This program is free software; you can redistribute  it and/or
> modify it
> + * under  the terms of  the GNU General  Public License as published
by
> the
> + * Free Software Foundation;  either version 2 of the  License, or
(at
> your
> + * option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/reboot.h>
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/rtc.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/seq_file.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/fs_uart_pd.h>
> +#include <linux/fs_enet_pd.h>
> +
> +#include <asm/prom.h>
> +#include <asm/machdep.h>
> +#include <asm/io.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/mpc8260.h>
> +#include <asm/cpm2.h>
> +#include <sysdev/cpm2_pic.h>
> +#include <asm/udbg.h>
> +#include <asm/i8259.h>
> +#include <asm/fs_pd.h>
> +
> +static struct resource m48t59_resources[] =3D {
> +	{
> +		.start	=3D SBCPQ2_RTC_BASE,
> +		.end	=3D SBCPQ2_RTC_BASE + SBCPQ2_RTC_SIZE - 1,
> +		.flags	=3D IORESOURCE_MEM,
> +	}, {
> +		.start	=3D SBCPQ2_M48T59_IRQ,
> +		.end	=3D SBCPQ2_M48T59_IRQ,
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +	{ },
> +};
> +

Shouldn't these come from device tree too?

Moreover, you can no longer use the hard coded IRQ numbers.  They need
to be mapped to virtual irq, and the driver needs to use the virtual irq
number.

> +static struct platform_device m48t59_rtc =3D {
> +	.name		=3D "rtc-m48t59",
> +	.id 		=3D 0,
> +	.num_resources	=3D 2,
> +	.resource	=3D m48t59_resources,
> +};
> +
> +static struct platform_device *sbcpq2_devices[] __initdata =3D {
> +	&m48t59_rtc,
> +};
> +
> +/**
> + * sbcpq2_pdev_init - Register the platform device for sbcpq2 board
> + */
> +static int __init sbcpq2_platdev_init(void)
> +{
> +	struct irq_desc *desc =3D irq_desc + SBCPQ2_M48T59_IRQ;
> +
> +	/* Install a dummy irq chip for M48T59 RTC irq */
> +	if (desc->chip =3D=3D &no_irq_chip)
> +		set_irq_handler(SBCPQ2_M48T59_IRQ, desc->handle_irq);
> +
> +	/* Register all platform devices for sbcpq2 */
> +	platform_add_devices(sbcpq2_devices,
ARRAY_SIZE(sbcpq2_devices));
> +	return 0;
> +}
> +arch_initcall(sbcpq2_platdev_init);
> +
{snip}
> diff --git a/arch/powerpc/platforms/82xx/sbcpq2.h
> b/arch/powerpc/platforms/82xx/sbcpq2.h
> new file mode 100644
> index 0000000..77b7ca6
> --- /dev/null
> +++ b/arch/powerpc/platforms/82xx/sbcpq2.h
> @@ -0,0 +1,118 @@
> +/*
> + * sbcpq2.h: the header file for Wind River SBC PowerQUICCII 82xx
> + *
> + * Copyright (C) 2007, Wind River Systems, Inc.
> + * Mark Zhan, <rongkai.zhan@windriver.com>
> + *
> + * This program is free software; you can redistribute  it and/or
> modify it
> + * under  the terms of  the GNU General  Public License as published
by
> the
> + * Free Software Foundation;  either version 2 of the  License, or
(at
> your
> + * option) any later version.
> + */
> +
> +#ifndef __MACH_SBCPQ2_H
> +#define __MACH_SBCPQ2_H
> +
> +#include <asm/ppcboot.h>
> +
> +/* For our show_cpuinfo hooks. */
> +#define CPUINFO_VENDOR		"Wind River"
> +#define CPUINFO_MACHINE		"SBC PowerQUICCII 82xx"
> +

I don't believe the following are necessary.  New MTD mapping should be
defined in device tree.

> +/*
> + * Wind River SBC PowerQUICCII 82xx Physical Memory Map (CS0 for
> OnBoard Flash)
> + *
> + *   0x00000000 - 0x07FFFFFF	CS2, 128 MB DIMM SDRAM
> + *   0x08000000 - 0x0FFFFFFF	CS3, 128 MB DIMM SDRAM
> + *   0x12000000 - 0x12100000	CS8, ATM
> + *   0x20000000 - 0x20FFFFFF	CS4, 16 MB Local Bus SDRAM
> + *   0x21000000 - 0x21001FFF	CS7, Control EPLD
> + *   0x22000000 - 0x22001FFF	CS5, 8KB EEPROM
> + *   0x22002000 - 0x22003FFF	CS5, visionPORT
> + *   0x22004000 - 0x22005FFF	CS5, User Switches
> + *   0x22006000 - 0x22007FFF	CS5, STATUS
> + *   0x22008000 - 0x22009FFF	CS5, i8259 interrupt controller
> + *   0x2200A000 - 0x2200BFFF	CS5, LED (Seven Segment Display)
> + *   0x80000000 - 0x80001FFF	CS11, RTC
> + *   0xE0000000 - 0xE3FFFFFF	CS6, 64 MB DIMM Flash
> + *   0xE4000000 - 0xE7FFFFFF	CS1, 64 MB DIMM Flash
> + *   0xFE000000 - 0xFFFFFFFF	CS0, 2 MB Boot Flash
> + *   0xF0000000 - 0xF0020000	MPC82xx Internal Registers Space
> + */
> +#define SBCPQ2_SDRAM_BASE		0x00000000
> +#define SBCPQ2_SDRAM_SIZE		0x10000000
> +
> +#define SBCPQ2_LOCAL_SDRAM_BASE		0x20000000
> +#define SBCPQ2_LOCAL_SDRAM_SIZE		0x1000000
> +
> +#define SBCPQ2_EPLD_BASE		0x21000000
> +#define SBCPQ2_EPLD_SIZE		0x2000
> +
> +#define SBCPQ2_EEPROM_BASE		0x22000000
> +#define SBCPQ2_EEPROM_SIZE		0x2000
> +
> +/* User Switches SW5 */
> +#define SBCPQ2_USER_SW_BASE		0x22004000
> +#define SBCPQ2_USER_SW_SIZE		0x2000
> +
> +#define SBCPQ2_STATUS_BASE		0x22006000
> +#define SBCPQ2_STATUS_SIZE		0x2000
> +
> +#define SBCPQ2_I8259_BASE		0x22008000
> +#define SBCPQ2_I8259_SIZE		0x2000
> +
> +/* Seven Segment Display LED D46 */
> +#define SBCPQ2_LED_BASE			0x2200A000
> +#define SBCPQ2_LED_SIZE			0x2000
> +
> +#define SBCPQ2_RTC_BASE			0x80000000
> +#define SBCPQ2_RTC_SIZE			0x2000
> +
> +#define SBCPQ2_BOOT_FLASH_BASE		0xFE000000
> +#define SBCPQ2_BOOT_FLASH_SIZE		0x00200000
> +
> +#define SBCPQ2_DIMM_FLASH_BASE		0xE0000000
> +#define SBCPQ2_DIMM_FLASH_SIZE		0x04000000
> +
> +#define CPM_MAP_ADDR			0xF0000000
> +#define CPM_IRQ_OFFSET			0
> +
> +/*
> + * The offset of ethernet MAC addr within EEPROM
> + */
> +#define SBCPQ2_FCC1_MACADDR_OFS		0x60
> +#define SBCPQ2_FCC2_MACADDR_OFS		0x66
> +#define SBCPQ2_FCC3_MACADDR_OFS		0x72
> +#define SBCPQ2_SCC1_MACADDR_OFS		0x78
> +
> +/*
> + * The interrupt of M48T59 RTC chip will generate
> + * a machine check exception. We use a fake irq
> + * to get the platform machine_check_exception() hook
> + * have a chance to call the driver ISR.
> + */
> +#define SBCPQ2_M48T59_IRQ		(NR_IRQS-1)
> +
> +/*
> + * The following IRQs are routed to i8259 PIC.
> + *
> + * NOTE: i8259 PIC is cascaded to SIU_INT_IRQ6 of CPM2 interrupt
> controller
> + */
> +#define SBCPQ2_PC_IRQA		(NR_SIU_INTS+0)
> +#define SBCPQ2_PC_IRQB		(NR_SIU_INTS+1)
> +#define SBCPQ2_MPC185_IRQ	(NR_SIU_INTS+2)
> +#define SBCPQ2_ATM_IRQ		(NR_SIU_INTS+3)
> +#define SBCPQ2_PIRQA		(NR_SIU_INTS+4)
> +#define SBCPQ2_PIRQB		(NR_SIU_INTS+5)
> +#define SBCPQ2_PIRQC		(NR_SIU_INTS+6)
> +#define SBCPQ2_PIRQD		(NR_SIU_INTS+7)
> +
> +/* cpm serial driver works with constants below */
> +#define SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
> +#define SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
> +#define SIU_INT_SCC1		((uint)0x28+CPM_IRQ_OFFSET)
> +#define SIU_INT_SCC2		((uint)0x29+CPM_IRQ_OFFSET)
> +#define SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
> +#define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
> +
> +#endif /* __MACH_SBCPQ2_H */
> diff --git a/arch/powerpc/boot/dts/sbcpq2.dts
> b/arch/powerpc/boot/dts/sbcpq2.dts
> new file mode 100644
> index 0000000..cdcf780
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/sbcpq2.dts
> @@ -0,0 +1,191 @@
> +/*
> + * Wind River SBC PowerQUICCII 82xx Device Tree Source
> + *
> + * Copyright 2007, Wind River Systems, Inc.
> + * Mark Zhan <rongkai.zhan@windriver.com>
> + *
> + * This program is free software; you can redistribute  it and/or
> modify it
> + * under  the terms of  the GNU General  Public License as published
by
> the
> + * Free Software Foundation;  either version 2 of the  License, or
(at
> your
> + * option) any later version.
> + *
> + * Build with: dtc -f -I dts -O dtb -o sbcpq2.dtb -V 16 sbcpq2.dts
> + */
> +
> +/ {
> +	model =3D "SBCPQ2";
> +	compatible =3D "mpc82xx";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	linux,phandle =3D <100>;
> +
> +	cpus {
> +		#cpus =3D <1>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		linux,phandle =3D <200>;
> +
> +		PowerPC,8260@0 {
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			d-cache-line-size =3D <20>;       // 32 bytes
> +			i-cache-line-size =3D <20>;       // 32 bytes
> +			d-cache-size =3D <4000>;          // L1, 16K
> +			i-cache-size =3D <4000>;          // L1, 16K
> +			timebase-frequency =3D <0>;	/* =3D
(bus-frequency / 4) */
> +			bus-frequency =3D <0>;		/* =3D
bd->bi_busfreq */
> +			clock-frequency =3D <0>;		/* =3D
bd->bi_intfreq =3D gd->cpu_clk */
> +			32-bit;
> +			linux,phandle =3D <201>;
> +		};
> +	};
> +
> +	memory {
> +		device_type =3D "memory";
> +		linux,phandle =3D <300>;
> +		/* 256MB DIMM SDRAM & 16MB Local Bus SDRAM */
> +		reg =3D <00000000 10000000 20000000 01000000>;
> +	};
> +
> +	soc8260@f0000000 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		#interrupt-cells =3D <2>;
> +		device_type =3D "soc";
> +		ranges =3D <00000000 f0000000 00020000>;
> +		reg =3D <f0000000 00020000>;
> +		bus-frequency =3D <0>; /* from u-boot */
> +
> +		cpm@f0000000 {
> +			linux,phandle =3D <f0000000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			#interrupt-cells =3D <2>;
> +			device_type =3D "cpm";
> +			model =3D "CPM2";
> +			ranges =3D <00000000 00000000 00020000>;
> +			reg =3D <0 00020000>;
> +			command-proc =3D <0>;	/* from u-boot */
> +			brg-frequency =3D <0>;	/* from u-boot */
> +			cpm_clk =3D <0>;		/* from u-boot */
> +
> +			smc@11a80 {
> +				device_type =3D "serial";
> +				compatible =3D "cpm_uart";
> +				model =3D "SMC";
> +				device-id =3D <1>;
> +				reg =3D <11a80 10 0 40>;
> +				rx-clock =3D <1>;
> +				tx-clock =3D <1>;
> +				interrupts =3D <4 2>;
> +				interrupt-parent =3D <10c00>;

Use < &interrupt-controller > as interrupt-parent instead.

- Leo
