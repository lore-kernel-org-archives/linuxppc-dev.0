Return-Path: <B32579@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BFFAAB6EFE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2012 15:13:25 +1100 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH] mtd/nand:Fix wrong usage of is_blank() in fsl_ifc_run_command
Date: Wed, 18 Jan 2012 09:43:11 +0530
Message-ID: <1326859991-7469-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Freescale IFC NAND Machine calculates ECC on 512byte sector and same is used in
fsl_ifc_run_command() during ECC status verification. Also this sector is passed
to is_blank() for blank checking. It is wrong at first place because
is_blank()'s implementation checks for Page size and OOB area size. 
is_blank() should be called per page for main and OOB area verification.

Variables name are redefined to avoid confusion between buffer and ecc sector.

Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git (branch next)

 Tested on P1010RDB

 This patch is created on top of IFC driver patch (already floated in mailing
 list). Please find their link:
 http://patchwork.ozlabs.org/patch/133315/
 http://patchwork.ozlabs.org/patch/133316/

 This patch is replacement of my earlier patch
  "mtd/nand:Fix wrong address read in is_blank()"

 drivers/mtd/nand/fsl_ifc_nand.c |   52 +++++++++++++++++++++------------------
 1 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 854fe95..33b55d2 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -1,7 +1,7 @@
 /*
  * Freescale Integrated Flash Controller NAND driver
  *
- * Copyright 2011 Freescale Semiconductor, Inc
+ * Copyright 2011,2012 Freescale Semiconductor, Inc
  *
  * Author: Dipen Dudhat <Dipen.Dudhat@freescale.com>
  *
@@ -216,24 +216,11 @@ static int check_read_ecc(struct mtd_info *mtd, struct fsl_ifc_ctrl *ctrl,
 			  u32 *eccstat, unsigned int bufnum)
 {
 	u32 reg = eccstat[bufnum / 4];
-	int errors = (reg >> ((3 - bufnum % 4) * 8)) & 15;
+	int errors;
 
-	if (errors == 15) { /* uncorrectable */
-		/* Blank pages fail hw ECC checks */
-		if (is_blank(mtd, bufnum))
-			return 1;
+	errors = (reg >> ((3 - bufnum % 4) * 8)) & 15;
 
-		/*
-		 * We disable ECCER reporting in hardware due to
-		 * erratum IFC-A002770 -- so report it now if we
-		 * see an uncorrectable error in ECCSTAT.
-		 */
-		ctrl->nand_stat |= IFC_NAND_EVTER_STAT_ECCER;
-	} else if (errors > 0) {
-		mtd->ecc_stats.corrected += errors;
-	}
-
-	return 0;
+	return errors;
 }
 
 /*
@@ -273,16 +260,33 @@ static void fsl_ifc_run_command(struct mtd_info *mtd)
 		dev_err(priv->dev, "NAND Flash Write Protect Error\n");
 
 	if (nctrl->eccread) {
-		int bufperpage = mtd->writesize / 512;
-		int bufnum = (nctrl->page & priv->bufnum_mask) * bufperpage;
-		int bufnum_end = bufnum + bufperpage - 1;
+		int errors;
+		int bufnum = nctrl->page & priv->bufnum_mask;
+		int sector = bufnum * chip->ecc.steps;
+		int sector_end = sector + chip->ecc.steps - 1;
 
-		for (i = bufnum / 4; i <= bufnum_end / 4; i++)
+		for (i = sector / 4; i <= sector_end / 4; i++)
 			eccstat[i] = in_be32(&ifc->ifc_nand.nand_eccstat[i]);
 
-		for (i = bufnum; i <= bufnum_end; i++) {
-			if (check_read_ecc(mtd, ctrl, eccstat, i))
+		for (i = sector; i <= sector_end; i++) {
+			errors = check_read_ecc(mtd, ctrl, eccstat, i);
+
+			if (errors == 15) {
+				/*
+				 * Uncorrectable error.
+				 * OK only if the whole page is blank.
+				 *
+				 * We disable ECCER reporting due to...
+				 * erratum IFC-A002770 -- so report it now if we
+				 * see an uncorrectable error in ECCSTAT.
+				 */
+				if (!is_blank(mtd, bufnum))
+					ctrl->nand_stat |=
+						IFC_NAND_EVTER_STAT_ECCER;
 				break;
+			}
+
+			mtd->ecc_stats.corrected += errors;
 		}
 
 		nctrl->eccread = 0;
-- 
1.7.5.4
