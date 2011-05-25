Return-Path: <B09055@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1A381B6F91
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 14:00:30 +1000 (EST)
From: Dipen Dudhat <Dipen.Dudhat@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH][upstream] NAND Machine support for Integrated Flash Controller
Date: Wed, 25 May 2011 09:30:11 +0530
Message-ID: <1306296011-11348-1-git-send-email-Dipen.Dudhat@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Integrated Flash Controller(IFC) can be used to hook NAND Flash
chips using NAND Flash Machine available on it.

Due to bug on ECC event generation, ECC support is not integrated yet. 

Signed-off-by: Dipen Dudhat <Dipen.Dudhat@freescale.com>
---
Applies to: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Tested on: P1010RDB
 drivers/mtd/nand/Kconfig        |    9 +
 drivers/mtd/nand/Makefile       |    1 +
 drivers/mtd/nand/fsl_ifc_nand.c |  936 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 946 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/fsl_ifc_nand.c

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index edec457..dae3d54 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -457,6 +457,15 @@ config MTD_NAND_FSL_ELBC
 	  Enabling this option will enable you to use this to control
 	  external NAND devices.
 
+config MTD_NAND_FSL_IFC
+	tristate "NAND support for Freescale IFC controller"
+	depends on MTD_NAND && PPC_OF
+	help
+	  Various Freescale chips e.g P1010, include a NAND Flash machine
+	  with built-in hardware ECC capabilities.
+	  Enabling this option will enable you to use this to control
+	  external NAND devices.
+
 config MTD_NAND_FSL_UPM
 	tristate "Support for NAND on Freescale UPM"
 	depends on PPC_83xx || PPC_85xx
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 5745d83..3094131 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_MTD_ALAUDA)		+= alauda.o
 obj-$(CONFIG_MTD_NAND_PASEMI)		+= pasemi_nand.o
 obj-$(CONFIG_MTD_NAND_ORION)		+= orion_nand.o
 obj-$(CONFIG_MTD_NAND_FSL_ELBC)		+= fsl_elbc_nand.o
