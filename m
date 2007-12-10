Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49585DDE17
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 15:57:12 +1100 (EST)
Subject: Re: [PATCH 16/25] powerpc: EP405 boards support for arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071206210550.520e5131@zod.rchland.ibm.com>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080127.1F2ACDDED0@ozlabs.org>
	<20071206210550.520e5131@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 10 Dec 2007 15:56:46 +1100
Message-Id: <1197262606.6563.50.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: EP405 boards support for arch/powerpc

Brings EP405 support to arch/powerpc. The IRQ routing for the CPLD
comes from a device-tree property, PCI is working to the point where
I can see the video card, USB device, and south bridge.

This should work with both EP405 and EP405PC.

I've not totally figured out how IRQs are wired on this hardware
though, thus at this stage, expect only USB interrupts working,
pretty much the same as what arch/ppc did.

Also, the flash, nvram, rtc and temp control still have to be wired.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note about IRQ routing: The doc is very obscure in that area.

I _think_ the SB interrupt on the CPLD is actually the Windond's
8259 output and the NB interrupt is the PCI_A...PCI_D mux in
there (which can be implemented as a cascaded controller) but
I haven't sorted that out yet. If anybody from Embedded Planet
is around, I could use some advice there.

If my deductions are correct, then we would need to wire up the
8259 driver to SB, which should be trivial provided I stick the
windbond bridge in the device-tree, or at least part of it,
and probably implement a cascaded controller for the PCI IRQ
A...D mux thingy, which should also be trivial.

Note also that it tends to lockup during the transition from
the boot wrapper to the kernel, before udbg is started. I didn't
have a RiscWatch at hand so I haven't yet been able to track that
down. It's random though, quite weird. Maybe some stale TLB entries
or cache content that isn't cleared properly...

Index: linux-work/arch/powerpc/boot/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/boot/Makefile	2007-12-10 15:52:04.000000000 +1100
+++ linux-work/arch/powerpc/boot/Makefile	2007-12-10 15:54:23.000000000 +1100
@@ -56,7 +56,7 @@ src-plat := of.c cuboot-52xx.c cuboot-83
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
-		fixed-head.S ep88xc.c cuboot-hpc2.c
+		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -150,6 +150,7 @@ image-$(CONFIG_DEFAULT_UIMAGE)		+= uImag
 ifneq ($(CONFIG_DEVICE_TREE),"")
 image-$(CONFIG_PPC_8xx)			+= cuImage.8xx
 image-$(CONFIG_PPC_EP88XC)		+= zImage.ep88xc
