Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-11.online-age.net (ext-nj2ut-11.online-age.net
	[64.14.54.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BC7DADE050
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 22:33:30 +1100 (EST)
Received: from int-nj2ut-4.online-age.net (int-nj2ut-4.online-age.net
	[3.159.237.73])
	by ext-nj2ut-11.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id n0JBXOg3023981
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 06:33:24 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-nj2ut-4.online-age.net
	[3.159.237.73])
	by int-nj2ut-4.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id n0JBXOF6014528
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 06:33:24 -0500
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 2/3] powerpc/86xx: Board support for GE Fanuc SBC310
To: linuxppc-dev@ozlabs.org
Date: Mon, 19 Jan 2009 11:33:24 +0000
Message-ID: <20090119113309.9225.78315.stgit@ubuntu8041.localdomain>
In-Reply-To: <20090119112130.9225.82681.stgit@ubuntu8041.localdomain>
References: <20090119112130.9225.82681.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for the SBC310 VPX Single Board Computer from GE Fanuc (PowerPC
MPC8641D).

This is the basic board support for GE Fanuc's SBC310, a 3U single board
computer, based on Freescale's MPC8641D.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc310.dts     |  364 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig      |   10 +
 arch/powerpc/platforms/86xx/Makefile     |    1 
 arch/powerpc/platforms/86xx/gef_sbc310.c |  230 +++++++++++++++++++
 drivers/watchdog/Kconfig                 |    2 
 5 files changed, 605 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/gef_sbc310.dts
