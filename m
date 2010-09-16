Return-Path: <tie-fei.zang@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205]) by ozlabs.org (Postfix) with ESMTP id DE458B70AE
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 17:04:20 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCH 2/3 v3] P4080/mtd: Only make elbc nand driver detect nand
	flash partitions
Date: Thu, 16 Sep 2010 14:41:23 +0800
Message-ID: <1284619284-23614-2-git-send-email-tie-fei.zang@freescale.com>
In-Reply-To: <1284619284-23614-1-git-send-email-tie-fei.zang@freescale.com>
References: <1284619284-23614-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, dedekind1@gmail.com, B25806@freescale.com,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	dwmw2@infradead.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jack Lan <jack.lan@freescale.com>

The former driver had the two functions:

1. detecting nand flash partitions;
2. registering elbc interrupt.

Now, second function is removed to fsl_lbc.c.

Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 drivers/mtd/nand/Kconfig         |    1 +
 drivers/mtd/nand/fsl_elbc_nand.c |  474 +++++++++++++++-----------------------
 2 files changed, 190 insertions(+), 285 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 8b4b67c..4132c46 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -458,6 +458,7 @@ config MTD_NAND_ORION
 config MTD_NAND_FSL_ELBC
 	tristate "NAND support for Freescale eLBC controllers"
 	depends on PPC_OF
+	select FSL_LBC
 	help
 	  Various Freescale chips, including the 8313, include a NAND Flash
 	  Controller Module with built-in hardware ECC capabilities.
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 80de0bf..91c5c05 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -1,9 +1,10 @@
 /* Freescale Enhanced Local Bus Controller NAND driver
  *
- * Copyright (c) 2006-2007 Freescale Semiconductor
+ * Copyright (c) 2006-2007, 2010 Freescale Semiconductor
  *
  * Authors: Nick Spence <nick.spence@freescale.com>,
  *          Scott Wood <scottwood@freescale.com>
+ *          Jack Lan <jack.lan@freescale.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -27,6 +28,7 @@
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 
@@ -42,14 +44,12 @@
 #define ERR_BYTE 0xFF /* Value returned for read bytes when read failed */
 #define FCM_TIMEOUT_MSECS 500 /* Maximum number of mSecs to wait for FCM */
 
