Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-1.online-age.net (ext-cn0ut-1.online-age.net
	[63.210.253.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B5897DF373
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 00:36:11 +1000 (EST)
Received: from int-cn0ut-3.online-age.net (int-cn0ut-3.online-age.net
	[3.159.252.72])
	by ext-cn0ut-1.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m7LDftwh004770
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 09:41:55 -0400
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-3.online-age.net
	[3.159.252.72])
	by int-cn0ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m7LDfoKa024049
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 09:41:54 -0400
Date: Thu, 21 Aug 2008 14:41:44 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: Board support for GE Fanuc SBC610
Message-Id: <20080821144144.fed06908.martyn.welch@gefanuc.com>
In-Reply-To: <20080821133852.17201.3862.stgit@welchma.Radstone.Local>
References: <20080821133852.17201.3862.stgit@welchma.Radstone.Local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for the SBC610 VPX Single Board Computer from GE Fanuc (PowerPC
MPC8641D).

This is the basic board support for GE Fanuc's SBC610, a 6U single board
computer, based on Freescale's MPC8641D.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc610.dts     |  268 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig      |    9 +
 arch/powerpc/platforms/86xx/Makefile     |    1 
 arch/powerpc/platforms/86xx/gef_sbc610.c |  187 +++++++++++++++++++++
 4 files changed, 464 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/gef_sbc610.dts
 create mode 100644 arch/powerpc/platforms/86xx/gef_sbc610.c


diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
new file mode 100644
index 0000000..32168c6
--- /dev/null
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -0,0 +1,268 @@
+/*
+ * GE Fanuc SBC610 Device Tree Source
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
+ */
+
+/*
+ * Compiled with dtc -I dts -O dtb -o gef_sbc610.dtb gef_sbc610.dts
+ */
+
+/dts-v1/;
+
+/ {
+	model = "GEF_SBC610";
+	compatible = "gef,sbc610";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#cpus = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8641@0 {
+			device_type = "cpu";
+			reg = <0x00000000>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+			l2cr = <0x80000000>;		// Enable L2
+			32-bit;
+		};
+		PowerPC,8641@1 {
+			device_type = "cpu";
+			reg = <0x00000001>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+			l2cr = <0x80000000>;		// Enable L2
+			32-bit;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>;	// set by u-boot
+	};
+
+	soc8641@fef00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0x00000000 0xfef00000 0x00100000>;
+		reg = <0xfef00000 0x00100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;
+
+		i2c1: i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <0x00003000 0x00000100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			eti@6b {
+				compatible = "dallas,ds1682";
+				reg = <0x0000006b>;
+			};
+		};
+
+		i2c2: i2c@3100 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <0x00003100 0x00000100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		ecc@2000 {
+			device_type = "dram-controller";
+			compatible = "mpc86xx";
+			reg = <0x00002000 0x00001000>;
+			interrupts = <0x12 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		ecc@6000 {
+			device_type = "dram-controller";
+			compatible = "mpc86xx";
+			reg = <0x00006000 0x00001000>;
+			interrupts = <0x12 0x2>;
+			interrupt-parent = <&mpic>;
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
+			device_type = "mdio";
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x00024520 0x00000020>;
+
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <0x0 0x1>;
+				reg = <0x00000001>;
+				device_type = "ethernet-phy";
+			};
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&mpic>;
+				interrupts = <0x0 0x1>;
+				reg = <0x00000003>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x00024000 0x00001000>;
+			mac-address = [ 00 00 00 00 00 00 ]; // set by u-boot
+			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "gmii";
+		};
+
+		ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x00026000 0x00001000>;
+			mac-address = [ 00 00 00 00 00 00 ]; // set by u-boot
+			interrupts = <0x1f 0x2 0x20 0x2 0x21 0x2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy2>;
+			phy-connection-type = "gmii";
+		};
+
+                serial0: serial@4500 {
+                        cell-index = <0>;
+                        device_type = "serial";
+                        compatible = "ns16550";
+                        reg = <0x00004500 0x00000100>;
+			clock-frequency = <0>;
+                        interrupts = <0x2a 0x2>;
+                        interrupt-parent = <&mpic>;
+                };
+
+                serial1: serial@4600 {
+                        cell-index = <1>;
+                        device_type = "serial";
+                        compatible = "ns16550";
+                        reg = <0x00004600 0x00000100>;
+			clock-frequency = <0>;
+                        interrupts = <0x1c 0x2>;
+                        interrupt-parent = <&mpic>;
+                };
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x00040000 0x00040000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+                        big-endian;
+		};
+
+		global-utilities@e0000 {
+			compatible = "fsl,mpc8641-guts";
+			reg = <0x000e0000 0x00001000>;
+			fsl,has-rstcr;
+		};
+
+	};
+
+	pcie@fef08000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xfef08000 0x00001000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
+			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <0x18 0x2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1
+		>;
+
+	};
+
+};
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 9355a52..77dd797 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -31,6 +31,13 @@ config MPC8610_HPCD
 	help
 	  This option enables support for the MPC8610 HPCD board.
 
