Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-7.online-age.net (ext-nj2ut-7.online-age.net
	[64.14.54.237])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 63CDBDE13B
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 20:28:02 +1000 (EST)
Received: from int-nj2ut-1.online-age.net (int-nj2ut-1.online-age.net
	[3.159.237.70])
	by ext-nj2ut-7.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m81ARvEW013454
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Sep 2008 06:27:57 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-1.online-age.net
	[3.159.237.70])
	by int-nj2ut-1.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m81ARsDt002103
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Sep 2008 06:27:57 -0400
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH v4 1/2] powerpc: Board support for GE Fanuc SBC610
To: linuxppc-dev@ozlabs.org
Date: Mon, 01 Sep 2008 11:27:59 +0100
Message-ID: <20080901102758.8068.77414.stgit@ubuntu8041.localdomain>
In-Reply-To: <20080901102753.8068.36706.stgit@ubuntu8041.localdomain>
References: <20080901102753.8068.36706.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: scottwood@freescale.com, paulus@samba.org
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

 arch/powerpc/boot/dts/gef_sbc610.dts     |  259 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig      |    9 +
 arch/powerpc/platforms/86xx/Makefile     |    1 
 arch/powerpc/platforms/86xx/gef_sbc610.c |  152 ++++++++++++++++++
 4 files changed, 420 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
new file mode 100644
index 0000000..d1505d9
--- /dev/null
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -0,0 +1,259 @@
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
+ * And: mpc8641_hpcn.dts (MPC8641 HPCN Device Tree Source)
+ * Copyright 2006 Freescale Semiconductor Inc.
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
+	soc@fef00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0x0 0xfef00000 0x00100000>;
+		reg = <0xfef00000 0x100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;
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
+			eti@6b {
+				compatible = "dallas,ds1682";
+				reg = <0x6b>;
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
+				interrupt-parent = <&mpic>;
+				interrupts = <0x0 0x1>;
+				reg = <1>;
+			};
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&mpic>;
+				interrupts = <0x0 0x1>;
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
+			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1
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
index 0000000..448d31c
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -0,0 +1,152 @@
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
+ * Based on: mpc86xx_hpcn.c (MPC86xx HPCN board specific routines)
+ * Copyright 2006 Freescale Semiconductor Inc.
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
+static void __init gef_sbc610_setup_arch(void)
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
+static void gef_sbc610_show_cpuinfo(struct seq_file *m)
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
+	.init_IRQ		= mpc86xx_init_irq,
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