-struct fsl_elbc_ctrl;
-
 /* mtd information per set */
 
 struct fsl_elbc_mtd {
 	struct mtd_info mtd;
 	struct nand_chip chip;
-	struct fsl_elbc_ctrl *ctrl;
+	struct fsl_lbc_ctrl *ctrl;
 
 	struct device *dev;
 	int bank;               /* Chip select bank number           */
@@ -58,18 +58,12 @@ struct fsl_elbc_mtd {
 	unsigned int fmr;       /* FCM Flash Mode Register value     */
 };
 
-/* overview of the fsl elbc controller */
+/* Freescale eLBC FCM controller infomation */
 
-struct fsl_elbc_ctrl {
+struct fsl_elbc_fcm_ctrl {
 	struct nand_hw_control controller;
 	struct fsl_elbc_mtd *chips[MAX_BANKS];
 
-	/* device info */
-	struct device *dev;
-	struct fsl_lbc_regs __iomem *regs;
-	int irq;
-	wait_queue_head_t irq_wait;
-	unsigned int irq_status; /* status read from LTESR by irq handler */
 	u8 __iomem *addr;        /* Address of assigned FCM buffer        */
 	unsigned int page;       /* Last page written to / read from      */
 	unsigned int read_bytes; /* Number of bytes read during command   */
@@ -164,11 +158,12 @@ static void set_addr(struct mtd_info *mtd, int column, int page_addr, int oob)
 {
 	struct nand_chip *chip = mtd->priv;
 	struct fsl_elbc_mtd *priv = chip->priv;
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
 	int buf_num;
 
-	ctrl->page = page_addr;
+	elbc_fcm_ctrl->page = page_addr;
 
 	out_be32(&lbc->fbar,
 	         page_addr >> (chip->phys_erase_shift - chip->page_shift));
@@ -185,16 +180,18 @@ static void set_addr(struct mtd_info *mtd, int column, int page_addr, int oob)
 		buf_num = page_addr & 7;
 	}
 
-	ctrl->addr = priv->vbase + buf_num * 1024;
-	ctrl->index = column;
+	elbc_fcm_ctrl->addr = priv->vbase + buf_num * 1024;
+	elbc_fcm_ctrl->index = column;
 
 	/* for OOB data point to the second half of the buffer */
 	if (oob)
-		ctrl->index += priv->page_size ? 2048 : 512;
+		elbc_fcm_ctrl->index += priv->page_size ? 2048 : 512;
 
-	dev_vdbg(ctrl->dev, "set_addr: bank=%d, ctrl->addr=0x%p (0x%p), "
+	dev_vdbg(priv->dev, "set_addr: bank=%d, "
+			    "elbc_fcm_ctrl->addr=0x%p (0x%p), "
 	                    "index %x, pes %d ps %d\n",
-	         buf_num, ctrl->addr, priv->vbase, ctrl->index,
+		 buf_num, elbc_fcm_ctrl->addr, priv->vbase,
+		 elbc_fcm_ctrl->index,
 	         chip->phys_erase_shift, chip->page_shift);
 }
 
@@ -205,18 +202,19 @@ static int fsl_elbc_run_command(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd->priv;
 	struct fsl_elbc_mtd *priv = chip->priv;
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 
 	/* Setup the FMR[OP] to execute without write protection */
 	out_be32(&lbc->fmr, priv->fmr | 3);
-	if (ctrl->use_mdr)
-		out_be32(&lbc->mdr, ctrl->mdr);
+	if (elbc_fcm_ctrl->use_mdr)
+		out_be32(&lbc->mdr, elbc_fcm_ctrl->mdr);
 
-	dev_vdbg(ctrl->dev,
+	dev_vdbg(priv->dev,
 	         "fsl_elbc_run_command: fmr=%08x fir=%08x fcr=%08x\n",
 	         in_be32(&lbc->fmr), in_be32(&lbc->fir), in_be32(&lbc->fcr));
-	dev_vdbg(ctrl->dev,
+	dev_vdbg(priv->dev,
 	         "fsl_elbc_run_command: fbar=%08x fpar=%08x "
 	         "fbcr=%08x bank=%d\n",
 	         in_be32(&lbc->fbar), in_be32(&lbc->fpar),
@@ -229,19 +227,18 @@ static int fsl_elbc_run_command(struct mtd_info *mtd)
 	/* wait for FCM complete flag or timeout */
 	wait_event_timeout(ctrl->irq_wait, ctrl->irq_status,
 	                   FCM_TIMEOUT_MSECS * HZ/1000);
-	ctrl->status = ctrl->irq_status;
-
+	elbc_fcm_ctrl->status = ctrl->irq_status;
 	/* store mdr value in case it was needed */
-	if (ctrl->use_mdr)
-		ctrl->mdr = in_be32(&lbc->mdr);
+	if (elbc_fcm_ctrl->use_mdr)
+		elbc_fcm_ctrl->mdr = in_be32(&lbc->mdr);
 
-	ctrl->use_mdr = 0;
+	elbc_fcm_ctrl->use_mdr = 0;
 
-	if (ctrl->status != LTESR_CC) {
-		dev_info(ctrl->dev,
+	if (elbc_fcm_ctrl->status != LTESR_CC) {
+		dev_info(priv->dev,
 		         "command failed: fir %x fcr %x status %x mdr %x\n",
 		         in_be32(&lbc->fir), in_be32(&lbc->fcr),
-		         ctrl->status, ctrl->mdr);
+			 elbc_fcm_ctrl->status, elbc_fcm_ctrl->mdr);
 		return -EIO;
 	}
 
@@ -251,7 +248,7 @@ static int fsl_elbc_run_command(struct mtd_info *mtd)
 static void fsl_elbc_do_read(struct nand_chip *chip, int oob)
 {
 	struct fsl_elbc_mtd *priv = chip->priv;
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 
 	if (priv->page_size) {
@@ -284,15 +281,16 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 {
 	struct nand_chip *chip = mtd->priv;
 	struct fsl_elbc_mtd *priv = chip->priv;
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 
-	ctrl->use_mdr = 0;
+	elbc_fcm_ctrl->use_mdr = 0;
 
 	/* clear the read buffer */
-	ctrl->read_bytes = 0;
+	elbc_fcm_ctrl->read_bytes = 0;
 	if (command != NAND_CMD_PAGEPROG)
-		ctrl->index = 0;
+		elbc_fcm_ctrl->index = 0;
 
 	switch (command) {
 	/* READ0 and READ1 read the entire buffer to use hardware ECC. */
@@ -301,7 +299,7 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 
 	/* fall-through */
 	case NAND_CMD_READ0:
-		dev_dbg(ctrl->dev,
+		dev_dbg(priv->dev,
 		        "fsl_elbc_cmdfunc: NAND_CMD_READ0, page_addr:"
 		        " 0x%x, column: 0x%x.\n", page_addr, column);
 
@@ -309,8 +307,8 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		out_be32(&lbc->fbcr, 0); /* read entire page to enable ECC */
 		set_addr(mtd, 0, page_addr, 0);
 
-		ctrl->read_bytes = mtd->writesize + mtd->oobsize;
-		ctrl->index += column;
+		elbc_fcm_ctrl->read_bytes = mtd->writesize + mtd->oobsize;
+		elbc_fcm_ctrl->index += column;
 
 		fsl_elbc_do_read(chip, 0);
 		fsl_elbc_run_command(mtd);
@@ -318,14 +316,14 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 
 	/* READOOB reads only the OOB because no ECC is performed. */
 	case NAND_CMD_READOOB:
-		dev_vdbg(ctrl->dev,
+		dev_vdbg(priv->dev,
 		         "fsl_elbc_cmdfunc: NAND_CMD_READOOB, page_addr:"
 			 " 0x%x, column: 0x%x.\n", page_addr, column);
 
 		out_be32(&lbc->fbcr, mtd->oobsize - column);
 		set_addr(mtd, column, page_addr, 1);
 
-		ctrl->read_bytes = mtd->writesize + mtd->oobsize;
+		elbc_fcm_ctrl->read_bytes = mtd->writesize + mtd->oobsize;
 
 		fsl_elbc_do_read(chip, 1);
 		fsl_elbc_run_command(mtd);
@@ -333,7 +331,7 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 
 	/* READID must read all 5 possible bytes while CEB is active */
 	case NAND_CMD_READID:
-		dev_vdbg(ctrl->dev, "fsl_elbc_cmdfunc: NAND_CMD_READID.\n");
+		dev_vdbg(priv->dev, "fsl_elbc_cmdfunc: NAND_CMD_READID.\n");
 
 		out_be32(&lbc->fir, (FIR_OP_CM0 << FIR_OP0_SHIFT) |
 		                    (FIR_OP_UA  << FIR_OP1_SHIFT) |
@@ -341,9 +339,9 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		out_be32(&lbc->fcr, NAND_CMD_READID << FCR_CMD0_SHIFT);
 		/* 5 bytes for manuf, device and exts */
 		out_be32(&lbc->fbcr, 5);
-		ctrl->read_bytes = 5;
-		ctrl->use_mdr = 1;
-		ctrl->mdr = 0;
+		elbc_fcm_ctrl->read_bytes = 5;
+		elbc_fcm_ctrl->use_mdr = 1;
+		elbc_fcm_ctrl->mdr = 0;
 
 		set_addr(mtd, 0, 0, 0);
 		fsl_elbc_run_command(mtd);
@@ -351,7 +349,7 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 
 	/* ERASE1 stores the block and page address */
 	case NAND_CMD_ERASE1:
-		dev_vdbg(ctrl->dev,
+		dev_vdbg(priv->dev,
 		         "fsl_elbc_cmdfunc: NAND_CMD_ERASE1, "
 		         "page_addr: 0x%x.\n", page_addr);
 		set_addr(mtd, 0, page_addr, 0);
@@ -359,7 +357,7 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 
 	/* ERASE2 uses the block and page address from ERASE1 */
 	case NAND_CMD_ERASE2:
-		dev_vdbg(ctrl->dev, "fsl_elbc_cmdfunc: NAND_CMD_ERASE2.\n");
+		dev_vdbg(priv->dev, "fsl_elbc_cmdfunc: NAND_CMD_ERASE2.\n");
 
 		out_be32(&lbc->fir,
 		         (FIR_OP_CM0 << FIR_OP0_SHIFT) |
@@ -374,8 +372,8 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		         (NAND_CMD_ERASE2 << FCR_CMD2_SHIFT));
 
 		out_be32(&lbc->fbcr, 0);
-		ctrl->read_bytes = 0;
-		ctrl->use_mdr = 1;
+		elbc_fcm_ctrl->read_bytes = 0;
+		elbc_fcm_ctrl->use_mdr = 1;
 
 		fsl_elbc_run_command(mtd);
 		return;
@@ -383,14 +381,12 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 	/* SEQIN sets up the addr buffer and all registers except the length */
 	case NAND_CMD_SEQIN: {
 		__be32 fcr;
-		dev_vdbg(ctrl->dev,
-		         "fsl_elbc_cmdfunc: NAND_CMD_SEQIN/PAGE_PROG, "
+		dev_vdbg(priv->dev,
+			 "fsl_elbc_cmdfunc: NAND_CMD_SEQIN/PAGE_PROG, "
 		         "page_addr: 0x%x, column: 0x%x.\n",
 		         page_addr, column);
 
-		ctrl->column = column;
-		ctrl->oob = 0;
-		ctrl->use_mdr = 1;
+		elbc_fcm_ctrl->use_mdr = 1;
 
 		fcr = (NAND_CMD_STATUS   << FCR_CMD1_SHIFT) |
 		      (NAND_CMD_SEQIN    << FCR_CMD2_SHIFT) |
@@ -420,7 +416,7 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 				/* OOB area --> READOOB */
 				column -= mtd->writesize;
 				fcr |= NAND_CMD_READOOB << FCR_CMD0_SHIFT;
-				ctrl->oob = 1;
+				elbc_fcm_ctrl->oob = 1;
 			} else {
 				WARN_ON(column != 0);
 				/* First 256 bytes --> READ0 */
@@ -429,24 +425,24 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		}
 
 		out_be32(&lbc->fcr, fcr);
-		set_addr(mtd, column, page_addr, ctrl->oob);
+		set_addr(mtd, column, page_addr, elbc_fcm_ctrl->oob);
 		return;
 	}
 
 	/* PAGEPROG reuses all of the setup from SEQIN and adds the length */
 	case NAND_CMD_PAGEPROG: {
 		int full_page;
-		dev_vdbg(ctrl->dev,
+		dev_vdbg(priv->dev,
 		         "fsl_elbc_cmdfunc: NAND_CMD_PAGEPROG "
-		         "writing %d bytes.\n", ctrl->index);
+			 "writing %d bytes.\n", elbc_fcm_ctrl->index);
 
 		/* if the write did not start at 0 or is not a full page
 		 * then set the exact length, otherwise use a full page
 		 * write so the HW generates the ECC.
 		 */
-		if (ctrl->oob || ctrl->column != 0 ||
-		    ctrl->index != mtd->writesize + mtd->oobsize) {
-			out_be32(&lbc->fbcr, ctrl->index);
+		if (elbc_fcm_ctrl->oob || elbc_fcm_ctrl->column != 0 ||
+		    elbc_fcm_ctrl->index != mtd->writesize + mtd->oobsize) {
+			out_be32(&lbc->fbcr, elbc_fcm_ctrl->index);
 			full_page = 0;
 		} else {
 			out_be32(&lbc->fbcr, 0);
@@ -458,21 +454,21 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		/* Read back the page in order to fill in the ECC for the
 		 * caller.  Is this really needed?
 		 */
-		if (full_page && ctrl->oob_poi) {
+		if (full_page && elbc_fcm_ctrl->oob_poi) {
 			out_be32(&lbc->fbcr, 3);
 			set_addr(mtd, 6, page_addr, 1);
 
-			ctrl->read_bytes = mtd->writesize + 9;
+			elbc_fcm_ctrl->read_bytes = mtd->writesize + 9;
 
 			fsl_elbc_do_read(chip, 1);
 			fsl_elbc_run_command(mtd);
 
-			memcpy_fromio(ctrl->oob_poi + 6,
-			              &ctrl->addr[ctrl->index], 3);
-			ctrl->index += 3;
+			memcpy_fromio(elbc_fcm_ctrl->oob_poi + 6,
+				&elbc_fcm_ctrl->addr[elbc_fcm_ctrl->index], 3);
+			elbc_fcm_ctrl->index += 3;
 		}
 
-		ctrl->oob_poi = NULL;
+		elbc_fcm_ctrl->oob_poi = NULL;
 		return;
 	}
 
@@ -485,26 +481,26 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		out_be32(&lbc->fcr, NAND_CMD_STATUS << FCR_CMD0_SHIFT);
 		out_be32(&lbc->fbcr, 1);
 		set_addr(mtd, 0, 0, 0);
-		ctrl->read_bytes = 1;
+		elbc_fcm_ctrl->read_bytes = 1;
 
 		fsl_elbc_run_command(mtd);
 
 		/* The chip always seems to report that it is
 		 * write-protected, even when it is not.
 		 */
-		setbits8(ctrl->addr, NAND_STATUS_WP);
+		setbits8(elbc_fcm_ctrl->addr, NAND_STATUS_WP);
 		return;
 
 	/* RESET without waiting for the ready line */
 	case NAND_CMD_RESET:
-		dev_dbg(ctrl->dev, "fsl_elbc_cmdfunc: NAND_CMD_RESET.\n");
+		dev_dbg(priv->dev, "fsl_elbc_cmdfunc: NAND_CMD_RESET.\n");
 		out_be32(&lbc->fir, FIR_OP_CM0 << FIR_OP0_SHIFT);
 		out_be32(&lbc->fcr, NAND_CMD_RESET << FCR_CMD0_SHIFT);
 		fsl_elbc_run_command(mtd);
 		return;
 
 	default:
-		dev_err(ctrl->dev,
+		dev_err(priv->dev,
 		        "fsl_elbc_cmdfunc: error, unsupported command 0x%x.\n",
 		        command);
 	}
@@ -524,24 +520,24 @@ static void fsl_elbc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 {
 	struct nand_chip *chip = mtd->priv;
 	struct fsl_elbc_mtd *priv = chip->priv;
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 	unsigned int bufsize = mtd->writesize + mtd->oobsize;
 
 	if (len <= 0) {
-		dev_err(ctrl->dev, "write_buf of %d bytes", len);
-		ctrl->status = 0;
+		dev_err(priv->dev, "write_buf of %d bytes", len);
+		elbc_fcm_ctrl->status = 0;
 		return;
 	}
 
-	if ((unsigned int)len > bufsize - ctrl->index) {
-		dev_err(ctrl->dev,
+	if ((unsigned int)len > bufsize - elbc_fcm_ctrl->index) {
+		dev_err(priv->dev,
 		        "write_buf beyond end of buffer "
 		        "(%d requested, %u available)\n",
-		        len, bufsize - ctrl->index);
-		len = bufsize - ctrl->index;
+			len, bufsize - elbc_fcm_ctrl->index);
+		len = bufsize - elbc_fcm_ctrl->index;
 	}
 
-	memcpy_toio(&ctrl->addr[ctrl->index], buf, len);
+	memcpy_toio(&elbc_fcm_ctrl->addr[elbc_fcm_ctrl->index], buf, len);
 	/*
 	 * This is workaround for the weird elbc hangs during nand write,
 	 * Scott Wood says: "...perhaps difference in how long it takes a
@@ -549,9 +545,9 @@ static void fsl_elbc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 	 * is causing problems, and sync isn't helping for some reason."
 	 * Reading back the last byte helps though.
 	 */
-	in_8(&ctrl->addr[ctrl->index] + len - 1);
+	in_8(&elbc_fcm_ctrl->addr[elbc_fcm_ctrl->index] + len - 1);
 
-	ctrl->index += len;
+	elbc_fcm_ctrl->index += len;
 }
 
 /*
@@ -562,13 +558,13 @@ static u8 fsl_elbc_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd->priv;
 	struct fsl_elbc_mtd *priv = chip->priv;
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 
 	/* If there are still bytes in the FCM, then use the next byte. */
-	if (ctrl->index < ctrl->read_bytes)
-		return in_8(&ctrl->addr[ctrl->index++]);
+	if (elbc_fcm_ctrl->index < elbc_fcm_ctrl->read_bytes)
+		return in_8(&elbc_fcm_ctrl->addr[elbc_fcm_ctrl->index++]);
 
-	dev_err(ctrl->dev, "read_byte beyond end of buffer\n");
+	dev_err(priv->dev, "read_byte beyond end of buffer\n");
 	return ERR_BYTE;
 }
 
@@ -579,18 +575,19 @@ static void fsl_elbc_read_buf(struct mtd_info *mtd, u8 *buf, int len)
 {
 	struct nand_chip *chip = mtd->priv;
 	struct fsl_elbc_mtd *priv = chip->priv;
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 	int avail;
 
 	if (len < 0)
 		return;
 
-	avail = min((unsigned int)len, ctrl->read_bytes - ctrl->index);
-	memcpy_fromio(buf, &ctrl->addr[ctrl->index], avail);
-	ctrl->index += avail;
+	avail = min((unsigned int)len,
+			elbc_fcm_ctrl->read_bytes - elbc_fcm_ctrl->index);
+	memcpy_fromio(buf, &elbc_fcm_ctrl->addr[elbc_fcm_ctrl->index], avail);
+	elbc_fcm_ctrl->index += avail;
 
 	if (len > avail)
-		dev_err(ctrl->dev,
+		dev_err(priv->dev,
 		        "read_buf beyond end of buffer "
 		        "(%d requested, %d available)\n",
 		        len, avail);
@@ -603,30 +600,32 @@ static int fsl_elbc_verify_buf(struct mtd_info *mtd, const u_char *buf, int len)
 {
 	struct nand_chip *chip = mtd->priv;
 	struct fsl_elbc_mtd *priv = chip->priv;
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 	int i;
 
 	if (len < 0) {
-		dev_err(ctrl->dev, "write_buf of %d bytes", len);
+		dev_err(priv->dev, "write_buf of %d bytes", len);
 		return -EINVAL;
 	}
 
-	if ((unsigned int)len > ctrl->read_bytes - ctrl->index) {
-		dev_err(ctrl->dev,
-		        "verify_buf beyond end of buffer "
-		        "(%d requested, %u available)\n",
-		        len, ctrl->read_bytes - ctrl->index);
+	if ((unsigned int)len >
+			elbc_fcm_ctrl->read_bytes - elbc_fcm_ctrl->index) {
+		dev_err(priv->dev,
+			"verify_buf beyond end of buffer "
+			"(%d requested, %u available)\n",
+			len, elbc_fcm_ctrl->read_bytes - elbc_fcm_ctrl->index);
 
-		ctrl->index = ctrl->read_bytes;
+		elbc_fcm_ctrl->index = elbc_fcm_ctrl->read_bytes;
 		return -EINVAL;
 	}
 
 	for (i = 0; i < len; i++)
-		if (in_8(&ctrl->addr[ctrl->index + i]) != buf[i])
+		if (in_8(&elbc_fcm_ctrl->addr[elbc_fcm_ctrl->index + i])
+				!= buf[i])
 			break;
 
-	ctrl->index += len;
-	return i == len && ctrl->status == LTESR_CC ? 0 : -EIO;
+	elbc_fcm_ctrl->index += len;
+	return i == len && elbc_fcm_ctrl->status == LTESR_CC ? 0 : -EIO;
 }
 
 /* This function is called after Program and Erase Operations to
@@ -635,22 +634,22 @@ static int fsl_elbc_verify_buf(struct mtd_info *mtd, const u_char *buf, int len)
 static int fsl_elbc_wait(struct mtd_info *mtd, struct nand_chip *chip)
 {
 	struct fsl_elbc_mtd *priv = chip->priv;
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 
-	if (ctrl->status != LTESR_CC)
+	if (elbc_fcm_ctrl->status != LTESR_CC)
 		return NAND_STATUS_FAIL;
 
 	/* The chip always seems to report that it is
 	 * write-protected, even when it is not.
 	 */
-	return (ctrl->mdr & 0xff) | NAND_STATUS_WP;
+	return (elbc_fcm_ctrl->mdr & 0xff) | NAND_STATUS_WP;
 }
 
 static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd->priv;
 	struct fsl_elbc_mtd *priv = chip->priv;
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 	unsigned int al;
 
@@ -665,41 +664,41 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 	priv->fmr |= (12 << FMR_CWTO_SHIFT) |  /* Timeout > 12 ms */
 	             (al << FMR_AL_SHIFT);
 
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->numchips = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->numchips = %d\n",
 	        chip->numchips);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->chipsize = %lld\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->chipsize = %lld\n",
 	        chip->chipsize);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->pagemask = %8x\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->pagemask = %8x\n",
 	        chip->pagemask);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->chip_delay = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->chip_delay = %d\n",
 	        chip->chip_delay);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->badblockpos = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->badblockpos = %d\n",
 	        chip->badblockpos);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->chip_shift = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->chip_shift = %d\n",
 	        chip->chip_shift);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->page_shift = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->page_shift = %d\n",
 	        chip->page_shift);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->phys_erase_shift = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->phys_erase_shift = %d\n",
 	        chip->phys_erase_shift);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->ecclayout = %p\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecclayout = %p\n",
 	        chip->ecclayout);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->ecc.mode = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.mode = %d\n",
 	        chip->ecc.mode);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->ecc.steps = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.steps = %d\n",
 	        chip->ecc.steps);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->ecc.bytes = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.bytes = %d\n",
 	        chip->ecc.bytes);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->ecc.total = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.total = %d\n",
 	        chip->ecc.total);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->ecc.layout = %p\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.layout = %p\n",
 	        chip->ecc.layout);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: mtd->flags = %08x\n", mtd->flags);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: mtd->size = %lld\n", mtd->size);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: mtd->erasesize = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: mtd->flags = %08x\n", mtd->flags);
+	dev_dbg(priv->dev, "fsl_elbc_init: mtd->size = %lld\n", mtd->size);
+	dev_dbg(priv->dev, "fsl_elbc_init: mtd->erasesize = %d\n",
 	        mtd->erasesize);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: mtd->writesize = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: mtd->writesize = %d\n",
 	        mtd->writesize);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: mtd->oobsize = %d\n",
+	dev_dbg(priv->dev, "fsl_elbc_init: mtd->oobsize = %d\n",
 	        mtd->oobsize);
 
 	/* adjust Option Register and ECC to match Flash page size */
@@ -719,7 +718,7 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 			chip->badblock_pattern = &largepage_memorybased;
 		}
 	} else {
-		dev_err(ctrl->dev,
+		dev_err(priv->dev,
 		        "fsl_elbc_init: page size %d is not supported\n",
 		        mtd->writesize);
 		return -1;
@@ -750,18 +749,19 @@ static void fsl_elbc_write_page(struct mtd_info *mtd,
                                 const uint8_t *buf)
 {
 	struct fsl_elbc_mtd *priv = chip->priv;
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 
 	fsl_elbc_write_buf(mtd, buf, mtd->writesize);
 	fsl_elbc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
 
-	ctrl->oob_poi = chip->oob_poi;
+	elbc_fcm_ctrl->oob_poi = chip->oob_poi;
 }
 
 static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 {
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
+	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
 	struct nand_chip *chip = &priv->chip;
 
 	dev_dbg(priv->dev, "eLBC Set Information for bank %d\n", priv->bank);
@@ -790,7 +790,7 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	chip->options = NAND_NO_READRDY | NAND_NO_AUTOINCR |
 			NAND_USE_FLASH_BBT;
 
-	chip->controller = &ctrl->controller;
+	chip->controller = &elbc_fcm_ctrl->controller;
 	chip->priv = priv;
 
 	chip->ecc.read_page = fsl_elbc_read_page;
@@ -815,8 +815,7 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 
 static int fsl_elbc_chip_remove(struct fsl_elbc_mtd *priv)
 {
-	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
-
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 	nand_release(&priv->mtd);
 
 	kfree(priv->mtd.name);
@@ -824,18 +823,22 @@ static int fsl_elbc_chip_remove(struct fsl_elbc_mtd *priv)
 	if (priv->vbase)
 		iounmap(priv->vbase);
 
-	ctrl->chips[priv->bank] = NULL;
+	elbc_fcm_ctrl->chips[priv->bank] = NULL;
 	kfree(priv);
-
+	kfree(elbc_fcm_ctrl);
 	return 0;
 }
 
-static int __devinit fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
-					 struct device_node *node)
+/*
+ * Currently only one elbc probe is supported.
+ */
+static int __devinit fsl_elbc_nand_probe(struct platform_device *dev)
 {
-	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
+	struct fsl_lbc_regs __iomem *lbc;
 	struct fsl_elbc_mtd *priv;
 	struct resource res;
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = NULL;
+
 #ifdef CONFIG_MTD_PARTITIONS
 	static const char *part_probe_types[]
 		= { "cmdlinepart", "RedBoot", NULL };
@@ -843,11 +846,16 @@ static int __devinit fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
 #endif
 	int ret;
 	int bank;
+	struct device_node *node = dev->dev.of_node;
+
+	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
+		return -ENODEV;
+	lbc = fsl_lbc_ctrl_dev->regs;
 
 	/* get, allocate and map the memory resource */
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret) {
-		dev_err(ctrl->dev, "failed to get resource\n");
+		dev_err(fsl_lbc_ctrl_dev->dev, "failed to get resource\n");
 		return ret;
 	}
 
@@ -861,7 +869,8 @@ static int __devinit fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
 			break;
 
 	if (bank >= MAX_BANKS) {
-		dev_err(ctrl->dev, "address did not match any chip selects\n");
+		dev_err(fsl_lbc_ctrl_dev->dev, "address did not match any "
+			"chip selects\n");
 		return -ENODEV;
 	}
 
@@ -869,14 +878,32 @@ static int __devinit fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
 	if (!priv)
 		return -ENOMEM;
 
-	ctrl->chips[bank] = priv;
+	if (fsl_lbc_ctrl_dev->nand == NULL) {
+		elbc_fcm_ctrl = kzalloc(sizeof(*elbc_fcm_ctrl), GFP_KERNEL);
+		if (!elbc_fcm_ctrl) {
+			dev_err(fsl_lbc_ctrl_dev->dev, "failed to allocate "
+					"memory\n");
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		elbc_fcm_ctrl->read_bytes = 0;
+		elbc_fcm_ctrl->index = 0;
+		elbc_fcm_ctrl->addr = NULL;
+
+		spin_lock_init(&elbc_fcm_ctrl->controller.lock);
+		init_waitqueue_head(&elbc_fcm_ctrl->controller.wq);
+		fsl_lbc_ctrl_dev->nand = elbc_fcm_ctrl;
+	}
+
+	elbc_fcm_ctrl->chips[bank] = priv;
 	priv->bank = bank;
-	priv->ctrl = ctrl;
-	priv->dev = ctrl->dev;
+	priv->ctrl = fsl_lbc_ctrl_dev;
+	priv->dev = fsl_lbc_ctrl_dev->dev;
 
 	priv->vbase = ioremap(res.start, resource_size(&res));
 	if (!priv->vbase) {
-		dev_err(ctrl->dev, "failed to map chip region\n");
+		dev_err(fsl_lbc_ctrl_dev->dev, "failed to map chip region\n");
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -933,171 +960,48 @@ err:
 	return ret;
 }
 
-static int __devinit fsl_elbc_ctrl_init(struct fsl_elbc_ctrl *ctrl)
+static int fsl_elbc_nand_remove(struct platform_device *dev)
 {
-	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
-
-	/*
-	 * NAND transactions can tie up the bus for a long time, so set the
-	 * bus timeout to max by clearing LBCR[BMT] (highest base counter
-	 * value) and setting LBCR[BMTPS] to the highest prescaler value.
-	 */
-	clrsetbits_be32(&lbc->lbcr, LBCR_BMT, 15);
-
-	/* clear event registers */
-	setbits32(&lbc->ltesr, LTESR_NAND_MASK);
-	out_be32(&lbc->lteatr, 0);
-
-	/* Enable interrupts for any detected events */
-	out_be32(&lbc->lteir, LTESR_NAND_MASK);
-
-	ctrl->read_bytes = 0;
-	ctrl->index = 0;
-	ctrl->addr = NULL;
-
-	return 0;
-}
-
-static int fsl_elbc_ctrl_remove(struct platform_device *ofdev)
-{
-	struct fsl_elbc_ctrl *ctrl = dev_get_drvdata(&ofdev->dev);
 	int i;
-
+	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = fsl_lbc_ctrl_dev->nand;
 	for (i = 0; i < MAX_BANKS; i++)
-		if (ctrl->chips[i])
-			fsl_elbc_chip_remove(ctrl->chips[i]);
-
-	if (ctrl->irq)
-		free_irq(ctrl->irq, ctrl);
+		if (elbc_fcm_ctrl->chips[i])
+			fsl_elbc_chip_remove(elbc_fcm_ctrl->chips[i]);
 
-	if (ctrl->regs)
-		iounmap(ctrl->regs);
+	fsl_lbc_ctrl_dev->nand = NULL;
+	kfree(elbc_fcm_ctrl);
 
-	dev_set_drvdata(&ofdev->dev, NULL);
-	kfree(ctrl);
 	return 0;
-}
-
-/* NOTE: This interrupt is also used to report other localbus events,
- * such as transaction errors on other chipselects.  If we want to
- * capture those, we'll need to move the IRQ code into a shared
- * LBC driver.
- */
 
-static irqreturn_t fsl_elbc_ctrl_irq(int irqno, void *data)
-{
-	struct fsl_elbc_ctrl *ctrl = data;
-	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
-	__be32 status = in_be32(&lbc->ltesr) & LTESR_NAND_MASK;
-
-	if (status) {
-		out_be32(&lbc->ltesr, status);
-		out_be32(&lbc->lteatr, 0);
-
-		ctrl->irq_status = status;
-		smp_wmb();
-		wake_up(&ctrl->irq_wait);
-
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
 }
 
-/* fsl_elbc_ctrl_probe
- *
- * called by device layer when it finds a device matching
- * one our driver can handled. This code allocates all of
- * the resources needed for the controller only.  The
- * resources for the NAND banks themselves are allocated
- * in the chip probe function.
-*/
-
-static int __devinit fsl_elbc_ctrl_probe(struct platform_device *ofdev,
-                                         const struct of_device_id *match)
-{
-	struct device_node *child;
-	struct fsl_elbc_ctrl *ctrl;
-	int ret;
-
-	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
-	if (!ctrl)
-		return -ENOMEM;
-
-	dev_set_drvdata(&ofdev->dev, ctrl);
-
-	spin_lock_init(&ctrl->controller.lock);
-	init_waitqueue_head(&ctrl->controller.wq);
-	init_waitqueue_head(&ctrl->irq_wait);
-
-	ctrl->regs = of_iomap(ofdev->dev.of_node, 0);
-	if (!ctrl->regs) {
-		dev_err(&ofdev->dev, "failed to get memory region\n");
-		ret = -ENODEV;
-		goto err;
-	}
-
-	ctrl->irq = of_irq_to_resource(ofdev->dev.of_node, 0, NULL);
-	if (ctrl->irq == NO_IRQ) {
-		dev_err(&ofdev->dev, "failed to get irq resource\n");
-		ret = -ENODEV;
-		goto err;
-	}
-
-	ctrl->dev = &ofdev->dev;
-
-	ret = fsl_elbc_ctrl_init(ctrl);
-	if (ret < 0)
-		goto err;
-
-	ret = request_irq(ctrl->irq, fsl_elbc_ctrl_irq, 0, "fsl-elbc", ctrl);
-	if (ret != 0) {
-		dev_err(&ofdev->dev, "failed to install irq (%d)\n",
-		        ctrl->irq);
-		ret = ctrl->irq;
-		goto err;
-	}
-
-	for_each_child_of_node(ofdev->dev.of_node, child)
-		if (of_device_is_compatible(child, "fsl,elbc-fcm-nand"))
-			fsl_elbc_chip_probe(ctrl, child);
-
-	return 0;
-
-err:
-	fsl_elbc_ctrl_remove(ofdev);
-	return ret;
-}
-
-static const struct of_device_id fsl_elbc_match[] = {
-	{
-		.compatible = "fsl,elbc",
-	},
+static const struct platform_device_id fsl_elbc_nand_match[] = {
+	{ "fsl,elbc-fcm-nand", },
 	{}
 };
 
-static struct of_platform_driver fsl_elbc_ctrl_driver = {
+static struct platform_driver fsl_elbc_nand_driver = {
 	.driver = {
-		.name = "fsl-elbc",
+		.name = "fsl,elbc-fcm-nand",
 		.owner = THIS_MODULE,
-		.of_match_table = fsl_elbc_match,
 	},
-	.probe = fsl_elbc_ctrl_probe,
-	.remove = fsl_elbc_ctrl_remove,
+	.id_table = fsl_elbc_nand_match,
+	.probe = fsl_elbc_nand_probe,
+	.remove = fsl_elbc_nand_remove,
 };
 
-static int __init fsl_elbc_init(void)
+static int __init fsl_elbc_nand_init(void)
 {
-	return of_register_platform_driver(&fsl_elbc_ctrl_driver);
+	return platform_driver_register(&fsl_elbc_nand_driver);
 }
 
-static void __exit fsl_elbc_exit(void)
+static void __exit fsl_elbc_nand_exit(void)
 {
-	of_unregister_platform_driver(&fsl_elbc_ctrl_driver);
+	platform_driver_unregister(&fsl_elbc_nand_driver);
 }
 
-module_init(fsl_elbc_init);
-module_exit(fsl_elbc_exit);
+module_init(fsl_elbc_nand_init);
+module_exit(fsl_elbc_nand_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Freescale");
-- 
1.5.6.5
