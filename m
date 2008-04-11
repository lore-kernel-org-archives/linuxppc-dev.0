Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 05E51DE183
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 03:00:04 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] 86xx: mark functions static, other minor cleanups
Date: Fri, 11 Apr 2008 12:59:46 -0400
Message-Id: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
Cc: sfr@canb.auug.org.au, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cleanups as suggested by Stephen Rothwell and Dale Farnsworth, which
incudes: mark a bunch of functions static; add vendor prefix to the
compat node check for uniqueness, add in missing of_node_put(), delete
unused DBG macros.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |    2 +-
 arch/powerpc/boot/dts/sbc8641d.dts         |    2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    4 ++--
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    8 ++++----
 arch/powerpc/platforms/86xx/sbc8641d.c     |   17 +++++------------
 5 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 79385bc..d5c2da4 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "MPC8641HPCN";
-	compatible = "mpc86xx";
+	compatible = "fsl,mpc86xx";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/boot/dts/sbc8641d.dts b/arch/powerpc/boot/dts/sbc8641d.dts
index 27b5a3d..33dcf6e 100644
--- a/arch/powerpc/boot/dts/sbc8641d.dts
+++ b/arch/powerpc/boot/dts/sbc8641d.dts
@@ -17,7 +17,7 @@
 
 / {
 	model = "SBC8641D";
-	compatible = "mpc86xx";
+	compatible = "wrs,sbc8641";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 0b07485..18b8ebe 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -52,7 +52,7 @@ static int __init mpc8610_declare_of_platform_devices(void)
 }
 machine_device_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);
 
-void __init
+static void __init
 mpc86xx_hpcd_init_irq(void)
 {
 	struct mpic *mpic1;
@@ -200,7 +200,7 @@ static int __init mpc86xx_hpcd_probe(void)
 	return 0;
 }
 
-long __init
+static long __init
 mpc86xx_time_init(void)
 {
 	unsigned int temp;
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index cfbe8c5..600bbf3 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -55,7 +55,7 @@ static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 }
 #endif	/* CONFIG_PCI */
 
-void __init
+static void __init
 mpc86xx_hpcn_init_irq(void)
 {
 	struct mpic *mpic1;
@@ -162,7 +162,7 @@ mpc86xx_hpcn_setup_arch(void)
 }
 
 
-void
+static void
 mpc86xx_hpcn_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *root;
@@ -190,13 +190,13 @@ static int __init mpc86xx_hpcn_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "mpc86xx"))
+	if (of_flat_dt_is_compatible(root, "fsl,mpc86xx"))
 		return 1;	/* Looks good */
 
 	return 0;
 }
 
-long __init
+static long __init
 mpc86xx_time_init(void)
 {
 	unsigned int temp;
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
index c7516be..0863cca 100644
--- a/arch/powerpc/platforms/86xx/sbc8641d.c
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -37,15 +37,7 @@
 
 #include "mpc86xx.h"
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt...) do { printk(KERN_ERR fmt); } while(0)
-#else
-#define DBG(fmt...) do { } while(0)
-#endif
-
-void __init
+static void __init
 sbc8641_init_irq(void)
 {
 	struct mpic *mpic1;
@@ -62,6 +54,7 @@ sbc8641_init_irq(void)
 	mpic1 = mpic_alloc(np, res.start,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " MPIC     ");
+	of_node_put(np);
 	BUG_ON(mpic1 == NULL);
 
 	mpic_init(mpic1);
@@ -90,7 +83,7 @@ sbc8641_setup_arch(void)
 }
 
 
-void
+static void
 sbc8641_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *root;
@@ -118,13 +111,13 @@ static int __init sbc8641_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "mpc86xx"))
+	if (of_flat_dt_is_compatible(root, "wrs,sbc8641"))
 		return 1;	/* Looks good */
 
 	return 0;
 }
 
-long __init
+static long __init
 mpc86xx_time_init(void)
 {
 	unsigned int temp;
-- 
1.5.4.3