+config GEF_SBC610
+	bool "GE Fanuc SBC610"
+	select DEFAULT_UIMAGE
+	select HAS_RAPIDIO
+	help
+	  This option enables support for GE Fanuc's SBC610.
+
 endif
 
 config MPC8641
@@ -39,7 +46,7 @@ config MPC8641
 	select FSL_PCI if PCI
 	select PPC_UDBG_16550
 	select MPIC
-	default y if MPC8641_HPCN || SBC8641D
+	default y if MPC8641_HPCN || SBC8641D || GEF_SBC610
 
 config MPC8610
 	bool
diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index 8fee37d..cb9fc8f 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
 obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
 obj-$(CONFIG_SBC8641D)		+= sbc8641d.o
 obj-$(CONFIG_MPC8610_HPCD)	+= mpc8610_hpcd.o
+obj-$(CONFIG_GEF_SBC610)	+= gef_sbc610.o
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
new file mode 100644
index 0000000..6b92876
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -0,0 +1,187 @@
+/*
+ * GE Fanuc SBC610 board support
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
+ */
+
+/*
+ * Based on: mpc86xx_hpcn.c
+ *
+ * MPC86xx HPCN board specific routines
+ *
+ * Recode: ZHANG WEI <wei.zhang@freescale.com>
+ * Initial author: Xianghua Xiao <x.xiao@freescale.com>
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
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
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG (fmt...) do { printk(KERN_ERR "SBC610: " fmt); } while (0)
+#else
+#define DBG (fmt...) do { } while (0)
+#endif
+
+static void __init
+gef_sbc610_init_irq(void)
+{
+	struct mpic *mpic1;
+	struct device_node *np;
+	struct resource res;
+
+	/* Determine PIC address. */
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (np == NULL)
+		return;
+	of_address_to_resource(np, 0, &res);
+
+	mpic1 = mpic_alloc(np, res.start,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			0, 256, "mpic");
+	of_node_put(np);
+	BUG_ON(mpic1 == NULL);
+
+	mpic_init(mpic1);
+}
+
+static void __init
+gef_sbc610_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+
+	for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie") {
+		fsl_add_bridge(np, 1);
+	}
+#endif
+
+	printk(KERN_INFO "GE Fanuc Intelligent Platforms SBC610 6U VPX SBC\n");
+
+#ifdef CONFIG_SMP
+	mpc86xx_smp_init();
+#endif
+}
+
+
+static void
+gef_sbc610_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	uint memsize = total_memory;
+	const char *model = "";
+	uint svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: GE Fanuc Intelligent Platforms\n");
+
+	root = of_find_node_by_path("/");
+	if (root)
+		model = of_get_property(root, "model", NULL);
+	seq_printf(m, "Machine\t\t: %s\n", model);
+	of_node_put(root);
+
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+}
+
+
+/*
+ * Called very early, device-tree isn't unflattened
+ *
+ * This function is called to determine whether the BSP is compatible with the
+ * supplied device-tree, which is assumed to be the correct one for the actual
+ * board. It is expected thati, in the future, a kernel may support multiple
+ * boards.
+ */
+static int __init gef_sbc610_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "gef,sbc610"))
+		return 1;
+
+	return 0;
+}
+
+static long __init
+mpc86xx_time_init(void)
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
+	{ .type = "serial", },
+	{ .type = "soc", },
+	{ .type = "i2c", },
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
+machine_device_initcall(gef_sbc610, declare_of_platform_devices);
+
+define_machine(gef_sbc610) {
+	.name			= "GE Fanuc SBC610",
+	.probe			= gef_sbc610_probe,
+	.setup_arch		= gef_sbc610_setup_arch,
+	.init_IRQ		= gef_sbc610_init_irq,
+	.show_cpuinfo		= gef_sbc610_show_cpuinfo,
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.time_init		= mpc86xx_time_init,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+};
