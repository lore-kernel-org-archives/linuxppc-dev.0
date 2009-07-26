Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 768D7B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 09:38:30 +1000 (EST)
Subject: Re:
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Solomon Peachy <solomon@linux-wlan.com>
In-Reply-To: <1248359928-16624-1-git-send-email-solomon@linux-wlan.com>
References: <1248359928-16624-1-git-send-email-solomon@linux-wlan.com>
Content-Type: text/plain
Date: Mon, 27 Jul 2009 09:38:18 +1000
Message-Id: <1248651498.28464.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-23 at 10:38 -0400, Solomon Peachy wrote:
> This patch (against 2.6.30) adds support for the ESTeem 195E Hotfoot
> SBC.  We've been maintaining this out-of-tree for some time now for
> older kernels, but recently I ported it to the new unified powerpc tree
> with the intent of pushing it upstream.

Please always have a subject or it will end up in patchwork without
a link I can clock on :-)

Cheersm
Ben.

> The board uses an ancient version of u-boot and a slightly mangled
> verison of the oft-abused ppcboot header.
> 
> There are several variants of the SBC deployed, single/dual
> ethernet/serial, and also 4MB/8MB flash units.  In the interest of
> having a single kernel image boot on all boards, the cuboot shim detects
> the differences and mangles the DTS tree appropriately.
> 
> With the exception of the CF interface that was never populated on
> production boards, this code/DTS supports all boardpop options.
> 
> Signed-off-by:  Solomon Peachy <solomon@linux-wlan.com>
> 
> diff -Naur linux-2.6.30/arch/powerpc/boot/Makefile linux-2.6.30.hotfoot/arch/powerpc/boot/Makefile
> --- linux-2.6.30/arch/powerpc/boot/Makefile	2009-06-09 23:05:27.000000000 -0400
> +++ linux-2.6.30.hotfoot/arch/powerpc/boot/Makefile	2009-07-07 12:55:18.000000000 -0400
> @@ -39,6 +39,7 @@
>  
>  $(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
>  $(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
> +$(obj)/cuboot-hotfoot.o: BOOTCFLAGS += -mcpu=405
>  $(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
>  $(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
>  $(obj)/cuboot-acadia.o: BOOTCFLAGS += -mcpu=405
> @@ -67,7 +68,7 @@
>  		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
>  		fsl-soc.c mpc8xx.c pq2.c
>  src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c \
> -		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
> +		cuboot-ebony.c cuboot-hotfoot.c treeboot-ebony.c prpmc2800.c \
>  		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
>  		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c \
>  		cuboot-bamboo.c cuboot-mpc7448hpc2.c cuboot-taishan.c \
> @@ -190,6 +191,7 @@
>  
>  # Board ports in arch/powerpc/platform/40x/Kconfig
>  image-$(CONFIG_EP405)			+= dtbImage.ep405
> +image-$(CONFIG_HOTFOOT)			+= cuImage.hotfoot
>  image-$(CONFIG_WALNUT)			+= treeImage.walnut
>  image-$(CONFIG_ACADIA)			+= cuImage.acadia
>  
> diff -Naur linux-2.6.30/arch/powerpc/boot/cuboot-hotfoot.c linux-2.6.30.hotfoot/arch/powerpc/boot/cuboot-hotfoot.c
> --- linux-2.6.30/arch/powerpc/boot/cuboot-hotfoot.c	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.30.hotfoot/arch/powerpc/boot/cuboot-hotfoot.c	2009-07-07 12:55:23.000000000 -0400
> @@ -0,0 +1,142 @@
> +/*
> + * Old U-boot compatibility for Esteem 195E Hotfoot CPU Board
> + *
> + * Author: Solomon Peachy <solomon@linux-wlan.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include "ops.h"
> +#include "stdio.h"
> +#include "reg.h"
> +#include "dcr.h"
> +#include "4xx.h"
> +#include "cuboot.h"
> +
> +#define TARGET_4xx
> +#define TARGET_HOTFOOT
> +
> +#include "ppcboot.h"
> +
> +static bd_t bd;
> +
> +#define NUM_REGS 3
> +
> +static void hotfoot_fixups(void)
> +{
> +	u32 uart = mfdcr(DCRN_CPC0_UCR) & 0x7f;
> +
> +	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize); 
> +
> +	dt_fixup_cpu_clocks(bd.bi_procfreq, bd.bi_procfreq, 0);
> +	dt_fixup_clock("/plb", bd.bi_plb_busfreq);
> +	dt_fixup_clock("/plb/opb", bd.bi_opbfreq);
> +	dt_fixup_clock("/plb/ebc", bd.bi_pci_busfreq);
> +	dt_fixup_clock("/plb/opb/serial@ef600300", bd.bi_procfreq / uart); 
> +	dt_fixup_clock("/plb/opb/serial@ef600400", bd.bi_procfreq / uart); 
> +	
> +	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
> +	dt_fixup_mac_address_by_alias("ethernet1", bd.bi_enet1addr);
> +
> +	/* Is this a single eth/serial board? */
> +	if ((bd.bi_enet1addr[0] == 0) && 
> +	    (bd.bi_enet1addr[1] == 0) &&
> +	    (bd.bi_enet1addr[2] == 0) &&
> +	    (bd.bi_enet1addr[3] == 0) &&
> +	    (bd.bi_enet1addr[4] == 0) &&
> +	    (bd.bi_enet1addr[5] == 0)) {
> +		void *devp;
> +
> +		printf("Trimming devtree for single eth board\n");
> +
> +		devp = finddevice("/plb/opb/serial@ef600300");
> +		if (!devp)
> +			fatal("Can't find node for /plb/opb/serial@ef600300");
> +		del_node(devp);
> +
> +		devp = finddevice("/plb/opb/ethernet@ef600900");
> +		if (!devp)
> +			fatal("Can't find node for /plb/opb/ethernet@ef600900");
> +		del_node(devp);
> +	}
> +
> +	ibm4xx_quiesce_eth((u32 *)0xef600800, (u32 *)0xef600900);
> +
> +	/* Fix up flash size in fdt for 4M boards. */
> +	if (bd.bi_flashsize < 0x800000) {
> +		u32 regs[NUM_REGS];
> +		void *devp = finddevice("/plb/ebc/nor_flash@0");
> +		if (!devp)
> +			fatal("Can't find FDT node for nor_flash!??");
> +
> +		printf("Fixing devtree for 4M Flash\n");
> +		
> +		/* First fix up the base addresse */
> +		getprop(devp, "reg", regs, sizeof(regs));
> +		regs[0] = 0;
> +		regs[1] = 0xffc00000;
> +		regs[2] = 0x00400000;
> +		setprop(devp, "reg", regs, sizeof(regs));
> +		
> +		/* Then the offsets */
> +		devp = finddevice("/plb/ebc/nor_flash@0/partition@0");
> +		if (!devp)
> +			fatal("Can't find FDT node for partition@0");
> +		getprop(devp, "reg", regs, 2*sizeof(u32));
> +		regs[0] -= 0x400000;
> +		setprop(devp, "reg", regs,  2*sizeof(u32));
> +
> +		devp = finddevice("/plb/ebc/nor_flash@0/partition@1");
> +		if (!devp)
> +			fatal("Can't find FDT node for partition@1");
> +		getprop(devp, "reg", regs, 2*sizeof(u32));
> +		regs[0] -= 0x400000;
> +		setprop(devp, "reg", regs,  2*sizeof(u32));
> +
> +		devp = finddevice("/plb/ebc/nor_flash@0/partition@2");
> +		if (!devp)
> +			fatal("Can't find FDT node for partition@2");
> +		getprop(devp, "reg", regs, 2*sizeof(u32));
> +		regs[0] -= 0x400000;
> +		setprop(devp, "reg", regs,  2*sizeof(u32));
> +
> +		devp = finddevice("/plb/ebc/nor_flash@0/partition@3");
> +		if (!devp)
> +			fatal("Can't find FDT node for partition@3");
> +		getprop(devp, "reg", regs, 2*sizeof(u32));
> +		regs[0] -= 0x400000;
> +		setprop(devp, "reg", regs,  2*sizeof(u32));
> +
> +		devp = finddevice("/plb/ebc/nor_flash@0/partition@4");
> +		if (!devp)
> +			fatal("Can't find FDT node for partition@4");
> +		getprop(devp, "reg", regs, 2*sizeof(u32));
> +		regs[0] -= 0x400000;
> +		setprop(devp, "reg", regs,  2*sizeof(u32));
> +
> +		devp = finddevice("/plb/ebc/nor_flash@0/partition@6");
> +		if (!devp)
> +			fatal("Can't find FDT node for partition@6");
> +		getprop(devp, "reg", regs, 2*sizeof(u32));
> +		regs[0] -= 0x400000;
> +		setprop(devp, "reg", regs,  2*sizeof(u32));
> +
> +		/* Delete the FeatFS node */
> +		devp = finddevice("/plb/ebc/nor_flash@0/partition@5");
> +		if (!devp)
> +			fatal("Can't find FDT node for partition@5");
> +		del_node(devp);
> +	}
> +}
> +
> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> +		   unsigned long r6, unsigned long r7)
> +{
> +	CUBOOT_INIT();
> +	platform_ops.fixups = hotfoot_fixups;
> +        platform_ops.exit = ibm40x_dbcr_reset;
> +	fdt_init(_dtb_start);
> +	serial_console_init();
> +}
> diff -Naur linux-2.6.30/arch/powerpc/boot/dts/hotfoot.dts linux-2.6.30.hotfoot/arch/powerpc/boot/dts/hotfoot.dts
> --- linux-2.6.30/arch/powerpc/boot/dts/hotfoot.dts	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.30.hotfoot/arch/powerpc/boot/dts/hotfoot.dts	2009-07-07 12:55:23.000000000 -0400
> @@ -0,0 +1,299 @@
> +/*
> + * Device Tree Source for ESTeem 195E Hotfoot
> + *
> + * Copyright 2009 AbsoluteValue Systems <solomon@linux-wlan.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without
> + * any warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	model = "est,hotfoot";
> +	compatible = "est,hotfoot";
> +	dcr-parent = <&{/cpus/cpu@0}>;
> +
> +	aliases {
> +		ethernet0 = &EMAC0;
> +		ethernet1 = &EMAC1;
> +		serial0 = &UART0;
> +		serial1 = &UART1;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			model = "PowerPC,405EP";
> +			reg = <0x00000000>;
> +			clock-frequency = <0>; /* Filled in by zImage */
> +			timebase-frequency = <0>; /* Filled in by zImage */
> +			i-cache-line-size = <0x20>;
> +			d-cache-line-size = <0x20>;
> +			i-cache-size = <0x4000>;
> +			d-cache-size = <0x4000>;
> +			dcr-controller;
> +			dcr-access-method = "native";
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000>; /* Filled in by zImage */
> +	};
> +
> +	UIC0: interrupt-controller {
> +		compatible = "ibm,uic";
> +		interrupt-controller;
> +		cell-index = <0>;
> +		dcr-reg = <0x0c0 0x009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	plb {
> +		compatible = "ibm,plb3";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		clock-frequency = <0>; /* Filled in by zImage */
> +
> +		SDRAM0: memory-controller {
> +			compatible = "ibm,sdram-405ep";
> +			dcr-reg = <0x010 0x002>;
> +		};
> +
> +		MAL: mcmal {
> +			compatible = "ibm,mcmal-405ep", "ibm,mcmal";
> +			dcr-reg = <0x180 0x062>;
> +			num-tx-chans = <4>;
> +			num-rx-chans = <2>;
> +			interrupt-parent = <&UIC0>;
> +			interrupts = <
> +				0xb 0x4 /* TXEOB */
> +				0xc 0x4 /* RXEOB */
> +				0xa 0x4 /* SERR */
> +				0xd 0x4 /* TXDE */
> +				0xe 0x4 /* RXDE */>;
> +		};
> +
> +		POB0: opb {
> +			compatible = "ibm,opb-405ep", "ibm,opb";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0xef600000 0xef600000 0x00a00000>;
> +			dcr-reg = <0x0a0 0x005>;
> +			clock-frequency = <0>; /* Filled in by zImage */
> +
> +			/* Hotfoot has UART0/UART1 swapped */
> +
> +			UART0: serial@ef600400 {
> +				device_type = "serial";
> +				compatible = "ns16550";
> +				reg = <0xef600400 0x00000008>;
> +				virtual-reg = <0xef600400>;
> +				clock-frequency = <0>; /* Filled in by zImage */
> +				current-speed = <0x9600>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <0x1 0x4>;
> +			};
> +
> +			UART1: serial@ef600300 {
> +				device_type = "serial";
> +				compatible = "ns16550";
> +				reg = <0xef600300 0x00000008>;
> +				virtual-reg = <0xef600300>;
> +				clock-frequency = <0>; /* Filled in by zImage */
> +				current-speed = <0x9600>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <0x0 0x4>;
> +			};
> +
> +
> +			IIC: i2c@ef600500 {
> +				compatible = "ibm,iic-405ep", "ibm,iic";
> +				reg = <0xef600500 0x00000011>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <0x2 0x4>;
> +
> +				rtc@68 {
> +				      /* Actually a DS1339 */
> +				      compatible = "dallas,ds1307"; 
> +				      reg = <0x68>;
> +				};
> +
> +				temp@4a { 
> +				      /* Not present on all boards */
> +				      compatible = "national,lm75";
> +				      reg = <0x4a>;
> +				};				
> +			};
> +
> +			GPIO: gpio@ef600700 {
> +			        #gpio-cells = <2>;
> +				compatible = "ibm,ppc4xx-gpio";
> +				reg = <0xef600700 0x00000020>;
> +				gpio-controller;
> +			};
> +
> +			gpio-leds {
> +			     compatible = "gpio-leds";
> +			     status {
> +			     	    label = "Status";
> +			     	    gpios = <&GPIO 1 0>;
> +				    /* linux,default=trigger = ".."; */
> +			     };
> +			     radiorx {
> +			     	    label = "Rx";
> +			     	    gpios = <&GPIO 0xe 0>;
> +				    /* linux,default=trigger = ".."; */
> +			     };
> +			};
> +
> +
> +			EMAC0: ethernet@ef600800 {
> +				linux,network-index = <0x0>;
> +				device_type = "network";
> +				compatible = "ibm,emac-405ep", "ibm,emac";
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <
> +					0xf 0x4 /* Ethernet */
> +					0x9 0x4 /* Ethernet Wake Up */>;
> +				local-mac-address = [000000000000]; /* Filled in by zImage */
> +				reg = <0xef600800 0x00000070>;
> +				mal-device = <&MAL>;
> +				mal-tx-channel = <0>;
> +				mal-rx-channel = <0>;
> +				cell-index = <0>;
> +				max-frame-size = <0x5dc>;
> +				rx-fifo-size = <0x1000>;
> +				tx-fifo-size = <0x800>;
> +				phy-mode = "mii";
> +				phy-map = <0x00000000>;
> +			};
> +
> +			EMAC1: ethernet@ef600900 {
> +				linux,network-index = <0x1>;
> +				device_type = "network";
> +				compatible = "ibm,emac-405ep", "ibm,emac";
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <
> +					0x11 0x4 /* Ethernet */
> +					0x9 0x4 /* Ethernet Wake Up */>;
> +				local-mac-address = [000000000000]; /* Filled in by zImage */
> +				reg = <0xef600900 0x00000070>;
> +				mal-device = <&MAL>;
> +				mal-tx-channel = <2>;
> +				mal-rx-channel = <1>;
> +				cell-index = <1>;
> +				max-frame-size = <0x5dc>;
> +				rx-fifo-size = <0x1000>;
> +				tx-fifo-size = <0x800>;
> +                                mdio-device = <&EMAC0>;
> +				phy-mode = "mii";
> +				phy-map = <0x0000001>;
> +			};
> +		};
> +
> +		EBC0: ebc {
> +			compatible = "ibm,ebc-405ep", "ibm,ebc";
> +			dcr-reg = <0x012 0x002>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +
> +			/* The ranges property is supplied by the bootwrapper
> +			 * and is based on the firmware's configuration of the
> +			 * EBC bridge
> +			 */
> +			clock-frequency = <0>; /* Filled in by zImage */
> +
> +                        nor_flash@0 {
> +                                compatible = "cfi-flash";
> +                                bank-width = <2>;
> +                                reg = <0x0 0xff800000 0x00800000>;
> +                                #address-cells = <1>;
> +                                #size-cells = <1>;
> +
> +				/* This mapping is for the 8M flash
> +				   4M flash has all ofssets -= 4M,
> +				   and FeatFS partition is not present */
> +				
> +                                partition@0 {
> +                                        label = "Bootloader";
> +                                        reg = <0x7c0000 0x40000>;
> +                                        /* read-only; */
> +                                };
> +                                partition@1 {
> +                                        label = "Env_and_Config_Primary";
> +                                        reg = <0x400000 0x10000>;
> +                                };
> +                                partition@2 {
> +                                        label = "Kernel";
> +                                        reg = <0x420000 0x100000>;
> +                                };
> +                                partition@3 {
> +                                        label = "Filesystem";
> +                                        reg = <0x520000 0x2a0000>;
> +                                };
> +                                partition@4 {
> +                                        label = "Env_and_Config_Secondary";
> +                                        reg = <0x410000 0x10000>;
> +                                };
> +                                partition@5 {
> +                                        label = "FeatFS";
> +                                        reg = <0x000000 0x400000>;
> +                                };
> +                                partition@6 {
> +                                        label = "Bootloader_Env";
> +                                        reg = <0x7d0000 0x10000>;
> +                                };
> +			};
> +		};
> +
> +                PCI0: pci@ec000000 {
> +                        device_type = "pci";
> +                        #interrupt-cells = <1>;
> +                        #size-cells = <2>;
> +                        #address-cells = <3>;
> +                        compatible = "ibm,plb405ep-pci", "ibm,plb-pci";
> +                        primary;
> +                        reg = <0xeec00000 0x00000008    /* Config space access */
> +                               0xeed80000 0x00000004    /* IACK */
> +                               0xeed80000 0x00000004    /* Special cycle */
> +                               0xef480000 0x00000040>;  /* Internal registers */
> +
> +                        /* Outbound ranges, one memory and one IO,
> +                         * later cannot be changed. Chip supports a second
> +                         * IO range but we don't use it for now
> +                         */
> +                        ranges = <0x02000000 0x00000000 0x80000000 0x80000000 0x00000000 0x20000000
> +                                  0x01000000 0x00000000 0x00000000 0xe8000000 0x00000000 0x00010000>;
> +
> +                        /* Inbound 2GB range starting at 0 */
> +                        dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x80000000>;
> +
> +			interrupt-parent = <&UIC0>;
> +                        interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> +                        interrupt-map = <
> +                                /* IDSEL 3 -- slot1 (optional) 27/29 A/B IRQ2/4 */
> +                                0x1800 0x0 0x0 0x1 &UIC0 0x1b 0x8
> +                                0x1800 0x0 0x0 0x2 &UIC0 0x1d 0x8
> +
> +                                /* IDSEL 4 -- slot0, 26/28 A/B IRQ1/3 */
> +                                0x2000 0x0 0x0 0x1 &UIC0 0x1a 0x8
> +                                0x2000 0x0 0x0 0x2 &UIC0 0x1c 0x8
> +                        >;
> +                };
> +	};
> +
> +	chosen {
> +		linux,stdout-path = &UART0;
> +	};
> +};
> diff -Naur linux-2.6.30/arch/powerpc/boot/ppcboot.h linux-2.6.30.hotfoot/arch/powerpc/boot/ppcboot.h
> --- linux-2.6.30/arch/powerpc/boot/ppcboot.h	2009-06-09 23:05:27.000000000 -0400
> +++ linux-2.6.30.hotfoot/arch/powerpc/boot/ppcboot.h	2009-07-07 12:55:18.000000000 -0400
> @@ -52,6 +52,11 @@
>  	unsigned long	bi_bootflags;	/* boot / reboot flag (for LynxOS) */
>  	unsigned long	bi_ip_addr;	/* IP Address */
>  	unsigned char	bi_enetaddr[6];	/* Ethernet address */
> +#if defined(TARGET_HOTFOOT)
> +	/* second onboard ethernet port */
> +	unsigned char	bi_enet1addr[6];
> +#define HAVE_ENET1ADDR
> +#endif /* TARGET_HOOTFOOT */
>  	unsigned short	bi_ethspeed;	/* Ethernet speed in Mbps */
>  	unsigned long	bi_intfreq;	/* Internal Freq, in MHz */
>  	unsigned long	bi_busfreq;	/* Bus Freq, in MHz */
> @@ -74,6 +79,9 @@
>  	unsigned int	bi_pci_busfreq;	/* PCI Bus speed, in Hz */
>  	unsigned char	bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
>  #endif
> +#if defined(TARGET_HOTFOOT)
> +	unsigned int     bi_pllouta_freq;       /* PLL OUTA speed, in Hz */
> +#endif
>  #if defined(TARGET_HYMOD)
>  	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
>  #endif
> @@ -94,6 +102,10 @@
>  	unsigned char	bi_enet3addr[6];
>  #define HAVE_ENET3ADDR
>  #endif
> +#if defined(TARGET_HOTFOOT)
> +        int             bi_phynum[2];           /* Determines phy mapping */
> +        int             bi_phymode[2];          /* Determines phy mode */
> +#endif
>  #if defined(TARGET_4xx)
>  	unsigned int	bi_opbfreq;		/* OB clock in Hz */
>  	int		bi_iic_fast[2];		/* Use fast i2c mode */
> diff -Naur linux-2.6.30/arch/powerpc/platforms/40x/Kconfig linux-2.6.30.hotfoot/arch/powerpc/platforms/40x/Kconfig
> --- linux-2.6.30/arch/powerpc/platforms/40x/Kconfig	2009-06-09 23:05:27.000000000 -0400
> +++ linux-2.6.30.hotfoot/arch/powerpc/platforms/40x/Kconfig	2009-07-07 12:55:18.000000000 -0400
> @@ -40,6 +40,16 @@
>  	help
>  	  This option enables support for the Nestal Maschinen HCU4 board.
>  
> +config HOTFOOT
> +        bool "Hotfoot"
> +	depends on 40x
> +	default n
> +	select 405EP
> +	select PPC40x_SIMPLE
> +	select PCI
> +        help
> +	 This option enables support for the ESTEEM 195E Hotfoot board.
> +
>  config KILAUEA
>  	bool "Kilauea"
>  	depends on 40x
> diff -Naur linux-2.6.30/arch/powerpc/platforms/40x/ppc40x_simple.c linux-2.6.30.hotfoot/arch/powerpc/platforms/40x/ppc40x_simple.c
> --- linux-2.6.30/arch/powerpc/platforms/40x/ppc40x_simple.c	2009-06-09 23:05:27.000000000 -0400
> +++ linux-2.6.30.hotfoot/arch/powerpc/platforms/40x/ppc40x_simple.c	2009-07-07 12:55:18.000000000 -0400
> @@ -51,7 +51,8 @@
>   * board.c file for it rather than adding it to this list.
>   */
>  static char *board[] __initdata = {
> -	"amcc,acadia"
> +	"amcc,acadia",
> +	"est,hotfoot"
>  };
>  
>  static int __init ppc40x_probe(void)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
