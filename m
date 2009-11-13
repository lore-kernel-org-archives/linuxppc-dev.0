Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 993F3B6EDF
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 07:12:43 +1100 (EST)
Date: Fri, 13 Nov 2009 14:13:01 -0600
From: Scott Wood <scottwood@freescale.com>
To: dwmw2@infradead.org
Subject: [PATCH 2/3] eLBC NAND: use recommended command sequences
Message-ID: <20091113201300.GA8329@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the program and erase sequences do not wait for completion,
instead relying on a subsequent waitfunc() callback.  However, this causes
the chipselect to be deasserted while the NAND chip is still asserting the
busy pin, which can corrupt activity on other chipselects.

This patch switches to using the sequences recommended by the manual,
in which a wait is performed within the initial command sequence.  We can
now re-use the status byte from the initial command sequence, rather than
having to do another status read in the waitfunc.

Since we're already touching the command sequences, it also cleans up some
cruft in SEQIN that isn't needed since we cannot program partial pages
outside of OOB.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Reported-by: Suchit Lepcha <suchit.lepcha@freescale.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |   66 +++++++++++++++----------------------
 1 files changed, 27 insertions(+), 39 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 58db278..5b51ed3 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -253,17 +253,17 @@ static void fsl_elbc_do_read(struct nand_chip *chip, int oob)
 
 	if (priv->page_size) {
 		out_be32(&lbc->fir,
-		         (FIR_OP_CW0 << FIR_OP0_SHIFT) |
+		         (FIR_OP_CM0 << FIR_OP0_SHIFT) |
 		         (FIR_OP_CA  << FIR_OP1_SHIFT) |
 		         (FIR_OP_PA  << FIR_OP2_SHIFT) |
-		         (FIR_OP_CW1 << FIR_OP3_SHIFT) |
+		         (FIR_OP_CM1 << FIR_OP3_SHIFT) |
 		         (FIR_OP_RBW << FIR_OP4_SHIFT));
 
 		out_be32(&lbc->fcr, (NAND_CMD_READ0 << FCR_CMD0_SHIFT) |
 		                    (NAND_CMD_READSTART << FCR_CMD1_SHIFT));
 	} else {
 		out_be32(&lbc->fir,
-		         (FIR_OP_CW0 << FIR_OP0_SHIFT) |
+		         (FIR_OP_CM0 << FIR_OP0_SHIFT) |
 		         (FIR_OP_CA  << FIR_OP1_SHIFT) |
 		         (FIR_OP_PA  << FIR_OP2_SHIFT) |
 		         (FIR_OP_RBW << FIR_OP3_SHIFT));
@@ -332,7 +332,7 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 	case NAND_CMD_READID:
 		dev_vdbg(ctrl->dev, "fsl_elbc_cmdfunc: NAND_CMD_READID.\n");
 
-		out_be32(&lbc->fir, (FIR_OP_CW0 << FIR_OP0_SHIFT) |
+		out_be32(&lbc->fir, (FIR_OP_CM0 << FIR_OP0_SHIFT) |
 		                    (FIR_OP_UA  << FIR_OP1_SHIFT) |
 		                    (FIR_OP_RBW << FIR_OP2_SHIFT));
 		out_be32(&lbc->fcr, NAND_CMD_READID << FCR_CMD0_SHIFT);
@@ -359,16 +359,20 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		dev_vdbg(ctrl->dev, "fsl_elbc_cmdfunc: NAND_CMD_ERASE2.\n");
 
 		out_be32(&lbc->fir,
-		         (FIR_OP_CW0 << FIR_OP0_SHIFT) |
+		         (FIR_OP_CM0 << FIR_OP0_SHIFT) |
 		         (FIR_OP_PA  << FIR_OP1_SHIFT) |
-		         (FIR_OP_CM1 << FIR_OP2_SHIFT));
+		         (FIR_OP_CM2 << FIR_OP2_SHIFT) |
+		         (FIR_OP_CW1 << FIR_OP3_SHIFT) |
+		         (FIR_OP_RS  << FIR_OP4_SHIFT));
 
 		out_be32(&lbc->fcr,
 		         (NAND_CMD_ERASE1 << FCR_CMD0_SHIFT) |
-		         (NAND_CMD_ERASE2 << FCR_CMD1_SHIFT));
+		         (NAND_CMD_STATUS << FCR_CMD1_SHIFT) |
+		         (NAND_CMD_ERASE2 << FCR_CMD2_SHIFT));
 
 		out_be32(&lbc->fbcr, 0);
 		ctrl->read_bytes = 0;
+		ctrl->use_mdr = 1;
 
 		fsl_elbc_run_command(mtd);
 		return;
