Return-Path: <mlcreech@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8ABFBB6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 08:35:11 +1000 (EST)
Received: by iwg8 with SMTP id 8so2467591iwg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Jul 2011 15:35:08 -0700 (PDT)
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCH v2] mtd: eLBC NAND: remove elbc_fcm_ctrl->oob_poi
Date: Tue,  5 Jul 2011 18:35:02 -0400
Message-Id: <1309905302-1990-1-git-send-email-mlcreech@gmail.com>
In-Reply-To: <20110705151525.438e87dc@schlenkerla.am.freescale.net>
References: <20110705151525.438e87dc@schlenkerla.am.freescale.net>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, rick22@wi.rr.com,
	mhench@elutions.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mike Hench <mhench@elutions.com>

The eLBC NAND driver currently follows up each program/write operation with a
read-back of the page, in order to [ostensibly] fill in ECC data for the
caller. However, the page address used for this read is always -1, so the read
will never work correctly.  Remove this useless (and potentially problematic)
block of code.

v2: elbc_fcm_ctrl->oob_poi is removed entirely, since this code block was the
only place it was actually used.

Signed-off-by: Matthew L. Creech <mlcreech@gmail.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 0bb254c..5e4fbf5 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -75,7 +75,6 @@ struct fsl_elbc_fcm_ctrl {
 	unsigned int use_mdr;    /* Non zero if the MDR is to be set      */
 	unsigned int oob;        /* Non zero if operating on OOB data     */
 	unsigned int counter;	 /* counter for the initializations	  */
-	char *oob_poi;           /* Place to write ECC after read back    */
 };
 
 /* These map to the positions used by the FCM hardware ECC generator */
@@ -454,25 +453,6 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		}
 
 		fsl_elbc_run_command(mtd);
-
-		/* Read back the page in order to fill in the ECC for the
-		 * caller.  Is this really needed?
-		 */
-		if (full_page && elbc_fcm_ctrl->oob_poi) {
-			out_be32(&lbc->fbcr, 3);
-			set_addr(mtd, 6, page_addr, 1);
-
-			elbc_fcm_ctrl->read_bytes = mtd->writesize + 9;
-
-			fsl_elbc_do_read(chip, 1);
-			fsl_elbc_run_command(mtd);
-
-			memcpy_fromio(elbc_fcm_ctrl->oob_poi + 6,
-				&elbc_fcm_ctrl->addr[elbc_fcm_ctrl->index], 3);
-			elbc_fcm_ctrl->index += 3;
-		}
-
-		elbc_fcm_ctrl->oob_poi = NULL;
 		return;
 	}
 
@@ -752,13 +732,8 @@ static void fsl_elbc_write_page(struct mtd_info *mtd,
                                 struct nand_chip *chip,
                                 const uint8_t *buf)
 {
-	struct fsl_elbc_mtd *priv = chip->priv;
-	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
-
 	fsl_elbc_write_buf(mtd, buf, mtd->writesize);
 	fsl_elbc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
-
-	elbc_fcm_ctrl->oob_poi = chip->oob_poi;
 }
 
 static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
-- 
1.6.3.3