+image-$(CONFIG_EP405)			+= zImage.ep405
 image-$(CONFIG_8260)			+= cuImage.pq2
 image-$(CONFIG_PPC_MPC52xx)		+= cuImage.52xx
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
Index: linux-work/arch/powerpc/boot/ep405.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/boot/ep405.c	2007-12-10 15:54:23.000000000 +1100
@@ -0,0 +1,74 @@
+/*
+ * Embedded Planet EP405 with PlanetCore firmware
+ *
+ * (c) Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp,\
+ *
+ * Based on ep88xc.c by
+ *
+ * Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "planetcore.h"
+#include "dcr.h"
+#include "4xx.h"
+#include "io.h"
+
+static char *table;
+static u64 mem_size;
+
+static void platform_fixups(void)
+{
+	u64 val;
+	void *nvrtc;
+
+	dt_fixup_memory(0, mem_size);
+	planetcore_set_mac_addrs(table);
+
+	if (!planetcore_get_decimal(table, PLANETCORE_KEY_CRYSTAL_HZ, &val)) {
+		printf("No PlanetCore crystal frequency key.\r\n");
+		return;
+	}
+	ibm405gp_fixup_clocks(val, 0xa8c000);
+	ibm4xx_quiesce_eth((u32 *)0xef600800, NULL);
+	ibm4xx_fixup_ebc_ranges("/plb/ebc");
+
+	if (!planetcore_get_decimal(table, PLANETCORE_KEY_KB_NVRAM, &val)) {
+		printf("No PlanetCore NVRAM size key.\r\n");
+		return;
+	}
+	nvrtc = finddevice("/plb/ebc/nvrtc@4,200000");
+	if (nvrtc != NULL) {
+		u32 reg[3] = { 4, 0x200000, 0};
+		getprop(nvrtc, "reg", reg, 3);
+		reg[2] = (val << 10) & 0xffffffff;
+		setprop(nvrtc, "reg", reg, 3);
+	}
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		   unsigned long r6, unsigned long r7)
+{
+	table = (char *)r3;
+	planetcore_prepare_table(table);
+
+	if (!planetcore_get_decimal(table, PLANETCORE_KEY_MB_RAM, &mem_size))
+		return;
+
+	mem_size *= 1024 * 1024;
+	simple_alloc_init(_end, mem_size - (unsigned long)_end, 32, 64);
+
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+
+	planetcore_set_stdout_path(table);
+
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
Index: linux-work/arch/powerpc/boot/dts/ep405.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/boot/dts/ep405.dts	2007-12-10 15:55:04.000000000 +1100
@@ -0,0 +1,221 @@
+/*
+ * Device Tree Source for EP405
+ *
+ * Copyright 2007 IBM Corp.
+ * Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	model = "ep405";
+	compatible = "ep405";
+	dcr-parent = <&/cpus/PowerPC,405GP@0>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,405GP@0 {
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <bebc200>; /* Filled in by zImage */
+			timebase-frequency = <0>; /* Filled in by zImage */
+			i-cache-line-size = <20>;
+			d-cache-line-size = <20>;
+			i-cache-size = <4000>;
+			d-cache-size = <4000>;
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0>; /* Filled in by zImage */
+	};
+
+	UIC0: interrupt-controller {
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0c0 9>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	plb {
+		compatible = "ibm,plb3";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by zImage */
+
+		SDRAM0: memory-controller {
+			compatible = "ibm,sdram-405gp";
+			dcr-reg = <010 2>;
+		};
+
+		MAL: mcmal {
+			compatible = "ibm,mcmal-405gp", "ibm,mcmal";
+			dcr-reg = <180 62>;
+			num-tx-chans = <1>;
+			num-rx-chans = <1>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <
+				b 4 /* TXEOB */
+				c 4 /* RXEOB */
+				a 4 /* SERR */
+				d 4 /* TXDE */
+				e 4 /* RXDE */>;
+		};
+
+		POB0: opb {
+			compatible = "ibm,opb-405gp", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <ef600000 ef600000 a00000>;
+			dcr-reg = <0a0 5>;
+			clock-frequency = <0>; /* Filled in by zImage */
+
+			UART0: serial@ef600300 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <ef600300 8>;
+				virtual-reg = <ef600300>;
+				clock-frequency = <0>; /* Filled in by zImage */
+				current-speed = <2580>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0 4>;
+			};
+
+			UART1: serial@ef600400 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <ef600400 8>;
+				virtual-reg = <ef600400>;
+				clock-frequency = <0>; /* Filled in by zImage */
+				current-speed = <2580>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <1 4>;
+			};
+
+			IIC: i2c@ef600500 {
+				compatible = "ibm,iic-405gp", "ibm,iic";
+				reg = <ef600500 11>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <2 4>;
+			};
+
+			GPIO: gpio@ef600700 {
+				compatible = "ibm,gpio-405gp";
+				reg = <ef600700 20>;
+			};
+
+			EMAC: ethernet@ef600800 {
+				linux,network-index = <0>;
+				device_type = "network";
+				compatible = "ibm,emac-405gp", "ibm,emac";
+				interrupt-parent = <&UIC0>;
+				interrupts = <
+					f 4 /* Ethernet */
+					9 4 /* Ethernet Wake Up */>;
+				local-mac-address = [000000000000]; /* Filled in by zImage */
+				reg = <ef600800 70>;
+				mal-device = <&MAL>;
+				mal-tx-channel = <0>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "rmii";
+				phy-map = <00000000>;
+			};
+
+		};
+
+		EBC0: ebc {
+			compatible = "ibm,ebc-405gp", "ibm,ebc";
+			dcr-reg = <012 2>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+
+
+			/* The ranges property is supplied by the bootwrapper
+			 * and is based on the firmware's configuration of the
+			 * EBC bridge
+			 */
+			clock-frequency = <0>; /* Filled in by zImage */
+
+			/* NVRAM and RTC */
+			nvrtc@4,200000 {
+				compatible = "ds1742";
+				reg = <4 200000 0>; /* size fixed up by zImage */
+			};
+
+			/* "BCSR" CPLD contains a PCI irq controller */
+			bcsr@4,0 {
+				compatible = "ep405-bcsr";
+				reg = <4 0 10>;
+				interrupt-controller;
+				/* Routing table */
+				irq-routing = [	00	/* SYSERR */
+						01	/* STTM */
+						01	/* RTC */
+						01	/* FENET */
+						02	/* NB PCIIRQ mux ? */
+						03	/* SB Winbond 8259 ? */
+						04	/* Serial Ring */
+						05	/* USB (ep405pc) */
+						06	/* XIRQ 0 */
+						06	/* XIRQ 1 */
+						06	/* XIRQ 2 */
+						06	/* XIRQ 3 */
+						06	/* XIRQ 4 */
+						06	/* XIRQ 5 */
+						06	/* XIRQ 6 */
+						07];	/* Reserved */
+			};
+		};
+
+		PCI0: pci@ec000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb405gp-pci", "ibm,plb-pci";
+			primary;
+			reg = <eec00000 8	/* Config space access */
+			       eed80000 4	/* IACK */
+			       eed80000 4	/* Special cycle */
+			       ef480000 40>;	/* Internal registers */
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed. Chip supports a second
+			 * IO range but we don't use it for now
+			 */
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 e8000000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <42000000 0 0 0 0 80000000>;
+
+			/* That's all I know about IRQs on that thing ... */
+			interrupt-map-mask = <f800 0 0 0>;
+			interrupt-map = <
+				/* USB */
+				7000 0 0 0 &UIC0 1e 8 /* IRQ5 */
+			>;
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@ef600300";
+	};
+};
Index: linux-work/arch/powerpc/boot/4xx.c
===================================================================
--- linux-work.orig/arch/powerpc/boot/4xx.c	2007-12-10 15:52:04.000000000 +1100
+++ linux-work/arch/powerpc/boot/4xx.c	2007-12-10 15:54:23.000000000 +1100
@@ -179,13 +179,16 @@ void ibm40x_dbcr_reset(void)
 #define EMAC_RESET 0x20000000
 void ibm4xx_quiesce_eth(u32 *emac0, u32 *emac1)
 {
-	/* Quiesce the MAL and EMAC(s) since PIBS/OpenBIOS don't do this for us */
+	/* Quiesce the MAL and EMAC(s) since PIBS/OpenBIOS don't
+	 * do this for us
+	 */
 	if (emac0)
 		*emac0 = EMAC_RESET;
 	if (emac1)
 		*emac1 = EMAC_RESET;
 
 	mtdcr(DCRN_MAL0_CFG, MAL_RESET);
+	while (mfdcr(DCRN_MAL0_CFG) & MAL_RESET) {};
 }
 
 /* Read 4xx EBC bus bridge registers to get mappings of the peripheral
@@ -298,3 +301,53 @@ void ibm440ep_fixup_clocks(unsigned int 
 	dt_fixup_clock("/plb/opb/serial@ef600500", uart0);
 	dt_fixup_clock("/plb/opb/serial@ef600600", uart0);
 }
+
+void ibm405gp_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
+{
+	u32 pllmr = mfdcr(DCRN_CPC0_PLLMR);
+	u32 cpc0_cr0 = mfdcr(DCRN_405_CPC0_CR0);
+	u32 cpc0_cr1 = mfdcr(DCRN_405_CPC0_CR1);
+	u32 cpu, plb, opb, ebc, tb, uart0, uart1, m;
+	u32 fwdv, fbdv, cbdv, opdv, epdv, udiv;
+
+	fwdv = (8 - ((pllmr & 0xe0000000) >> 29));
+	fbdv = (pllmr & 0x1e000000) >> 25;
+	cbdv = ((pllmr & 0x00060000) >> 17) + 1;
+	opdv = ((pllmr & 0x00018000) >> 15) + 1;
+	epdv = ((pllmr & 0x00001800) >> 13) + 2;
+	udiv = ((cpc0_cr0 & 0x3e) >> 1) + 1;
+
+	m = fwdv * fbdv * cbdv;
+
+	cpu = sysclk * m / fwdv;
+	plb = cpu / cbdv;
+	opb = plb / opdv;
+	ebc = plb / epdv;
+
+	if (cpc0_cr0 & 0x80) {
+		/* uart0 uses the external clock */
+		uart0 = ser_clk;
+	} else {
+		uart0 = cpu / udiv;
+	}
+
+	if (cpc0_cr0 & 0x40) {
+		/* uart1 uses the external clock */
+		uart1 = ser_clk;
+	} else {
+		uart1 = cpu / udiv;
+	}
+
+	/* setup the timebase clock to tick at the cpu frequency */
+	cpc0_cr1 = cpc0_cr1 & ~0x00800000;
+	mtdcr(DCRN_405_CPC0_CR1, cpc0_cr1);
+	tb = cpu;
+
+	dt_fixup_cpu_clocks(cpu, tb, 0);
+	dt_fixup_clock("/plb", plb);
+	dt_fixup_clock("/plb/opb", opb);
+	dt_fixup_clock("/plb/ebc", ebc);
+	dt_fixup_clock("/plb/opb/serial@ef600300", uart0);
+	dt_fixup_clock("/plb/opb/serial@ef600400", uart1);
+}
+
Index: linux-work/arch/powerpc/boot/treeboot-walnut.c
===================================================================
--- linux-work.orig/arch/powerpc/boot/treeboot-walnut.c	2007-12-10 15:52:04.000000000 +1100
+++ linux-work/arch/powerpc/boot/treeboot-walnut.c	2007-12-10 15:54:23.000000000 +1100
@@ -20,55 +20,6 @@
 
 BSS_STACK(4096);
 
