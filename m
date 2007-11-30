Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2007 17:11:01 +1100
Subject: [PATCH 18/24] powerpc: Base support for 440GX Taishan eval board
In-Reply-To: <1196403038.569525.367459803520.qpush@grosgo>
Message-Id: <20071130061203.B6239DDED7@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Hugh Blemings <hugh@blemings.org>


Signed-off-by: Hugh Blemings <hugh@blemings.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This needs a bit of cleanup still, probably not to be merged as-is
just yet (like using mtdcri/mfdcri for CPR access).

 arch/powerpc/Kconfig.debug           |    6 
 arch/powerpc/boot/44x.h              |    1 
 arch/powerpc/boot/Makefile           |    7 
 arch/powerpc/boot/cuboot-taishan.c   |   35 ++
 arch/powerpc/boot/dcr.h              |   32 ++
 arch/powerpc/boot/dts/taishan.dts    |  414 +++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/taishan.c          |   64 +++++
 arch/powerpc/platforms/44x/Kconfig   |   12 +
 arch/powerpc/platforms/44x/Makefile  |    1 
 arch/powerpc/platforms/44x/taishan.c |   74 ++++++
 10 files changed, 643 insertions(+), 3 deletions(-)

Index: linux-work/arch/powerpc/boot/44x.h
===================================================================
--- linux-work.orig/arch/powerpc/boot/44x.h	2007-11-30 13:27:01.000000000 +1100
+++ linux-work/arch/powerpc/boot/44x.h	2007-11-30 13:39:18.000000000 +1100
@@ -12,5 +12,6 @@
 
 void ebony_init(void *mac0, void *mac1);
 void bamboo_init(void *mac0, void *mac1);
+void taishan_init(void *mac0, void *mac1);
 
 #endif /* _PPC_BOOT_44X_H_ */
Index: linux-work/arch/powerpc/boot/dcr.h
===================================================================
--- linux-work.orig/arch/powerpc/boot/dcr.h	2007-11-30 13:27:01.000000000 +1100
+++ linux-work/arch/powerpc/boot/dcr.h	2007-11-30 13:39:18.000000000 +1100
@@ -139,4 +139,36 @@ static const unsigned long sdram_bxcr[] 
 #define DCRN_405_CPC0_CR0 0xb1
 #define DCRN_405_CPC0_CR1 0xb2
 
+
+/* 440GX Clock control etc */
+
+
+#define DCRN_CPR0_CLKUPD				0x020
+#define DCRN_CPR0_PLLC					0x040
+#define DCRN_CPR0_PLLD					0x060
+#define DCRN_CPR0_PRIMAD				0x080
+#define DCRN_CPR0_PRIMBD				0x0a0
+#define DCRN_CPR0_OPBD					0x0c0
+#define DCRN_CPR0_PERD					0x0e0
+#define DCRN_CPR0_MALD					0x100
+
+//#define	  CPC0_SYS0_TUNE				  0xffc00000
+//#define	  CPC0_SYS0_FBDV_MASK				  0x003c0000
+//#define	  CPC0_SYS0_FWDVA_MASK				  0x00038000
+
+
+/* CPRs read/write helper macros - based off include/asm-ppc/ibm44x.h */
+
+#define DCRN_CPR0_CFGADDR				0xc
+#define DCRN_CPR0_CFGDATA				0xd
+
+#define CPR0_READ(offset) ({\
+        mtdcr(DCRN_CPR0_CFGADDR, offset); \
+        mfdcr(DCRN_CPR0_CFGDATA);})
+#define CPR0_WRITE(offset, data) ({\
+        mtdcr(DCRN_CPR0_CFGADDR, offset); \
+        mtdcr(DCRN_CPR0_CFGDATA, data);})
+
+
+
 #endif	/* _PPC_BOOT_DCR_H_ */
