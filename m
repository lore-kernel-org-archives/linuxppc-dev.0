Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C18B3B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:54:49 +1000 (EST)
Received: by ewy6 with SMTP id 6so1840091ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:54:45 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 01/14] 83xx: consolidate init_IRQ functions
Date: Tue, 19 Jul 2011 12:53:38 +0400
Message-Id: <1311065631-3429-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On mpc83xx platform nearly all _init_IRQ functions look alike. They either
just setup ipic, or setup ipic and QE PIC. Separate this to special functions
to be either referenced from ppc_md, or called from board file.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/83xx/asp834x.c     |   20 +------------
 arch/powerpc/platforms/83xx/km83xx.c      |   33 +--------------------
 arch/powerpc/platforms/83xx/misc.c        |   46 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc830x_rdb.c |   18 +----------
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |   18 +----------
 arch/powerpc/platforms/83xx/mpc832x_mds.c |   30 +------------------
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |   31 +-------------------
 arch/powerpc/platforms/83xx/mpc834x_itx.c |   18 +----------
 arch/powerpc/platforms/83xx/mpc834x_mds.c |   18 +----------
 arch/powerpc/platforms/83xx/mpc836x_mds.c |   30 +------------------
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |   28 +-----------------
 arch/powerpc/platforms/83xx/mpc837x_mds.c |   18 +----------
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |   18 +----------
 arch/powerpc/platforms/83xx/mpc83xx.h     |    9 +++++
 arch/powerpc/platforms/83xx/sbc834x.c     |   20 +------------
 15 files changed, 68 insertions(+), 287 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/asp834x.c b/arch/powerpc/platforms/83xx/asp834x.c
index aa0d84d..90b6c06 100644
--- a/arch/powerpc/platforms/83xx/asp834x.c
+++ b/arch/powerpc/platforms/83xx/asp834x.c
@@ -36,24 +36,6 @@ static void __init asp834x_setup_arch(void)
 	mpc834x_usb_cfg();
 }
 
-static void __init asp834x_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	of_node_put(np);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-}
-
 static struct __initdata of_device_id asp8347_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
@@ -82,7 +64,7 @@ define_machine(asp834x) {
 	.name			= "ASP8347E",
 	.probe			= asp834x_probe,
 	.setup_arch		= asp834x_setup_arch,
-	.init_IRQ		= asp834x_init_IRQ,
+	.init_IRQ		= mpc83xx_ipic_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.restart		= mpc83xx_restart,
 	.time_init		= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index a2b9b9e..71ba863 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -140,37 +140,6 @@ static int __init kmeter_declare_of_platform_devices(void)
 }
 machine_device_initcall(mpc83xx_km, kmeter_declare_of_platform_devices);
 
-static void __init mpc83xx_km_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,pq2pro-pic");
-	if (!np) {
-		np = of_find_node_by_type(NULL, "ipic");
-		if (!np)
-			return;
-	}
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-	of_node_put(np);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (!np) {
-		np = of_find_node_by_type(NULL, "qeic");
-		if (!np)
-			return;
-	}
-	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
-	of_node_put(np);
-#endif				/* CONFIG_QUICC_ENGINE */
-}
-
 /* list of the supported boards */
 static char *board[] __initdata = {
 	"Keymile,KMETER1",
@@ -198,7 +167,7 @@ define_machine(mpc83xx_km) {
 	.name		= "mpc83xx-km-platform",
 	.probe		= mpc83xx_km_probe,
 	.setup_arch	= mpc83xx_km_setup_arch,
-	.init_IRQ	= mpc83xx_km_init_IRQ,
+	.init_IRQ	= mpc83xx_both_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index f01806c..95f2274 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -11,9 +11,12 @@
 
 #include <linux/stddef.h>
 #include <linux/kernel.h>
+#include <linux/of_platform.h>
 
 #include <asm/io.h>
 #include <asm/hw_irq.h>
+#include <asm/ipic.h>
+#include <asm/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 
 #include "mpc83xx.h"
@@ -65,3 +68,46 @@ long __init mpc83xx_time_init(void)
 
 	return 0;
 }
+
+void __init mpc83xx_ipic_init_IRQ(void)
+{
+	struct device_node *np;
+
+	/* looking for fsl,pq2pro-pic which is asl compatible with fsl,ipic */
+	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
+	if (!np)
+		np = of_find_node_by_type(NULL, "ipic");
+	if (!np)
+		return;
+
+	ipic_init(np, 0);
+
+	of_node_put(np);
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	ipic_set_default_priority();
+}
+
+#ifdef CONFIG_QUICC_ENGINE
+void __init mpc83xx_qe_init_IRQ(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (!np) {
+		np = of_find_node_by_type(NULL, "qeic");
+		if (!np)
+			return;
+	}
+	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
+	of_node_put(np);
+}
+
+void __init mpc83xx_both_init_IRQ(void)
+{
+	mpc83xx_ipic_init_IRQ();
+	mpc83xx_qe_init_IRQ();
+}
+#endif /* CONFIG_QUICC_ENGINE */
diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
index d0c4e15..b453c15 100644
--- a/arch/powerpc/platforms/83xx/mpc830x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
@@ -41,22 +41,6 @@ static void __init mpc830x_rdb_setup_arch(void)
 	mpc831x_usb_cfg();
 }
 
