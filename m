Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3B545B6EF3
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 06:30:00 +1000 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] mpc8308rdb: support for MPC8308RDB board from Freescale
Date: Fri,  9 Jul 2010 00:10:39 +0400
Message-Id: <1278619839-23998-3-git-send-email-yanok@emcraft.com>
In-Reply-To: <1278619839-23998-1-git-send-email-yanok@emcraft.com>
References: <1278619839-23998-1-git-send-email-yanok@emcraft.com>
Cc: Ilya Yanok <yanok@emcraft.com>, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for MPC8308RDB development board from
Freescale.
Supported devices:
 DUART
 Dual Ethernet
 NOR and NAND flashes
 I2C
 USB in peripheral mode

PCIE support is broken by the commit 3da34aa ("powerpc/fsl: Support
unique MSI addresses per PCIe Root Complex"). Works after revert.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/powerpc/boot/dts/mpc8308rdb.dts      |  303 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/Kconfig       |    8 +
 arch/powerpc/platforms/83xx/Makefile      |    1 +
 arch/powerpc/platforms/83xx/mpc830x_rdb.c |   94 +++++++++
 4 files changed, 406 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8308rdb.dts
 create mode 100644 arch/powerpc/platforms/83xx/mpc830x_rdb.c

diff --git a/arch/powerpc/boot/dts/mpc8308rdb.dts b/arch/powerpc/boot/dts/mpc8308rdb.dts
new file mode 100644
index 0000000..a97eb2d
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8308rdb.dts
@@ -0,0 +1,303 @@
+/*
+ * MPC8308RDB Device Tree Source
+ *
+ * Copyright 2009 Freescale Semiconductor Inc.
+ * Copyright 2010 Ilya Yanok, Emcraft Systems, yanok@emcraft.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	compatible = "fsl,mpc8308rdb";
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
+		PowerPC,8308@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <16384>;
+			i-cache-size = <16384>;
+			timebase-frequency = <0>;	// from bootloader
+			bus-frequency = <0>;		// from bootloader
+			clock-frequency = <0>;		// from bootloader
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x08000000>;	// 128MB at 0
+	};
+
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8315-elbc", "fsl,elbc", "simple-bus";
+		reg = <0xe0005000 0x1000>;
+		interrupts = <77 0x8>;
+		interrupt-parent = <&ipic>;
+
+		// CS0 and CS1 are swapped when
+		// booting from nand, but the
+		// addresses are the same.
+		ranges = <0x0 0x0 0xfe000000 0x00800000
+		          0x1 0x0 0xe0600000 0x00002000
+		          0x2 0x0 0xf0000000 0x00020000
+		          0x3 0x0 0xfa000000 0x00008000>;
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x800000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			u-boot@0 {
+				reg = <0x0 0x60000>;
+				read-only;
+			};
+			env@60000 {
+				reg = <0x60000 0x10000>;
+			};
+			env1@70000 {
+				reg = <0x70000 0x10000>;
+			};
+			kernel@80000 {
+				reg = <0x80000 0x200000>;
+			};
+			dtb@280000 {
+				reg = <0x280000 0x10000>;
+			};
+			ramdisk@290000 {
+				reg = <0x290000 0x570000>;
+			};
+		};
+
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8315-fcm-nand",
+			             "fsl,elbc-fcm-nand";
+			reg = <0x1 0x0 0x2000>;
+
+			jffs2@0 {
+				reg = <0x0 0x2000000>;
+			};
+		};
+	};
+
+	immr@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,mpc8315-immr", "simple-bus";
+		ranges = <0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
+		bus-frequency = <0>;
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <14 0x8>;
+			interrupt-parent = <&ipic>;
+			dfsrr;
+			rtc@68 {
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+			};
+		};
+
+		usb@23000 {
+			compatible = "fsl-usb2-dr";
+			reg = <0x23000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&ipic>;
+			interrupts = <38 0x8>;
+			dr_mode = "peripheral";
+			phy_type = "ulpi";
+		};
+
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x24000 0x1000>;
+
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <32 0x8 33 0x8 34 0x8>;
+			interrupt-parent = <&ipic>;
+			tbi-handle = < &tbi0 >;
+			phy-handle = < &phy2 >;
+			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 0x8 36 0x8 37 0x8>;
+			interrupt-parent = <&ipic>;
+			tbi-handle = < &tbi1 >;
+			/* Vitesse 7385 isn't on the MDIO bus */
+			fixed-link = <1 1 1000 0 0>;
+			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <133333333>;
+			interrupts = <9 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <133333333>;
+			interrupts = <10 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		gpio@c00 {
+			#gpio-cells = <2>;
+			device_type = "gpio";
+			compatible = "fsl,mpc8308-gpio", "fsl,mpc8349-gpio";
+			reg = <0xc00 0x18>;
+			interrupts = <74 0x8>;
+			interrupt-parent = <&ipic>;
+			gpio-controller;
+		};
+
+		/* IPIC
+		 * interrupts cell = <intr #, sense>
+		 * sense values match linux IORESOURCE_IRQ_* defines:
+		 * sense == 8: Level, low assertion
+		 * sense == 2: Edge, high-to-low change
+		 */
+		ipic: interrupt-controller@700 {
+			compatible = "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x700 0x100>;
+			device_type = "ipic";
+		};
+
+		ipic-msi@7c0 {
+			compatible = "fsl,ipic-msi";
+			reg = <0x7c0 0x40>;
+			msi-available-ranges = <0x0 0x100>;
+			interrupts = < 0x43 0x8
+					0x4  0x8
+					0x51 0x8
+					0x52 0x8
+					0x56 0x8
+					0x57 0x8
+					0x58 0x8
+					0x59 0x8 >;
+			interrupt-parent = < &ipic >;
+		};
+
+	};
+
+	pci0: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8308-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000
+			0xb0000000 0x01000000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		interrupts = <0x1 0x8>;
+		interrupt-parent = <&ipic>;
+		clock-frequency = <0>;
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xa0000000
+				  0x02000000 0 0xa0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index f49a254..021763a 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -9,6 +9,14 @@ menuconfig PPC_83xx
 
 if PPC_83xx
 
