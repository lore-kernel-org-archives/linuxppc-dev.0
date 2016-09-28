Return-Path: <qiang.zhao@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0040.outbound.protection.outlook.com [104.47.32.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skNgY1zPKzDrZD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 13:37:29 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <oss@buserror.net>, <tglx@linutronix.de>
CC: <jason@lakedaemon.net>, <marc.zyngier@arm.com>, <xiaobo.xie@nxp.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang
 <qiang.zhao@nxp.com>
Subject: [PATCH v6 2/4] irqchip/qeic: merge qeic init code from platforms to a
 common function
Date: Wed, 28 Sep 2016 11:25:01 +0800
Message-ID: <1475033103-18192-2-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1475033103-18192-1-git-send-email-qiang.zhao@nxp.com>
References: <1475033103-18192-1-git-send-email-qiang.zhao@nxp.com>
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

The codes of qe_ic init from a variety of platforms are redundant,
merge them to a common function and put it to irqchip/irq-qeic.c

For non-p1021_mds mpc85xx_mds boards, use "qe_ic_init(np, 0,
qe_ic_cascade_low_mpic, qe_ic_cascade_high_mpic);" instead of
"qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);".

qe_ic_cascade_muxed_mpic was used for boards has the same interrupt
number for low interrupt and high interrupt, qe_ic_init has checked
if "low interrupt == high interrupt"

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2:
	- modify subject and commit msg
	- add check for qeic by type
Changes for v3:
	- na
Changes for v4:
	- na
Changes for v5:
	- na
Changes for v6:
	- rebase

 arch/powerpc/platforms/83xx/misc.c            | 15 ---------------
 arch/powerpc/platforms/85xx/corenet_generic.c |  9 ---------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     | 14 --------------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     | 16 ----------------
 arch/powerpc/platforms/85xx/twr_p102x.c       | 14 --------------
 drivers/irqchip/irq-qeic.c                    | 16 ++++++++++++++++
 6 files changed, 16 insertions(+), 68 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index d75c981..c09a135 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -93,24 +93,9 @@ void __init mpc83xx_ipic_init_IRQ(void)
 }
 
 #ifdef CONFIG_QUICC_ENGINE
-void __init mpc83xx_qe_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (!np) {
-		np = of_find_node_by_type(NULL, "qeic");
-		if (!np)
-			return;
-	}
-	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
-	of_node_put(np);
-}
-
 void __init mpc83xx_ipic_and_qe_init_IRQ(void)
 {
 	mpc83xx_ipic_init_IRQ();
-	mpc83xx_qe_init_IRQ();
 }
 #endif /* CONFIG_QUICC_ENGINE */
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 1179115..1d96c3f 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -41,8 +41,6 @@ void __init corenet_gen_pic_init(void)
 	unsigned int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU |
 		MPIC_NO_RESET;
 
-	struct device_node *np;
-
 	if (ppc_md.get_irq == mpic_get_coreint_irq)
 		flags |= MPIC_ENABLE_COREINT;
 
@@ -50,13 +48,6 @@ void __init corenet_gen_pic_init(void)
 	BUG_ON(mpic == NULL);
 
 	mpic_init(mpic);
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-		of_node_put(np);
-	}
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index d7e440e..06f34a9 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -283,20 +283,6 @@ static void __init mpc85xx_mds_qeic_init(void)
 		of_node_put(np);
 		return;
 	}
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (!np) {
-		np = of_find_node_by_type(NULL, "qeic");
-		if (!np)
-			return;
-	}
-
-	if (machine_is(p1021_mds))
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-	else
-		qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
-	of_node_put(np);
 }
 #else
 static void __init mpc85xx_mds_qe_init(void) { }
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 1006950..000d385 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -48,10 +48,6 @@ void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic;
 
-#ifdef CONFIG_QUICC_ENGINE
-	struct device_node *np;
-#endif
-
 	if (of_machine_is_compatible("fsl,MPC85XXRDB-CAMP")) {
 		mpic = mpic_alloc(NULL, 0, MPIC_NO_RESET |
 			MPIC_BIG_ENDIAN |
@@ -66,18 +62,6 @@ void __init mpc85xx_rdb_pic_init(void)
 
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-		of_node_put(np);
-
-	} else
-		pr_err("%s: Could not find qe-ic node\n", __func__);
-#endif
-
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 360f625..6be9b33 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -35,26 +35,12 @@ static void __init twr_p1025_pic_init(void)
 {
 	struct mpic *mpic;
 
-#ifdef CONFIG_QUICC_ENGINE
-	struct device_node *np;
-#endif
-
 	mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
 			MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
 
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-		of_node_put(np);
-	} else
-		pr_err("Could not find qe-ic node\n");
-#endif
 }
 
 /* ************************************************************************
diff --git a/drivers/irqchip/irq-qeic.c b/drivers/irqchip/irq-qeic.c
index 48ceded..1463731 100644
--- a/drivers/irqchip/irq-qeic.c
+++ b/drivers/irqchip/irq-qeic.c
@@ -598,4 +598,20 @@ static int __init init_qe_ic_sysfs(void)
 	return 0;
 }
 
+static int __init qeic_of_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (!np) {
+		np = of_find_node_by_type(NULL, "qeic");
+		if (!np)
+			return;
+	}
+	qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
+		   qe_ic_cascade_high_mpic);
+	of_node_put(np);
+}
+
+subsys_initcall(qeic_of_init);
 subsys_initcall(init_qe_ic_sysfs);
-- 
2.1.0.27.g96db324
