Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 23B5BB71FD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 01:49:28 +1100 (EST)
Received: by wwf25 with SMTP id 25so9513037wwf.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 06:49:24 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc/83xx: merge PCI bridge additions
Date: Thu, 17 Nov 2011 18:48:48 +0400
Message-Id: <1321541330-2330-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1321541330-2330-1-git-send-email-dbaryshkov@gmail.com>
References: <1321541330-2330-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nearly all mpc83xx-based boards have a common piece of code - one that
loops over all pci/pcie bridges and registers them. Merge that code into
a special function common to all boards.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/83xx/km83xx.c      |    7 +++----
 arch/powerpc/platforms/83xx/misc.c        |   14 ++++++++++++++
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |   11 +----------
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    5 +----
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    7 ++-----
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    9 +--------
 arch/powerpc/platforms/83xx/mpc834x_mds.c |    9 +--------
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    5 +----
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |    9 +--------
 arch/powerpc/platforms/83xx/mpc837x_mds.c |   11 +----------
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |   11 +----------
 arch/powerpc/platforms/83xx/mpc83xx.h     |    6 ++++++
 arch/powerpc/platforms/83xx/sbc834x.c     |   10 +---------
 13 files changed, 34 insertions(+), 80 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index 7ef6354..65eb792 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -51,15 +51,14 @@
  */
 static void __init mpc83xx_km_setup_arch(void)
 {
+#ifdef CONFIG_QUICC_ENGINE
 	struct device_node *np;
+#endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("kmpbec83xx_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
-#endif
+	mpc83xx_setup_pci();
 
 #ifdef CONFIG_QUICC_ENGINE
 	qe_reset();
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index ee4de77..125336f 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -12,12 +12,14 @@
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/pci.h>
 
 #include <asm/io.h>
 #include <asm/hw_irq.h>
 #include <asm/ipic.h>
 #include <asm/qe_ic.h>
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
@@ -128,3 +130,15 @@ int __init mpc83xx_declare_of_platform_devices(void)
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 	return 0;
 }
+
+#ifdef CONFIG_PCI
+void __init mpc83xx_setup_pci(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
+		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8314-pcie")
+		mpc83xx_add_bridge(np);
+}
+#endif
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index ce87406..fa25977 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -28,19 +28,10 @@
  */
 static void __init mpc831x_rdb_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc831x_rdb_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
-	for_each_compatible_node(np, "pci", "fsl,mpc8314-pcie")
-		mpc83xx_add_bridge(np);
-#endif
+	mpc83xx_setup_pci();
 	mpc831x_usb_cfg();
 }
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index df80ecc..e36bc61 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -72,10 +72,7 @@ static void __init mpc832x_sys_setup_arch(void)
 		of_node_put(np);
 	}
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
-#endif
+	mpc83xx_setup_pci();
 
 #ifdef CONFIG_QUICC_ENGINE
 	qe_reset();
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index e4c7c64..eff5baa 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -193,17 +193,14 @@ machine_device_initcall(mpc832x_rdb, mpc832x_spi_init);
  */
 static void __init mpc832x_rdb_setup_arch(void)
 {
-#if defined(CONFIG_PCI) || defined(CONFIG_QUICC_ENGINE)
+#if defined(CONFIG_QUICC_ENGINE)
 	struct device_node *np;
 #endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc832x_rdb_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
-#endif
+	mpc83xx_setup_pci();
 
 #ifdef CONFIG_QUICC_ENGINE
 	qe_reset();
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 87868c1..39849dd 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -58,17 +58,10 @@ machine_device_initcall(mpc834x_itx, mpc834x_itx_declare_of_platform_devices);
  */
 static void __init mpc834x_itx_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc834x_itx_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
-#endif
+	mpc83xx_setup_pci();
 
 	mpc834x_usb_cfg();
 }
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 4be9555..5828d8e 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -77,17 +77,10 @@ static int mpc834xemds_usb_cfg(void)
  */
 static void __init mpc834x_mds_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc834x_mds_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
-#endif
+	mpc83xx_setup_pci();
 
 	mpc834xemds_usb_cfg();
 }
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 3b20275..ad8e4bc 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -80,10 +80,7 @@ static void __init mpc836x_mds_setup_arch(void)
 		of_node_put(np);
 	}
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
-#endif
+	mpc83xx_setup_pci();
 
 #ifdef CONFIG_QUICC_ENGINE
 	qe_reset();
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index fd6f730..f8769d7 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -31,17 +31,10 @@ machine_device_initcall(mpc836x_rdk, mpc83xx_declare_of_platform_devices);
 
 static void __init mpc836x_rdk_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc836x_rdk_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
-#endif
+	mpc83xx_setup_pci();
 #ifdef CONFIG_QUICC_ENGINE
 	qe_reset();
 #endif
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 7463183..e53a60b 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -79,19 +79,10 @@ out:
  */
 static void __init mpc837x_mds_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc837x_mds_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
-	for_each_compatible_node(np, "pci", "fsl,mpc8314-pcie")
-		mpc83xx_add_bridge(np);
-#endif
+	mpc83xx_setup_pci();
 	mpc837xmds_usb_cfg();
 }
 
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index a4a5336..16c9c9c 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -50,19 +50,10 @@ static void mpc837x_rdb_sd_cfg(void)
  */
 static void __init mpc837x_rdb_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc837x_rdb_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
-	for_each_compatible_node(np, "pci", "fsl,mpc8314-pcie")
-		mpc83xx_add_bridge(np);
-#endif
+	mpc83xx_setup_pci();
 	mpc837x_usb_cfg();
 	mpc837x_rdb_sd_cfg();
 }
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index a54f6ba..0cf74d7 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -79,6 +79,12 @@ static inline void __init mpc83xx_qe_init_IRQ(void) {}
 #define mpc83xx_ipic_and_qe_init_IRQ mpc83xx_ipic_init_IRQ
 #endif /* CONFIG_QUICC_ENGINE */
 
+#ifdef CONFIG_PCI
+extern void mpc83xx_setup_pci(void);
+#else
+#define mpc83xx_setup_pci()	do {} while (0)
+#endif
+
 extern int mpc83xx_declare_of_platform_devices(void);
 
 #endif				/* __MPC83XX_H__ */
diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
index 22faaa1..1c3dfc8 100644
--- a/arch/powerpc/platforms/83xx/sbc834x.c
+++ b/arch/powerpc/platforms/83xx/sbc834x.c
@@ -48,18 +48,10 @@
  */
 static void __init sbc834x_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("sbc834x_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
-#endif
-
+	mpc83xx_setup_pci();
 }
 
 machine_device_initcall(sbc834x, mpc83xx_declare_of_platform_devices);
-- 
1.7.7.1
