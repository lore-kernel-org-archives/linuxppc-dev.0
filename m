Return-Path: <michaelhench@gmail.com>
Received: from mail-qw0-f42.google.com (mail-qw0-f42.google.com
	[209.85.216.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE881B6F64
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jul 2011 23:06:56 +1000 (EST)
Received: by qwi4 with SMTP id 4so1192754qwi.15
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jul 2011 06:06:53 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 22 Jul 2011 08:06:53 -0500
Message-ID: <CAHyXW60RcO4poP8VXkm5Q0+9ACui1i_og2kDis8RKs=pxKB18w@mail.gmail.com>
Subject: RFC fsl_elbc_nand.c does not update mtd->ecc_stats
From: Michael Hench <michaelhench@gmail.com>
To: linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: MatthewLCreech@eaton.com, mhench@elutions.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

when using the fsl_elbc_nand driver, mtd->ecc_stats does not appear to
get updated
UBI uses this to determine when to scrub blocks
the patch below appears to fix this (draft 0)
am I missing anything?
does this look reasonable?



diff -purN orig/drivers/mtd/nand/fsl_elbc_nand.c
linux-3.0-rc7/drivers/mtd/nand/fsl_elbc_nand.c
--- orig/drivers/mtd/nand/fsl_elbc_nand.c	2011-07-22 07:02:37.908778052 -0500
+++ linux-3.0-rc7/drivers/mtd/nand/fsl_elbc_nand.c	2011-07-22
06:56:09.655002047 -0500
@@ -748,12 +748,43 @@ static int fsl_elbc_read_page(struct mtd
 			      uint8_t *buf,
 			      int page)
 {
+	struct fsl_elbc_mtd *priv = chip->priv;
+	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
+	uint32_t lteccr;
+
 	fsl_elbc_read_buf(mtd, buf, mtd->writesize);
 	fsl_elbc_read_buf(mtd, chip->oob_poi, mtd->oobsize);

 	if (fsl_elbc_wait(mtd, chip) & NAND_STATUS_FAIL)
 		mtd->ecc_stats.failed++;

+	if(chip->ecc.mode != NAND_ECC_HW)
+		return(0);
+
+	/* get the hardware ECC results */
+	lteccr = in_be32(&lbc->lteccr);
+	if(lteccr & 0x000F000F) {
+		int i;
+
+		out_be32(&lbc->lteccr, -1); /* clear lteccr */
+		printk(KERN_ERR "ECC RESULT %x n=%d",
+			lteccr, mtd->ecc_stats.corrected);
+		/*
+		 * 4 bits, one for each 512 byte subpage
+		 * 12-15 (ppc order) are for successfully corrected
+		 * 28-31 are for failed
+		 * small page nand has 3 bits set to zero in each field
+		 */
+		for(i=0; i < 4; i++) {
+			if(lteccr & 0x10000)
+				mtd->ecc_stats.corrected++;
+			if(lteccr & 0x1)
+				mtd->ecc_stats.failed++;
+			lteccr >>= 1;
+		}
+	}
+
 	return 0;
 }
