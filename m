Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0143.outbound.protection.outlook.com [65.55.169.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D092A1A08BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 18:23:05 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH v12 5/6] QE: use subsys_initcall to init qe
Date: Wed, 14 Oct 2015 15:16:07 +0800
Message-ID: <1444806968-4627-5-git-send-email-qiang.zhao@freescale.com>
In-Reply-To: <1444806968-4627-1-git-send-email-qiang.zhao@freescale.com>
References: <1444806968-4627-1-git-send-email-qiang.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use subsys_initcall to init qe to adapt ARM architecture.
Remove qe_reset from PowerPC platform file.

Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
---
Changes for v12:
	- Nil

 arch/powerpc/platforms/83xx/km83xx.c      |  2 --
 arch/powerpc/platforms/83xx/mpc832x_mds.c |  2 --
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |  2 --
 arch/powerpc/platforms/83xx/mpc836x_mds.c |  2 --
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |  3 ---
 arch/powerpc/platforms/85xx/common.c      |  1 -
 arch/powerpc/sysdev/qe_lib/qe.c           | 15 +++++++++++++++
 7 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index bf4c447..ae111581 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -136,8 +136,6 @@ static void __init mpc83xx_km_setup_arch(void)
 	mpc83xx_setup_pci();
 
 #ifdef CONFIG_QUICC_ENGINE
-	qe_reset();
-
 	np = of_find_node_by_name(NULL, "par_io");
 	if (np != NULL) {
 		par_io_init(np);
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 8d76220..aacc43f 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -74,8 +74,6 @@ static void __init mpc832x_sys_setup_arch(void)
 	mpc83xx_setup_pci();
 
 #ifdef CONFIG_QUICC_ENGINE
-	qe_reset();
-
 	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
 		par_io_init(np);
 		of_node_put(np);
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index eff5baa..0c7a43e 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -203,8 +203,6 @@ static void __init mpc832x_rdb_setup_arch(void)
 	mpc83xx_setup_pci();
 
 #ifdef CONFIG_QUICC_ENGINE
-	qe_reset();
-
 	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
 		par_io_init(np);
 		of_node_put(np);
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 1a26d2f..eb24abd 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -82,8 +82,6 @@ static void __init mpc836x_mds_setup_arch(void)
 	mpc83xx_setup_pci();
 
 #ifdef CONFIG_QUICC_ENGINE
-	qe_reset();
-
 	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
 		par_io_init(np);
 		of_node_put(np);
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index b63b42d..823e370 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -35,9 +35,6 @@ static void __init mpc836x_rdk_setup_arch(void)
 		ppc_md.progress("mpc836x_rdk_setup_arch()", 0);
 
 	mpc83xx_setup_pci();
-#ifdef CONFIG_QUICC_ENGINE
-	qe_reset();
-#endif
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 7bfb9b1..0f91edc 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -105,7 +105,6 @@ void __init mpc85xx_qe_init(void)
 		return;
 	}
 
-	qe_reset();
 	of_node_put(np);
 
 }
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index c2518cd..3f9f596 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -671,6 +671,21 @@ unsigned int qe_get_num_of_snums(void)
 }
 EXPORT_SYMBOL(qe_get_num_of_snums);
 
+static int __init qe_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!np) {
+		pr_err("%s: Could not find Quicc Engine node\n", __func__);
+		return -ENODEV;
+	}
+	qe_reset();
+	of_node_put(np);
+	return 0;
+}
+subsys_initcall(qe_init);
+
 #if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC_85xx)
 static int qe_resume(struct platform_device *ofdev)
 {
-- 
2.1.0.27.g96db324
