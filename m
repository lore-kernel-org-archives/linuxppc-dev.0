Return-Path: <ying.zhang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0119.outbound.protection.outlook.com [65.55.169.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 392B41A0689
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 21:23:43 +1100 (AEDT)
From: <ying.zhang@freescale.com>
To: <scottwood@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/3] P1021RDB: Add QE TDM support
Date: Thu, 26 Mar 2015 17:16:17 +0800
Message-ID: <1427361377-4789-1-git-send-email-ying.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Xie Xiaobo <X.Xie@freescale.com>, Ying Zhang <b40530@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ying Zhang <b40530@freescale.com>

The P1021RDB-PC have PMC sockets that support QE-TDM function.
The patch enable Quicc Engine and the related signals of QE-TDM.

Signed-off-by: Ying Zhang <b40530@freescale.com>
Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>

---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 76 ++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index e358bed..a2f0639 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -86,6 +86,12 @@ void __init mpc85xx_rdb_pic_init(void)
  */
 static void __init mpc85xx_rdb_setup_arch(void)
 {
+	struct device_node *np;
+#if defined(CONFIG_QUICC_ENGINE) && defined(CONFIG_SPI_FSL_SPI)
+	struct device_node *qe_spi;
+#endif
+	struct ccsr_guts __iomem *guts;
+
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_rdb_setup_arch()", 0);
 
@@ -96,37 +102,63 @@ static void __init mpc85xx_rdb_setup_arch(void)
 #ifdef CONFIG_QUICC_ENGINE
 	mpc85xx_qe_init();
 	mpc85xx_qe_par_io_init();
-#if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
-	if (machine_is(p1025_rdb)) {
-		struct device_node *np;
-
-		struct ccsr_guts __iomem *guts;
-
-		np = of_find_node_by_name(NULL, "global-utilities");
-		if (np) {
-			guts = of_iomap(np, 0);
-			if (!guts) {
-
-				pr_err("mpc85xx-rdb: could not map global utilities register\n");
+#ifdef CONFIG_SPI_FSL_SPI
+	for_each_node_by_name(qe_spi, "spi")
+			par_io_of_config(qe_spi);
+#endif	/* CONFIG_SPI_FSL_SPI */
 
-			} else {
-			/* P1025 has pins muxed for QE and other functions. To
-			* enable QE UEC mode, we need to set bit QE0 for UCC1
-			* in Eth mode, QE0 and QE3 for UCC5 in Eth mode, QE9
-			* and QE12 for QE MII management singals in PMUXCR
-			* register.
-			*/
+	np = of_find_node_by_name(NULL, "global-utilities");
+	if (np) {
+		guts = of_iomap(np, 0);
+		if (!guts)
+			pr_err("mpc85xx-rdb: could not map global %s\n",
+					"utilities register");
+		else {
+#if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
+			if (machine_is(p1025_rdb)) {
+				/*
+				 * P1025 has pins muxed for QE and other
+				 * functions. To enable QE UEC mode, we
+				 * need to set bit QE0 for UCC1 in Eth mode,
+				 * QE0 and QE3 for UCC5 in Eth mode, QE9
+				 * and QE12 for QE MII management singals
+				 * in PMUXCR register.
+				 */
 				setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0) |
 						MPC85xx_PMUXCR_QE(3) |
 						MPC85xx_PMUXCR_QE(9) |
 						MPC85xx_PMUXCR_QE(12));
-				iounmap(guts);
 			}
-			of_node_put(np);
+#endif
+#ifdef CONFIG_FSL_UCC_TDM
+			if (machine_is(p1021_rdb_pc)) {
+				/* Clear QE12 for releasing the LBCTL */
+				clrbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(12));
+				/* TDMA */
+				setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(5) |
+						  MPC85xx_PMUXCR_QE(11));
+				/* TDMB */
+				setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0) |
+						  MPC85xx_PMUXCR_QE(9));
+				/* TDMC */
+				setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0));
+				/* TDMD */
+				setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(8) |
+						  MPC85xx_PMUXCR_QE(7));
+			}
+#endif	/* CONFIG_FSL_UCC_TDM */
+#ifdef CONFIG_SPI_FSL_SPI
+			clrbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(12));
+			/*QE-SPI*/
+			setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(6) |
+					  MPC85xx_PMUXCR_QE(9) |
+					  MPC85xx_PMUXCR_QE(10));
+#endif	/* CONFIG_SPI_FSL_SPI */
+			iounmap(guts);
 		}
 
+		of_node_put(np);
 	}
-#endif
 #endif	/* CONFIG_QUICC_ENGINE */
 
 	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
-- 
1.8.4.1
