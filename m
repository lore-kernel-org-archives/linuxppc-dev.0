Return-Path: <holger.brunck@keymile.com>
Received: from mail.de.keymile.com (mail.de.keymile.com [195.8.104.1])
	by ozlabs.org (Postfix) with SMTP id C85AEB6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 23:03:37 +1100 (EST)
From: Holger Brunck <holger.brunck@keymile.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ppc, 82xx: rename and update mgcoge board support
Date: Thu, 10 Mar 2011 12:52:45 +0100
Message-Id: <1299757965-10235-1-git-send-email-holger.brunck@keymile.com>
Cc: Heiko Schocher <hs@denx.de>, Holger Brunck <holger.brunck@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mgcoge board from keymile is now base for some other
similar boards. Therefore the board specific name mgcoge
was renamed to a generic name km82xx. Additionally some
enhancements were made:
	- rework partition table in dts file
	- add cpm2_pio_c gpio controller in dts file
	- update defconfig
	- add pin description for SCC1
	- add pin description and configuration for USB

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Acked-by: Heiko Schocher <hs@denx.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Kumar Gala <galak@kernel.crashing.org>
CC: Heiko Schocher <hs@denx.de>

---
 arch/powerpc/boot/dts/mgcoge.dts                   |   47 ++++++++-------
 arch/powerpc/configs/mgcoge_defconfig              |    9 +---
 arch/powerpc/platforms/82xx/Makefile               |    2 +-
 arch/powerpc/platforms/82xx/{mgcoge.c => km82xx.c} |   62 ++++++++++++++------
 4 files changed, 72 insertions(+), 48 deletions(-)
 rename arch/powerpc/platforms/82xx/{mgcoge.c => km82xx.c} (69%)