-static void __init mpc830x_rdb_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-}
-
 static const char *board[] __initdata = {
 	"MPC8308RDB",
 	"fsl,mpc8308rdb",
@@ -89,7 +73,7 @@ define_machine(mpc830x_rdb) {
 	.name			= "MPC830x RDB",
 	.probe			= mpc830x_rdb_probe,
 	.setup_arch		= mpc830x_rdb_setup_arch,
-	.init_IRQ		= mpc830x_rdb_init_IRQ,
+	.init_IRQ		= mpc83xx_ipic_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.restart		= mpc83xx_restart,
 	.time_init		= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index f859ead..386bde8 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -44,22 +44,6 @@ static void __init mpc831x_rdb_setup_arch(void)
 	mpc831x_usb_cfg();
 }
 
-static void __init mpc831x_rdb_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-}
-
 static const char *board[] __initdata = {
 	"MPC8313ERDB",
 	"fsl,mpc8315erdb",
@@ -92,7 +76,7 @@ define_machine(mpc831x_rdb) {
 	.name			= "MPC831x RDB",
 	.probe			= mpc831x_rdb_probe,
 	.setup_arch		= mpc831x_rdb_setup_arch,
-	.init_IRQ		= mpc831x_rdb_init_IRQ,
+	.init_IRQ		= mpc83xx_ipic_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.restart		= mpc83xx_restart,
 	.time_init		= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index ec0b401b..85c120c 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -119,34 +119,6 @@ static int __init mpc832x_declare_of_platform_devices(void)
 }
 machine_device_initcall(mpc832x_mds, mpc832x_declare_of_platform_devices);
 
-static void __init mpc832x_sys_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-	of_node_put(np);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (!np) {
-		np = of_find_node_by_type(NULL, "qeic");
-		if (!np)
-			return;
-	}
-	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
-	of_node_put(np);
-#endif				/* CONFIG_QUICC_ENGINE */
-}
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -161,7 +133,7 @@ define_machine(mpc832x_mds) {
 	.name 		= "MPC832x MDS",
 	.probe 		= mpc832x_sys_probe,
 	.setup_arch 	= mpc832x_sys_setup_arch,
-	.init_IRQ 	= mpc832x_sys_init_IRQ,
+	.init_IRQ	= mpc83xx_both_init_IRQ,
 	.get_irq 	= ipic_get_irq,
 	.restart 	= mpc83xx_restart,
 	.time_init 	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 17f9974..03d015d 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -236,35 +236,6 @@ static int __init mpc832x_declare_of_platform_devices(void)
 }
 machine_device_initcall(mpc832x_rdb, mpc832x_declare_of_platform_devices);
 
-static void __init mpc832x_rdb_init_IRQ(void)
-{
-
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-	of_node_put(np);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (!np) {
-		np = of_find_node_by_type(NULL, "qeic");
-		if (!np)
-			return;
-	}
-	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
-	of_node_put(np);
-#endif				/* CONFIG_QUICC_ENGINE */
-}
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -279,7 +250,7 @@ define_machine(mpc832x_rdb) {
 	.name		= "MPC832x RDB",
 	.probe		= mpc832x_rdb_probe,
 	.setup_arch	= mpc832x_rdb_setup_arch,
-	.init_IRQ	= mpc832x_rdb_init_IRQ,
+	.init_IRQ	= mpc83xx_both_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 81e44fa..2e2dc73 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -74,22 +74,6 @@ static void __init mpc834x_itx_setup_arch(void)
 	mpc834x_usb_cfg();
 }
 
-static void __init mpc834x_itx_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-}
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -104,7 +88,7 @@ define_machine(mpc834x_itx) {
 	.name			= "MPC834x ITX",
 	.probe			= mpc834x_itx_probe,
 	.setup_arch		= mpc834x_itx_setup_arch,
-	.init_IRQ		= mpc834x_itx_init_IRQ,
+	.init_IRQ		= mpc83xx_ipic_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.restart		= mpc83xx_restart,
 	.time_init		= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index d0a634b..94702e6 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -92,22 +92,6 @@ static void __init mpc834x_mds_setup_arch(void)
 	mpc834xemds_usb_cfg();
 }
 
-static void __init mpc834x_mds_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-}
-
 static struct of_device_id mpc834x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
