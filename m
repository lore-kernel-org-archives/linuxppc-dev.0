Return-Path: <holger.brunck@keymile.com>
Received: from mail.de.keymile.com (mail.de.keymile.com [195.8.104.1])
	by ozlabs.org (Postfix) with SMTP id 08285B6FA9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Mar 2011 18:03:03 +1100 (EST)
From: Holger Brunck <holger.brunck@keymile.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ppc, 83xx: rename and update kmeter1
Date: Fri, 11 Mar 2011 08:02:44 +0100
Message-Id: <1299826964-3846-1-git-send-email-holger.brunck@keymile.com>
Cc: Heiko Schocher <hs@denx.de>, Holger Brunck <holger.brunck@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Beside the MPC 8360 based board kmeter1 other km83xx boards
from keymile will follow. Therefore the board specific naming
kmeter1 for functions and files were replaced with km83xx.
Additionally some updates were made:
    - update defconfig for 2.6.38
    - rework flash partitioning in dts file
    - add gpio controller for qe_pio_c in dts

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Acked-by: Heiko Schocher <hs@denx.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Kumar Gala <galak@kernel.crashing.org>
CC: Heiko Schocher <hs@denx.de>
---
 arch/powerpc/boot/dts/kmeter1.dts                  |   69 +++++++++++---------
 arch/powerpc/configs/83xx/kmeter1_defconfig        |    7 +--
 arch/powerpc/platforms/83xx/Makefile               |    2 +-
 .../powerpc/platforms/83xx/{kmeter1.c => km83xx.c} |   46 +++++++++----
 4 files changed, 71 insertions(+), 53 deletions(-)
 rename arch/powerpc/platforms/83xx/{kmeter1.c => km83xx.c} (80%)

diff --git a/arch/powerpc/boot/dts/kmeter1.dts b/arch/powerpc/boot/dts/kmeter1.dts
index d8b5d12..d16bae1 100644
--- a/arch/powerpc/boot/dts/kmeter1.dts
+++ b/arch/powerpc/boot/dts/kmeter1.dts
@@ -1,7 +1,7 @@
 /*
  * Keymile KMETER1 Device Tree Source
  *
- * 2008 DENX Software Engineering GmbH
+ * 2008-2011 DENX Software Engineering GmbH
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -70,11 +70,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
-			compatible = "fsl-i2c";
+			compatible = "fsl,mpc8313-i2c","fsl-i2c";
 			reg = <0x3000 0x100>;
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
-			dfsrr;
+			clock-frequency = <400000>;
 		};
 
 		serial0: serial@4500 {
@@ -137,6 +137,13 @@
 			compatible = "fsl,mpc8360-par_io";
 			num-ports = <7>;
 
+			qe_pio_c: gpio-controller@30 {
+				#gpio-cells = <2>;
+				compatible = "fsl,mpc8360-qe-pario-bank",
+					     "fsl,mpc8323-qe-pario-bank";
+				reg = <0x1430 0x18>;
+				gpio-controller;
+			};
 			pio_ucc1: ucc_pin@0 {
 				reg = <0>;
 
@@ -472,7 +479,17 @@
 				#address-cells = <0>;
 				#interrupt-cells = <1>;
 				reg = <0x80 0x80>;
-				interrupts = <32 8 33 8>;
+				big-endian;
+				interrupts = <
+					32 0x8
+					33 0x8
+					34 0x8
+					35 0x8
+					40 0x8
+					41 0x8
+					42 0x8
+					43 0x8
+				>;
 				interrupt-parent = <&ipic>;
 			};
 		};
@@ -484,43 +501,31 @@
 		compatible = "fsl,mpc8360-localbus", "fsl,pq2pro-localbus",
 			     "simple-bus";
 		reg = <0xe0005000 0xd8>;
-		ranges = <0 0 0xf0000000 0x04000000>;	/* Filled in by U-Boot */
+		ranges = <0 0 0xf0000000 0x04000000	/* LB 0 */
+			  1 0 0xe8000000 0x01000000	/* LB 1 */
+			  3 0 0xa0000000 0x10000000>;	/* LB 3 */
 
