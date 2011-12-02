Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 5A0A11007D8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 03:29:10 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 01/10] powerpc/85xx: Move mpc85xx_smp_init() decl to a new
 "smp.h"
Date: Fri,  2 Dec 2011 11:27:58 -0500
Message-Id: <1322843287-2745-2-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1322795058.3729.48.camel@pasglop>
References: <1322795058.3729.48.camel@pasglop>
Cc: Michael Ellerman <michaele@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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
index c48b661..3052821 100644
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
index 2113120..3f66631 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -35,6 +35,7 @@
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
+#include "smp.h"
 
 #include "mpc85xx.h"
 
@@ -154,9 +155,6 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 /*
  * Setup the architecture
  */
-#ifdef CONFIG_SMP
-extern void __init mpc85xx_smp_init(void);
-#endif
 static void __init mpc85xx_ds_setup_arch(void)
 {
 #ifdef CONFIG_PCI
@@ -189,9 +187,7 @@ static void __init mpc85xx_ds_setup_arch(void)
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
 
 #ifdef CONFIG_SWIOTLB
 	if (memblock_end_of_DRAM() > max) {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 495cfd9..813b5d3 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -51,6 +51,7 @@
 #include <asm/qe_ic.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
+#include "smp.h"
 
 #include "mpc85xx.h"
 
@@ -155,10 +156,6 @@ static int mpc8568_mds_phy_fixups(struct phy_device *phydev)
  * Setup the architecture
  *
  */
-#ifdef CONFIG_SMP
-extern void __init mpc85xx_smp_init(void);
-#endif
-
 #ifdef CONFIG_QUICC_ENGINE
 static void __init mpc85xx_mds_reset_ucc_phys(void)
 {
@@ -363,9 +360,7 @@ static void __init mpc85xx_mds_setup_arch(void)
 	}
 #endif
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
 
 	mpc85xx_mds_qe_init();
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 9feccbb..b1ca429 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -29,6 +29,7 @@
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
+#include "smp.h"
 
 #include "mpc85xx.h"
 
@@ -84,9 +85,6 @@ void __init mpc85xx_rdb_pic_init(void)
 /*
  * Setup the architecture
  */
-#ifdef CONFIG_SMP
-extern void __init mpc85xx_smp_init(void);
-#endif
 static void __init mpc85xx_rdb_setup_arch(void)
 {
 #ifdef CONFIG_PCI
@@ -104,10 +102,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 
 #endif
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
-
 	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
 }
 
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 2bf4342..8d5c22b 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -26,6 +26,7 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <asm/fsl_guts.h>
+#include "smp.h"
 
 #include "mpc85xx.h"
 
@@ -268,10 +269,6 @@ void __init p1022_ds_pic_init(void)
 	mpic_init(mpic);
 }
 
-#ifdef CONFIG_SMP
-void __init mpc85xx_smp_init(void);
-#endif
-
 /*
  * Setup the architecture
  */
@@ -311,9 +308,7 @@ static void __init p1022_ds_setup_arch(void)
 	diu_ops.valid_monitor_port	= p1022ds_valid_monitor_port;
 #endif
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
 
 #ifdef CONFIG_SWIOTLB
 	if (memblock_end_of_DRAM() > max) {
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index e76c4dc..57c3e0f 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -30,6 +30,7 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#include "smp.h"
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -41,10 +42,6 @@
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
@@ -89,9 +86,7 @@ static void __init mpc85xx_rds_setup_arch(void)
 		fsl_add_bridge(np, 0);
 #endif
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
 }
 
 machine_device_initcall(p1023_rds, mpc85xx_common_publish_devices);
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
index 4632c1b..daf9bef 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -32,6 +32,7 @@
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
+#include "smp.h"
 
 #include "mpc85xx.h"
 
@@ -138,9 +139,6 @@ static int primary_phb_addr;
 /*
  * Setup the architecture
  */
-#ifdef CONFIG_SMP
-extern void __init mpc85xx_smp_init(void);
-#endif
 static void __init xes_mpc85xx_setup_arch(void)
 {
 #ifdef CONFIG_PCI
@@ -174,9 +172,7 @@ static void __init xes_mpc85xx_setup_arch(void)
 	}
 #endif
 
-#ifdef CONFIG_SMP
 	mpc85xx_smp_init();
-#endif
 }
 
 machine_device_initcall(xes_mpc8572, mpc85xx_common_publish_devices);
-- 
1.7.2.5