+obj-$(CONFIG_MTD_NAND_FSL_IFC)		+= fsl_ifc_nand.o
 obj-$(CONFIG_MTD_NAND_FSL_UPM)		+= fsl_upm.o
 obj-$(CONFIG_MTD_NAND_SH_FLCTL)		+= sh_flctl.o
 obj-$(CONFIG_MTD_NAND_MXC)		+= mxc_nand.o
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
new file mode 100644
index 0000000..16acf18
--- /dev/null
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -0,0 +1,936 @@
+/*
+ * Freescale Integrated Flash Controller NAND Machine
+ *
+ * Copyright 2011 Freescale Semiconductor, Inc
+ *
+ * Author: Dipen Dudhat <Dipen.Dudhat@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/io.h>
+#include <asm/fsl_ifc.h>
+
+#define ERR_BYTE		0xFF /* Value returned for read
+					bytes when read failed */
+#define IFC_TIMEOUT_MSECS	1000 /* Maximum number of mSecs to wait
+					for IFC NAND Machine */
+
+/* mtd information per set */
+
+struct fsl_ifc_mtd {
+	struct mtd_info mtd;
+	struct nand_chip chip;
+	struct fsl_ifc_ctrl *ctrl;
+
+	struct device *dev;
+	int bank;		/* Chip select bank number           */
+	u8 __iomem *vbase;      /* Chip select base virtual address  */
+	int page_size;
+};
+
+/* Freescale IFC NAND Machine information */
+struct fsl_ifc_nand_ctrl {
+	struct nand_hw_control controller;
+	struct fsl_ifc_mtd *chips[FSL_IFC_BANK_COUNT];
+
+	u8 __iomem *addr;	/* Address of assigned IFC buffer*/
+	unsigned int cs_nand;	/* On which chipsel NAND is connected	  */
+	unsigned int page;	/* Last page written to / read from      */
+	unsigned int read_bytes;/* Number of bytes read during command   */
+	unsigned int column;	/* Saved column from SEQIN       */
+	unsigned int index;	/* Pointer to next byte to 'read'*/
+	unsigned int status;	/* status read from NEESR after last op  */
+	unsigned int mdr;	/* IFC Data Register value               */
+	unsigned int use_mdr;	/* Non zero if the MDR is to be set      */
+	unsigned int oob;	/* Non zero if operating on OOB data     */
+
+	wait_queue_head_t		irq_wait;
+};
+
+/*
+ * Generic flash bbt descriptors
+ */
+static u8 bbt_pattern[] = {'B', 'b', 't', '0' };
+static u8 mirror_pattern[] = {'1', 't', 'b', 'B' };
+
+static struct nand_bbt_descr bbt_main_descr = {
+	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE |
+		   NAND_BBT_2BIT | NAND_BBT_VERSION,
+	.offs =	11,
+	.len = 4,
+	.veroffs = 15,
+	.maxblocks = 4,
+	.pattern = bbt_pattern,
+};
+
+static struct nand_bbt_descr bbt_mirror_descr = {
+	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE |
+		   NAND_BBT_2BIT | NAND_BBT_VERSION,
+	.offs =	11,
+	.len = 4,
+	.veroffs = 15,
+	.maxblocks = 4,
+	.pattern = mirror_pattern,
+};
+
+/*
+ * Set up the IFC hardware block and page address fields, and the ifc nand
+ * structure addr field to point to the correct IFC buffer in memory
+ */
+static void set_addr(struct mtd_info *mtd, int column,
+				int page_addr, int oob) {
+	struct nand_chip *chip = mtd->priv;
+	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
+	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = ctrl->nand;
+	int buf_num;
+
+	ifc_nand_ctrl->page = page_addr;
+	/* Program ROW0/COL0 */
+	out_be32(&ifc->ifc_nand.row0, page_addr);
+	out_be32(&ifc->ifc_nand.col0, (oob ? IFC_NAND_COL_MS : 0) | column);
+
+	if (mtd->writesize == 4096)
+		buf_num = page_addr & 0x1;
+	else if (mtd->writesize == 2048)
+		buf_num = page_addr & 0x3;
+	else
+		buf_num = page_addr & 0xf;
+
+	ifc_nand_ctrl->addr = priv->vbase + buf_num * (mtd->writesize * 2);
+	ifc_nand_ctrl->index = column;
+
+	/* for OOB data point to the second half of the buffer */
+	if (oob)
+		ifc_nand_ctrl->index += mtd->writesize;
+}
+
+/*
+ * execute IFC NAND command and wait for it to complete
+ */
+static int fsl_ifc_run_command(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = ctrl->nand;
+	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
+
+	if (ifc_nand_ctrl->use_mdr)
+		out_be32(&ifc->ifc_nand.nand_mdr, ifc_nand_ctrl->mdr);
+
+	out_be32(&ifc->ifc_nand.ncfgr, 0x0);
+
+	dev_vdbg(priv->dev,
+			"%s: fir0=%08x fcr0=%08x\n",
+			__func__,
+			in_be32(&ifc->ifc_nand.nand_fir0),
+			in_be32(&ifc->ifc_nand.nand_fcr0));
+
+	ifc_nand_ctrl->status = 0;
+
+	/* start read/write seq */
+	out_be32(&ifc->ifc_nand.nandseq_strt, IFC_NAND_SEQ_STRT_FIR_STRT);
+
+	/* wait for command complete flag or timeout */
+	wait_event_timeout(ifc_nand_ctrl->irq_wait, ifc_nand_ctrl->status,
+				IFC_TIMEOUT_MSECS * HZ/1000);
+
+	/* store mdr value in case it was needed */
+	if (ifc_nand_ctrl->use_mdr)
+		ifc_nand_ctrl->mdr = in_be32(&ifc->ifc_nand.nand_mdr);
+
+	ifc_nand_ctrl->use_mdr = 0;
+
+	/* enable NAND Machine Interrupts which we have disabled in ISR */
+	out_be32(&ifc->ifc_nand.nand_evter_intr_en,
+			IFC_NAND_EVTER_INTR_OPCIR_EN |
+			IFC_NAND_EVTER_INTR_FTOERIR_EN |
+			IFC_NAND_EVTER_INTR_WPERIR_EN |
+			IFC_NAND_EVTER_INTR_ECCERIR_EN);
+	return 0;
+}
+
+static void fsl_ifc_do_read(struct nand_chip *chip,
+			    int oob,
+			    struct mtd_info *mtd)
+{
+	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
+	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
+
+	/* Program FIR/IFC_NAND_FCR0 for Small/Large page */
+	if (mtd->writesize > 512) {
+		out_be32(&ifc->ifc_nand.nand_fir0,
+			 (IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
+			 (IFC_FIR_OP_CA0 << IFC_NAND_FIR0_OP1_SHIFT) |
+			 (IFC_FIR_OP_RA0 << IFC_NAND_FIR0_OP2_SHIFT) |
+			 (IFC_FIR_OP_CMD1 << IFC_NAND_FIR0_OP3_SHIFT) |
+			 (IFC_FIR_OP_RBCD << IFC_NAND_FIR0_OP4_SHIFT));
+		out_be32(&ifc->ifc_nand.nand_fir1, 0x0);
+
+		out_be32(&ifc->ifc_nand.nand_fcr0,
+			(NAND_CMD_READ0 << IFC_NAND_FCR0_CMD0_SHIFT) |
+			(NAND_CMD_READSTART << IFC_NAND_FCR0_CMD1_SHIFT));
+	} else {
+		out_be32(&ifc->ifc_nand.nand_fir0,
+			 (IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
+			 (IFC_FIR_OP_CA0 << IFC_NAND_FIR0_OP1_SHIFT) |
+			 (IFC_FIR_OP_RA0  << IFC_NAND_FIR0_OP2_SHIFT) |
+			 (IFC_FIR_OP_RBCD << IFC_NAND_FIR0_OP3_SHIFT));
+		out_be32(&ifc->ifc_nand.nand_fir1, 0x0);
+
+		if (oob)
+			out_be32(&ifc->ifc_nand.nand_fcr0,
+				 NAND_CMD_READOOB << IFC_NAND_FCR0_CMD0_SHIFT);
+		else
+			out_be32(&ifc->ifc_nand.nand_fcr0,
+				NAND_CMD_READ0 << IFC_NAND_FCR0_CMD0_SHIFT);
+	}
+}
+
+/* cmdfunc send commands to the IFC NAND Machine */
+static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
+			     int column, int page_addr) {
+	struct nand_chip *chip = mtd->priv;
+	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = ctrl->nand;
+	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
+
+	/* set the chip select for NAND Transaction */
+	out_be32(&ifc->ifc_nand.nand_csel, ifc_nand_ctrl->cs_nand);
+
+	ifc_nand_ctrl->use_mdr = 0;
+
+	/* clear the read buffer */
+	ifc_nand_ctrl->read_bytes = 0;
+	if (command != NAND_CMD_PAGEPROG)
+		ifc_nand_ctrl->index = 0;
+
+	switch (command) {
+	/* READ0 read the entire buffer to use hardware ECC. */
+	case NAND_CMD_READ0:
+		out_be32(&ifc->ifc_nand.nand_fbcr, 0);
+		set_addr(mtd, 0, page_addr, 0);
+
+		ifc_nand_ctrl->read_bytes = mtd->writesize + mtd->oobsize;
+		ifc_nand_ctrl->index += column;
+
+		fsl_ifc_do_read(chip, 0, mtd);
+		fsl_ifc_run_command(mtd);
+		return;
+
+	/* READOOB reads only the OOB because no ECC is performed. */
+	case NAND_CMD_READOOB:
+		out_be32(&ifc->ifc_nand.nand_fbcr, mtd->oobsize - column);
+		set_addr(mtd, column, page_addr, 1);
+
+		ifc_nand_ctrl->read_bytes = mtd->writesize + mtd->oobsize;
+
+		fsl_ifc_do_read(chip, 1, mtd);
+		fsl_ifc_run_command(mtd);
+
+		return;
+
+	/* READID must read all 5 possible bytes while CEB is active */
+	case NAND_CMD_READID:
+		out_be32(&ifc->ifc_nand.nand_fir0,
+				(IFC_FIR_OP_CMD0 << IFC_NAND_FIR0_OP0_SHIFT) |
+				(IFC_FIR_OP_UA  << IFC_NAND_FIR0_OP1_SHIFT) |
+				(IFC_FIR_OP_RB << IFC_NAND_FIR0_OP2_SHIFT));
+		out_be32(&ifc->ifc_nand.nand_fcr0,
+				NAND_CMD_READID << IFC_NAND_FCR0_CMD0_SHIFT);
+		/* 8 bytes for manuf, device and exts */
+		out_be32(&ifc->ifc_nand.nand_fbcr, 8);
+		ifc_nand_ctrl->read_bytes = 8;
+		ifc_nand_ctrl->use_mdr = 0;
+		ifc_nand_ctrl->mdr = 0;
+
+		set_addr(mtd, 0, 0, 0);
+		fsl_ifc_run_command(mtd);
+		return;
+
+	/* ERASE1 stores the block and page address */
+	case NAND_CMD_ERASE1:
+		set_addr(mtd, 0, page_addr, 0);
+		return;
+
+	/* ERASE2 uses the block and page address from ERASE1 */
+	case NAND_CMD_ERASE2:
+		out_be32(&ifc->ifc_nand.nand_fir0,
+			 (IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
+			 (IFC_FIR_OP_RA0 << IFC_NAND_FIR0_OP1_SHIFT) |
+			 (IFC_FIR_OP_CMD1 << IFC_NAND_FIR0_OP2_SHIFT));
+
+		out_be32(&ifc->ifc_nand.nand_fcr0,
+			 (NAND_CMD_ERASE1 << IFC_NAND_FCR0_CMD0_SHIFT) |
+			 (NAND_CMD_ERASE2 << IFC_NAND_FCR0_CMD1_SHIFT));
+
+		out_be32(&ifc->ifc_nand.nand_fbcr, 0);
+		ifc_nand_ctrl->read_bytes = 0;
+		fsl_ifc_run_command(mtd);
+		return;
+
+	/* SEQIN sets up the addr buffer and all registers except the length */
+	case NAND_CMD_SEQIN: {
+		u32 nand_fcr0;
+		ifc_nand_ctrl->column = column;
+		ifc_nand_ctrl->oob = 0;
+
+		if (mtd->writesize > 512) {
+			nand_fcr0 =
+				(NAND_CMD_SEQIN << IFC_NAND_FCR0_CMD0_SHIFT) |
+				(NAND_CMD_PAGEPROG << IFC_NAND_FCR0_CMD1_SHIFT);
+
+			out_be32(&ifc->ifc_nand.nand_fir0,
+				 (IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
+				 (IFC_FIR_OP_CA0 << IFC_NAND_FIR0_OP1_SHIFT) |
+				 (IFC_FIR_OP_RA0 << IFC_NAND_FIR0_OP2_SHIFT) |
+				 (IFC_FIR_OP_WBCD  << IFC_NAND_FIR0_OP3_SHIFT) |
+				 (IFC_FIR_OP_CW1 << IFC_NAND_FIR0_OP4_SHIFT));
+		} else {
+			nand_fcr0 = ((NAND_CMD_PAGEPROG <<
+					IFC_NAND_FCR0_CMD1_SHIFT) |
+				    (NAND_CMD_SEQIN <<
+					IFC_NAND_FCR0_CMD2_SHIFT));
+
+			out_be32(&ifc->ifc_nand.nand_fir0,
+				 (IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
+				 (IFC_FIR_OP_CMD2 << IFC_NAND_FIR0_OP1_SHIFT) |
+				 (IFC_FIR_OP_CA0 << IFC_NAND_FIR0_OP2_SHIFT) |
+				 (IFC_FIR_OP_RA0 << IFC_NAND_FIR0_OP3_SHIFT) |
+				 (IFC_FIR_OP_WBCD << IFC_NAND_FIR0_OP4_SHIFT));
+			out_be32(&ifc->ifc_nand.nand_fir1,
+				 (IFC_FIR_OP_CW1 << IFC_NAND_FIR1_OP5_SHIFT));
+
+			if (column >= mtd->writesize) {
+				/* OOB area --> READOOB */
+				column -= mtd->writesize;
+				nand_fcr0 |= NAND_CMD_READOOB <<
+						IFC_NAND_FCR0_CMD0_SHIFT;
+				ifc_nand_ctrl->oob = 1;
+			} else if (column < 256)
+				/* First 256 bytes --> READ0 */
+				nand_fcr0 |=
+				NAND_CMD_READ0 << IFC_NAND_FCR0_CMD0_SHIFT;
+			else
+				/* Second 256 bytes --> READ1 */
+				nand_fcr0 |=
+				NAND_CMD_READ1 << IFC_NAND_FCR0_CMD0_SHIFT;
+		}
+
+		out_be32(&ifc->ifc_nand.nand_fcr0, nand_fcr0);
+		set_addr(mtd, column, page_addr, ifc_nand_ctrl->oob);
+		return;
+	}
+
+	/* PAGEPROG reuses all of the setup from SEQIN and adds the length */
+	case NAND_CMD_PAGEPROG: {
+		int full_page;
+		if (ifc_nand_ctrl->oob) {
+			out_be32(&ifc->ifc_nand.nand_fbcr,
+					ifc_nand_ctrl->index);
+			full_page = 0;
+		} else {
+			out_be32(&ifc->ifc_nand.nand_fbcr, 0);
+			full_page = 1;
+		}
+
+		fsl_ifc_run_command(mtd);
+		return;
+	}
+
+	case NAND_CMD_STATUS:
+		out_be32(&ifc->ifc_nand.nand_fir0,
+				(IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
+				(IFC_FIR_OP_RB << IFC_NAND_FIR0_OP1_SHIFT));
+		out_be32(&ifc->ifc_nand.nand_fcr0,
+				NAND_CMD_STATUS << IFC_NAND_FCR0_CMD0_SHIFT);
+		out_be32(&ifc->ifc_nand.nand_fbcr, 1);
+		set_addr(mtd, 0, 0, 0);
+		ifc_nand_ctrl->read_bytes = 1;
+
+		fsl_ifc_run_command(mtd);
+
+		/*
+		 * The chip always seems to report that it is
+		 * write-protected, even when it is not.
+		 */
+		setbits8(ifc_nand_ctrl->addr, NAND_STATUS_WP);
+		return;
+
+	case NAND_CMD_RESET:
+		out_be32(&ifc->ifc_nand.nand_fir0,
+				IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT);
+		out_be32(&ifc->ifc_nand.nand_fcr0,
+				NAND_CMD_RESET << IFC_NAND_FCR0_CMD0_SHIFT);
+		fsl_ifc_run_command(mtd);
+		return;
+
+	default:
+		dev_err(ctrl->dev, "%s: error, unsupported command 0x%x.\n",
+					__func__, command);
+	}
+}
+
+static void fsl_ifc_select_chip(struct mtd_info *mtd, int chip)
+{
+	/* The hardware does not seem to support multiple
+	 * chips per bank.
+	 */
+}
+
+/*
+ * Write buf to the IFC NAND Controller Data Buffer
+ */
+static void fsl_ifc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = priv->ctrl->nand;
+	unsigned int bufsize = mtd->writesize + mtd->oobsize;
+
+	if (len <= 0) {
+		dev_err(priv->dev, "%s: write_buf of %d bytes", __func__, len);
+		ifc_nand_ctrl->status = 0;
+		return;
+	}
+
+	if ((unsigned int)len > bufsize - ifc_nand_ctrl->index) {
+		dev_err(priv->dev,
+			"%s: write_buf beyond end of buffer "
+			"(%d requested, %u available)\n",
+			__func__, len, bufsize - ifc_nand_ctrl->index);
+		len = bufsize - ifc_nand_ctrl->index;
+	}
+
+	memcpy_toio(&ifc_nand_ctrl->addr[ifc_nand_ctrl->index], buf, len);
+	ifc_nand_ctrl->index += len;
+}
+
+/*
+ * Read two bytes from the IFC hardware buffer
+ * read function for 16-bit buswith
+ */
+static uint8_t fsl_ifc_read_byte16(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = priv->ctrl->nand;
+	uint16_t data;
+
+	/*
+	 * If there are still bytes in the IFC buffer, then use the
+	 * next byte.
+	 */
+	if (ifc_nand_ctrl->index < ifc_nand_ctrl->read_bytes) {
+		data = in_be16((uint16_t *)&ifc_nand_ctrl->
+					addr[ifc_nand_ctrl->index]);
+		ifc_nand_ctrl->index += 2;
+		return (uint8_t) data;
+	}
+
+	dev_err(priv->dev, "%s: read_byte16 beyond end of buffer\n", __func__);
+	return ERR_BYTE;
+}
+
+/*
+ * Read a byte from either the IFC hardware buffer
+ * read function for 8-bit buswidth
+ */
+static uint8_t fsl_ifc_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = priv->ctrl->nand;
+
+	/*
+	 * If there are still bytes in the IFC buffer, then use the
+	 * next byte.
+	 */
+	if (ifc_nand_ctrl->index < ifc_nand_ctrl->read_bytes)
+		return in_8(&ifc_nand_ctrl->addr[ifc_nand_ctrl->index++]);
+
+	dev_err(priv->dev, "%s: read_byte beyond end of buffer\n", __func__);
+	return ERR_BYTE;
+}
+
+/*
+ * Read from the IFC Controller Data Buffer
+ */
+static void fsl_ifc_read_buf(struct mtd_info *mtd, u8 *buf, int len)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = priv->ctrl->nand;
+	int avail;
+
+	if (len < 0)
+		return;
+
+	avail = min((unsigned int)len,
+			ifc_nand_ctrl->read_bytes - ifc_nand_ctrl->index);
+	memcpy_fromio(buf, &ifc_nand_ctrl->addr[ifc_nand_ctrl->index], avail);
+	ifc_nand_ctrl->index += avail;
+
+	if (len > avail)
+		dev_err(priv->dev,
+			"%s: read_buf beyond end of buffer "
+			"(%d requested, %d available)\n",
+			__func__, len, avail);
+}
+
+/*
+ * Verify buffer against the IFC Controller Data Buffer
+ */
+static int fsl_ifc_verify_buf(struct mtd_info *mtd,
+			       const u_char *buf, int len)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = priv->ctrl->nand;
+	int i;
+
+	if (len < 0) {
+		dev_err(priv->dev, "%s: write_buf of %d bytes", __func__, len);
+		return -EINVAL;
+	}
+
+	if ((unsigned int)len >
+			ifc_nand_ctrl->read_bytes - ifc_nand_ctrl->index) {
+		dev_err(priv->dev,
+			"%s: verify_buf beyond end of buffer "
+			"(%d requested, %u available)\n", __func__,
+		       len, ifc_nand_ctrl->read_bytes - ifc_nand_ctrl->index);
+
+		ifc_nand_ctrl->index = ifc_nand_ctrl->read_bytes;
+		return -EINVAL;
+	}
+
+	for (i = 0; i < len; i++)
+		if (in_8(&ifc_nand_ctrl->addr[ifc_nand_ctrl->index + i]) !=
+									buf[i])
+			break;
+
+	ifc_nand_ctrl->index += len;
+	return 0;
+}
+
+/*
+ * This function is called after Program and Erase Operations to
+ * check for success or failure.
+ */
+static int fsl_ifc_wait(struct mtd_info *mtd, struct nand_chip *chip)
+{
+	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = ctrl->nand;
+	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
+	u32 nand_fsr;
+
+	/* Use READ_STATUS command, but wait for the device to be ready */
+	ifc_nand_ctrl->use_mdr = 0;
+	out_be32(&ifc->ifc_nand.nand_fir0,
+		 (IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
+		 (IFC_FIR_OP_RDSTAT << IFC_NAND_FIR0_OP1_SHIFT));
+	out_be32(&ifc->ifc_nand.nand_fcr0, NAND_CMD_STATUS <<
+			IFC_NAND_FCR0_CMD0_SHIFT);
+	out_be32(&ifc->ifc_nand.nand_fbcr, 1);
+	set_addr(mtd, 0, 0, 0);
+	ifc_nand_ctrl->read_bytes = 1;
+
+	fsl_ifc_run_command(mtd);
+
+	nand_fsr = in_be32(&ifc->ifc_nand.nand_fsr);
+
+	/*
+	 * The chip always seems to report that it is
+	 * write-protected, even when it is not.
+	 */
+	return nand_fsr | NAND_STATUS_WP;
+}
+
+static int fsl_ifc_chip_init_tail(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct fsl_ifc_mtd *priv = chip->priv;
+
+	dev_dbg(priv->dev, "%s: nand->numchips = %d\n", __func__,
+							chip->numchips);
+	dev_dbg(priv->dev, "%s: nand->chipsize = %lld\n", __func__,
+							chip->chipsize);
+	dev_dbg(priv->dev, "%s: nand->pagemask = %8x\n", __func__,
+							chip->pagemask);
+	dev_dbg(priv->dev, "%s: nand->chip_delay = %d\n", __func__,
+							chip->chip_delay);
+	dev_dbg(priv->dev, "%s: nand->badblockpos = %d\n", __func__,
+							chip->badblockpos);
+	dev_dbg(priv->dev, "%s: nand->chip_shift = %d\n", __func__,
+							chip->chip_shift);
+	dev_dbg(priv->dev, "%s: nand->page_shift = %d\n", __func__,
+							chip->page_shift);
+	dev_dbg(priv->dev, "%s: nand->phys_erase_shift = %d\n", __func__,
+							chip->phys_erase_shift);
+	dev_dbg(priv->dev, "%s: nand->ecclayout = %p\n", __func__,
+							chip->ecclayout);
+	dev_dbg(priv->dev, "%s: nand->ecc.mode = %d\n", __func__,
+							chip->ecc.mode);
+	dev_dbg(priv->dev, "%s: nand->ecc.steps = %d\n", __func__,
+							chip->ecc.steps);
+	dev_dbg(priv->dev, "%s: nand->ecc.bytes = %d\n", __func__,
+							chip->ecc.bytes);
+	dev_dbg(priv->dev, "%s: nand->ecc.total = %d\n", __func__,
+							chip->ecc.total);
+	dev_dbg(priv->dev, "%s: nand->ecc.layout = %p\n", __func__,
+							chip->ecc.layout);
+	dev_dbg(priv->dev, "%s: mtd->flags = %08x\n", __func__, mtd->flags);
+	dev_dbg(priv->dev, "%s: mtd->size = %lld\n", __func__, mtd->size);
+	dev_dbg(priv->dev, "%s: mtd->erasesize = %d\n", __func__,
+							mtd->erasesize);
+	dev_dbg(priv->dev, "%s: mtd->writesize = %d\n", __func__,
+							mtd->writesize);
+	dev_dbg(priv->dev, "%s: mtd->oobsize = %d\n", __func__,
+							mtd->oobsize);
+
+	if (mtd->writesize == 512) {
+		priv->page_size = 0;
+	} else if (mtd->writesize == 2048) {
+		priv->page_size = 1;
+	} else if (mtd->writesize == 4096) {
+		priv->page_size = 1;
+	} else {
+		dev_err(priv->dev,
+			"%s: page size %d is not supported\n", __func__,
+			mtd->writesize);
+		return -1;
+	}
+	return 0;
+}
+
+static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
+{
+	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
+	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = ctrl->nand;
+	struct nand_chip *chip = &priv->chip;
+
+	dev_info(priv->dev, "IFC Set Information for bank %d\n", priv->bank);
+
+	/* Fill in fsl_ifc_mtd structure */
+	priv->mtd.priv = chip;
+	priv->mtd.owner = THIS_MODULE;
+
+	/* fill in nand_chip structure */
+	/* set up function call table */
+	if ((in_be32(&ifc->cspr_cs[priv->bank].cspr)) & CSPR_PORT_SIZE_16)
+		chip->read_byte = fsl_ifc_read_byte16;
+	else
+		chip->read_byte = fsl_ifc_read_byte;
+	chip->write_buf = fsl_ifc_write_buf;
+	chip->read_buf = fsl_ifc_read_buf;
+	chip->verify_buf = fsl_ifc_verify_buf;
+	chip->select_chip = fsl_ifc_select_chip;
+	chip->cmdfunc = fsl_ifc_cmdfunc;
+	chip->waitfunc = fsl_ifc_wait;
+
+	chip->bbt_td = &bbt_main_descr;
+	chip->bbt_md = &bbt_mirror_descr;
+
+	/* set up nand options */
+	chip->options = NAND_NO_READRDY | NAND_NO_AUTOINCR |
+			NAND_USE_FLASH_BBT;
+
+	chip->controller = &ifc_nand_ctrl->controller;
+	chip->priv = priv;
+
+	return 0;
+}
+
+static int fsl_ifc_chip_remove(struct fsl_ifc_mtd *priv)
+{
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = priv->ctrl->nand;
+	nand_release(&priv->mtd);
+
+	kfree(priv->mtd.name);
+
+	if (priv->vbase)
+		iounmap(priv->vbase);
+
+	ifc_nand_ctrl->chips[priv->bank] = NULL;
+	kfree(priv);
+	kfree(ifc_nand_ctrl);
+
+	return 0;
+}
+
+/*
+ * This interrupt is used to report ifc nand events of various kinds,
+ * such as transaction complete, errors on the chipselects.
+ */
+static irqreturn_t fsl_ifc_nand_irq(int irqno, void *data)
+{
+	struct fsl_ifc_ctrl *ctrl = data;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = ctrl->nand;
+	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
+
+	/* disable the Interrupts */
+	out_be32(&ifc->ifc_nand.nand_evter_intr_en, 0x0);
+
+	ifc_nand_ctrl->status = in_be32(&ifc->ifc_nand.nand_evter_stat);
+
+	/* clear status events for NAND Machine */
+	out_be32(&ifc->ifc_nand.nand_evter_stat, ifc_nand_ctrl->status);
+
+	if (ifc_nand_ctrl->status != IFC_NAND_EVTER_STAT_OPC) {
+		/* Print error info */
+			dev_err(ctrl->dev, "%s: Status = 0x%x\n",
+					__func__, ifc_nand_ctrl->status);
+		if (ifc_nand_ctrl->status & IFC_NAND_EVTER_STAT_FTOER)
+			dev_err(ctrl->dev, "%s: Flash Time-out Error",
+					__func__);
+		else if (ifc_nand_ctrl->status & IFC_NAND_EVTER_STAT_WPER)
+			dev_err(ctrl->dev, "%s: Flash Write Protect Error",
+					__func__);
+		else if (ifc_nand_ctrl->status & IFC_NAND_EVTER_STAT_ECCER)
+			dev_err(ctrl->dev, "%s: ECC Error",
+					__func__);
+
+		return -EIO;
+	}
+
+	/* wake up */
+	wake_up(&ifc_nand_ctrl->irq_wait);
+
+	return IRQ_HANDLED;
+}
+
+
+static int __devinit fsl_ifc_nand_probe(struct platform_device *pdev)
+{
+	struct fsl_ifc_regs __iomem *ifc;
+	struct fsl_ifc_mtd *priv;
+	struct resource res;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = NULL;
+
+#ifdef CONFIG_MTD_PARTITIONS
+	static const char *part_probe_types[]
+		= { "cmdlinepart", "RedBoot", NULL };
+	struct mtd_partition *parts;
+#endif
+	int ret;
+	int bank;
+	struct device *dev;
+	struct device_node *node = pdev->dev.of_node;
+
+	ifc = fsl_ifc_ctrl_dev->regs;
+	dev = fsl_ifc_ctrl_dev->dev;
+
+	/* get, allocate and map the memory resource */
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret) {
+		dev_err(dev, "%s: failed to get resource\n", __func__);
+		return ret;
+	}
+
+	/* find which chip select it is connected to */
+	for (bank = 0; bank < FSL_IFC_BANK_COUNT; bank++) {
+		if ((in_be32(&ifc->cspr_cs[bank].cspr) & CSPR_V) &&
+			((in_be32(&ifc->cspr_cs[bank].cspr) & CSPR_MSEL)
+							== CSPR_MSEL_NAND) &&
+			(in_be32(&ifc->cspr_cs[bank].cspr) & CSPR_BA)
+			== convert_ifc_address(res.start))
+			break;
+	}
+
+	if (bank >= FSL_IFC_BANK_COUNT) {
+		dev_err(dev, "%s: address did not match any "
+				"chip selects\n", __func__);
+		return -ENODEV;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (!fsl_ifc_ctrl_dev->nand) {
+		ifc_nand_ctrl = kzalloc(sizeof(*ifc_nand_ctrl), GFP_KERNEL);
+		if (!ifc_nand_ctrl) {
+			dev_err(dev, "failed to allocate memory\n");
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		ifc_nand_ctrl->cs_nand = bank << IFC_NAND_CSEL_SHIFT;
+		fsl_ifc_ctrl_dev->nand = ifc_nand_ctrl;
+
+		spin_lock_init(&ifc_nand_ctrl->controller.lock);
+		init_waitqueue_head(&ifc_nand_ctrl->controller.wq);
+	}
+
+	init_waitqueue_head(&ifc_nand_ctrl->irq_wait);
+
+	ifc_nand_ctrl->chips[bank] = priv;
+	priv->bank = bank;
+	priv->ctrl = fsl_ifc_ctrl_dev;
+	priv->dev = dev;
+
+	priv->vbase = ioremap(res.start, resource_size(&res));
+	if (!priv->vbase) {
+		dev_err(dev, "%s: failed to map chip"
+						"region\n", __func__);
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	out_be32(&ifc->ifc_nand.nand_evter_en,
+			IFC_NAND_EVTER_EN_OPC_EN |
+			IFC_NAND_EVTER_EN_FTOER_EN |
+			IFC_NAND_EVTER_EN_WPER_EN |
+			IFC_NAND_EVTER_EN_ECCER_EN);
+
+	/* enable NAND Machine Interrupts */
+	out_be32(&ifc->ifc_nand.nand_evter_intr_en,
+			IFC_NAND_EVTER_INTR_OPCIR_EN |
+			IFC_NAND_EVTER_INTR_FTOERIR_EN |
+			IFC_NAND_EVTER_INTR_WPERIR_EN |
+			IFC_NAND_EVTER_INTR_ECCERIR_EN);
+
+	ret = request_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_nand_irq, 0,
+				"fsl-ifc-nand", priv->ctrl);
+
+	if (ret != 0) {
+		dev_err(dev, "%s: failed to install "
+			"irq (%d)\n", __func__, fsl_ifc_ctrl_dev->nand_irq);
+		goto err;
+	}
+
+	priv->mtd.name = kasprintf(GFP_KERNEL, "%x.flash", (unsigned)res.start);
+	if (!priv->mtd.name) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = fsl_ifc_chip_init(priv);
+	if (ret)
+		goto err;
+
+	ret = nand_scan_ident(&priv->mtd, 1, NULL);
+	if (ret)
+		goto err;
+
+	ret = fsl_ifc_chip_init_tail(&priv->mtd);
+	if (ret)
+		goto err;
+
+	ret = nand_scan_tail(&priv->mtd);
+	if (ret)
+		goto err;
+
+#ifdef CONFIG_MTD_PARTITIONS
+	/* First look for RedBoot table or partitions on the command
+	 * line, these take precedence over device tree information */
+	ret = parse_mtd_partitions(&priv->mtd, part_probe_types, &parts, 0);
+	if (ret < 0)
+		goto err;
+
+#ifdef CONFIG_MTD_OF_PARTS
+	if (ret == 0) {
+		ret = of_mtd_parse_partitions(priv->dev, node, &parts);
+		if (ret < 0)
+			goto err;
+	}
+#endif
+
+	if (ret > 0)
+		add_mtd_partitions(&priv->mtd, parts, ret);
+	else
+#endif
+		add_mtd_device(&priv->mtd);
+
+	printk(KERN_INFO "IFC NAND device at 0x%llx, bank %d\n",
+	       (unsigned long long)res.start, priv->bank);
+	return 0;
+
+err:
+	fsl_ifc_chip_remove(priv);
+	return ret;
+}
+
+static int fsl_ifc_nand_remove(struct platform_device *pdev)
+{
+	int i;
+	struct fsl_ifc_nand_ctrl *ifc_nand_ctrl = fsl_ifc_ctrl_dev->nand;
+
+	for (i = 0; i < FSL_IFC_BANK_COUNT; i++)
+		if (ifc_nand_ctrl->chips[i])
+			fsl_ifc_chip_remove(ifc_nand_ctrl->chips[i]);
+
+	fsl_ifc_ctrl_dev->nand = NULL;
+	kfree(ifc_nand_ctrl);
+	return 0;
+}
+
+static const struct of_device_id fsl_ifc_nand_match[] = {
+	{
+		.compatible = "fsl,ifc-nand",
+	},
+	{}
+};
+
+static struct platform_driver fsl_ifc_nand_driver = {
+	.driver = {
+		.name	= "fsl,ifc-nand",
+		.owner = THIS_MODULE,
+		.of_match_table = fsl_ifc_nand_match,
+	},
+	.probe       = fsl_ifc_nand_probe,
+	.remove      = fsl_ifc_nand_remove,
+};
+
+static int __init fsl_ifc_nand_init(void)
+{
+	return platform_driver_register(&fsl_ifc_nand_driver);
+}
+
+static void __exit fsl_ifc_nand_exit(void)
+{
+	platform_driver_unregister(&fsl_ifc_nand_driver);
+}
+
+module_init(fsl_ifc_nand_init);
+module_exit(fsl_ifc_nand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Freescale");
+MODULE_DESCRIPTION("Freescale Integrated Flash Controller MTD NAND driver");
-- 
1.5.5.6