-void ibm405gp_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
-{
-	u32 pllmr = mfdcr(DCRN_CPC0_PLLMR);
-	u32 cpc0_cr0 = mfdcr(DCRN_405_CPC0_CR0);
-	u32 cpc0_cr1 = mfdcr(DCRN_405_CPC0_CR1);
-	u32 cpu, plb, opb, ebc, tb, uart0, uart1, m;
-	u32 fwdv, fbdv, cbdv, opdv, epdv, udiv;
-
-	fwdv = (8 - ((pllmr & 0xe0000000) >> 29));
-	fbdv = (pllmr & 0x1e000000) >> 25;
-	cbdv = ((pllmr & 0x00060000) >> 17) + 1;
-	opdv = ((pllmr & 0x00018000) >> 15) + 1;
-	epdv = ((pllmr & 0x00001800) >> 13) + 2;
-	udiv = ((cpc0_cr0 & 0x3e) >> 1) + 1;
-
-	m = fwdv * fbdv * cbdv;
-
-	cpu = sysclk * m / fwdv;
-	plb = cpu / cbdv;
-	opb = plb / opdv;
-	ebc = plb / epdv;
-
-	if (cpc0_cr0 & 0x80) {
-		/* uart0 uses the external clock */
-		uart0 = ser_clk;
-	} else {
-		uart0 = cpu / udiv;
-	}
-
-	if (cpc0_cr0 & 0x40) {
-		/* uart1 uses the external clock */
-		uart1 = ser_clk;
-	} else {
-		uart1 = cpu / udiv;
-	}
-
-	/* setup the timebase clock to tick at the cpu frequency */
-	cpc0_cr1 = cpc0_cr1 & ~0x00800000;
-	mtdcr(DCRN_405_CPC0_CR1, cpc0_cr1);
-	tb = cpu;
-
-	dt_fixup_cpu_clocks(cpu, tb, 0);
-	dt_fixup_clock("/plb", plb);
-	dt_fixup_clock("/plb/opb", opb);
-	dt_fixup_clock("/plb/ebc", ebc);
-	dt_fixup_clock("/plb/opb/serial@ef600300", uart0);
-	dt_fixup_clock("/plb/opb/serial@ef600400", uart1);
-}
-
 static void walnut_flashsel_fixup(void)
 {
 	void *devp, *sram;
Index: linux-work/arch/powerpc/platforms/40x/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/40x/Kconfig	2007-12-10 15:52:04.000000000 +1100
+++ linux-work/arch/powerpc/platforms/40x/Kconfig	2007-12-10 15:54:23.000000000 +1100
@@ -14,20 +14,13 @@
 #	help
 #	  This option enables support for the CPCI405 board.
 
-#config EP405
-#	bool "EP405/EP405PC"
-#	depends on 40x
-#	default n
-#	select 405GP
-#	help
-#	  This option enables support for the EP405/EP405PC boards.
-
-#config EP405PC
-#	bool "EP405PC Support"
-#	depends on EP405
-#	default y
-#	help
-#	  This option enables support for the extra features of the EP405PC board.
+config EP405
+	bool "EP405/EP405PC"
+	depends on 40x
+	default n
+	select 405GP
+	help
+	  This option enables support for the EP405/EP405PC boards.
 
 config KILAUEA
 	bool "Kilauea"
Index: linux-work/arch/powerpc/platforms/40x/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/platforms/40x/Makefile	2007-12-10 15:52:04.000000000 +1100
+++ linux-work/arch/powerpc/platforms/40x/Makefile	2007-12-10 15:54:23.000000000 +1100
@@ -1,3 +1,4 @@
 obj-$(CONFIG_KILAUEA)				+= kilauea.o
 obj-$(CONFIG_WALNUT)				+= walnut.o
 obj-$(CONFIG_XILINX_VIRTEX_GENERIC_BOARD)	+= virtex.o
+obj-$(CONFIG_EP405)				+= ep405.o
Index: linux-work/arch/powerpc/platforms/40x/ep405.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/platforms/40x/ep405.c	2007-12-10 15:55:38.000000000 +1100
@@ -0,0 +1,124 @@
+/*
+ * Architecture- / platform-specific boot-time initialization code for
+ * IBM PowerPC 4xx based boards. Adapted from original
+ * code by Gary Thomas, Cort Dougan <cort@fsmlabs.com>, and Dan Malek
+ * <dan@net4x.com>.
+ *
+ * Copyright(c) 1999-2000 Grant Erickson <grant@lcse.umn.edu>
+ *
+ * Rewritten and ported to the merged powerpc tree:
+ * Copyright 2007 IBM Corporation
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * Adapted to EP405 by Ben. Herrenschmidt <benh@kernel.crashing.org>
+ *
+ * TODO: Wire up the PCI IRQ mux and the southbridge interrupts
+ *
+ * 2002 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/pci-bridge.h>
+
+static struct device_node *bcsr_node;
+static void __iomem *bcsr_regs;
+
+/* BCSR registers  */
+#define BCSR_ID			0
+#define BCSR_PCI_CTRL	       	1
+#define BCSR_FLASH_NV_POR_CTRL	2
+#define BCSR_FENET_UART_CTRL	3
+#define BCSR_PCI_IRQ		4
+#define BCSR_XIRQ_SELECT	5
+#define BCSR_XIRQ_ROUTING	6
+#define BCSR_XIRQ_STATUS	7
+#define BCSR_XIRQ_STATUS2	8
+#define BCSR_SW_STAT_LED_CTRL	9
+#define BCSR_GPIO_IRQ_PAR_CTRL	10
+/* there's more, can't be bothered typing them tho */
+
+
+static struct of_device_id ep405_of_bus[] = {
+	{ .compatible = "ibm,plb3", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init ep405_device_probe(void)
+{
+	if (!machine_is(ep405))
+		return 0;
+
+	of_platform_bus_probe(NULL, ep405_of_bus, NULL);
+
+	return 0;
+}
+device_initcall(ep405_device_probe);
+
+static void __init ep405_init_bcsr(void)
+{
+	const u8 *irq_routing;
+	int i;
+
+	/* Find the bloody thing & map it */
+	bcsr_node = of_find_compatible_node(NULL, NULL, "ep405-bcsr");
+	if (bcsr_node == NULL) {
+		printk(KERN_ERR "EP405 BCSR not found !\n");
+		return;
+	}
+	bcsr_regs = of_iomap(bcsr_node, 0);
+	if (bcsr_regs == NULL) {
+		printk(KERN_ERR "EP405 BCSR failed to map !\n");
+		return;
+	}
+
+	/* Get the irq-routing property and apply the routing to the CPLD */
+	irq_routing = of_get_property(bcsr_node, "irq-routing", NULL);
+	if (irq_routing == NULL)
+		return;
+	for (i = 0; i < 16; i++) {
+		u8 irq = irq_routing[i];
+		out_8(bcsr_regs + BCSR_XIRQ_SELECT, i);
+		out_8(bcsr_regs + BCSR_XIRQ_ROUTING, irq);
+	}
+	in_8(bcsr_regs + BCSR_XIRQ_SELECT);
+	mb();
+	out_8(bcsr_regs + BCSR_GPIO_IRQ_PAR_CTRL, 0xfe);
+}
+
+static void __init ep405_setup_arch(void)
+{
+	/* Find & init the BCSR CPLD */
+	ep405_init_bcsr();
+}
+
+static int __init ep405_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "ep405"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(ep405) {
+	.name			= "EP405",
+	.probe			= ep405_probe,
+	.setup_arch		= ep405_setup_arch,
+	.progress		= udbg_progress,
+	.init_IRQ		= uic_init_tree,
+	.get_irq		= uic_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+};
Index: linux-work/arch/powerpc/boot/4xx.h
===================================================================
--- linux-work.orig/arch/powerpc/boot/4xx.h	2007-12-10 15:52:04.000000000 +1100
+++ linux-work/arch/powerpc/boot/4xx.h	2007-12-10 15:54:23.000000000 +1100
@@ -18,5 +18,6 @@ void ibm40x_dbcr_reset(void);
 void ibm4xx_quiesce_eth(u32 *emac0, u32 *emac1);
 void ibm4xx_fixup_ebc_ranges(const char *ebc);
 void ibm440ep_fixup_clocks(unsigned int sysclk, unsigned int ser_clk);
+void ibm405gp_fixup_clocks(unsigned int sysclk, unsigned int ser_clk);
 
 #endif /* _POWERPC_BOOT_4XX_H_ */
Index: linux-work/arch/powerpc/boot/wrapper
===================================================================
--- linux-work.orig/arch/powerpc/boot/wrapper	2007-12-10 15:52:04.000000000 +1100
+++ linux-work/arch/powerpc/boot/wrapper	2007-12-10 15:54:23.000000000 +1100
@@ -163,7 +163,7 @@ ps3)
     ksection=.kernel:vmlinux.bin
     isection=.kernel:initrd
     ;;
-ep88xc)
+ep88xc|ep405)
     platformo="$object/fixed-head.o $object/$platform.o"
     binary=y
     ;;