-		flash@f0000000,0 {
+		flash@0,0 {
 			compatible = "cfi-flash";
-			/*
-			 * The Intel P30 chip has 2 non-identical chips on
-			 * one die, so we need to define 2 separate regions
-			 * that are scanned by physmap_of independantly.
-			 */
-			reg = <0 0x00000000 0x02000000
-			       0 0x02000000 0x02000000>;	/* Filled in by U-Boot */
-			bank-width = <2>;
+			reg = <0 0 0x04000000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			partition@0 {
+			bank-width = <2>;
+			partition@0 { /* 768KB */
 				label = "u-boot";
-				reg = <0 0x40000>;
+				reg = <0 0xC0000>;
 			};
-			partition@40000 {
+			partition@c0000 { /* 128KB */
 				label = "env";
-				reg = <0x40000 0x40000>;
-			};
-			partition@80000 {
-				label = "dtb";
-				reg = <0x80000 0x20000>;
-			};
-			partition@a0000 {
-				label = "kernel";
-				reg = <0xa0000 0x300000>;
+				reg = <0xC0000 0x20000>;
 			};
-			partition@3a0000 {
-				label = "ramdisk";
-				reg = <0x3a0000 0x800000>;
+			partition@e0000 { /* 128KB */
+				label = "envred";
+				reg = <0xE0000 0x20000>;
 			};
-			partition@ba0000 {
-				label = "user";
-				reg = <0xba0000 0x3460000>;
+			partition@100000 { /* 64512KB */
+				label = "ubi0";
+				reg = <0x100000 0x3F00000>;
 			};
 		};
 	};
diff --git a/arch/powerpc/configs/83xx/kmeter1_defconfig b/arch/powerpc/configs/83xx/kmeter1_defconfig
index 7a7b731..07e1bba 100644
--- a/arch/powerpc/configs/83xx/kmeter1_defconfig
+++ b/arch/powerpc/configs/83xx/kmeter1_defconfig
@@ -2,6 +2,7 @@ CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_SPARSE_IRQ=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 # CONFIG_HOTPLUG is not set
@@ -18,7 +19,6 @@ CONFIG_KMETER1=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
-CONFIG_SPARSE_IRQ=y
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -37,7 +37,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -49,13 +48,12 @@ CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_GLUEBI=y
 CONFIG_MTD_UBI_DEBUG=y
 CONFIG_PROC_DEVICETREE=y
-# CONFIG_MISC_DEVICES is not set
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
 CONFIG_TUN=y
+CONFIG_MII=y
 CONFIG_MARVELL_PHY=y
 CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
 CONFIG_UCC_GETH=y
 # CONFIG_NETDEV_10000 is not set
 CONFIG_WAN=y
@@ -77,7 +75,6 @@ CONFIG_I2C_MPC=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_UIO=y
 # CONFIG_DNOTIFY is not set
-CONFIG_INOTIFY=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index 6e8bbbb..ed95bfc 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -16,4 +16,4 @@ obj-$(CONFIG_MPC837x_MDS)	+= mpc837x_mds.o
 obj-$(CONFIG_SBC834x)		+= sbc834x.o
 obj-$(CONFIG_MPC837x_RDB)	+= mpc837x_rdb.o
 obj-$(CONFIG_ASP834x)		+= asp834x.o
-obj-$(CONFIG_KMETER1)		+= kmeter1.o
+obj-$(CONFIG_KMETER1)		+= km83xx.o
diff --git a/arch/powerpc/platforms/83xx/kmeter1.c b/arch/powerpc/platforms/83xx/km83xx.c
similarity index 80%
rename from arch/powerpc/platforms/83xx/kmeter1.c
rename to arch/powerpc/platforms/83xx/km83xx.c
index 903acfd..a2b9b9e 100644
--- a/arch/powerpc/platforms/83xx/kmeter1.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2008 DENX Software Engineering GmbH
+ * Copyright 2008-2011 DENX Software Engineering GmbH
  * Author: Heiko Schocher <hs@denx.de>
  *
  * Description:
@@ -49,12 +49,12 @@
  * Setup the architecture
  *
  */
-static void __init kmeter1_setup_arch(void)
+static void __init mpc83xx_km_setup_arch(void)
 {
 	struct device_node *np;
 
 	if (ppc_md.progress)
-		ppc_md.progress("kmeter1_setup_arch()", 0);
+		ppc_md.progress("kmpbec83xx_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
@@ -69,6 +69,9 @@ static void __init kmeter1_setup_arch(void)
 		par_io_init(np);
 		of_node_put(np);
 
+		for_each_node_by_name(np, "spi")
+			par_io_of_config(np);
+
 		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
 			par_io_of_config(np);
 	}
@@ -119,7 +122,7 @@ static void __init kmeter1_setup_arch(void)
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
-static struct of_device_id kmeter_ids[] = {
+static struct of_device_id kmpbec83xx_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
@@ -131,13 +134,13 @@ static struct of_device_id kmeter_ids[] = {
 static int __init kmeter_declare_of_platform_devices(void)
 {
 	/* Publish the QE devices */
-	of_platform_bus_probe(NULL, kmeter_ids, NULL);
+	of_platform_bus_probe(NULL, kmpbec83xx_ids, NULL);
 
 	return 0;
 }
-machine_device_initcall(kmeter1, kmeter_declare_of_platform_devices);
+machine_device_initcall(mpc83xx_km, kmeter_declare_of_platform_devices);
 
-static void __init kmeter1_init_IRQ(void)
+static void __init mpc83xx_km_init_IRQ(void)
 {
 	struct device_node *np;
 
@@ -168,21 +171,34 @@ static void __init kmeter1_init_IRQ(void)
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
+/* list of the supported boards */
+static char *board[] __initdata = {
+	"Keymile,KMETER1",
+	"Keymile,kmpbec8321",
+	NULL
+};
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
-static int __init kmeter1_probe(void)
+static int __init mpc83xx_km_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
+	unsigned long node = of_get_flat_dt_root();
+	int i = 0;
 
-	return of_flat_dt_is_compatible(root, "keymile,KMETER1");
+	while (board[i]) {
+		if (of_flat_dt_is_compatible(node, board[i]))
+			break;
+		i++;
+	}
+	return (board[i] != NULL);
 }
 
-define_machine(kmeter1) {
-	.name		= "KMETER1",
-	.probe		= kmeter1_probe,
-	.setup_arch	= kmeter1_setup_arch,
-	.init_IRQ	= kmeter1_init_IRQ,
+define_machine(mpc83xx_km) {
+	.name		= "mpc83xx-km-platform",
+	.probe		= mpc83xx_km_probe,
+	.setup_arch	= mpc83xx_km_setup_arch,
+	.init_IRQ	= mpc83xx_km_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
-- 
1.7.0.5
