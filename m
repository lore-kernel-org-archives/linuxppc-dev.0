Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id C2530DE7F8
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 03:52:50 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] 86xx: mark functions static, other minor cleanups
Date: Wed, 16 Apr 2008 13:53:06 -0400
Message-Id: <ebd47a82600724a6a80f7fd6efacab22e778858d.1208364243.git.paul.gortmaker@windriver.com>
In-Reply-To: <80CCBF8C-FE21-4DD7-B1CF-0647D31655D9@kernel.crashing.org>
References: <80CCBF8C-FE21-4DD7-B1CF-0647D31655D9@kernel.crashing.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cleanups as suggested by Stephen Rothwell and Dale Farnsworth, which
incudes marking a bunch of functions static and add a vendor prefix to
the compat node check for uniqueness.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |    2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    4 ++--
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 79385bc..7f9b999 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "MPC8641HPCN";
-	compatible = "mpc86xx";
+	compatible = "fsl,mpc8641hpcn";
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
index cfbe8c5..0764032 100644
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
+	if (of_flat_dt_is_compatible(root, "fsl,mpc8641hpcn"))
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