Index: linux-work/arch/powerpc/configs/ep405_defconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/configs/ep405_defconfig	2007-12-10 15:54:23.000000000 +1100
@@ -0,0 +1,951 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.24-rc2
+# Wed Nov 21 16:44:30 2007
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_6xx is not set
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+CONFIG_40x=y
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_4xx=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_NOT_COHERENT_CACHE=y
+CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_IRQ_PER_CPU=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_OF=y
+CONFIG_PPC_UDBG_16550=y
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+# CONFIG_DEFAULT_UIMAGE is not set
+CONFIG_PPC_DCR_NATIVE=y
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_PPC_DCR=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+CONFIG_BLOCK=y
+CONFIG_LBD=y
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
+# Platform support
+#
+# CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PQ2ADS is not set
+CONFIG_EP405=y
+# CONFIG_KILAUEA is not set
+# CONFIG_WALNUT is not set
+# CONFIG_XILINX_VIRTEX_GENERIC_BOARD is not set
+CONFIG_405GP=y
+CONFIG_IBM405_ERR77=y
+CONFIG_IBM405_ERR51=y
+# CONFIG_MPIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_CPM2 is not set
+# CONFIG_FSL_ULI1575 is not set
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_MATH_EMULATION is not set
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
+CONFIG_SECCOMP=y
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE="ep405.dts"
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
+CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0xc0000000
+CONFIG_CONSISTENT_START=0xff100000
+CONFIG_CONSISTENT_SIZE=0x00200000
+CONFIG_BOOT_LOAD=0x00400000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+CONFIG_CONNECTOR=y
+CONFIG_PROC_EVENTS=y
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=m
+CONFIG_MTD_BLOCK=m
+# CONFIG_MTD_BLOCK_RO is not set
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+CONFIG_OF_DEVICE=y
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=35000
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_XILINX_SYSACE is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_PHANTOM is not set
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_IP1000 is not set
+# CONFIG_ARCNET is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_IBM_NEW_EMAC=y
+CONFIG_IBM_NEW_EMAC_RXB=128
+CONFIG_IBM_NEW_EMAC_TXB=64
+CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=32
+CONFIG_IBM_NEW_EMAC_RX_COPY_THRESHOLD=256
+CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=0
+# CONFIG_IBM_NEW_EMAC_DEBUG is not set
+CONFIG_IBM_NEW_EMAC_ZMII=y
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
+CONFIG_NETDEV_10000=y
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGBE is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+# CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
+# CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
+# CONFIG_TR is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_EXTENDED=y
+# CONFIG_SERIAL_8250_MANY_PORTS is not set
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+# CONFIG_SERIAL_8250_DETECT_IRQ is not set
+# CONFIG_SERIAL_8250_RSA is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+# CONFIG_I2C is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_DAB is not set
+
+#
+# Graphics support
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PPC_OF=y
+CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
+CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
+CONFIG_USB_OHCI_HCD_PCI=y
+CONFIG_USB_OHCI_BIG_ENDIAN_DESC=y
+CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# may also be needed; see USB_STORAGE Help for more information
+#
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+
+#
+# USB DSL modem support
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+# CONFIG_MMC is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_INFINIBAND is not set
+# CONFIG_EDAC is not set
+# CONFIG_RTC_CLASS is not set
+
+#
+# Userspace I/O
+#
+# CONFIG_UIO is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4DEV_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
+CONFIG_CRAMFS=y
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_NLS is not set
+# CONFIG_DLM is not set
+# CONFIG_UCC_SLOW is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_INSTRUMENTATION=y
+# CONFIG_PROFILING is not set
+# CONFIG_KPROBES is not set
+# CONFIG_MARKERS is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_DEBUGGER is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=y
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_XTS is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_PPC_CLOCK is not set