@@ -383,40 +387,41 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 
 		ctrl->column = column;
 		ctrl->oob = 0;
+		ctrl->use_mdr = 1;
 
-		if (priv->page_size) {
-			fcr = (NAND_CMD_SEQIN << FCR_CMD0_SHIFT) |
-			      (NAND_CMD_PAGEPROG << FCR_CMD1_SHIFT);
+		fcr = (NAND_CMD_STATUS   << FCR_CMD1_SHIFT) |
+		      (NAND_CMD_SEQIN    << FCR_CMD2_SHIFT) |
+		      (NAND_CMD_PAGEPROG << FCR_CMD3_SHIFT);
 
+		if (priv->page_size) {
 			out_be32(&lbc->fir,
-			         (FIR_OP_CW0 << FIR_OP0_SHIFT) |
+			         (FIR_OP_CM2 << FIR_OP0_SHIFT) |
 			         (FIR_OP_CA  << FIR_OP1_SHIFT) |
 			         (FIR_OP_PA  << FIR_OP2_SHIFT) |
 			         (FIR_OP_WB  << FIR_OP3_SHIFT) |
-			         (FIR_OP_CW1 << FIR_OP4_SHIFT));
+			         (FIR_OP_CM3 << FIR_OP4_SHIFT) |
+			         (FIR_OP_CW1 << FIR_OP5_SHIFT) |
+			         (FIR_OP_RS  << FIR_OP6_SHIFT));
 		} else {
-			fcr = (NAND_CMD_PAGEPROG << FCR_CMD1_SHIFT) |
-			      (NAND_CMD_SEQIN << FCR_CMD2_SHIFT);
-
 			out_be32(&lbc->fir,
-			         (FIR_OP_CW0 << FIR_OP0_SHIFT) |
+			         (FIR_OP_CM0 << FIR_OP0_SHIFT) |
 			         (FIR_OP_CM2 << FIR_OP1_SHIFT) |
 			         (FIR_OP_CA  << FIR_OP2_SHIFT) |
 			         (FIR_OP_PA  << FIR_OP3_SHIFT) |
 			         (FIR_OP_WB  << FIR_OP4_SHIFT) |
-			         (FIR_OP_CW1 << FIR_OP5_SHIFT));
+			         (FIR_OP_CM3 << FIR_OP5_SHIFT) |
+			         (FIR_OP_CW1 << FIR_OP6_SHIFT) |
+			         (FIR_OP_RS  << FIR_OP7_SHIFT));
 
 			if (column >= mtd->writesize) {
 				/* OOB area --> READOOB */
 				column -= mtd->writesize;
 				fcr |= NAND_CMD_READOOB << FCR_CMD0_SHIFT;
 				ctrl->oob = 1;
-			} else if (column < 256) {
+			} else {
+				WARN_ON(column != 0);
 				/* First 256 bytes --> READ0 */
 				fcr |= NAND_CMD_READ0 << FCR_CMD0_SHIFT;
-			} else {
-				/* Second 256 bytes --> READ1 */
-				fcr |= NAND_CMD_READ1 << FCR_CMD0_SHIFT;
 			}
 		}
 
@@ -628,22 +633,6 @@ static int fsl_elbc_wait(struct mtd_info *mtd, struct nand_chip *chip)
 {
 	struct fsl_elbc_mtd *priv = chip->priv;
 	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
-	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
-
-	if (ctrl->status != LTESR_CC)
-		return NAND_STATUS_FAIL;
-
-	/* Use READ_STATUS command, but wait for the device to be ready */
-	ctrl->use_mdr = 0;
-	out_be32(&lbc->fir,
-	         (FIR_OP_CW0 << FIR_OP0_SHIFT) |
-	         (FIR_OP_RBW << FIR_OP1_SHIFT));
-	out_be32(&lbc->fcr, NAND_CMD_STATUS << FCR_CMD0_SHIFT);
-	out_be32(&lbc->fbcr, 1);
-	set_addr(mtd, 0, 0, 0);
-	ctrl->read_bytes = 1;
-
-	fsl_elbc_run_command(mtd);
 
 	if (ctrl->status != LTESR_CC)
 		return NAND_STATUS_FAIL;
@@ -651,8 +640,7 @@ static int fsl_elbc_wait(struct mtd_info *mtd, struct nand_chip *chip)
 	/* The chip always seems to report that it is
 	 * write-protected, even when it is not.
 	 */
-	setbits8(ctrl->addr, NAND_STATUS_WP);
-	return fsl_elbc_read_byte(mtd);
+	return (ctrl->mdr & 0xff) | NAND_STATUS_WP;
 }
 
 static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
-- 
1.6.4.4