diff --git a/arch/powerpc/boot/dts/mgcoge.dts b/arch/powerpc/boot/dts/mgcoge.dts
index 0ce9664..1360d2f 100644
--- a/arch/powerpc/boot/dts/mgcoge.dts
+++ b/arch/powerpc/boot/dts/mgcoge.dts
@@ -13,7 +13,7 @@
 /dts-v1/;
 / {
 	model = "MGCOGE";
-	compatible = "keymile,mgcoge";
+	compatible = "keymile,km82xx";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -48,8 +48,10 @@
 		reg = <0xf0010100 0x40>;
 
 		ranges = <0 0 0xfe000000 0x00400000
-			  5 0 0x50000000 0x20000000
-			>; /* Filled in by U-Boot */
+			  1 0 0x30000000 0x00010000
+			  2 0 0x40000000 0x00010000
+			  5 0 0x50000000 0x04000000
+			>;
 
 		flash@0,0 {
 			compatible = "cfi-flash";
@@ -60,36 +62,32 @@
 			device-width = <1>;
 			partition@0 {
 				label = "u-boot";
-				reg = <0 0x40000>;
+				reg = <0x00000 0xC0000>;
 			};
-			partition@40000 {
+			partition@1 {
 				label = "env";
-				reg = <0x40000 0x20000>;
+				reg = <0xC0000 0x20000>;
 			};
-			partition@60000 {
-				label = "kernel";
-				reg = <0x60000 0x220000>;
+			partition@2 {
+				label = "envred";
+				reg = <0xE0000 0x20000>;
 			};
-			partition@280000 {
-				label = "dtb";
-				reg = <0x280000 0x20000>;
+			partition@3 {
+				label = "free";
+				reg = <0x100000 0x300000>;
 			};
 		};
 
 		flash@5,0 {
 			compatible = "cfi-flash";
-			reg = <5 0x0 0x2000000>;
+			reg = <5 0x00000000 0x02000000
+			       5 0x02000000 0x02000000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			bank-width = <2>;
-			device-width = <2>;
-			partition@0 {
-				label = "ramdisk";
-				reg = <0 0x7a0000>;
-			};
-			partition@7a0000 {
-				label = "user";
-				reg = <0x7a0000 0x1860000>;
+			partition@app { /* 64 MBytes */
+				label = "ubi0";
+				reg = <0x00000000 0x04000000>;
 			};
 		};
 	};
@@ -217,6 +215,13 @@
 			};
 		};
 
+		cpm2_pio_c: gpio-controller@10d40 {
+			#gpio-cells = <2>;
+			compatible = "fsl,cpm2-pario-bank";
+			reg = <0x10d40 0x14>;
+			gpio-controller;
+		};
+
 		PIC: interrupt-controller@10c00 {
 			#interrupt-cells = <2>;
 			interrupt-controller;
diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
index 39518e9..6cb588a 100644
--- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -1,4 +1,5 @@
 CONFIG_SYSVIPC=y
+CONFIG_SPARSE_IRQ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -10,7 +11,6 @@ CONFIG_SLAB=y
 CONFIG_PPC_82xx=y
 CONFIG_MGCOGE=y
 CONFIG_BINFMT_MISC=y
-CONFIG_SPARSE_IRQ=y
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -30,7 +30,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_CFI=y
@@ -43,7 +42,6 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-# CONFIG_MISC_DEVICES is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
 CONFIG_FIXED_PHY=y
@@ -67,7 +65,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_EXT3_FS_XATTR is not set
-CONFIG_INOTIFY=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
@@ -88,13 +85,9 @@ CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_BDI_SWITCH=y
-CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/platforms/82xx/Makefile b/arch/powerpc/platforms/82xx/Makefile
index d982793..455fe21 100644
--- a/arch/powerpc/platforms/82xx/Makefile
+++ b/arch/powerpc/platforms/82xx/Makefile
@@ -6,4 +6,4 @@ obj-$(CONFIG_CPM2) += pq2.o
 obj-$(CONFIG_PQ2_ADS_PCI_PIC) += pq2ads-pci-pic.o
 obj-$(CONFIG_PQ2FADS) += pq2fads.o
 obj-$(CONFIG_EP8248E) += ep8248e.o
-obj-$(CONFIG_MGCOGE) += mgcoge.o
+obj-$(CONFIG_MGCOGE) += km82xx.o
diff --git a/arch/powerpc/platforms/82xx/mgcoge.c b/arch/powerpc/platforms/82xx/km82xx.c
similarity index 69%
rename from arch/powerpc/platforms/82xx/mgcoge.c
rename to arch/powerpc/platforms/82xx/km82xx.c
index 7a5de9e..428c5e0 100644
--- a/arch/powerpc/platforms/82xx/mgcoge.c
+++ b/arch/powerpc/platforms/82xx/km82xx.c
@@ -1,6 +1,6 @@
 /*
- * Keymile mgcoge support
- * Copyright 2008 DENX Software Engineering GmbH
+ * Keymile km82xx support
+ * Copyright 2008-2011 DENX Software Engineering GmbH
  * Author: Heiko Schocher <hs@denx.de>
  *
  * based on code from:
@@ -31,9 +31,10 @@
 
 #include "pq2.h"
 
-static void __init mgcoge_pic_init(void)
+static void __init km82xx_pic_init(void)
 {
-	struct device_node *np = of_find_compatible_node(NULL, NULL, "fsl,pq2-pic");
+	struct device_node *np = of_find_compatible_node(NULL, NULL,
+							"fsl,pq2-pic");
 	if (!np) {
 		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
 		return;
@@ -47,12 +48,18 @@ struct cpm_pin {
 	int port, pin, flags;
 };
 
-static __initdata struct cpm_pin mgcoge_pins[] = {
+static __initdata struct cpm_pin km82xx_pins[] = {
 
 	/* SMC2 */
 	{0, 8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
 	{0, 9, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 
+	/* SCC1 */
+	{2, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 15, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+
 	/* SCC4 */
 	{2, 25, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
 	{2, 24, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
@@ -107,30 +114,49 @@ static __initdata struct cpm_pin mgcoge_pins[] = {
 	{3, 14, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
 	{3, 15, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
 #endif
+
+	/* USB */
+	{0, 10, CPM_PIN_OUTPUT | CPM_PIN_GPIO},    /* FULL_SPEED */
+	{0, 11, CPM_PIN_OUTPUT | CPM_PIN_GPIO},    /*/SLAVE */
+	{2, 10, CPM_PIN_INPUT  | CPM_PIN_PRIMARY}, /* RXN */
+	{2, 11, CPM_PIN_INPUT  | CPM_PIN_PRIMARY}, /* RXP */
+	{2, 20, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY}, /* /OE */
+	{2, 27, CPM_PIN_INPUT  | CPM_PIN_PRIMARY}, /* RXCLK */
+	{3, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY}, /* TXP */
+	{3, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY}, /* TXN */
+	{3, 25, CPM_PIN_INPUT  | CPM_PIN_PRIMARY}, /* RXD */
 };
 
 static void __init init_ioports(void)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mgcoge_pins); i++) {
-		const struct cpm_pin *pin = &mgcoge_pins[i];
+	for (i = 0; i < ARRAY_SIZE(km82xx_pins); i++) {
+		const struct cpm_pin *pin = &km82xx_pins[i];
 		cpm2_set_pin(pin->port, pin->pin, pin->flags);
 	}
 
 	cpm2_smc_clk_setup(CPM_CLK_SMC2, CPM_BRG8);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_CLK11, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_CLK11, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_SCC3, CPM_CLK5, CPM_CLK_RTX);
 	cpm2_clk_setup(CPM_CLK_SCC4, CPM_CLK7, CPM_CLK_RX);
 	cpm2_clk_setup(CPM_CLK_SCC4, CPM_CLK8, CPM_CLK_TX);
 	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_RX);
 	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK9,  CPM_CLK_TX);
 	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK13, CPM_CLK_RX);
 	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK14, CPM_CLK_TX);
+
+	/* Force USB FULL SPEED bit to '1' */
+	setbits32(&cpm2_immr->im_ioport.iop_pdata, 1 << (31 - 10));
+	/* clear USB_SLAVE */
+	clrbits32(&cpm2_immr->im_ioport.iop_pdata, 1 << (31 - 11));
 }
 
-static void __init mgcoge_setup_arch(void)
+static void __init km82xx_setup_arch(void)
 {
 	if (ppc_md.progress)
-		ppc_md.progress("mgcoge_setup_arch()", 0);
+		ppc_md.progress("km82xx_setup_arch()", 0);
 
 	cpm2_reset();
 
@@ -142,7 +168,7 @@ static void __init mgcoge_setup_arch(void)
 	init_ioports();
 
 	if (ppc_md.progress)
-		ppc_md.progress("mgcoge_setup_arch(), finish", 0);
+		ppc_md.progress("km82xx_setup_arch(), finish", 0);
 }
 
 static  __initdata struct of_device_id of_bus_ids[] = {
@@ -156,23 +182,23 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(mgcoge, declare_of_platform_devices);
+machine_device_initcall(km82xx, declare_of_platform_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
  */
-static int __init mgcoge_probe(void)
+static int __init km82xx_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
-	return of_flat_dt_is_compatible(root, "keymile,mgcoge");
+	return of_flat_dt_is_compatible(root, "keymile,km82xx");
 }
 
-define_machine(mgcoge)
+define_machine(km82xx)
 {
-	.name = "Keymile MGCOGE",
-	.probe = mgcoge_probe,
-	.setup_arch = mgcoge_setup_arch,
-	.init_IRQ = mgcoge_pic_init,
+	.name = "Keymile km82xx",
+	.probe = km82xx_probe,
+	.setup_arch = km82xx_setup_arch,
+	.init_IRQ = km82xx_pic_init,
 	.get_irq = cpm2_get_irq,
 	.calibrate_decr = generic_calibrate_decr,
 	.restart = pq2_restart,
-- 
1.7.0.5
