Return-Path: <qiang.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0105.outbound.protection.outlook.com [207.46.100.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA9811A0A84
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 13:57:03 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <lauraa@codeaurora.org>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <akpm@linux-foundation.org>, <olof@lixom.net>, <catalin.marinas@arm.com>,
 <scottwood@freescale.com>, <X.xie@freescale.com>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH v13 5/6] QE: use subsys_initcall to init qe
Date: Mon, 30 Nov 2015 10:48:56 +0800
Message-ID: <1448851737-33125-5-git-send-email-qiang.zhao@freescale.com>
In-Reply-To: <1448851737-33125-1-git-send-email-qiang.zhao@freescale.com>
References: <1448851737-33125-1-git-send-email-qiang.zhao@freescale.com>
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
Changes for v13:
	- drop a print

 arch/powerpc/platforms/83xx/km83xx.c      |  2 --
 arch/powerpc/platforms/83xx/mpc832x_mds.c |  2 --
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |  2 --
 arch/powerpc/platforms/83xx/mpc836x_mds.c |  2 --
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |  3 ---
 arch/powerpc/platforms/85xx/common.c      |  1 -
 arch/powerpc/sysdev/qe_lib/qe.c           | 13 +++++++++++++
 7 files changed, 13 insertions(+), 12 deletions(-)

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
index 23791de..18bca20 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -105,7 +105,6 @@ void __init mpc85xx_qe_init(void)
 		return;
 	}
 
-	qe_reset();
 	of_node_put(np);
 
 }
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index c2518cd..88ae5c7 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -671,6 +671,19 @@ unsigned int qe_get_num_of_snums(void)
 }
 EXPORT_SYMBOL(qe_get_num_of_snums);
 
+static int __init qe_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!np)
+		return -ENODEV;
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