new file mode 100644
index 0000000..09eeb43
--- /dev/null
+++ b/arch/powerpc/boot/dts/gef_sbc310.dts
@@ -0,0 +1,364 @@
+/*
+ * GE Fanuc SBC310 Device Tree Source
+ *
+ * Copyright 2008 GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Based on: SBS CM6 Device Tree Source
+ * Copyright 2007 SBS Technologies GmbH & Co. KG
+ * And: mpc8641_hpcn.dts (MPC8641 HPCN Device Tree Source)
+ * Copyright 2006 Freescale Semiconductor Inc.
+ */
+
+/*
+ * Compiled with dtc -I dts -O dtb -o gef_sbc310.dtb gef_sbc310.dts
+ */
+
+/dts-v1/;
+
+/ {
+	model = "GEF_SBC310";
+	compatible = "gef,sbc310";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8641@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+		PowerPC,8641@1 {
+			device_type = "cpu";
+			reg = <1>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;	// set by uboot
+	};
+
+	localbus@fef05000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8641-localbus", "simple-bus";
+		reg = <0xfef05000 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
+			  1 0 0xe0000000 0x08000000	// Paged Flash 0
+			  2 0 0xe8000000 0x08000000	// Paged Flash 1
+			  3 0 0xfc100000 0x00020000	// NVRAM
+			  4 0 0xfc000000 0x00010000>;	// FPGA
+
+		/* flash@0,0 is a mirror of part of the memory in flash@1,0
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x01000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "firmware";
+				reg = <0x00000000 0x01000000>;
+				read-only;
+			};
+		};
+		*/
+
+		flash@1,0 {
+			compatible = "cfi-flash";
+			reg = <1 0 0x8000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "user";
+				reg = <0x00000000 0x07800000>;
+			};
+			partition@7800000 {
+				label = "firmware";
+				reg = <0x07800000 0x00800000>;
+				read-only;
+			};
+		};
+
+		fpga@4,0 {
+			compatible = "gef,fpga-regs";
+			reg = <0x4 0x0 0x40>;
+		};
+
+		wdt@4,2000 {
+			#interrupt-cells = <2>;
+			device_type = "watchdog";
+			compatible = "gef,fpga-wdt";
+			reg = <0x4 0x2000 0x8>;
+			interrupts = <0x1a 0x4>;
+			interrupt-parent = <&gef_pic>;
+		};
+/*
+		wdt@4,2010 {
+			#interrupt-cells = <2>;
+			device_type = "watchdog";
+			compatible = "gef,fpga-wdt";
+			reg = <0x4 0x2010 0x8>;
+			interrupts = <0x1b 0x4>;
+			interrupt-parent = <&gef_pic>;
+		};
+*/
+		gef_pic: pic@4,4000 {
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			compatible = "gef,fpga-pic";
+			reg = <0x4 0x4000 0x20>;
+			interrupts = <0x8
+				      0x9>;
+			interrupt-parent = <&mpic>;
+
+		};
+		gef_gpio: gpio@4,8000 {
+			#gpio-cells = <2>;
+			compatible = "gef,sbc310-gpio";
+			reg = <0x4 0x8000 0x24>;
+			gpio-controller;
+		};
+	};
+
+	soc@fef00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		compatible = "simple-bus";
+		ranges = <0x0 0xfef00000 0x00100000>;
+		reg = <0xfef00000 0x100000>;	// CCSRBAR 1M
+		bus-frequency = <33333333>;
+
+		i2c1: i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			rtc@51 {
+				compatible = "epson,rx8581";
+				reg = <0x00000051>;
+			};
+		};
+
+		i2c2: i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			hwmon@48 {
+				compatible = "national,lm92";
+				reg = <0x48>;
+			};
+
+			hwmon@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
+			eti@6b {
+				compatible = "dallas,ds1682";
+				reg = <0x6b>;
+			};
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&gef_pic>;
+				interrupts = <0x9 0x4>;
+				reg = <1>;
+			};
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&gef_pic>;
+				interrupts = <0x8 0x4>;
+				reg = <3>;
+			};
+		};
+
+		enet0: ethernet@24000 {
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "gmii";
+		};
+
+		enet1: ethernet@26000 {
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x1f 0x2 0x20 0x2 0x21 0x2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy2>;
+			phy-connection-type = "gmii";
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <0x2a 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <0x1c 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+
+		global-utilities@e0000 {
+			compatible = "fsl,mpc8641-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	pci0: pcie@fef08000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xfef08000 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
+			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <0x18 0x2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			0x0000 0x0 0x0 0x1 &mpic 0x0 0x2
+			0x0000 0x0 0x0 0x2 &mpic 0x1 0x2
+			0x0000 0x0 0x0 0x3 &mpic 0x2 0x2
+			0x0000 0x0 0x0 0x4 &mpic 0x3 0x2
+		>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0x80000000
+				  0x02000000 0x0 0x80000000
+				  0x0 0x40000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00400000>;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 8e56939..fa276c6 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -31,6 +31,14 @@ config MPC8610_HPCD
 	help
 	  This option enables support for the MPC8610 HPCD board.
 
+config GEF_SBC310
+	bool "GE Fanuc SBC310"
+	select DEFAULT_UIMAGE
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  This option enables support for GE Fanuc's SBC310.
+
 config GEF_SBC610
 	bool "GE Fanuc SBC610"
 	select DEFAULT_UIMAGE
@@ -48,7 +56,7 @@ config MPC8641
 	select FSL_PCI if PCI
 	select PPC_UDBG_16550
 	select MPIC
-	default y if MPC8641_HPCN || SBC8641D || GEF_SBC610
+	default y if MPC8641_HPCN || SBC8641D || GEF_SBC610 || GEF_SBC310
 
 config MPC8610
 	bool
diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index 31e540c..7c080da 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_SBC8641D)		+= sbc8641d.o
 obj-$(CONFIG_MPC8610_HPCD)	+= mpc8610_hpcd.o
 gef-gpio-$(CONFIG_GPIOLIB)	+= gef_gpio.o
 obj-$(CONFIG_GEF_SBC610)	+= gef_sbc610.o gef_pic.o $(gef-gpio-y)
+obj-$(CONFIG_GEF_SBC310)	+= gef_sbc310.o gef_pic.o $(gef-gpio-y)
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
new file mode 100644
index 0000000..0f20172
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -0,0 +1,230 @@
+/*
+ * GE Fanuc SBC310 board support
+ *
+ * Author: Martyn Welch <martyn.welch@gefanuc.com>
+ *
+ * Copyright 2008 GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Based on: mpc86xx_hpcn.c (MPC86xx HPCN board specific routines)
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * NEC fixup adapted from arch/mips/pci/fixup-lm2e.c
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc86xx.h>
+#include <asm/prom.h>
+#include <mm/mmu_decl.h>
+#include <asm/udbg.h>
+
+#include <asm/mpic.h>
+
+#include <sysdev/fsl_pci.h>
+#include <sysdev/fsl_soc.h>
+
+#include "mpc86xx.h"
+#include "gef_pic.h"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG (fmt...) do { printk(KERN_ERR "SBC310: " fmt); } while (0)
+#else
+#define DBG (fmt...) do { } while (0)
+#endif
+
+void __iomem *sbc310_regs;
+
+static void __init gef_sbc310_init_irq(void)
+{
+	struct device_node *cascade_node = NULL;
+
+	mpc86xx_init_irq();
+
+	/*
+	 * There is a simple interrupt handler in the main FPGA, this needs
+	 * to be cascaded into the MPIC
+	 */
+	cascade_node = of_find_compatible_node(NULL, NULL, "gef,fpga-pic");
+	if (!cascade_node) {
+		printk(KERN_WARNING "SBC310: No FPGA PIC\n");
+		return;
+	}
+
+	gef_pic_init(cascade_node);
+	of_node_put(cascade_node);
+}
+
+static void __init gef_sbc310_setup_arch(void)
+{
+	struct device_node *regs;
+#ifdef CONFIG_PCI
+	struct device_node *np;
+
+	for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie") {
+		fsl_add_bridge(np, 1);
+	}
+#endif
+
+	printk(KERN_INFO "GE Fanuc Intelligent Platforms SBC310 6U VPX SBC\n");
+
+#ifdef CONFIG_SMP
+	mpc86xx_smp_init();
+#endif
+
+	/* Remap basic board registers */
+	regs = of_find_compatible_node(NULL, NULL, "gef,fpga-regs");
+	if (regs) {
+		sbc310_regs = of_iomap(regs, 0);
+		if (sbc310_regs == NULL)
+			printk(KERN_WARNING "Unable to map board registers\n");
+		of_node_put(regs);
+	}
+}
+
+/* Return the PCB revision */
+static unsigned int gef_sbc310_get_board_id(void)
+{
+	unsigned int reg;
+
+	reg = ioread32(sbc310_regs);
+	return reg & 0xff;
+}
+
+/* Return the PCB revision */
+static unsigned int gef_sbc310_get_pcb_rev(void)
+{
+	unsigned int reg;
+
+	reg = ioread32(sbc310_regs);
+	return (reg >> 8) & 0xff;
+}
+
+/* Return the board (software) revision */
+static unsigned int gef_sbc310_get_board_rev(void)
+{
+	unsigned int reg;
+
+	reg = ioread32(sbc310_regs);
+	return (reg >> 16) & 0xff;
+}
+
+/* Return the FPGA revision */
+static unsigned int gef_sbc310_get_fpga_rev(void)
+{
+	unsigned int reg;
+
+	reg = ioread32(sbc310_regs);
+	return (reg >> 24) & 0xf;
+}
+
+static void gef_sbc310_show_cpuinfo(struct seq_file *m)
+{
+	uint svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: GE Fanuc Intelligent Platforms\n");
+
+	seq_printf(m, "Board ID\t: 0x%2.2x\n", gef_sbc310_get_board_id());
+	seq_printf(m, "Revision\t: %u%c\n", gef_sbc310_get_pcb_rev(),
+		('A' + gef_sbc310_get_board_rev() - 1));
+	seq_printf(m, "FPGA Revision\t: %u\n", gef_sbc310_get_fpga_rev());
+
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+}
+
+static void __init gef_sbc310_nec_fixup(struct pci_dev *pdev)
+{
+	unsigned int val;
+
+	printk(KERN_INFO "Running NEC uPD720101 Fixup\n");
+
+	/* Ensure only ports 1 & 2 are enabled */
+	pci_read_config_dword(pdev, 0xe0, &val);
+	pci_write_config_dword(pdev, 0xe0, (val & ~7) | 0x2);
+
+	/* System clock is 48-MHz Oscillator and EHCI Enabled. */
+	pci_write_config_dword(pdev, 0xe4, 1 << 5);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
+	gef_sbc310_nec_fixup);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ *
+ * This function is called to determine whether the BSP is compatible with the
+ * supplied device-tree, which is assumed to be the correct one for the actual
+ * board. It is expected thati, in the future, a kernel may support multiple
+ * boards.
+ */
+static int __init gef_sbc310_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "gef,sbc310"))
+		return 1;
+
+	return 0;
+}
+
+static long __init mpc86xx_time_init(void)
+{
+	unsigned int temp;
+
+	/* Set the time base to zero */
+	mtspr(SPRN_TBWL, 0);
+	mtspr(SPRN_TBWU, 0);
+
+	temp = mfspr(SPRN_HID0);
+	temp |= HID0_TBEN;
+	mtspr(SPRN_HID0, temp);
+	asm volatile("isync");
+
+	return 0;
+}
+
+static __initdata struct of_device_id of_bus_ids[] = {
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	printk(KERN_DEBUG "Probe platform devices\n");
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(gef_sbc310, declare_of_platform_devices);
+
+define_machine(gef_sbc310) {
+	.name			= "GE Fanuc SBC310",
+	.probe			= gef_sbc310_probe,
+	.setup_arch		= gef_sbc310_setup_arch,
+	.init_IRQ		= gef_sbc310_init_irq,
+	.show_cpuinfo		= gef_sbc310_show_cpuinfo,
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.time_init		= mpc86xx_time_init,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+};
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3efa12f..d47c612 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -772,7 +772,7 @@ config TXX9_WDT
 
 config GEF_WDT
 	tristate "GE Fanuc Watchdog Timer"
-	depends on GEF_SBC610
+	depends on GEF_SBC610 || GEF_SBC310
 	---help---
 	  Watchdog timer found in a number of GE Fanuc single board computers.
 