@@ -137,7 +121,7 @@ define_machine(mpc834x_mds) {
 	.name			= "MPC834x MDS",
 	.probe			= mpc834x_mds_probe,
 	.setup_arch		= mpc834x_mds_setup_arch,
-	.init_IRQ		= mpc834x_mds_init_IRQ,
+	.init_IRQ		= mpc83xx_ipic_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.restart		= mpc83xx_restart,
 	.time_init		= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 09e9d6f..a968d78 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -226,34 +226,6 @@ err:
 machine_arch_initcall(mpc836x_mds, mpc836x_usb_cfg);
 #endif /* CONFIG_QE_USB */
 
-static void __init mpc836x_mds_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-	of_node_put(np);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (!np) {
-		np = of_find_node_by_type(NULL, "qeic");
-		if (!np)
-			return;
-	}
-	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
-	of_node_put(np);
-#endif				/* CONFIG_QUICC_ENGINE */
-}
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -268,7 +240,7 @@ define_machine(mpc836x_mds) {
 	.name		= "MPC836x MDS",
 	.probe		= mpc836x_mds_probe,
 	.setup_arch	= mpc836x_mds_setup_arch,
-	.init_IRQ	= mpc836x_mds_init_IRQ,
+	.init_IRQ	= mpc83xx_both_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index b0090aa..e4d3a75 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -56,32 +56,6 @@ static void __init mpc836x_rdk_setup_arch(void)
 #endif
 }
 
-static void __init mpc836x_rdk_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/*
-	 * Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-	of_node_put(np);
-#ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (!np)
-		return;
-
-	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
-	of_node_put(np);
-#endif
-}
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened.
  */
@@ -96,7 +70,7 @@ define_machine(mpc836x_rdk) {
 	.name		= "MPC836x RDK",
 	.probe		= mpc836x_rdk_probe,
 	.setup_arch	= mpc836x_rdk_setup_arch,
-	.init_IRQ	= mpc836x_rdk_init_IRQ,
+	.init_IRQ	= mpc83xx_both_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 8306832..3be7f3a 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -112,22 +112,6 @@ static int __init mpc837x_declare_of_platform_devices(void)
 }
 machine_device_initcall(mpc837x_mds, mpc837x_declare_of_platform_devices);
 
-static void __init mpc837x_mds_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-}
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -142,7 +126,7 @@ define_machine(mpc837x_mds) {
 	.name			= "MPC837x MDS",
 	.probe			= mpc837x_mds_probe,
 	.setup_arch		= mpc837x_mds_setup_arch,
-	.init_IRQ		= mpc837x_mds_init_IRQ,
+	.init_IRQ		= mpc83xx_ipic_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.restart		= mpc83xx_restart,
 	.time_init		= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 7bafbf2..eebfd81 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -85,22 +85,6 @@ static int __init mpc837x_declare_of_platform_devices(void)
 }
 machine_device_initcall(mpc837x_rdb, mpc837x_declare_of_platform_devices);
 
-static void __init mpc837x_rdb_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-}
-
 static const char *board[] __initdata = {
 	"fsl,mpc8377rdb",
 	"fsl,mpc8378rdb",
@@ -121,7 +105,7 @@ define_machine(mpc837x_rdb) {
 	.name			= "MPC837x RDB/WLAN",
 	.probe			= mpc837x_rdb_probe,
 	.setup_arch		= mpc837x_rdb_setup_arch,
-	.init_IRQ		= mpc837x_rdb_init_IRQ,
+	.init_IRQ		= mpc83xx_ipic_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.restart		= mpc83xx_restart,
 	.time_init		= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 82a4345..9d77ddb 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -70,5 +70,14 @@ extern long mpc83xx_time_init(void);
 extern int mpc837x_usb_cfg(void);
 extern int mpc834x_usb_cfg(void);
 extern int mpc831x_usb_cfg(void);
+extern void mpc83xx_ipic_init_IRQ(void);
+#ifdef CONFIG_QUICC_ENGINE
+extern void mpc83xx_qe_init_IRQ(void);
+extern void mpc83xx_both_init_IRQ(void);
+#else
+static inline void __init mpc83xx_qe_init_IRQ(void) {}
+#define mpc83xx_both_init_IRQ mpc83xx_ipic_init_IRQ
+#endif /* CONFIG_QUICC_ENGINE */
+
 
 #endif				/* __MPC83XX_H__ */
diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
index 49023db..205a28d 100644
--- a/arch/powerpc/platforms/83xx/sbc834x.c
+++ b/arch/powerpc/platforms/83xx/sbc834x.c
@@ -62,24 +62,6 @@ static void __init sbc834x_setup_arch(void)
 
 }
 
-static void __init sbc834x_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-
-	of_node_put(np);
-}
-
 static struct __initdata of_device_id sbc834x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
@@ -109,7 +91,7 @@ define_machine(sbc834x) {
 	.name			= "SBC834x",
 	.probe			= sbc834x_probe,
 	.setup_arch		= sbc834x_setup_arch,
-	.init_IRQ		= sbc834x_init_IRQ,
+	.init_IRQ		= mpc83xx_ipic_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.restart		= mpc83xx_restart,
 	.time_init		= mpc83xx_time_init,
-- 
1.7.2.5
