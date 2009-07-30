Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 85CDCB7BB1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 00:07:17 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UE72nL011937
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2009 10:07:02 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UE70kx2453744
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2009 10:07:00 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UE6cZj009691
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2009 08:06:38 -0600
Date: Thu, 30 Jul 2009 10:06:30 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Solomon Peachy <solomon@linux-wlan.com>
Subject: Re: [PATCH] Add support for the ESTeem 195E (PPC405EP) SBC
Message-ID: <20090730140630.GD10244@zod.rchland.ibm.com>
References: <1248448916-29473-1-git-send-email-solomon@linux-wlan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1248448916-29473-1-git-send-email-solomon@linux-wlan.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 24, 2009 at 11:21:56AM -0400, Solomon Peachy wrote:
>This patch adds support for the ESTeem 195E Hotfoot SBC.
>I've been maintaining this out-of-tree for some time now for
>older kernels, but recently I ported it to the new unified powerpc 
>tree with the intent of pushing it upstream.
>
>The 195E boards use ancient versions of u-boot and a slightly mangled
>verison of the oft-abused ppcboot header. 
>
>There are several variants of the SBC deployed, single/dual
>ethernet+serial, and also 4MB/8MB flash variations.  In the interest of
>having a single kernel image boot on all boards, the cuboot shim detects
>the differences and mangles the DTS tree appropriately.
>
>With the exception of the CF interface that was never populated on
>production boards, this code/DTS supports all boardpop options.
>
>Signed-off-by:  Solomon Peachy <solomon@linux-wlan.com>

Overall, really nice.  Just a few questions below.

>--- linux-2.6.30/arch/powerpc/boot/cuboot-hotfoot.c	1969-12-31 19:00:00.000000000 -0500
>+++ linux-2.6.30.hotfoot/arch/powerpc/boot/cuboot-hotfoot.c	2009-07-07 12:55:23.000000000 -0400
>@@ -0,0 +1,142 @@
>+/*
>+ * Old U-boot compatibility for Esteem 195E Hotfoot CPU Board
>+ *
>+ * Author: Solomon Peachy <solomon@linux-wlan.com>
>+ *
>+ * This program is free software; you can redistribute it and/or modify it
>+ * under the terms of the GNU General Public License version 2 as published
>+ * by the Free Software Foundation.
>+ */
>+
>+#include "ops.h"
>+#include "stdio.h"
>+#include "reg.h"
>+#include "dcr.h"
>+#include "4xx.h"
>+#include "cuboot.h"
>+
>+#define TARGET_4xx
>+#define TARGET_HOTFOOT
>
>+#include "ppcboot.h"
>+
>+static bd_t bd;
>+
>+#define NUM_REGS 3
>+
>+static void hotfoot_fixups(void)
>+{
>+	u32 uart = mfdcr(DCRN_CPC0_UCR) & 0x7f;
>+
>+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize); 
>+
>+	dt_fixup_cpu_clocks(bd.bi_procfreq, bd.bi_procfreq, 0);
>+	dt_fixup_clock("/plb", bd.bi_plb_busfreq);
>+	dt_fixup_clock("/plb/opb", bd.bi_opbfreq);
>+	dt_fixup_clock("/plb/ebc", bd.bi_pci_busfreq);
>+	dt_fixup_clock("/plb/opb/serial@ef600300", bd.bi_procfreq / uart); 
>+	dt_fixup_clock("/plb/opb/serial@ef600400", bd.bi_procfreq / uart); 
>+	
>+	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
>+	dt_fixup_mac_address_by_alias("ethernet1", bd.bi_enet1addr);
>+
>+	/* Is this a single eth/serial board? */
>+	if ((bd.bi_enet1addr[0] == 0) && 
>+	    (bd.bi_enet1addr[1] == 0) &&
>+	    (bd.bi_enet1addr[2] == 0) &&
>+	    (bd.bi_enet1addr[3] == 0) &&
>+	    (bd.bi_enet1addr[4] == 0) &&
>+	    (bd.bi_enet1addr[5] == 0)) {
>+		void *devp;
>+
>+		printf("Trimming devtree for single eth board\n");
>+
>+		devp = finddevice("/plb/opb/serial@ef600300");
>+		if (!devp)
>+			fatal("Can't find node for /plb/opb/serial@ef600300");
>+		del_node(devp);

Slightly confused here.  You delete the first serial node in the single eth
case?

>+
>+		devp = finddevice("/plb/opb/ethernet@ef600900");
>+		if (!devp)
>+			fatal("Can't find node for /plb/opb/ethernet@ef600900");
>+		del_node(devp);
>+	}
>+
>+	ibm4xx_quiesce_eth((u32 *)0xef600800, (u32 *)0xef600900);

