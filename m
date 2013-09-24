Return-Path: <r63061@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E0B9E2C0157
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 20:54:35 +1000 (EST)
Received: from mail25-db8 (localhost [127.0.0.1])	by mail25-db8-R.bigfish.com
 (Postfix) with ESMTP id F23B512402E2	for
 <linuxppc-dev@lists.ozlabs.org>;
 Tue, 24 Sep 2013 10:54:29 +0000 (UTC)
Received: from DB8EHSMHS017.bigfish.com (unknown [10.174.8.242])	by
 mail25-db8.bigfish.com (Postfix) with ESMTP id 97495F40048	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 10:54:28 +0000 (UTC)
From: Xie Xiaobo <X.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH V4 2/3] powerpc/85xx: Use common init functions for QE
Date: Tue, 24 Sep 2013 18:48:58 +0800
Message-ID: <1380019739-8196-2-git-send-email-X.Xie@freescale.com>
In-Reply-To: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
References: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use common init functions instead of the duplicated codes
in some platforms with QUICC Engine.

Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
---
V4: new patch

 arch/powerpc/platforms/85xx/mpc85xx_mds.c | 55 ++-----------------------------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 36 ++------------------
 2 files changed, 4 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index a7b3621..da28d74 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -238,32 +238,7 @@ static void __init mpc85xx_mds_qe_init(void)
 {
 	struct device_node *np;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!np) {
-		np = of_find_node_by_name(NULL, "qe");
-		if (!np)
-			return;
-	}
-
-	if (!of_device_is_available(np)) {
-		of_node_put(np);
-		return;
-	}
-
-	qe_reset();
-	of_node_put(np);
-
-	np = of_find_node_by_name(NULL, "par_io");
-	if (np) {
-		struct device_node *ucc;
-
-		par_io_init(np);
-		of_node_put(np);
-
-		for_each_node_by_name(ucc, "ucc")
-			par_io_of_config(ucc);
-	}
-
+	mpc85xx_qe_init();
 	mpc85xx_mds_reset_ucc_phys();
 
 	if (machine_is(p1021_mds)) {
@@ -293,34 +268,8 @@ static void __init mpc85xx_mds_qe_init(void)
 
 	}
 }
-
-static void __init mpc85xx_mds_qeic_init(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!of_device_is_available(np)) {
-		of_node_put(np);
-		return;
-	}
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
-}
 #else
 static void __init mpc85xx_mds_qe_init(void) { }
-static void __init mpc85xx_mds_qeic_init(void) { }
 #endif	/* CONFIG_QUICC_ENGINE */
 
 static void __init mpc85xx_mds_setup_arch(void)
@@ -395,7 +344,7 @@ static void __init mpc85xx_mds_pic_init(void)
 	BUG_ON(mpic == NULL);
 
 	mpic_init(mpic);
-	mpc85xx_mds_qeic_init();
+	mpc85xx_qe_pic_init();
 }
 
 static int __init mpc85xx_mds_probe(void)
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 53b6fb0..67d78e2 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -49,10 +49,6 @@ void __init mpc85xx_rdb_pic_init(void)
 	struct mpic *mpic;
 	unsigned long root = of_get_flat_dt_root();
 
-#ifdef CONFIG_QUICC_ENGINE
-	struct device_node *np;
-#endif
-
 	if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
 		mpic = mpic_alloc(NULL, 0, MPIC_NO_RESET |
 			MPIC_BIG_ENDIAN |
@@ -69,16 +65,8 @@ void __init mpc85xx_rdb_pic_init(void)
 	mpic_init(mpic);
 
 #ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-		of_node_put(np);
-
-	} else
-		pr_err("%s: Could not find qe-ic node\n", __func__);
+	mpc85xx_qe_pic_init();
 #endif
-
 }
 
 /*
@@ -98,26 +86,8 @@ static void __init mpc85xx_rdb_setup_arch(void)
 	fsl_pci_assign_primary();
 
 #ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!np) {
-		pr_err("%s: Could not find Quicc Engine node\n", __func__);
-		goto qe_fail;
-	}
+	mpc85xx_qe_init();
 
-	qe_reset();
-	of_node_put(np);
-
-	np = of_find_node_by_name(NULL, "par_io");
-	if (np) {
-		struct device_node *ucc;
-
-		par_io_init(np);
-		of_node_put(np);
-
-		for_each_node_by_name(ucc, "ucc")
-			par_io_of_config(ucc);
-
-	}
 #if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
 	if (machine_is(p1025_rdb)) {
 
@@ -148,8 +118,6 @@ static void __init mpc85xx_rdb_setup_arch(void)
 
 	}
 #endif
-
-qe_fail:
 #endif	/* CONFIG_QUICC_ENGINE */
 
 	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
-- 
1.8.0
