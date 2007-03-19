Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id C7C51DDFFB
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 10:27:18 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2JNREar014129
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 16:27:15 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2JNREkf029682
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 18:27:14 -0500 (CDT)
Subject: [PATCH 2/2] Add initial MPC8544DS platform files.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1174346834.6595.365.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 19 Mar 2007 18:27:14 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch provides the basic 8544 platform code and config.
Follow-up patches will add peripherals such as PCI and SATA.

Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: York Sun <yorksun@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/boot/dts/mpc8544ds.dts      |  137 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig      |    9 ++-
 arch/powerpc/platforms/85xx/Makefile     |    1 +
 arch/powerpc/platforms/85xx/mpc8544_ds.c |  147 ++++++++++++++++++++++++++++++
 4 files changed, 293 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8544ds.dts
 create mode 100644 arch/powerpc/platforms/85xx/mpc8544_ds.c

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
new file mode 100644
index 0000000..ae76f48
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -0,0 +1,137 @@
+/*
+ * MPC8544 DS Device Tree Source
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/ {
+	model = "MPC8544DS";
+	compatible = "MPC8544DS", "MPC85xxDS";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8544@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			32-bit;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 00000000>;	// Filled by U-Boot
+	};
+
+	soc8544@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;		// Filled out by uboot.
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <2b 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <4a 1>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <4a 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <1d 2 1e 2 22 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+		};
+
+		ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <26000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <1f 2 20 2 21 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>;
+			clock-frequency = <0>;
+			interrupts = <2a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;
+			clock-frequency = <0>;
+			interrupts = <2a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+			interrupt-parent = <&mpic>;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index eb661cc..124e2c5 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -30,6 +30,12 @@ config MPC85xx_MDS
 	help
 	  This option enables support for the MPC85xx MDS board
 
+config MPC8544_DS
+	bool "Freescale MPC8544 DS"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the MPC8544 DS board
+
 endchoice
 
 config MPC8540
@@ -47,7 +53,8 @@ config MPC85xx
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
-	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS || MPC85xx_MDS
+	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
+		|| MPC85xx_MDS || MPC8544_DS
 
 config PPC_INDIRECT_PCI_BE
 	bool
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 4e63917..4e02cbb 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_PPC_85xx)	+= misc.o pci.o
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
+obj-$(CONFIG_MPC8544_DS)  += mpc8544_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
diff --git a/arch/powerpc/platforms/85xx/mpc8544_ds.c b/arch/powerpc/platforms/85xx/mpc8544_ds.c
new file mode 100644
index 0000000..b216b98
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc8544_ds.c
@@ -0,0 +1,147 @@
+/*
+ * MPC8544 DS Board Setup
+ *
+ * Author Xianghua Xiao (x.xiao@freescale.com)
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/mpc85xx.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+#include <asm/i8259.h>
+
+#include <sysdev/fsl_soc.h>
+#include "mpc85xx.h"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+#else
+#define DBG(fmt, args...)
+#endif
+
+
+void __init mpc8544_ds_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np = NULL;
+#ifdef CONFIG_PPC_I8259
+	struct device_node *cascade_node = NULL;
+	int cascade_irq;
+#endif
+
+	np = of_find_node_by_type(np, "open-pic");
+
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	/* Alloc mpic structure and per isu has 16 INT entries. */
+	mpic = mpic_alloc(np, r.start,
+			  MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			  16, NR_IRQS - 10, " OPENPIC     ");
+	BUG_ON(mpic == NULL);
+
+	/* Return the mpic node */
+
+	mpic_assign_isu(mpic, 0, r.start + 0x10000);
+
+	/* 48 Internal Interrupts */
+	mpic_assign_isu(mpic, 1, r.start + 0x10200);
+	mpic_assign_isu(mpic, 2, r.start + 0x10400);
+	mpic_assign_isu(mpic, 3, r.start + 0x10600);
+
+	/* 16 External interrupts
+	 * Moving them from [0 - 15] to [64 - 79]
+	 */
+	mpic_assign_isu(mpic, 4, r.start + 0x10000);
+
+	mpic_init(mpic);
+
+#ifdef CONFIG_PPC_I8259
+	/* Initialize the i8259 controller */
+	for_each_node_by_type(np, "interrupt-controller")
+	    if (device_is_compatible(np, "chrp,iic")) {
+		cascade_node = np;
+		break;
+	}
+
+	if (cascade_node == NULL) {
+		printk(KERN_DEBUG "Could not find i8259 PIC\n");
+		return;
+	}
+
+	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
+	if (cascade_irq == NO_IRQ) {
+		printk(KERN_ERR "Failed to map cascade interrupt\n");
+		return;
+	}
+
+	DBG("mpc8544ds: cascade mapped to irq %d\n", cascade_irq);
+
+	i8259_init(cascade_node, 0);
+	of_node_put(cascade_node);
+
+	set_irq_chained_handler(cascade_irq, mpc8544_8259_cascade);
+#endif	/* CONFIG_PPC_I8259 */
+}
+
+
+/*
+ * Setup the architecture
+ */
+static void __init mpc8544_ds_setup_arch(void)
+{
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc8544_ds_setup_arch()", 0);
+
+	printk("MPC8544 DS board from Freescale Semiconductor\n");
+}
+
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mpc8544_ds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "MPC8544DS");
+}
+
+define_machine(mpc8544_ds) {
+	.name			= "MPC8544 DS",
+	.probe			= mpc8544_ds_probe,
+	.setup_arch		= mpc8544_ds_setup_arch,
+	.init_IRQ		= mpc8544_ds_pic_init,
+	.get_irq		= mpic_get_irq,
+	.restart		= mpc85xx_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.5.0.3