Shouldn't you do the quiesce conditionally if the other eth port doesn't
exist?

>+
>+	/* Fix up flash size in fdt for 4M boards. */
>+	if (bd.bi_flashsize < 0x800000) {
>+		u32 regs[NUM_REGS];
>+		void *devp = finddevice("/plb/ebc/nor_flash@0");
>+		if (!devp)
>+			fatal("Can't find FDT node for nor_flash!??");
>+
>+		printf("Fixing devtree for 4M Flash\n");
>+		
>+		/* First fix up the base addresse */
>+		getprop(devp, "reg", regs, sizeof(regs));
>+		regs[0] = 0;
>+		regs[1] = 0xffc00000;
>+		regs[2] = 0x00400000;
>+		setprop(devp, "reg", regs, sizeof(regs));
>+		
>+		/* Then the offsets */
>+		devp = finddevice("/plb/ebc/nor_flash@0/partition@0");
>+		if (!devp)
>+			fatal("Can't find FDT node for partition@0");
>+		getprop(devp, "reg", regs, 2*sizeof(u32));
>+		regs[0] -= 0x400000;
>+		setprop(devp, "reg", regs,  2*sizeof(u32));
>+
>+		devp = finddevice("/plb/ebc/nor_flash@0/partition@1");
>+		if (!devp)
>+			fatal("Can't find FDT node for partition@1");
>+		getprop(devp, "reg", regs, 2*sizeof(u32));
>+		regs[0] -= 0x400000;
>+		setprop(devp, "reg", regs,  2*sizeof(u32));
>+
>+		devp = finddevice("/plb/ebc/nor_flash@0/partition@2");
>+		if (!devp)
>+			fatal("Can't find FDT node for partition@2");
>+		getprop(devp, "reg", regs, 2*sizeof(u32));
>+		regs[0] -= 0x400000;
>+		setprop(devp, "reg", regs,  2*sizeof(u32));
>+
>+		devp = finddevice("/plb/ebc/nor_flash@0/partition@3");
>+		if (!devp)
>+			fatal("Can't find FDT node for partition@3");
>+		getprop(devp, "reg", regs, 2*sizeof(u32));
>+		regs[0] -= 0x400000;
>+		setprop(devp, "reg", regs,  2*sizeof(u32));
>+
>+		devp = finddevice("/plb/ebc/nor_flash@0/partition@4");
>+		if (!devp)
>+			fatal("Can't find FDT node for partition@4");
>+		getprop(devp, "reg", regs, 2*sizeof(u32));
>+		regs[0] -= 0x400000;
>+		setprop(devp, "reg", regs,  2*sizeof(u32));
>+
>+		devp = finddevice("/plb/ebc/nor_flash@0/partition@6");
>+		if (!devp)
>+			fatal("Can't find FDT node for partition@6");
>+		getprop(devp, "reg", regs, 2*sizeof(u32));
>+		regs[0] -= 0x400000;
>+		setprop(devp, "reg", regs,  2*sizeof(u32));
>+
>+		/* Delete the FeatFS node */
>+		devp = finddevice("/plb/ebc/nor_flash@0/partition@5");
>+		if (!devp)
>+			fatal("Can't find FDT node for partition@5");
>+		del_node(devp);
>+	}
>+}
>+
>+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
>+		   unsigned long r6, unsigned long r7)
>+{
>+	CUBOOT_INIT();
>+	platform_ops.fixups = hotfoot_fixups;
>+        platform_ops.exit = ibm40x_dbcr_reset;
>+	fdt_init(_dtb_start);
>+	serial_console_init();
>+}
>diff -Naur linux-2.6.30/arch/powerpc/boot/dts/hotfoot.dts linux-2.6.30.hotfoot/arch/powerpc/boot/dts/hotfoot.dts
>--- linux-2.6.30/arch/powerpc/boot/dts/hotfoot.dts	1969-12-31 19:00:00.000000000 -0500
>+++ linux-2.6.30.hotfoot/arch/powerpc/boot/dts/hotfoot.dts	2009-07-07 12:55:23.000000000 -0400
>@@ -0,0 +1,299 @@
>+/*
>+ * Device Tree Source for ESTeem 195E Hotfoot
>+ *
>+ * Copyright 2009 AbsoluteValue Systems <solomon@linux-wlan.com>
>+ *
>+ * This file is licensed under the terms of the GNU General Public
>+ * License version 2.  This program is licensed "as is" without
>+ * any warranty of any kind, whether express or implied.
>+ */
>+
>+/dts-v1/;
>+
>+/ {
>+	#address-cells = <1>;
>+	#size-cells = <1>;
>+	model = "est,hotfoot";
>+	compatible = "est,hotfoot";
>+	dcr-parent = <&{/cpus/cpu@0}>;
>+
>+	aliases {
>+		ethernet0 = &EMAC0;
>+		ethernet1 = &EMAC1;
>+		serial0 = &UART0;
>+		serial1 = &UART1;
>+	};
>+
>+	cpus {
>+		#address-cells = <1>;
>+		#size-cells = <0>;
>+
>+		cpu@0 {
>+			device_type = "cpu";
>+			model = "PowerPC,405EP";
>+			reg = <0x00000000>;
>+			clock-frequency = <0>; /* Filled in by zImage */
>+			timebase-frequency = <0>; /* Filled in by zImage */
>+			i-cache-line-size = <0x20>;
>+			d-cache-line-size = <0x20>;
>+			i-cache-size = <0x4000>;
>+			d-cache-size = <0x4000>;
>+			dcr-controller;
>+			dcr-access-method = "native";
>+		};
>+	};
>+
>+	memory {
>+		device_type = "memory";
>+		reg = <0x00000000 0x00000000>; /* Filled in by zImage */
>+	};
>+
>+	UIC0: interrupt-controller {
>+		compatible = "ibm,uic";
>+		interrupt-controller;
>+		cell-index = <0>;
>+		dcr-reg = <0x0c0 0x009>;
>+		#address-cells = <0>;
>+		#size-cells = <0>;
>+		#interrupt-cells = <2>;
>+	};
>+
>+	plb {
>+		compatible = "ibm,plb3";
>+		#address-cells = <1>;
>+		#size-cells = <1>;
>+		ranges;
>+		clock-frequency = <0>; /* Filled in by zImage */
>+
>+		SDRAM0: memory-controller {
>+			compatible = "ibm,sdram-405ep";
>+			dcr-reg = <0x010 0x002>;
>+		};
>+
>+		MAL: mcmal {
>+			compatible = "ibm,mcmal-405ep", "ibm,mcmal";
>+			dcr-reg = <0x180 0x062>;
>+			num-tx-chans = <4>;
>+			num-rx-chans = <2>;
>+			interrupt-parent = <&UIC0>;
>+			interrupts = <
>+				0xb 0x4 /* TXEOB */
>+				0xc 0x4 /* RXEOB */
>+				0xa 0x4 /* SERR */
>+				0xd 0x4 /* TXDE */
>+				0xe 0x4 /* RXDE */>;
>+		};
>+
>+		POB0: opb {
>+			compatible = "ibm,opb-405ep", "ibm,opb";
>+			#address-cells = <1>;
>+			#size-cells = <1>;
>+			ranges = <0xef600000 0xef600000 0x00a00000>;
>+			dcr-reg = <0x0a0 0x005>;
>+			clock-frequency = <0>; /* Filled in by zImage */
>+
>+			/* Hotfoot has UART0/UART1 swapped */
>+
>+			UART0: serial@ef600400 {
>+				device_type = "serial";
>+				compatible = "ns16550";
>+				reg = <0xef600400 0x00000008>;
>+				virtual-reg = <0xef600400>;
>+				clock-frequency = <0>; /* Filled in by zImage */
>+				current-speed = <0x9600>;

Just a question, but is the baud supposed to be 38400 or 9600?  At first glance
it almost seems like a typo :).

>+				interrupt-parent = <&UIC0>;
>+				interrupts = <0x1 0x4>;
>+			};
>+
>+			UART1: serial@ef600300 {
>+				device_type = "serial";
>+				compatible = "ns16550";
>+				reg = <0xef600300 0x00000008>;
>+				virtual-reg = <0xef600300>;
>+				clock-frequency = <0>; /* Filled in by zImage */
>+				current-speed = <0x9600>;
>+				interrupt-parent = <&UIC0>;
>+				interrupts = <0x0 0x4>;
>+			};
>+
>+
>+			IIC: i2c@ef600500 {
>+				compatible = "ibm,iic-405ep", "ibm,iic";
>+				reg = <0xef600500 0x00000011>;
>+				interrupt-parent = <&UIC0>;
>+				interrupts = <0x2 0x4>;
>+
>+				rtc@68 {
>+				      /* Actually a DS1339 */
>+				      compatible = "dallas,ds1307"; 
>+				      reg = <0x68>;
>+				};
>+
>+				temp@4a { 
>+				      /* Not present on all boards */
>+				      compatible = "national,lm75";
>+				      reg = <0x4a>;
>+				};				
>+			};
>+
>+			GPIO: gpio@ef600700 {
>+			        #gpio-cells = <2>;
>+				compatible = "ibm,ppc4xx-gpio";
>+				reg = <0xef600700 0x00000020>;
>+				gpio-controller;
>+			};
>+
>+			gpio-leds {
>+			     compatible = "gpio-leds";
>+			     status {
>+			     	    label = "Status";
>+			     	    gpios = <&GPIO 1 0>;
>+				    /* linux,default=trigger = ".."; */

What does that comment mean?

>+			     };
>+			     radiorx {
>+			     	    label = "Rx";
>+			     	    gpios = <&GPIO 0xe 0>;
>+				    /* linux,default=trigger = ".."; */
>+			     };
>+			};
>+

<snip>

>diff -Naur linux-2.6.30/arch/powerpc/boot/ppcboot.h linux-2.6.30.hotfoot/arch/powerpc/boot/ppcboot.h
>--- linux-2.6.30/arch/powerpc/boot/ppcboot.h	2009-06-09 23:05:27.000000000 -0400
>+++ linux-2.6.30.hotfoot/arch/powerpc/boot/ppcboot.h	2009-07-07 12:55:18.000000000 -0400
>@@ -52,6 +52,11 @@
> 	unsigned long	bi_bootflags;	/* boot / reboot flag (for LynxOS) */
> 	unsigned long	bi_ip_addr;	/* IP Address */
> 	unsigned char	bi_enetaddr[6];	/* Ethernet address */
>+#if defined(TARGET_HOTFOOT)
>+	/* second onboard ethernet port */
>+	unsigned char	bi_enet1addr[6];
>+#define HAVE_ENET1ADDR
>+#endif /* TARGET_HOOTFOOT */
> 	unsigned short	bi_ethspeed;	/* Ethernet speed in Mbps */
> 	unsigned long	bi_intfreq;	/* Internal Freq, in MHz */
> 	unsigned long	bi_busfreq;	/* Bus Freq, in MHz */
>@@ -74,6 +79,9 @@
> 	unsigned int	bi_pci_busfreq;	/* PCI Bus speed, in Hz */
> 	unsigned char	bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
> #endif
>+#if defined(TARGET_HOTFOOT)
>+	unsigned int     bi_pllouta_freq;       /* PLL OUTA speed, in Hz */
>+#endif
> #if defined(TARGET_HYMOD)
> 	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
> #endif
>@@ -94,6 +102,10 @@
> 	unsigned char	bi_enet3addr[6];
> #define HAVE_ENET3ADDR
> #endif
>+#if defined(TARGET_HOTFOOT)
>+        int             bi_phynum[2];           /* Determines phy mapping */
>+        int             bi_phymode[2];          /* Determines phy mode */
>+#endif
> #if defined(TARGET_4xx)
> 	unsigned int	bi_opbfreq;		/* OB clock in Hz */
> 	int		bi_iic_fast[2];		/* Use fast i2c mode */

Ok.  So I'm not really all that thrilled with changes to ppcboot.h.  We try to
keep this file as much in-sync with U-Boot as we can.  Did your HOTFOOT changes
get pulled into upstream U-Boot?

josh
