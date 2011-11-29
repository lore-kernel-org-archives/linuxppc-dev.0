Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id C9AE11007D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 05:59:32 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 01/10] powerpc/85xx: Move mpc85xx_smp_init() decl to a new
 "smp.h"
Date: Tue, 29 Nov 2011 13:58:28 -0500
Message-Id: <1322593117-29938-2-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1322593117-29938-1-git-send-email-Kyle.D.Moffett@boeing.com>
References: <1322593117-29938-1-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes a bunch of "extern" declarations and CONFIG_SMP ifdefs.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/corenet_ds.c  |    7 +------
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |    6 +-----
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    7 +------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |    7 +------
 arch/powerpc/platforms/85xx/p1022_ds.c    |    7 +------
 arch/powerpc/platforms/85xx/p1023_rds.c   |    7 +------
 arch/powerpc/platforms/85xx/smp.c         |    1 +
 arch/powerpc/platforms/85xx/smp.h         |   15 +++++++++++++++
 arch/powerpc/platforms/85xx/xes_mpc85xx.c |    6 +-----
 9 files changed, 23 insertions(+), 40 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/smp.h

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 802ad11..435074d 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -31,6 +31,7 @@
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
+#include "smp.h"
 
 void __init corenet_ds_pic_init(void)
 {
@@ -65,10 +66,6 @@ void __init corenet_ds_pic_init(void)
 /*
  * Setup the architecture
  */
-#ifdef CONFIG_SMP
-void __init mpc85xx_smp_init(void);
-#endif
-
 void __init corenet_ds_setup_arch(void)
 {
 #ifdef CONFIG_PCI
@@ -77,9 +74,7 @@ void __init corenet_ds_setup_arch(void)
 #endif
 	dma_addr_t max = 0xffffffff;
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
 
 #ifdef CONFIG_PCI
 	for_each_node_by_type(np, "pci") {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 1b9a8cf..52d2a3e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -35,6 +35,7 @@
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
+#include "smp.h"
 
 #undef DEBUG
 
@@ -152,9 +153,6 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 /*
  * Setup the architecture
  */
-#ifdef CONFIG_SMP
-extern void __init mpc85xx_smp_init(void);
-#endif
 static void __init mpc85xx_ds_setup_arch(void)
 {
 #ifdef CONFIG_PCI
@@ -187,9 +185,7 @@ static void __init mpc85xx_ds_setup_arch(void)
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
 
 #ifdef CONFIG_SWIOTLB
 	if (memblock_end_of_DRAM() > max) {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index a23a3ff..e4d470e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -51,6 +51,7 @@
 #include <asm/qe_ic.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
+#include "smp.h"
 
 #undef DEBUG
 #ifdef DEBUG
@@ -153,10 +154,6 @@ static int mpc8568_mds_phy_fixups(struct phy_device *phydev)
  * Setup the architecture
  *
  */
-#ifdef CONFIG_SMP
-extern void __init mpc85xx_smp_init(void);
-#endif
-
 #ifdef CONFIG_QUICC_ENGINE
 static struct of_device_id mpc85xx_qe_ids[] __initdata = {
 	{ .type = "qe", },
@@ -381,9 +378,7 @@ static void __init mpc85xx_mds_setup_arch(void)
 	}
 #endif
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
 
 	mpc85xx_mds_qe_init();
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index f5ff911..cd49898 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -29,6 +29,7 @@
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
+#include "smp.h"
 
 #undef DEBUG
 
@@ -82,9 +83,6 @@ void __init mpc85xx_rdb_pic_init(void)
 /*
  * Setup the architecture
  */
-#ifdef CONFIG_SMP
-extern void __init mpc85xx_smp_init(void);
-#endif
 static void __init mpc85xx_rdb_setup_arch(void)
 {
 #ifdef CONFIG_PCI
@@ -102,10 +100,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 
 #endif
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
-
 	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
 }
 
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index fda1571..089b959 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -26,6 +26,7 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <asm/fsl_guts.h>
+#include "smp.h"
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 
@@ -266,10 +267,6 @@ void __init p1022_ds_pic_init(void)
 	mpic_init(mpic);
 }
 
-#ifdef CONFIG_SMP
-void __init mpc85xx_smp_init(void);
-#endif
-
 /*
  * Setup the architecture
  */
@@ -309,9 +306,7 @@ static void __init p1022_ds_setup_arch(void)
 	diu_ops.valid_monitor_port	= p1022ds_valid_monitor_port;
 #endif
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
 
 #ifdef CONFIG_SWIOTLB
 	if (memblock_end_of_DRAM() > max) {
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index 835e0b3..da546ea 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -30,6 +30,7 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#include "smp.h"
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -39,10 +40,6 @@
  * Setup the architecture
  *
  */
-#ifdef CONFIG_SMP
-void __init mpc85xx_smp_init(void);
-#endif
-
 static void __init mpc85xx_rds_setup_arch(void)
 {
 	struct device_node *np;
@@ -87,9 +84,7 @@ static void __init mpc85xx_rds_setup_arch(void)
 		fsl_add_bridge(np, 0);
 #endif
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
 }
 
 static struct of_device_id p1023_ids[] = {
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 2df4785..ff42490 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -27,6 +27,7 @@
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/mpic.h>
+#include "smp.h"
 
 extern void __early_start(void);
 
diff --git a/arch/powerpc/platforms/85xx/smp.h b/arch/powerpc/platforms/85xx/smp.h
new file mode 100644
index 0000000..e2b4493
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/smp.h
@@ -0,0 +1,15 @@
+#ifndef POWERPC_85XX_SMP_H_
+#define POWERPC_85XX_SMP_H_ 1
+
+#include <linux/init.h>
+
+#ifdef CONFIG_SMP
+void __init mpc85xx_smp_init(void);
+#else
+static inline void mpc85xx_smp_init(void)
+{
+	/* Nothing to do */
+}
+#endif
+
+#endif /* not POWERPC_85XX_SMP_H_ */
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index a9dc5e7..ce3f660 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -32,6 +32,7 @@
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
+#include "smp.h"
 
 /* A few bit definitions needed for fixups on some boards */
 #define MPC85xx_L2CTL_L2E		0x80000000 /* L2 enable */
@@ -136,9 +137,6 @@ static int primary_phb_addr;
 /*
  * Setup the architecture
  */
-#ifdef CONFIG_SMP
-extern void __init mpc85xx_smp_init(void);
-#endif
 static void __init xes_mpc85xx_setup_arch(void)
 {
 #ifdef CONFIG_PCI
@@ -172,9 +170,7 @@ static void __init xes_mpc85xx_setup_arch(void)
 	}
 #endif
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
 }
 
 static struct of_device_id __initdata xes_mpc85xx_ids[] = {
-- 
1.7.2.5