Index: linux-work/arch/powerpc/boot/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/boot/Makefile	2007-11-30 13:38:25.000000000 +1100
+++ linux-work/arch/powerpc/boot/Makefile	2007-11-30 13:39:18.000000000 +1100
@@ -37,8 +37,10 @@ BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(ob
 
 $(obj)/4xx.o: BOOTCFLAGS += -mcpu=440
 $(obj)/ebony.o: BOOTCFLAGS += -mcpu=440
+$(obj)/taishan.o: BOOTCFLAGS += -mcpu=440
 $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
 
+
 zlib       := inffast.c inflate.c inftrees.c
 zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h
 zliblinuxheader := zlib.h zconf.h zutil.h
@@ -51,12 +53,12 @@ src-wlib := string.S crt0.S stdio.c main
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
 		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
-		fsl-soc.c mpc8xx.c pq2.c
+		fsl-soc.c mpc8xx.c pq2.c taishan.c
 src-plat := of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
-		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c
+		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c cuboot-taishan.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -160,6 +162,7 @@ image-$(CONFIG_EBONY)			+= treeImage.ebo
 image-$(CONFIG_BAMBOO)			+= treeImage.bamboo #cuImage.bamboo
 #image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
+image-$(CONFIG_TAISHAN)			+= cuImage.taishan
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
Index: linux-work/arch/powerpc/Kconfig.debug
===================================================================
--- linux-work.orig/arch/powerpc/Kconfig.debug	2007-11-30 13:38:22.000000000 +1100
+++ linux-work/arch/powerpc/Kconfig.debug	2007-11-30 13:39:18.000000000 +1100
@@ -218,7 +218,8 @@ config PPC_EARLY_DEBUG_44x
 	depends on 44x
 	help
 	  Select this to enable early debugging for IBM 44x chips via the
-	  inbuilt serial port.
+	  inbuilt serial port.  If you enable this, ensure you set
+          PPC_EARLY_DEBUG_44x_PHYSLOW below to suit your target board.
 
 config PPC_EARLY_DEBUG_40x
 	bool "Early serial debugging for IBM/AMCC 40x CPUs"
@@ -243,6 +244,9 @@ config PPC_EARLY_DEBUG_44x_PHYSLOW
 	hex "Low 32 bits of early debug UART physical address"
 	depends on PPC_EARLY_DEBUG_44x
 	default "0x40000200"
+	help
+	  You probably want 0x40000200 for ebony boards and
+          0x40000300 for taishan
 
 config PPC_EARLY_DEBUG_44x_PHYSHIGH
 	hex "EPRN of early debug UART physical address"
Index: linux-work/arch/powerpc/platforms/44x/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/Kconfig	2007-11-30 13:29:18.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/Kconfig	2007-11-30 13:39:18.000000000 +1100
@@ -22,6 +22,14 @@ config SEQUOIA
 	help
 	  This option enables support for the AMCC PPC440EPX evaluation board.
 
+config TAISHAN
+	bool "Taishan"
+	depends on 44x
+	default n
+	select 440GX
+	help
+	  This option enables support for the IBM PPC440GX "Taishan" evaluation board.
+
 #config LUAN
 #	bool "Luan"
 #	depends on 44x
@@ -58,6 +66,10 @@ config 440GP
 
 config 440GX
 	bool
+        select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_RGMII
+        select IBM_NEW_EMAC_ZMII #test only
+        select IBM_NEW_EMAC_TAH  #test only
 
 config 440SP
 	bool
Index: linux-work/arch/powerpc/platforms/44x/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/Makefile	2007-11-30 13:27:01.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/Makefile	2007-11-30 13:39:18.000000000 +1100
@@ -1,4 +1,5 @@
 obj-$(CONFIG_44x)	:= misc_44x.o
 obj-$(CONFIG_EBONY)	+= ebony.o
+obj-$(CONFIG_TAISHAN)	+= taishan.o
 obj-$(CONFIG_BAMBOO) += bamboo.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
Index: linux-work/arch/powerpc/platforms/44x/taishan.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/platforms/44x/taishan.c	2007-11-30 13:39:37.000000000 +1100
@@ -0,0 +1,74 @@
+/*
+ * Taishan board specific routines based off ebony.c code
+ * original copyrights below
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ * Copyright 2002-2005 MontaVista Software Inc.
+ *
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2003-2005 Zultys Technologies
+ *
+ * Rewritten and ported to the merged powerpc tree:
+ * Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
+ *
+ * Modified from ebony.c for taishan:
+ * Copyright 2007 Hugh Blemings <hugh@au.ibm.com>, IBM Corporation.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
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
+#include "44x.h"
+
+static struct of_device_id taishan_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init taishan_device_probe(void)
+{
+	if (!machine_is(taishan))
+		return 0;
+
+	of_platform_bus_probe(NULL, taishan_of_bus, NULL);
+
+	return 0;
+}
+device_initcall(taishan_device_probe);
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init taishan_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "ibm,taishan"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(taishan) {
+	.name			= "Taishan",
+	.probe			= taishan_probe,
+	.progress		= udbg_progress,
+	.init_IRQ		= uic_init_tree,
+	.get_irq		= uic_get_irq,
+	.restart		= ppc44x_reset_system,
+	.calibrate_decr		= generic_calibrate_decr,
+};
Index: linux-work/arch/powerpc/boot/dts/taishan.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/boot/dts/taishan.dts	2007-11-30 13:39:18.000000000 +1100
@@ -0,0 +1,414 @@
+/*
+ * Device Tree Source for IBM/AMCC Taishan
+ *
+ * Copyright 2007 IBM Corp.
+ * Hugh Blemings <hugh@au.ibm.com> based off code by
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>, David Gibson <dwg@au1.ibm.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ *
+ * To build:
+ *   dtc -I dts -O asm -o taishan.S -b 0 taishan.dts
+ *   dtc -I dts -O dtb -o taishan.dtb -b 0 taishan.dts
+ */
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "ibm,taishan";
+	compatible = "ibm,taishan";
+	dcr-parent = <&/cpus/PowerPC,440GX@0>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,440GX@0 {
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <2FAF0800>; // 800MHz
+			timebase-frequency = <0>; // Filled in by zImage
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <8000>; /* 32 kB */
+			d-cache-size = <8000>; /* 32 kB */
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0 0>; // Filled in by zImage
+	};
+
+
+	UICB0: interrupt-controller-base {
+		compatible = "ibm,uic-440gx", "ibm,uic";
+		interrupt-controller;
+		cell-index = <3>;
+		dcr-reg = <200 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+
+	UIC0: interrupt-controller0 {
+		compatible = "ibm,uic-440gx", "ibm,uic"; /* Should be AMCC ? */
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0c0 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <01 4 00 4>; /* cascade - first non-critical */
+		interrupt-parent = <&UICB0>;
+
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible = "ibm,uic-440gx", "ibm,uic";
+		interrupt-controller;
+		cell-index = <1>;
+		dcr-reg = <0d0 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <03 4 02 4>; /* cascade */
+		interrupt-parent = <&UICB0>;
+	};
+
+	UIC2: interrupt-controller2 {
+		compatible = "ibm,uic-440gx", "ibm,uic";
+		interrupt-controller;
+		cell-index = <2>; /* was 1 */
+		dcr-reg = <210 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <05 4 04 4>; /* cascade */
+		interrupt-parent = <&UICB0>;
+	};
+
+
+	CPC0: cpc {
+		compatible = "ibm,cpc-440gp";
+		dcr-reg = <0b0 003 0e0 010>;
+		// FIXME: anything else?
+	};
+
+	plb {
+		compatible = "ibm,plb-440gx", "ibm,plb4";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <9896800>; // 160MHz
+
+		SDRAM0: memory-controller {
+			compatible = "ibm,sdram-440gp";
+			dcr-reg = <010 2>;
+			// FIXME: anything else?
+		};
+
+		SRAM0: sram {
+			compatible = "ibm,sram-440gp";
+			dcr-reg = <020 8 00a 1>;
+		};
+
+		DMA0: dma {
+			// FIXME: ???
+			compatible = "ibm,dma-440gp";
+			dcr-reg = <100 027>;
+		};
+
+		MAL0: mcmal {
+			compatible = "ibm,mcmal-440gx", "ibm,mcmal2";
+			dcr-reg = <180 62>;
+			num-tx-chans = <4>;
+			num-rx-chans = <4>;
+			interrupt-parent = <&MAL0>;
+			interrupts = <0 1 2 3 4>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
+					 /*RXEOB*/ 1 &UIC0 b 4
+					 /*SERR*/  2 &UIC1 0 4
+					 /*TXDE*/  3 &UIC1 1 4
+					 /*RXDE*/  4 &UIC1 2 4>;
+			interrupt-map-mask = <ffffffff>;
+		};
+
+		POB0: opb {
+			compatible = "ibm,opb-440gx", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* Wish there was a nicer way of specifying a full 32-bit
+			   range */
+			ranges = <00000000 1 00000000 80000000
+				  80000000 1 80000000 80000000>;
+			dcr-reg = <090 00b>;
+			interrupt-parent = <&UIC1>;
+			interrupts = <7 4>;
+			clock-frequency = <4C4B400>; // 80MHz
+
+
+			/* Put EBC0 back **FIXME** */
+
+			EBC0: ebc {
+				compatible = "ibm,ebc-440gx", "ibm,ebc";
+				dcr-reg = <012 2>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				clock-frequency = <4C4B400>; // 80MHz
+				// ranges property is supplied by zImage
+				// based on firmware's configuration of the
+				// EBC bridge
+				interrupts = <5 4>;
+				interrupt-parent = <&UIC1>;
+
+//				small-flash@0,80000 {
+//					device_type = "rom";
+//					compatible = "direct-mapped";
+//					probe-type = "JEDEC";
+//					bank-width = <1>;
+//					partitions = <0 80000>;
+//					partition-names = "OpenBIOS";
+//					reg = <0 80000 80000>;
+//				};
+
+//				ds1743@1,0 {
+//					/* NVRAM & RTC */
+//					compatible = "ds1743";
+//					reg = <1 0 2000>;
+//				};
+
+//				large-flash@2,0 {
+//					device_type = "rom";
+//					compatible = "direct-mapped";
+//					probe-type = "JEDEC";
+//					bank-width = <1>;
+//					partitions = <0 380000
+//						      380000 80000>;
+//					partition-names = "fs", "firmware";
+//					reg = <2 0 400000>;
+//				};
+
+//				ir@3,0 {
+//					reg = <3 0 10>;
+//				};
+
+//				fpga@7,0 {
+//					compatible = "Ebony-FPGA";
+//					reg = <7 0 10>;
+//				};
+			};
+
+
+
+			UART0: serial@40000200 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <40000200 8>;
+				virtual-reg = <e0000200>;
+ 				clock-frequency = <A8C000>;
+				current-speed = <1C200>; /* 115200 */
+				interrupt-parent = <&UIC0>;
+				interrupts = <0 4>;
+			};
+
+			UART1: serial@40000300 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <40000300 8>;
+				virtual-reg = <e0000300>;
+				clock-frequency = <A8C000>;
+				current-speed = <1C200>; /* 115200 */
+				interrupt-parent = <&UIC0>;
+				interrupts = <1 4>;
+			};
+
+			IIC0: i2c@40000400 {
+				/* FIXME */
+				device_type = "i2c";
+				compatible = "ibm,iic-440gp", "ibm,iic";
+				reg = <40000400 14>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <2 4>;
+			};
+			IIC1: i2c@40000500 {
+				/* FIXME */
+				device_type = "i2c";
+				compatible = "ibm,iic-440gp", "ibm,iic";
+				reg = <40000500 14>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <3 4>;
+			};
+
+			GPIO0: gpio@40000700 {
+				/* FIXME */
+				compatible = "ibm,gpio-440gp";
+				reg = <40000700 20>;
+			};
+
+			ZMII0: emac-zmii@40000780 {
+				device_type = "zgmii-interface";
+				compatible = "ibm,zmii-440gx", "ibm,zmii";
+				reg = <40000780 c>;
+			};
+
+			RGMII0: emac-rgmii@40000790 {
+				device_type = "rgmii-interface";
+				compatible = "ibm,rgmii";
+				reg = <40000790 8>;
+			};
+
+
+			EMAC0: ethernet@40000800 {
+				unused = <1>;
+				linux,network-index = <2>;
+				device_type = "network";
+				compatible = "ibm,emac-440gx", "ibm,emac4";
+				interrupt-parent = <&UIC1>;
+				interrupts = <1c 4 1d 4>;
+				reg = <40000800 70>;
+				local-mac-address = [000000000000]; // Filled in by zImage
+				mal-device = <&MAL0>;
+				mal-tx-channel = <0>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "rmii";
+				phy-map = <00000001>;
+				zmii-device = <&ZMII0>;
+				zmii-channel = <0>;
+			};
+		 	EMAC1: ethernet@40000900 {
+				unused = <1>;
+				linux,network-index = <3>;
+				device_type = "network";
+				compatible = "ibm,emac-440gx", "ibm,emac4";
+				interrupt-parent = <&UIC1>;
+				interrupts = <1e 4 1f 4>;
+				reg = <40000900 70>;
+				local-mac-address = [000000000000]; // Filled in by zImage
+				mal-device = <&MAL0>;
+				mal-tx-channel = <1>;
+				mal-rx-channel = <1>;
+				cell-index = <1>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "rmii";
+				phy-map = <00000001>;
+ 				zmii-device = <&ZMII0>;
+				zmii-channel = <1>;
+			};
+
+		 	EMAC2: ethernet@40000c00 {
+				linux,network-index = <0>;
+				device_type = "network";
+				compatible = "ibm,emac-440gx", "ibm,emac4";
+				interrupt-parent = <&UIC2>;
+				interrupts = <0 4 1 4>;
+				reg = <40000c00 70>;
+				local-mac-address = [000000000000]; // Filled in by zImage
+				mal-device = <&MAL0>;
+				mal-tx-channel = <2>;
+				mal-rx-channel = <2>;
+				cell-index = <2>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "rgmii";
+				phy-map = <00000001>;
+				rgmii-device = <&RGMII0>;
+				rgmii-channel = <0>;
+ 				zmii-device = <&ZMII0>;
+				zmii-channel = <2>;
+			};
+
+		 	EMAC3: ethernet@40000e00 {
+				linux,network-index = <1>;
+				device_type = "network";
+				compatible = "ibm,emac-440gx", "ibm,emac4";
+				interrupt-parent = <&UIC2>;
+				interrupts = <2 4 3 4>;
+				reg = <40000e00 70>;
+				local-mac-address = [000000000000]; // Filled in by zImage
+				mal-device = <&MAL0>;
+				mal-tx-channel = <3>;
+				mal-rx-channel = <3>;
+				cell-index = <3>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "rgmii";
+				phy-map = <00000003>;
+				rgmii-device = <&RGMII0>;
+				rgmii-channel = <1>;
+ 				zmii-device = <&ZMII0>;
+				zmii-channel = <3>;
+			};
+
+
+			GPT0: gpt@40000a00 {
+				/* FIXME */
+				reg = <40000a00 d4>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <12 4 13 4 14 4 15 4 16 4>;
+			};
+
+		};
+
+		PCIX0: pci@20ec00000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb440gp-pcix", "ibm,plb-pcix";
+			primary;
+			large-inbound-windows;
+			enable-msi-hole;
+			reg = <2 0ec00000   8	/* Config space access */
+			       0 0 0		/* no IACK cycles */
+			       2 0ed00000   4   /* Special cycles */
+			       2 0ec80000 100	/* Internal registers */
+			       2 0ec80100  fc>;	/* Internal messaging registers */
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges = <02000000 0 80000000 00000003 80000000 0 80000000
+				  01000000 0 00000000 00000002 08000000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+
+			/* Ebony has all 4 IRQ pins tied together per slot */
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 1 */
+				0800 0 0 1 &UIC0 17 8
+				0800 0 0 2 &UIC0 18 8
+				0800 0 0 3 &UIC0 19 8
+				0800 0 0 4 &UIC0 1a 8
+
+				/* IDSEL 2 */
+				1000 0 0 1 &UIC0 18 8
+				1000 0 0 2 &UIC0 19 8
+				1000 0 0 3 &UIC0 1a 8
+				1000 0 0 4 &UIC0 17 8
+			>;
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@40000300";
+	};
+};
Index: linux-work/arch/powerpc/boot/taishan.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/boot/taishan.c	2007-11-30 13:39:18.000000000 +1100
@@ -0,0 +1,64 @@
+/*
+ * Copyright 2007 David Gibson, IBM Corporation.
+ *
+ * Based on earlier code:
+ *   Copyright (C) Paul Mackerras 1997.
+ *
+ *   Matt Porter <mporter@kernel.crashing.org>
+ *   Copyright 2002-2005 MontaVista Software Inc.
+ *
+ *   Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *   Copyright (c) 2003, 2004 Zultys Technologies
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "elf.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+#include "reg.h"
+#include "dcr.h"
+#include "4xx.h"
+#include "44x.h"
+
+
+extern char _dtb_start[];
+extern char _dtb_end[];
+
+static u8 *taishan_mac0, *taishan_mac1;
+
+
+
+static void taishan_fixups(void)
+{
+	/* FIXME: sysclk should be derived by reading the FPGA
+	   registers */
+	unsigned long sysclk = 33000000;
+
+	/* 440EP Clock logic is all but identical to 440GX
+	   so we just use that code for now at least */
+	ibm440ep_fixup_clocks(sysclk, 6 * 1843200);
+
+	ibm4xx_fixup_memsize();
+
+	dt_fixup_mac_addresses(taishan_mac0, taishan_mac1);
+
+	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
+}
+
+void taishan_init(void *mac0, void *mac1)
+{
+	platform_ops.fixups = taishan_fixups;
+//	platform_ops.exit = ibm44x_dbcr_reset;  **FIXME**
+	taishan_mac0 = mac0;
+	taishan_mac1 = mac1;
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	serial_console_init();
+}
Index: linux-work/arch/powerpc/boot/cuboot-taishan.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/boot/cuboot-taishan.c	2007-11-30 13:39:18.000000000 +1100
@@ -0,0 +1,35 @@
+/*
+ * Old U-boot compatibility for Taishan
+ *
+ * Author: Hugh Blemings <hugh@au.ibm.com>
+ *
+ * Copyright 2007 Hugh Blemings, IBM Corporation.
+ *   Based on cuboot-ebony.c which is:
+ * Copyright 2007 David Gibson, IBM Corporation.
+ *   Based on cuboot-83xx.c, which is:
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "44x.h"
+#include "cuboot.h"
+
+#define TARGET_44x
+#include "ppcboot.h"
+
+static bd_t bd;
+
+BSS_STACK(4096);
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+
+	taishan_init(&bd.bi_enetaddr, &bd.bi_enet1addr);
+}