+config MPC830x_RDB
+	bool "Freescale MPC830x RDB"
+	select DEFAULT_UIMAGE
+	select PPC_MPC831x
+	select FSL_GTM
+	help
+	  This option enables support for the MPC8308 RDB board.
+
 config MPC831x_RDB
 	bool "Freescale MPC831x RDB"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index e139c36..6e8bbbb 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -4,6 +4,7 @@
 obj-y				:= misc.o usb.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o suspend-asm.o
 obj-$(CONFIG_MCU_MPC8349EMITX)	+= mcu_mpc8349emitx.o
+obj-$(CONFIG_MPC830x_RDB)	+= mpc830x_rdb.o
 obj-$(CONFIG_MPC831x_RDB)	+= mpc831x_rdb.o
 obj-$(CONFIG_MPC832x_RDB)	+= mpc832x_rdb.o
 obj-$(CONFIG_MPC834x_MDS)	+= mpc834x_mds.o
diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
new file mode 100644
index 0000000..ac102ee
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
@@ -0,0 +1,94 @@
+/*
+ * arch/powerpc/platforms/83xx/mpc830x_rdb.c
+ *
+ * Description: MPC830x RDB board specific routines.
+ * This file is based on mpc831x_rdb.c
+ *
+ * Copyright (C) Freescale Semiconductor, Inc. 2009. All rights reserved.
+ * Copyright (C) 2010. Ilya Yanok, Emcraft Systems, yanok@emcraft.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/pci.h>
+#include <linux/of_platform.h>
+#include <asm/time.h>
+#include <asm/ipic.h>
+#include <asm/udbg.h>
+#include <sysdev/fsl_pci.h>
+#include <sysdev/fsl_soc.h>
+#include "mpc83xx.h"
+
+/*
+ * Setup the architecture
+ */
+static void __init mpc830x_rdb_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc830x_rdb_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,mpc8308-pcie")
+		mpc83xx_add_bridge(np);
+#endif
+	mpc831x_usb_cfg();
+}
+
+static void __init mpc830x_rdb_init_IRQ(void)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_type(NULL, "ipic");
+	if (!np)
+		return;
+
+	ipic_init(np, 0);
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	ipic_set_default_priority();
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init mpc830x_rdb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "MPC8308RDB") ||
+	       of_flat_dt_is_compatible(root, "fsl,mpc8308rdb");
+}
+
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .compatible = "simple-bus" },
+	{ .compatible = "gianfar" },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	return 0;
+}
+machine_device_initcall(mpc830x_rdb, declare_of_platform_devices);
+
+define_machine(mpc830x_rdb) {
+	.name			= "MPC830x RDB",
+	.probe			= mpc830x_rdb_probe,
+	.setup_arch		= mpc830x_rdb_setup_arch,
+	.init_IRQ		= mpc830x_rdb_init_IRQ,
+	.get_irq		= ipic_get_irq,
+	.restart		= mpc83xx_restart,
+	.time_init		= mpc83xx_time_init,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.6.2.5
