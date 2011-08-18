Return-Path: <B35362@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A59D5B6FA3
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2011 13:34:32 +1000 (EST)
From: <b35362@freescale.com>
To: <dwmw2@infradead.org>
Subject: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
Date: Thu, 18 Aug 2011 10:33:03 +0800
Message-ID: <1313634783-8855-1-git-send-email-b35362@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liu Shuo <b35362@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liu Shuo <b35362@freescale.com>

Freescale FCM controller has a 2K size limitation of buffer RAM. In order
to support the Nand flash chip whose page size is larger than 2K bytes,
we divide a page into multi-2K pages for MTD layer driver. In that case,
we force to set the page size to 2K bytes. We convert the page address of
MTD layer driver to a real page address in flash chips and a column index
in fsl_elbc driver. We can issue any column address by UA instruction of
elbc controller.

NOTE: Due to there is a limitation of 'Number of Partial Program Cycles in
the Same Page (NOP)', the flash chip which is supported by this workaround 
have to meet below conditions.
	1. page size is not greater than 4KB 
	2.	1) if main area and spare area have independent NOPs:
			  main  area NOP    :    >=3
			  spare area NOP    :    >=2
		2) if main area and spare area have a common NOP: 
			  NOP               :    >=4

Signed-off-by: Liu Shuo <b35362@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |   66 ++++++++++++++++++++++++++++++-------
 1 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index a212116..884a9f1 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -76,6 +76,13 @@ struct fsl_elbc_fcm_ctrl {
 	unsigned int oob;        /* Non zero if operating on OOB data     */
 	unsigned int counter;	 /* counter for the initializations	  */
 	char *oob_poi;           /* Place to write ECC after read back    */
+
+	/*
+	 * If writesize > 2048, these two members are used to calculate
+	 * the real page address and real column address.
+	 */
+	int subpage_shift;
+	int subpage_mask;
 };
 
 /* These map to the positions used by the FCM hardware ECC generator */
@@ -164,18 +171,27 @@ static void set_addr(struct mtd_info *mtd, int column, int page_addr, int oob)
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
 	int buf_num;
+	u32 real_ca = column;
 
-	elbc_fcm_ctrl->page = page_addr;
+	if (priv->page_size && elbc_fcm_ctrl->subpage_shift) {
+		real_ca = (page_addr & elbc_fcm_ctrl->subpage_mask) * 2112;
+		page_addr >>= elbc_fcm_ctrl->subpage_shift;
+	}
 
-	out_be32(&lbc->fbar,
-	         page_addr >> (chip->phys_erase_shift - chip->page_shift));
+	elbc_fcm_ctrl->page = page_addr;
 
 	if (priv->page_size) {
+		real_ca += (oob ? 2048 : 0);
+		elbc_fcm_ctrl->use_mdr = 1;
+		elbc_fcm_ctrl->mdr = real_ca;
+
+		out_be32(&lbc->fbar, page_addr >> 6);
 		out_be32(&lbc->fpar,
 		         ((page_addr << FPAR_LP_PI_SHIFT) & FPAR_LP_PI) |
 		         (oob ? FPAR_LP_MS : 0) | column);
 		buf_num = (page_addr & 1) << 2;
 	} else {
+		out_be32(&lbc->fbar, page_addr >> 5);
 		out_be32(&lbc->fpar,
 		         ((page_addr << FPAR_SP_PI_SHIFT) & FPAR_SP_PI) |
 		         (oob ? FPAR_SP_MS : 0) | column);
@@ -256,10 +272,11 @@ static void fsl_elbc_do_read(struct nand_chip *chip, int oob)
 	if (priv->page_size) {
 		out_be32(&lbc->fir,
 		         (FIR_OP_CM0 << FIR_OP0_SHIFT) |
-		         (FIR_OP_CA  << FIR_OP1_SHIFT) |
-		         (FIR_OP_PA  << FIR_OP2_SHIFT) |
-		         (FIR_OP_CM1 << FIR_OP3_SHIFT) |
-		         (FIR_OP_RBW << FIR_OP4_SHIFT));
+		         (FIR_OP_UA  << FIR_OP1_SHIFT) |
+		         (FIR_OP_UA  << FIR_OP2_SHIFT) |
+		         (FIR_OP_PA  << FIR_OP3_SHIFT) |
+		         (FIR_OP_CM1 << FIR_OP4_SHIFT) |
+		         (FIR_OP_RBW << FIR_OP5_SHIFT));
 
 		out_be32(&lbc->fcr, (NAND_CMD_READ0 << FCR_CMD0_SHIFT) |
 		                    (NAND_CMD_READSTART << FCR_CMD1_SHIFT));
@@ -399,12 +416,13 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		if (priv->page_size) {
 			out_be32(&lbc->fir,
 			         (FIR_OP_CM2 << FIR_OP0_SHIFT) |
-			         (FIR_OP_CA  << FIR_OP1_SHIFT) |
-			         (FIR_OP_PA  << FIR_OP2_SHIFT) |
-			         (FIR_OP_WB  << FIR_OP3_SHIFT) |
-			         (FIR_OP_CM3 << FIR_OP4_SHIFT) |
-			         (FIR_OP_CW1 << FIR_OP5_SHIFT) |
-			         (FIR_OP_RS  << FIR_OP6_SHIFT));
+			         (FIR_OP_UA  << FIR_OP1_SHIFT) |
+			         (FIR_OP_UA  << FIR_OP2_SHIFT) |
+			         (FIR_OP_PA  << FIR_OP3_SHIFT) |
+			         (FIR_OP_WB  << FIR_OP4_SHIFT) |
+			         (FIR_OP_CM3 << FIR_OP5_SHIFT) |
+			         (FIR_OP_CW1 << FIR_OP6_SHIFT) |
+			         (FIR_OP_RS  << FIR_OP7_SHIFT));
 		} else {
 			out_be32(&lbc->fir,
 			         (FIR_OP_CM0 << FIR_OP0_SHIFT) |
@@ -453,6 +471,9 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 			full_page = 1;
 		}
 
+		if (priv->page_size)
+			elbc_fcm_ctrl->use_mdr = 1;
+
 		fsl_elbc_run_command(mtd);
 
 		/* Read back the page in order to fill in the ECC for the
@@ -654,9 +675,28 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 	struct nand_chip *chip = mtd->priv;
 	struct fsl_elbc_mtd *priv = chip->priv;
 	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 	unsigned int al;
 
+	/*
+	 * Hack for supporting the flash chip whose writesize is
+	 * larger than 2K bytes.
+	 */
+	if (mtd->writesize > 2048) {
+		elbc_fcm_ctrl->subpage_shift = ffs(mtd->writesize >> 11) - 1;
+		elbc_fcm_ctrl->subpage_mask =
+			(1 << elbc_fcm_ctrl->subpage_shift) - 1;
+		/*
+		 * Rewrite mtd->writesize, mtd->oobsize, chip->page_shift
+		 * and chip->pagemask.
+		 */
+		mtd->writesize = 2048;
+		mtd->oobsize = 64;
+		chip->page_shift = ffs(mtd->writesize) - 1;
+		chip->pagemask = (chip->chipsize >> chip->page_shift) - 1;
+	}
+
 	/* calculate FMR Address Length field */
 	al = 0;
 	if (chip->pagemask & 0xffff0000)
-- 
1.7.1
