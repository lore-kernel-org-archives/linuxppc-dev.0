Return-Path: <vooon341@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B5B3B7529
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Mar 2011 10:46:39 +1100 (EST)
Received: by mail-bw0-f51.google.com with SMTP id 10so1883133bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 16:46:39 -0700 (PDT)
Subject: [PATCH 4/4] mtd/nand: Add initial support for TWR-MPC5125
From: Vladimir Ermakov <vooon341@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Mar 2011 02:46:04 +0300
Message-ID: <1300319164.12970.79.camel@desinto>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds NAND Flash Controller driver for MPC5125.
Also adds chip id for Micron's NAND used in TWR-MPC5125.

Driver ported from original Freescale BSP (kernel 2.6.29.1).

Signed-off-by: Vladimir Ermakov <vooon341@gmail.com>
---

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index a92054e..eb660a8 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -472,6 +472,26 @@ config MTD_NAND_MPC5121_NFC
 	  This enables the driver for the NAND flash controller on the
 	  MPC5121 SoC.
 
+config MTD_NAND_MPC5125_NFC
+	tristate "MPC5125 built-in NAND Flash Controller support"
+	depends on PPC_MPC512x
+	help
+	  This enables the driver for the NAND flash controller on the
+	  MPC5125 SoC.
+
+config MTD_NAND_MPC5125_HWECC
+	bool "Enable hardware ECC"
+	depends on MTD_NAND_MPC5125_NFC
+	help
+	  This enables the support for Software ECC handling. By
+	  default FSL NAND controller Hardware ECC is supported.
+
+config NFC_DMA_ENABLE
+	bool "Enable NAND Flash DMA"
+	depends on MTD_NAND_MPC5125_NFC
+	help
+	  This enables the nfc dma support
+
 config MTD_NAND_MXC
 	tristate "MXC NAND support"
 	depends on IMX_HAVE_PLATFORM_MXC_NAND
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 5745d83..bd354cd 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_MTD_NAND_NUC900)		+= nuc900_nand.o
 obj-$(CONFIG_MTD_NAND_NOMADIK)		+= nomadik_nand.o
 obj-$(CONFIG_MTD_NAND_BCM_UMI)		+= bcm_umi_nand.o nand_bcm_umi.o
 obj-$(CONFIG_MTD_NAND_MPC5121_NFC)	+= mpc5121_nfc.o
+obj-$(CONFIG_MTD_NAND_MPC5125_NFC)	+= mpc5125_nfc.o
 obj-$(CONFIG_MTD_NAND_RICOH)		+= r852.o
 obj-$(CONFIG_MTD_NAND_JZ4740)		+= jz4740_nand.o
 
diff --git a/drivers/mtd/nand/mpc5125_nfc.c b/drivers/mtd/nand/mpc5125_nfc.c
new file mode 100644
index 0000000..aea3186
--- /dev/null
+++ b/drivers/mtd/nand/mpc5125_nfc.c
@@ -0,0 +1,1290 @@
+/*
+ * Copyright (C) 2009 Freescale Semiconductor, Inc.
+ *
+ * MPC5125 Nand driver.
+ *
+ * Based on original driver from Freescale Semiconductor
+ * written by Shaohui Xie <b21989@freescale.com> on basis
+ * of drivers/mtd/nand/mpc5121_nfc.c.
+ * Modyfied by Cloudy Chen <chen_yunsong@mtcera.com>.
+ * Reworked by Vladimir Ermakov <vooon341@gmail.com>.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/gfp.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include "mpc5125_nfc.h"
+
+#define	DRV_NAME		"mpc5125_nfc"
+
+#define	SPARE_BUFFER_MAX_SIZE	0x400
+#define	DATA_BUFFER_MAX_SIZE	0x2000
+
+/* Timeouts */
+#define NFC_RESET_TIMEOUT	1000		/* 1 ms */
+#define NFC_TIMEOUT		(HZ / 10)	/* 1/10 s */
+
+#ifdef CONFIG_NFC_DMA_ENABLE
+#define NFC_DMA_ENABLE		1
+#else
+#define NFC_DMA_ENABLE		0
+#endif
+
+struct mpc5125_nfc_prv {
+	struct mtd_info		mtd;
+	struct nand_chip	chip;
+	int			irq;
+	void __iomem		*regs;
+	struct clk		*clk;
+	wait_queue_head_t	irq_waitq;
+	uint			column;
+	int			spareonly;
+	u32		irq_stat;
+	u32		wait_timeout;
+	void __iomem		*csreg;
+	struct device		*dev;
+	void			*data_buffers;
+	dma_addr_t		data_buffers_phyaddr;
+	void			*ops_buffer;
+	dma_addr_t		ops_buffer_phyaddr;
+	void			*tmp_buf;
+	unsigned int		sync_flags;
+};
+
+static int get_status;
+static int get_id;
+
+#define	NFC_IRQ_ENABLE	(IDLE_EN_MASK|WERR_EN_MASK)
+#define	NFC_IRQ_MASK	(IDLE_IRQ_MASK|WERR_IRQ_MASK)
+
+#define	MPC5125_NFC_ECC_STATUS_ADD	(NFC_SPARE_AREA(0)+0xf0)
+
+#if 1
+/* for ECC_MODE=0x6 45bytes*2 */
+static struct nand_ecclayout nand_hw_eccoob_4k_128 = {
+	.eccbytes = 90,	/* actually 72 but only room for 64 */
+	.eccpos = {
+		/* 9 bytes of ecc for each 512 bytes of data */
+		19,  20,  21,  22,  23,  24,  25,  26,  27,
+		28,  29,  30,  31,  32,  33,  34,  35,  36,
+		37,  38,  39,  40,  41,  42,  43,  44,  45,
+		46,  47,  48,  49,  50,  51,  52,  53,  54,
+		55,  56,  57,  58,  59,  60,  61,  62,  63,
+
+		83,  84,  85,  86,  87,  88,  89,  90,  91,
+		92,  93,  94,  95,  96,  97,  98,  99, 100,
+		101,102, 103, 104, 105, 106, 107, 108, 109,
+		110,111, 112, 113, 114, 115, 116, 117, 118,
+		119,120, 121, 122, 123, 124, 125, 126, 127
+		/* 120, 121, 122, 123, 124, 125, 126, 127, */
+	},
+	.oobavail = 30,
+	.oobfree = {
+		{4, 15},
+		{68, 15}
+	}
+};
+#else
+/* for ECC_MODE=0x5 30bytes*2 */
+static struct nand_ecclayout nand_hw_eccoob_4k_128 = {
+	.eccbytes = 60,	/* actually 72 but only room for 64 */
+	.eccpos = {
+		/* 9 bytes of ecc for each 512 bytes of data */
+		34,  35,  36,  37,  38,  39,  40,  41,  42,
+		43,  44,  45,  46,  47,  48,  49,  50,  51,
+		52,  53,  54,  55,  56,  57,  58,  59,  60,
+		61,  62,  63,
+
+		98,  99, 100,
+		101,102, 103, 104, 105, 106, 107, 108, 109,
+		110,111, 112, 113, 114, 115, 116, 117, 118,
+		119,120, 121, 122, 123, 124, 125, 126, 127
+		/* 120, 121, 122, 123, 124, 125, 126, 127, */
+	},
+	.oobavail = 48,
+	.oobfree = {
+		{8, 24},
+		{68, 24}
+	}
+};
+#endif
+
+static struct nand_ecclayout nand_hw_eccoob_4k_218 = {
+	.eccbytes = 64,	/* actually 144 but only room for 64 */
+	.eccpos = {
+		/* 18 bytes of ecc for each 512 bytes of data */
+		7, 8, 9, 10, 11, 12, 13, 14, 15,
+		    16, 17, 18, 19, 20, 21, 22, 23, 24,
+		33, 34, 35, 36, 37, 38, 39, 40, 41,
+		    42, 43, 44, 45, 46, 47, 48, 49, 50,
+		59, 60, 61, 62, 63, 64, 65, 66, 67,
+		    68, 69, 70, 71, 72, 73, 74, 75, 76,
+		85, 86, 87, 88, 89, 90, 91, 92, 93,
+		    94, /* 95, 96, 97, 98, 99, 100, 101, 102,
+		111, 112, 113, 114, 115, 116, 117, 118, 119,
+		    120, 121, 122, 123, 124, 125, 126, 127, 128,
+		137, 138, 139, 140, 141, 142, 143, 144, 145,
+		    146, 147, 148, 149, 150, 151, 152, 153, 154,
+		163, 164, 165, 166, 167, 168, 169, 170, 171,
+		    172, 173, 174, 175, 176, 177, 178, 179, 180,
+		189, 190, 191, 192, 193, 194, 195, 196, 197,
+		    198, 199, 200, 201, 202, 203, 204, 205, 206, */
+	},
+	.oobavail = 4,
+	.oobfree = {
+		{0, 5}, {26, 8},
+		{52, 8}, {78, 8},
+		{104, 8}, {130, 8},
+		{156, 8}, {182, 8}
+	}
+};
+
+
+#if NFC_DMA_ENABLE
+static void mpc5125_dma_config(struct mtd_info *mtd, struct nand_chip *chip, unsigned isRead);
+static void mpc5125_nand_dma_wait(struct mtd_info *mtd, struct nand_chip *chip);
+#endif
+
+#ifdef CONFIG_MTD_PARTITIONS
+static const char *mpc5125_nfc_pprobes[] = { "cmdlinepart", NULL };
+#endif
+
+/* Read NFC register */
+static inline u32 nfc_read(struct mtd_info *mtd, uint reg)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct mpc5125_nfc_prv *prv = chip->priv;
+
+	return in_be32(prv->regs + reg);
+}
+
+/* Write NFC register */
+static inline void nfc_write(struct mtd_info *mtd, uint reg, u32 val)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct mpc5125_nfc_prv *prv = chip->priv;
+
+	out_be32(prv->regs + reg, val);
+}
+
+/* Set bits in NFC register */
+static inline void nfc_set(struct mtd_info *mtd, uint reg, u32 bits)
+{
+	nfc_write(mtd, reg, nfc_read(mtd, reg) | bits);
+}
+
+/* Clear bits in NFC register */
+static inline void nfc_clear(struct mtd_info *mtd, uint reg, u32 bits)
+{
+	nfc_write(mtd, reg, nfc_read(mtd, reg) & ~bits);
+}
+
+
+static inline void
+nfc_set_field(struct mtd_info *mtd, u32 reg, u32 mask, u32 shift, u32 val)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct mpc5125_nfc_prv *prv = chip->priv;
+
+	out_be32(prv->regs + reg,
+			(in_be32(prv->regs + reg) & (~mask))
+			| val << shift);
+}
+
+static inline int
+nfc_get_field(struct mtd_info *mtd, u32 reg, u32 field_mask)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct mpc5125_nfc_prv *prv = chip->priv;
+
+	return in_be32(prv->regs + reg) & field_mask;
+}
+
+static inline u8 nfc_check_status(struct mtd_info *mtd)
+{
+	u8 fls_status = 0;
+	fls_status = nfc_get_field(mtd, NFC_FLASH_STATUS2, STATUS_BYTE1_MASK);
+	return fls_status;
+}
+
+/* clear cmd_done and cmd_idle falg for the coming command */
+static void mpc5125_nfc_clear(struct mtd_info *mtd)
+{
+	nfc_write(mtd, NFC_IRQ_STATUS, 1 << CMD_DONE_CLEAR_SHIFT);
+	nfc_write(mtd, NFC_IRQ_STATUS, 1 << IDLE_CLEAR_SHIFT);
+	nfc_write(mtd, NFC_IRQ_STATUS, 1 << WERR_CLEAR_SHIFT);
+}
+
+/* Wait for operation complete */
+static void mpc5125_nfc_done(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct mpc5125_nfc_prv *prv = chip->priv;
+	int rv;
+	unsigned int wait_time = NFC_TIMEOUT;
+
+	mpc5125_nfc_clear(mtd);
+	nfc_set(mtd, NFC_IRQ_STATUS, NFC_IRQ_ENABLE);
+	prv->wait_timeout = 0;
+	prv->sync_flags = 0;
+	nfc_set_field(mtd, NFC_FLASH_CMD2, START_MASK,
+			START_SHIFT, 1);
+
+	if ((nfc_read(mtd, NFC_IRQ_STATUS) & NFC_IRQ_MASK) == 0){
+		rv = wait_event_timeout(prv->irq_waitq,
+			(nfc_read(mtd, NFC_IRQ_STATUS) & NFC_IRQ_MASK), wait_time);
+
+		if (!rv) {
+			prv->irq_stat = nfc_read(mtd, NFC_IRQ_STATUS);
+
+			if(!prv->sync_flags)
+				dev_warn(prv->dev, "Lost irq.\n");
+
+			dev_warn(prv->dev,
+				"Timeout while waiting for interrupt.\n");
+			prv->wait_timeout = 1;
+		}
+	}
+
+	mpc5125_nfc_clear(mtd);
+}
+
+static inline u8 mpc5125_nfc_get_id(struct mtd_info *mtd, int col)
+{
+	u32 flash_id1 = 0;
+	u8 *pid;
+
+	flash_id1 = nfc_read(mtd, NFC_FLASH_STATUS1);
+	pid = (u8 *)&flash_id1;
+
+	return *(pid + col);
+}
+
+static inline u8 mpc5125_nfc_get_status(struct mtd_info *mtd)
+{
+	u32 flash_status = 0;
+	u8 *pstatus;
+
+	flash_status = nfc_read(mtd, NFC_FLASH_STATUS2);
+	pstatus = (u8 *)&flash_status;
+
+	return *(pstatus + 3);
+}
+
+/* Invoke command cycle */
+static inline void
+mpc5125_nfc_send_cmd(struct mtd_info *mtd, u32 cmd_byte1,
+		u32 cmd_byte2, u32 cmd_code)
+{
+	mpc5125_nfc_clear(mtd);
+	nfc_set_field(mtd, NFC_FLASH_CMD2, CMD_BYTE1_MASK,
+			CMD_BYTE1_SHIFT, cmd_byte1);
+
+	nfc_set_field(mtd, NFC_FLASH_CMD1, CMD_BYTE2_MASK,
+			CMD_BYTE2_SHIFT, cmd_byte2);
+
+	nfc_set_field(mtd, NFC_FLASH_CMD2, BUFNO_MASK,
+			BUFNO_SHIFT, 0);
+
+	nfc_set_field(mtd, NFC_FLASH_CMD2, CMD_CODE_MASK,
+			CMD_CODE_SHIFT, cmd_code);
+
+	if (cmd_code == RANDOM_OUT_CMD_CODE)
+		nfc_set_field(mtd, NFC_FLASH_CMD2, BUFNO_MASK,
+			BUFNO_SHIFT, 1);
+}
+
+/* Receive ID and status from NAND flash */
+static inline void
+mpc5125_nfc_send_one_byte(struct mtd_info *mtd, u32 cmd_byte1, u32 cmd_code)
+{
+	mpc5125_nfc_clear(mtd);
+	nfc_set_field(mtd, NFC_FLASH_CMD2, CMD_BYTE1_MASK,
+			CMD_BYTE1_SHIFT, cmd_byte1);
+
+	nfc_set_field(mtd, NFC_FLASH_CMD2, BUFNO_MASK,
+			BUFNO_SHIFT, 0);
+
+	nfc_set_field(mtd, NFC_FLASH_CMD2, CMD_CODE_MASK,
+			CMD_CODE_SHIFT, cmd_code);
+}
+
+/* NFC interrupt handler */
+static irqreturn_t mpc5125_nfc_irq(int irq, void *data)
+{
+	struct mtd_info *mtd = data;
+	struct nand_chip *chip = mtd->priv;
+	struct mpc5125_nfc_prv *prv = chip->priv;
+
+	prv->irq_stat = nfc_read(mtd, NFC_IRQ_STATUS);
+	nfc_clear(mtd, NFC_IRQ_STATUS, NFC_IRQ_ENABLE);
+	wake_up(&prv->irq_waitq);
+	/*mpc5125_nfc_clear(mtd);*/
+	prv->sync_flags |= 1;
+
+	return IRQ_HANDLED;
+}
+
+/* Do address cycle(s) */
+static void mpc5125_nfc_addr_cycle(struct mtd_info *mtd, int column, int page)
+{
+
+	if (column != -1) {
+		nfc_set_field(mtd, NFC_COL_ADDR,
+				COL_ADDR_MASK,
+				COL_ADDR_SHIFT, column);
+	}
+
+	if (page != -1) {
+		nfc_set_field(mtd, NFC_ROW_ADDR,
+				ROW_ADDR_MASK,
+				ROW_ADDR_SHIFT, page);
+	}
+	/* DMA Disable */
+#if (NFC_DMA_ENABLE<1)
+	nfc_clear(mtd, NFC_FLASH_CONFIG, CONFIG_DMA_REQ_MASK);
+#endif
+	/* PAGE_CNT = 2 */
+	nfc_set_field(mtd, NFC_FLASH_CONFIG, CONFIG_PAGE_CNT_MASK,
+			CONFIG_PAGE_CNT_SHIFT, 0x2);
+}
+
+
+/* Control chips select signal on ADS5125 board */
+static void ads5125_select_chip(struct mtd_info *mtd, int chip)
+{
+
+	if ((chip < 0)||(chip > 3)) {
+		nfc_set_field(mtd, NFC_ROW_ADDR,
+			ROW_ADDR_CHIP_SEL_RB_MASK,
+			ROW_ADDR_CHIP_SEL_RB_SHIFT, 0);
+
+		nfc_set_field(mtd, NFC_ROW_ADDR,
+			ROW_ADDR_CHIP_SEL_MASK,
+			ROW_ADDR_CHIP_SEL_SHIFT, 0);
+		return;
+	}
+
+	nfc_set_field(mtd, NFC_ROW_ADDR,
+		ROW_ADDR_CHIP_SEL_RB_MASK,
+		ROW_ADDR_CHIP_SEL_RB_SHIFT, (1<<chip));
+
+	nfc_set_field(mtd, NFC_ROW_ADDR,
+		ROW_ADDR_CHIP_SEL_MASK,
+		ROW_ADDR_CHIP_SEL_SHIFT, (1<<chip));
+}
+
+/* Read NAND Ready/Busy signal */
+static int mpc5125_nfc_dev_ready(struct mtd_info *mtd)
+{
+	/*
+	 * NFC handles ready/busy signal internally. Therefore, this function
+	 * always returns status as ready.
+	 */
+	return 1;
+}
+
+/* Write command to NAND flash */
+static void mpc5125_nfc_command(struct mtd_info *mtd, unsigned command,
+						int column, int page)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct mpc5125_nfc_prv *prv = chip->priv;
+
+	prv->column = (column >= 0) ? column : 0;
+	prv->spareonly = 0;
+	get_id = 0;
+	get_status = 0;
+
+
+	switch (command) {
+	case NAND_CMD_PAGEPROG:
+#if (NFC_DMA_ENABLE)
+		mpc5125_nfc_send_cmd(mtd,
+				PROGRAM_PAGE_CMD_BYTE1,
+				PROGRAM_PAGE_CMD_BYTE2,
+				DMA_PROGRAM_PAGE_CMD_CODE);
+		/*
+		nfc_set_field(mtd, NFC_FLASH_CMD2, CMD_BYTE1_MASK,
+			CMD_BYTE1_SHIFT, READ_STATUS_CMD_BYTE);
+			*/
+		mpc5125_dma_config(mtd, chip, 0);
+#else
+		mpc5125_nfc_send_cmd(mtd,
+				PROGRAM_PAGE_CMD_BYTE1,
+				PROGRAM_PAGE_CMD_BYTE2,
+				PROGRAM_PAGE_CMD_CODE);
+#endif
+		break;
+	/*
+	 * NFC does not support sub-page reads and writes,
+	 * so emulate them using full page transfers.
+	 */
+	case NAND_CMD_READ0:
+		column = 0;
+		goto read0;
+		break;
+
+	case NAND_CMD_READ1:
+		prv->column += 256;
+		command = NAND_CMD_READ0;
+		column = 0;
+		goto read0;
+		break;
+
+	case NAND_CMD_READOOB:
+		prv->spareonly = 1;
+		command = NAND_CMD_READ0;
+		column = 0;
+
+read0:
+		mpc5125_nfc_send_cmd(mtd,
+				PAGE_READ_CMD_BYTE1,
+				PAGE_READ_CMD_BYTE2,
+				READ_PAGE_CMD_CODE);
+#if NFC_DMA_ENABLE
+		mpc5125_dma_config(mtd, chip, 1);
+#endif
+		break;
+
+	case NAND_CMD_SEQIN:
+		mpc5125_nfc_command(mtd, NAND_CMD_READ0, column, page);
+		column = 0;
+		break;
+
+	case NAND_CMD_ERASE1:
+		mpc5125_nfc_send_cmd(mtd,
+				ERASE_CMD_BYTE1,
+				ERASE_CMD_BYTE2,
+				ERASE_CMD_CODE);
+		break;
+
+	case NAND_CMD_ERASE2:
+		return;
+
+	case NAND_CMD_READID:
+		get_id = 1;
+		mpc5125_nfc_send_one_byte(mtd, command, READ_ID_CMD_CODE);
+		break;
+
+	case NAND_CMD_STATUS:
+		get_status = 1;
+		mpc5125_nfc_send_one_byte(mtd, command, STATUS_READ_CMD_CODE);
+		break;
+
+	case NAND_CMD_RNDOUT:
+		mpc5125_nfc_send_cmd(mtd,
+				RANDOM_OUT_CMD_BYTE1,
+				RANDOM_OUT_CMD_BYTE2,
+				RANDOM_OUT_CMD_CODE);
+		break;
+
+	default:
+		return;
+	}
+
+	mpc5125_nfc_addr_cycle(mtd, column, page);
+	mpc5125_nfc_done(mtd);
+
+#if (NFC_DMA_ENABLE)
+	/* mpc5125_nand_dma_wait(mtd, chip); */
+	nfc_clear(mtd, NFC_FLASH_CONFIG, CONFIG_DMA_REQ_MASK);
+#endif
+}
+
+/* Copy data from/to NFC spare buffers. */
+static void mpc5125_nfc_copy_spare(struct mtd_info *mtd, uint offset,
+						u8 *buffer, uint size, int wr)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct mpc5125_nfc_prv *prv = nand->priv;
+	u16 ooblen = mtd->oobsize;
+	u8 i, count;
+	uint  sbsize, blksize;
+
+	/*
+	 * NAND spare area is available through NFC spare buffers.
+	 * The NFC divides spare area into (page_size / 512) chunks.
+	 * Each chunk is placed into separate spare memory area, using
+	 * first (spare_size / num_of_chunks) bytes of the buffer.
+	 *
+	 * For NAND device in which the spare area is not divided fully
+	 * by the number of chunks, number of used bytes in each spare
+	 * buffer is rounded down to the nearest even number of bytes,
+	 * and all remaining bytes are added to the last used spare area.
+	 *
+	 * For more information read section 26.6.10 of MPC5121e
+	 * Microcontroller Reference Manual, Rev. 3.
+	 */
+
+	/* Calculate number of valid bytes in each spare buffer */
+	count = mtd->writesize >> 11;
+	count = (count > 0) ? count : 1;
+	sbsize = (ooblen / count >> 1) << 1;
+
+	for (i=0; (i < count) && size; i++) {
+		blksize = min(sbsize, size);
+		if (wr)
+			memcpy_toio(prv->regs + NFC_SPARE_AREA(i),
+							buffer, blksize);
+		else
+			memcpy_fromio(buffer,
+				prv->regs + NFC_SPARE_AREA(i), blksize);
+
+		buffer += blksize;
+		offset += blksize;
+		size -= blksize;
+	}
+}
+
+/* Copy data from/to NFC main and spare buffers */
+static void
+mpc5125_nfc_buf_copy(struct mtd_info *mtd, u8 *buf, int len, int wr)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct mpc5125_nfc_prv *prv = chip->priv;
+	uint c = prv->column;
+	uint l;
+
+	/* Handle spare area access */
+	if (prv->spareonly || c >= mtd->writesize) {
+		/* Calculate offset from beginning of spare area */
+		if (c >= mtd->writesize)
+			c -= mtd->writesize;
+
+		prv->column += len;
+#if NFC_DMA_ENABLE
+		if (wr)
+			memcpy(prv->ops_buffer, buf, len);
+		else
+			memcpy(buf, prv->ops_buffer, len);
+#else
+		mpc5125_nfc_copy_spare(mtd, c, buf, len, wr);
+#endif
+		return;
+	}
+
+	/*
+	 * Handle main area access - limit copy length to prevent
+	 * crossing main/spare boundary.
+	 */
+	l = min((uint)len, mtd->writesize - c);
+	prv->column += l;
+
+	if (wr)	{
+#if NFC_DMA_ENABLE
+		memcpy(prv->data_buffers+c, buf, len);
+#else
+		unsigned int size, i;
+		for (i=(c/PAGE_2K); i < 4; i++) {
+			size = min(len, PAGE_2K);
+			memcpy_toio(prv->regs + NFC_MAIN_AREA(i) + c, buf, size);
+			buf += size;
+			len -= size;
+			if (!len)
+				break;
+		}
+#endif
+	} else {
+		if (get_status) {
+			get_status = 0;
+			*buf = mpc5125_nfc_get_status(mtd);
+		} else if (l == 1 && c <= 3 && get_id) {
+			*buf = mpc5125_nfc_get_id(mtd, c);
+		} else {
+			unsigned int size, i;
+#if NFC_DMA_ENABLE
+			if (len == mtd->writesize)
+				memcpy(buf, prv->data_buffers+c, len);
+			else
+#endif
+			for (i=(c/PAGE_2K); i < 4; i++) {
+				size = min(len, PAGE_2K);
+				memcpy_fromio(buf, prv->regs + NFC_MAIN_AREA(i) + c, size);
+				buf += size;
+				len -= size;
+				if (!len)
+					break;
+			}
+		}
+	}
+}
+
+/* Read data from NFC buffers */
+static void mpc5125_nfc_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+{
+	mpc5125_nfc_buf_copy(mtd, buf, len, 0);
+}
+
+/* Write data to NFC buffers */
+static void mpc5125_nfc_write_buf(struct mtd_info *mtd,
+						const u_char *buf, int len)
+{
+	mpc5125_nfc_buf_copy(mtd, (u_char *)buf, len, 1);
+}
+
+/* Compare buffer with NAND flash */
+static int mpc5125_nfc_verify_buf(struct mtd_info *mtd,
+						const u_char *buf, int len)
+{
+	u_char tmp[256];
+	uint bsize;
+
+	while (len) {
+		bsize = min(len, 256);
+		mpc5125_nfc_read_buf(mtd, tmp, bsize);
+
+		if (memcmp(buf, tmp, bsize))
+			return 1;
+
+		buf += bsize;
+		len -= bsize;
+	}
+
+	return 0;
+}
+
+/* Read byte from NFC buffers */
+static u8 mpc5125_nfc_read_byte(struct mtd_info *mtd)
+{
+	u8 tmp;
+
+	mpc5125_nfc_read_buf(mtd, &tmp, sizeof(tmp));
+
+	return tmp;
+}
+
+/* Read word from NFC buffers */
+static u16 mpc5125_nfc_read_word(struct mtd_info *mtd)
+{
+	u16 tmp;
+
+	mpc5125_nfc_read_buf(mtd, (u_char *)&tmp, sizeof(tmp));
+
+	return tmp;
+}
+
+/*
+ * Read NFC configuration from Reset Config Word
+ *
+ */
+static int mpc5125_nfc_read_hw_config(struct mtd_info *mtd)
+{
+	uint rcw_pagesize = 0;
+	uint rcw_sparesize = 0;
+
+	/* TODO */
+	rcw_pagesize = 4096;
+	rcw_sparesize = 128;
+	mtd->writesize = rcw_pagesize;
+	mtd->oobsize = rcw_sparesize;
+
+	return 0;
+}
+
+/* Free driver resources */
+static void mpc5125_nfc_free(struct device *dev, struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct mpc5125_nfc_prv *prv = chip->priv;
+
+	if (prv->clk) {
+		clk_disable(prv->clk);
+		clk_put(prv->clk);
+	}
+
+	if (prv->csreg)
+		iounmap(prv->csreg);
+}
+
+static void mpc5125_nand_enable_hwecc(struct mtd_info *mtd, int mode)
+{
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+			CONFIG_ECC_MODE_MASK,
+			CONFIG_ECC_MODE_SHIFT, ECC_45_BYTE);
+	return;
+}
+
+/*
+ * Function to correct the detected errors. This NFC corrects all the errors
+ * detected. So this function is not required.
+ */
+static int mpc5125_nand_correct_data(struct mtd_info *mtd, u_char * dat,
+				 u_char * read_ecc, u_char * calc_ecc)
+{
+	panic("Shouldn't be called here: %d\n", __LINE__);
+	return 0;		/* FIXME */
+}
+
+/*
+ * Function to calculate the ECC for the data to be stored in the Nand device.
+ * This NFC has a hardware RS(511,503) ECC engine together with the RS ECC
+ * CONTROL blocks are responsible for detection  and correction of up to
+ * 4 symbols of 9 bits each in 528 byte page.
+ * So this function is not required.
+ */
+static int mpc5125_nand_calculate_ecc(struct mtd_info *mtd, const u_char * dat,
+				  u_char * ecc_code)
+{
+	panic(KERN_ERR "Shouldn't be called here %d \n", __LINE__);
+	return 0;		/* FIXME */
+}
+
+static int mpc5125_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
+			     int page, int sndcmd)
+{
+
+	if (sndcmd) {
+		mpc5125_nfc_command(mtd, NAND_CMD_READ0, 0, page);
+		sndcmd = 0;
+	}
+
+#if NFC_DMA_ENABLE
+{
+	struct mpc5125_nfc_prv *prv = chip->priv;
+	memcpy(chip->oob_poi, prv->ops_buffer, mtd->oobsize);
+}
+#else
+	mpc5125_nfc_copy_spare(mtd, 0, chip->oob_poi, mtd->oobsize, 0);
+#endif
+	return sndcmd;
+}
+
+static int mpc5125_nand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
+			      int page)
+{
+//	unsigned int stat;
+	struct mpc5125_nfc_prv *prv = chip->priv;
+	mpc5125_nfc_command(mtd, NAND_CMD_READ0, 0, page);
+#if NFC_DMA_ENABLE
+	memcpy(prv->ops_buffer, chip->oob_poi, mtd->oobsize);
+#else
+	mpc5125_nfc_copy_spare(mtd, 0, chip->oob_poi, mtd->oobsize, 1);
+#endif
+	mpc5125_nfc_command(mtd, NAND_CMD_PAGEPROG, 0, page);
+
+	if (prv->wait_timeout) {
+		dev_err(prv->dev, "%s wait timeout.\n", __FUNCTION__);
+		return -EIO;
+	}
+	if (prv->irq_stat & WERR_IRQ_MASK) {
+		dev_err(prv->dev, "%s faield.\n", __FUNCTION__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int mpc5125_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
+			      uint8_t * buf, int page)
+{
+	unsigned int stat;
+	struct mpc5125_nfc_prv *prv = chip->priv;
+	u8 *erase_page_check, ecc_bytes = 0;
+	const u8 ecc_bytes_map[] = {0, 8, 12, 15, 23, 30, 45, 60};
+
+	stat = nfc_read(mtd, NFC_FLASH_CONFIG);
+	stat >>= 17;
+	stat &= 0x7;
+	ecc_bytes = ecc_bytes_map[stat];
+
+	erase_page_check = (u8 *)(PAGE_virtual_2K - ecc_bytes + prv->regs);
+	stat = nfc_read(mtd, MPC5125_NFC_ECC_STATUS_ADD + 4);
+
+	if (stat & 0x80) {
+		/*check the page is erased*/
+		if (stat & 0x3f) {
+			mtd->ecc_stats.failed++;
+			dev_warn(prv->dev, "Uncorrectable RS-ECC Error\n");
+		}
+
+	} else if (stat & 0x3f) {
+		/* dev_notice(prv->dev, "Correctable ECC %d\n", stat & 0x3f); */
+		mtd->ecc_stats.corrected += stat & 0x3f;
+	}
+
+#if NFC_DMA_ENABLE
+	memcpy(buf, prv->data_buffers, mtd->writesize);
+	memcpy(chip->oob_poi, prv->ops_buffer, mtd->oobsize);
+#else
+	mpc5125_nfc_buf_copy(mtd, buf, mtd->writesize, 0);
+	mpc5125_nfc_copy_spare(mtd, 0, chip->oob_poi, mtd->oobsize, 0);
+#endif
+
+	return 0;
+}
+
+static void mpc5125_nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
+				const uint8_t *buf)
+{
+#if NFC_DMA_ENABLE
+	struct mpc5125_nfc_prv *prv = chip->priv;
+	memcpy(prv->data_buffers, buf, mtd->writesize);
+	memcpy(prv->ops_buffer, chip->oob_poi, mtd->oobsize);
+#else
+	mpc5125_nfc_buf_copy(mtd, buf, mtd->writesize, 1);
+	mpc5125_nfc_copy_spare(mtd, 0, chip->oob_poi, mtd->oobsize, 1);
+#endif
+}
+
+static int chip_nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
+			   const uint8_t *buf, int page, int cached, int raw)
+{
+	int status;
+#if (NFC_DMA_ENABLE<1)
+	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
+#endif
+	if (unlikely(raw))
+		chip->ecc.write_page_raw(mtd, chip, buf);
+	else
+		chip->ecc.write_page(mtd, chip, buf);
+
+	/*
+	 * Cached progamming disabled for now, Not sure if its worth the
+	 * trouble. The speed gain is not very impressive. (2.3->2.6Mib/s)
+	 */
+	cached = 0;
+
+	if (!cached || !(chip->options & NAND_CACHEPRG)) {
+#if NFC_DMA_ENABLE
+		chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, 0x00, page);
+#else
+		chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+#endif
+
+		status = chip->waitfunc(mtd, chip);
+		/*
+		 * See if operation failed and additional status checks are
+		 * available
+		 */
+		if ((status & NAND_STATUS_FAIL) && (chip->errstat))
+			status = chip->errstat(mtd, chip, FL_WRITING, status,
+					       page);
+
+		if (status & NAND_STATUS_FAIL)
+			return -EIO;
+	} else {
+#if NFC_DMA_ENABLE
+		chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, 0x00, page);
+#else
+		chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+#endif
+		status = chip->waitfunc(mtd, chip);
+	}
+	if (nfc_get_field(mtd, NFC_IRQ_STATUS, WERR_IRQ_MASK|WERR_STATUS_MASK)) {
+		printk(KERN_ERR "%s line:%d write page %d failed\n", __FUNCTION__, __LINE__, page);
+		nfc_set_field(mtd, NFC_IRQ_STATUS,
+			WERR_CLEAR_MASK,
+			WERR_CLEAR_SHIFT, 1);
+		return -EIO;
+	}
+	return 0;
+}
+
+#if NFC_DMA_ENABLE
+static void mpc5125_dma_config(struct mtd_info *mtd,
+		struct nand_chip *chip, unsigned isRead)
+{
+	struct mpc5125_nfc_prv *prv = chip->priv;
+	nfc_write(mtd, NFC_DMA1_ADDR, prv->data_buffers_phyaddr);
+	nfc_write(mtd, NFC_DMA2_ADDR, prv->ops_buffer_phyaddr);
+
+	if (isRead)
+		nfc_set_field(mtd, NFC_FLASH_CONFIG,
+				CONFIG_DMA_REQ_MASK,
+				CONFIG_DMA_REQ_SHIFT, 1);
+	else
+		nfc_set_field(mtd, NFC_FLASH_CONFIG,
+				CONFIG_DMA_REQ_MASK,
+				CONFIG_DMA_REQ_SHIFT, 0);
+
+	nfc_set_field(mtd, NFC_FLASH_COMMAND_REPEAT,
+			COMMAND_REPEAT_MASK,
+			COMMAND_REPEAT_SHIFT, 0);
+	nfc_set_field(mtd, NFC_FLASH_CMD2, BUFNO_MASK,
+			BUFNO_SHIFT, 0);
+}
+
+static void mpc5125_nand_dma_wait(struct mtd_info *mtd,
+		struct nand_chip *chip)
+{
+	struct mpc5125_nfc_prv *prv = chip->priv;
+	int rv;
+
+	if ((DMA_BUSY_MASK|ECC_BUSY_MASK|RESIDUE_BUSY_MASK) &
+			nfc_read(mtd, NFC_IRQ_STATUS)) {
+		rv = wait_event_timeout(prv->irq_waitq,
+				(nfc_read(mtd, NFC_IRQ_STATUS) &
+				 (CMD_DONE_IRQ_MASK|IDLE_IRQ_MASK)) ==
+				(CMD_DONE_IRQ_MASK|IDLE_IRQ_MASK),
+				NFC_TIMEOUT * 4);
+		if (!rv) {
+			prv->irq_stat = nfc_read(mtd, NFC_IRQ_STATUS);
+			dev_err(prv->dev, "%s timeout status: %08x\n", __FUNCTION__, prv->irq_stat);
+			prv->wait_timeout = 1;
+		}
+	}
+}
+
+/**
+ * nand_read_page_raw - [Intern] read raw page data without ecc
+ * @mtd:	mtd info structure
+ * @chip:	nand chip info structure
+ * @buf:	buffer to store read data
+ */
+static int nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
+			      uint8_t *buf, int page)
+{
+	struct mpc5125_nfc_prv *prv = chip->priv;
+
+	memcpy(buf, prv->data_buffers, mtd->writesize);
+	memcpy(chip->oob_poi, prv->ops_buffer, mtd->oobsize);
+
+	return 0;
+}
+
+/**
+ * nand_write_page_raw - [Intern] raw page write function
+ * @mtd:	mtd info structure
+ * @chip:	nand chip info structure
+ * @buf:	data buffer
+ */
+static void nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
+				const uint8_t *buf)
+{
+	struct mpc5125_nfc_prv *prv = chip->priv;
+
+	memcpy(prv->data_buffers, buf, mtd->writesize);
+	memcpy(prv->ops_buffer, chip->oob_poi, mtd->oobsize);
+	mpc5125_dma_config(mtd, chip, 0);
+}
+#endif
+
+static int __devinit mpc5125_nfc_probe(struct platform_device *op)
+{
+	struct device_node *dn = op->dev.of_node;
+	struct device *dev = &op->dev;
+	struct mpc5125_nfc_prv *prv;
+	struct resource res;
+	struct mtd_info *mtd;
+#ifdef CONFIG_MTD_PARTITIONS
+	struct mtd_partition *parts;
+#endif
+	struct nand_chip *chip;
+	unsigned long regs_paddr, regs_size;
+	const __be32 *chips_no;
+	int retval = 0;
+	int len;
+
+	prv = devm_kzalloc(dev, sizeof(*prv), GFP_KERNEL);
+	if (!prv) {
+		dev_err(dev, "Memory exhausted!\n");
+		return -ENOMEM;
+	}
+
+	mtd = &prv->mtd;
+	chip = &prv->chip;
+
+	mtd->priv = chip;
+	chip->priv = prv;
+	prv->dev = dev;
+
+	/* Read NFC configuration from Reset Config Word */
+	retval = mpc5125_nfc_read_hw_config(mtd);
+	if (retval) {
+		dev_err(dev, "Unable to read NFC config!\n");
+		return retval;
+	}
+
+	/* speed up nand flash r/w add by cloudy */
+	{
+		volatile u32 *nfc_div = ioremap(0x80000f80, sizeof(u32));
+		if (!nfc_div)
+			dev_err(dev, "Unable to speed up nfc !\n");
+		else {
+#ifdef CONFIG_MTD_NAND_MPC5125_HWECC
+			*nfc_div = 0x1430 << 16;
+#else
+			*nfc_div = 0x2860 << 16;
+#endif
+			iounmap(nfc_div);
+		}
+	}
+
+	prv->irq = irq_of_parse_and_map(dn, 0);
+	if (prv->irq == NO_IRQ) {
+		dev_err(dev, "Error mapping IRQ!\n");
+		return -EINVAL;
+	}
+
+	retval = of_address_to_resource(dn, 0, &res);
+	if (retval) {
+		dev_err(dev, "Error parsing memory region!\n");
+		return retval;
+	}
+
+	chips_no = of_get_property(dn, "chips", &len);
+	if (!chips_no || len != sizeof(*chips_no)) {
+		dev_err(dev, "Invalid/missing 'chips' property!\n");
+		return -EINVAL;
+	}
+
+	regs_paddr = res.start;
+	regs_size = res.end - res.start + 1;
+
+	if (!devm_request_mem_region(dev, regs_paddr, regs_size, DRV_NAME)) {
+		dev_err(dev, "Error requesting memory region!\n");
+		return -EBUSY;
+	}
+
+	prv->regs = devm_ioremap(dev, regs_paddr, regs_size);
+	if (!prv->regs) {
+		dev_err(dev, "Error mapping memory region!\n");
+		return -ENOMEM;
+	}
+
+	prv->data_buffers = dma_alloc_coherent(dev, DATA_BUFFER_MAX_SIZE,
+                       &prv->data_buffers_phyaddr, GFP_KERNEL);
+	if (!prv->data_buffers) {
+		return -ENOMEM;
+	}
+
+	prv->ops_buffer = dma_alloc_coherent(dev, SPARE_BUFFER_MAX_SIZE,
+                       &prv->ops_buffer_phyaddr, GFP_KERNEL);
+	if (!prv->ops_buffer) {
+		dma_free_coherent(dev, DATA_BUFFER_MAX_SIZE,
+				prv->data_buffers, prv->data_buffers_phyaddr);
+		return -ENOMEM;
+	}
+
+	/* Enable NFC clock */
+	prv->clk = clk_get(dev, "nfc_clk");
+	if (!prv->clk) {
+		dev_err(dev, "Unable to acquire NFC clock!\n");
+		retval = -ENODEV;
+		goto error;
+	}
+
+	clk_enable(prv->clk);
+	init_waitqueue_head(&prv->irq_waitq);
+	retval = devm_request_irq(dev, prv->irq, &mpc5125_nfc_irq,
+			0, DRV_NAME, mtd);
+	if (retval) {
+		dev_err(dev, "Error requesting IRQ!\n");
+		goto error;
+	}
+
+	mtd->name = "MPC5125 NAND";
+	chip->write_page = chip_nand_write_page;
+	chip->dev_ready = mpc5125_nfc_dev_ready;
+	chip->cmdfunc = mpc5125_nfc_command;
+	chip->read_byte = mpc5125_nfc_read_byte;
+	chip->read_word = mpc5125_nfc_read_word;
+	chip->read_buf = mpc5125_nfc_read_buf;
+	chip->write_buf = mpc5125_nfc_write_buf;
+	chip->verify_buf = mpc5125_nfc_verify_buf;
+	chip->select_chip = ads5125_select_chip;
+	chip->options = NAND_NO_AUTOINCR | NAND_USE_FLASH_BBT | NAND_SKIP_BBTSCAN;
+
+#ifdef CONFIG_MTD_NAND_MPC5125_HWECC
+	chip->ecc.read_page = mpc5125_nand_read_page;
+	chip->ecc.write_page = mpc5125_nand_write_page;
+	chip->ecc.read_oob = mpc5125_nand_read_oob;
+	chip->ecc.write_oob = mpc5125_nand_write_oob;
+	chip->ecc.calculate = mpc5125_nand_calculate_ecc;
+	chip->ecc.hwctl = mpc5125_nand_enable_hwecc;
+	chip->ecc.correct = mpc5125_nand_correct_data;
+	chip->ecc.mode = NAND_ECC_HW;
+	chip->ecc.size = 512;	/* RS-ECC is applied for both MAIN+SPARE not MAIN alone */
+	chip->ecc.bytes = 9;	/* used for both main and spare area */
+	chip->ecc.layout = &nand_hw_eccoob_4k_128;
+
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+		CONFIG_ECC_SRAM_ADDR_MASK,
+		CONFIG_ECC_SRAM_ADDR_SHIFT,
+		(MPC5125_NFC_ECC_STATUS_ADD>>3) & 0x00001ff);
+
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+		CONFIG_ECC_MODE_MASK,
+		CONFIG_ECC_MODE_SHIFT, ECC_45_BYTE);
+
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+		CONFIG_CMD_TIMEOUT_MASK,
+		CONFIG_CMD_TIMEOUT_SHIFT, 0xf);
+
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+		CONFIG_ECC_SRAM_REQ_MASK,
+		CONFIG_ECC_SRAM_REQ_SHIFT, 1);
+
+#else
+#if NFC_DMA_ENABLE
+	chip->ecc.read_page_raw = nand_read_page_raw;
+	chip->ecc.write_page_raw = nand_write_page_raw;
+#endif
+	chip->ecc.mode = NAND_ECC_SOFT;
+	chip->ecc.layout = &nand_hw_eccoob_4k_128;
+
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+		CONFIG_ECC_MODE_MASK,
+		CONFIG_ECC_MODE_SHIFT, ECC_BYPASS);
+
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+		CONFIG_ECC_SRAM_REQ_MASK,
+		CONFIG_ECC_SRAM_REQ_SHIFT, 0);
+#endif /* CONFIG_MTD_NAND_MPC5125_HWECC */
+
+	/* SET SECTOR SIZE */
+	nfc_write(mtd, NFC_SECTOR_SIZE, PAGE_virtual_2K);
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+			CONFIG_PAGE_CNT_MASK,
+			CONFIG_PAGE_CNT_SHIFT, 2);
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+			CONFIG_ADDR_AUTO_INCR_MASK,
+			CONFIG_ADDR_AUTO_INCR_SHIFT, 0);
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+			CONFIG_BUFNO_AUTO_INCR_MASK,
+			CONFIG_BUFNO_AUTO_INCR_SHIFT, 1);
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+			CONFIG_16BIT_MASK,
+			CONFIG_16BIT_SHIFT, 0);
+
+#if NFC_DMA_ENABLE
+	nfc_set_field(mtd, NFC_DMA_CONFIG, DMA_CONFIG_DMA1_CNT_MASK,
+			DMA_CONFIG_DMA1_CNT_SHIFT, PAGE_2K);
+	nfc_set_field(mtd, NFC_DMA_CONFIG, DMA_CONFIG_DMA2_CNT_MASK,
+			DMA_CONFIG_DMA2_CNT_SHIFT, PAGE_64);
+	nfc_set_field(mtd, NFC_DMA_CONFIG, DMA_CONFIG_DMA1_ACT_MASK,
+			DMA_CONFIG_DMA1_ACT_SHIFT, 1);
+	nfc_set_field(mtd, NFC_DMA_CONFIG, DMA_CONFIG_DMA2_OFFSET_MASK,
+			DMA_CONFIG_DMA2_OFFSET_SHIFT, (PAGE_2K>>1));
+	nfc_set_field(mtd, NFC_DMA_CONFIG, DMA_CONFIG_DMA2_ACT_MASK,
+			DMA_CONFIG_DMA2_ACT_SHIFT, 1);
+#endif
+
+	/* SET FAST_FLASH = 1 */
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+			CONFIG_FAST_FLASH_MASK,
+			CONFIG_FAST_FLASH_SHIFT, 1);
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+			CONFIG_BOOT_MODE_MASK,
+			CONFIG_BOOT_MODE_SHIFT, 0);
+
+	/* Detect NAND chips */
+	if (nand_scan(mtd, be32_to_cpup(chips_no))) {
+		dev_err(dev, "NAND Flash not found !\n");
+		devm_free_irq(dev, prv->irq, mtd);
+		retval = -ENXIO;
+		goto error;
+	}
+
+	dev_set_drvdata(dev, mtd);
+
+	/* Register device in MTD */
+#ifdef CONFIG_MTD_PARTITIONS
+	retval = parse_mtd_partitions(mtd, mpc5125_nfc_pprobes, &parts, 0);
+#ifdef CONFIG_MTD_OF_PARTS
+	if (retval == 0)
+		retval = of_mtd_parse_partitions(dev, dn, &parts);
+#endif
+	if (retval < 0) {
+		dev_err(dev, "Error parsing MTD partitions!\n");
+		devm_free_irq(dev, prv->irq, mtd);
+		retval = -EINVAL;
+		goto error;
+	}
+
+	if (retval > 0)
+		retval = add_mtd_partitions(mtd, parts, retval);
+	else
+#endif
+		retval = add_mtd_device(mtd);
+
+	if (retval) {
+		dev_err(dev, "Error adding MTD device!\n");
+		devm_free_irq(dev, prv->irq, mtd);
+		goto error;
+	}
+
+	return 0;
+error:
+	dma_free_coherent(dev, DATA_BUFFER_MAX_SIZE, prv->data_buffers, prv->data_buffers_phyaddr);
+	dma_free_coherent(dev, SPARE_BUFFER_MAX_SIZE, prv->ops_buffer, prv->ops_buffer_phyaddr);
+	mpc5125_nfc_free(dev, mtd);
+	return retval;
+}
+
+static int __exit mpc5125_nfc_remove(struct platform_device *op)
+{
+	struct device *dev = &op->dev;
+	struct mtd_info *mtd = dev_get_drvdata(dev);
+	struct nand_chip *chip = mtd->priv;
+	struct mpc5125_nfc_prv *prv = chip->priv;
+
+	nand_release(mtd);
+	devm_free_irq(dev, prv->irq, mtd);
+	dma_free_coherent(dev, DATA_BUFFER_MAX_SIZE, prv->data_buffers, prv->data_buffers_phyaddr);
+	dma_free_coherent(dev, SPARE_BUFFER_MAX_SIZE, prv->ops_buffer, prv->ops_buffer_phyaddr);
+	mpc5125_nfc_free(dev, mtd);
+
+	return 0;
+}
+
+static struct of_device_id mpc5125_nfc_match[] __devinitdata = {
+	{ .compatible = "fsl,mpc5125-nfc", },
+	{},
+};
+
+static struct platform_driver mpc5125_nfc_driver = {
+	.probe		= mpc5125_nfc_probe,
+	.remove		= __devexit_p(mpc5125_nfc_remove),
+	.driver		= {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = mpc5125_nfc_match,
+	},
+};
+
+static int __init mpc5125_nfc_init(void)
+{
+	return platform_driver_register(&mpc5125_nfc_driver);
+}
+
+module_init(mpc5125_nfc_init);
+
+static void __exit mpc5125_nfc_cleanup(void)
+{
+	platform_driver_unregister(&mpc5125_nfc_driver);
+}
+
+module_exit(mpc5125_nfc_cleanup);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("MPC5125 NAND MTD driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mtd/nand/mpc5125_nfc.h b/drivers/mtd/nand/mpc5125_nfc.h
new file mode 100644
index 0000000..5cb312c
--- /dev/null
+++ b/drivers/mtd/nand/mpc5125_nfc.h
@@ -0,0 +1,293 @@
+/*
+ * Copyright (C) 2009 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: Shaohui Xie <b21989@freescale.com>
+ *
+ * Description:
+ * MPC5125 Nand driver.
+ *
+ * This is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef MPC5125_NFC_H
+#define MPC5125_NFC_H
+
+/* Addresses for NFC MAIN RAM BUFFER areas */
+#define NFC_MAIN_AREA(n)	((n) *  0x1000)
+
+/* Addresses for NFC SPARE BUFFER areas */
+#define NFC_SPARE_BUFFERS		8
+#define NFC_SPARE_LEN			0x10
+#define NFC_SPARE_AREA(n)		(0x800 + NFC_MAIN_AREA(n))
+
+#define PAGE_2K                   	0x0800
+#define PAGE_virtual_2K          0x0840
+#define PAGE_64                   	0x0040
+
+/* MPC5125 NFC registers */
+/* Typical Flash Commands */
+#define READ_PAGE_CMD_CODE		0x7EE0
+#define DMA_READ_PAGE_CMD_CODE		0x7EE0
+#define PROGRAM_PAGE_CMD_CODE		0x7FC0
+#define ERASE_CMD_CODE			0x4EC0
+#define READ_ID_CMD_CODE		0x4804
+#define RESET_CMD_CODE			0x4040
+#define DMA_PROGRAM_PAGE_CMD_CODE	0xFFC0
+#define RANDOM_IN_CMD_CODE		0x7140
+#define RANDOM_OUT_CMD_CODE		0x70E0
+#define STATUS_READ_CMD_CODE		0x4068
+
+#define PAGE_READ_CMD_BYTE1		0x00
+#define PAGE_READ_CMD_BYTE2		0x30
+#define PROGRAM_PAGE_CMD_BYTE1		0x80
+#define PROGRAM_PAGE_CMD_BYTE2		0x10
+#define READ_STATUS_CMD_BYTE		0x70
+#define ERASE_CMD_BYTE1		0x60
+#define ERASE_CMD_BYTE2		0xD0
+#define READ_ID_CMD_BYTE		0x90
+#define RESET_CMD_BYTE			0xFF
+#define RANDOM_OUT_CMD_BYTE1		0x05
+#define RANDOM_OUT_CMD_BYTE2		0xE0
+
+/* NFC ECC mode define */
+#define ECC_BYPASS			0x0
+#define ECC_8_BYTE			0x1
+#define ECC_12_BYTE			0x2
+#define ECC_15_BYTE			0x3
+#define ECC_23_BYTE			0x4
+#define ECC_30_BYTE			0x5
+#define ECC_45_BYTE			0x6
+#define ECC_60_BYTE			0x7
+#define ECC_ERROR			1
+#define ECC_RIGHT			0
+
+/***************** Module-Relative Register Offsets *************************/
+#define NFC_SRAM_BUFFER                0x0000
+#define NFC_FLASH_CMD1 		0x3F00
+#define NFC_FLASH_CMD2			0x3F04
+#define NFC_COL_ADDR			0x3F08
+#define NFC_ROW_ADDR			0x3F0c
+#define NFC_FLASH_COMMAND_REPEAT	0x3F10
+#define NFC_ROW_ADDR_INC		0x3F14
+#define NFC_FLASH_STATUS1		0x3F18
+#define NFC_FLASH_STATUS2		0x3F1c
+#define NFC_DMA1_ADDR			0x3F20
+#define NFC_DMA2_ADDR			0x3F34
+#define NFC_DMA_CONFIG			0x3F24
+#define NFC_CACHE_SWAP			0x3F28
+#define NFC_SECTOR_SIZE		0x3F2c
+#define NFC_FLASH_CONFIG		0x3F30
+#define NFC_IRQ_STATUS			0x3F38
+
+/***************** Module-Relative Register Reset Value *********************/
+#define NFC_SRAM_BUFFER_RSTVAL                	0x00000000
+#define NFC_FLASH_CMD1_RSTVAL 			0x30FF0000
+#define NFC_FLASH_CMD2_RSTVAL			0x007EE000
+#define NFC_COL_ADDR_RSTVAL			0x00000000
+#define NFC_ROW_ADDR_RSTVAL			0x11000000
+#define NFC_FLASH_COMMAND_REPEAT_RSTVAL	0x00000000
+#define NFC_ROW_ADDR_INC_RSTVAL		0x00000001
+#define NFC_FLASH_STATUS1_RSTVAL		0x00000000
+#define NFC_FLASH_STATUS2_RSTVAL		0x00000000
+#define NFC_DMA1_ADDR_RSTVAL			0x00000000
+#define NFC_DMA2_ADDR_RSTVAL			0x00000000
+#define NFC_DMA_CONFIG_RSTVAL			0x00000000
+#define NFC_CACHE_SWAP_RSTVAL			0x0FFE0FFE
+#define NFC_SECTOR_SIZE_RSTVAL			0x00000420
+#define NFC_FLASH_CONFIG_RSTVAL		0x000EA631
+#define NFC_IRQ_STATUS_RSTVAL			0x04000000
+
+/***************** Module-Relative Register Mask *************************/
+
+/* NFC_FLASH_CMD1 Field */
+#define CMD1_MASK				0xFFFF0000
+#define CMD1_SHIFT				0
+#define CMD_BYTE2_MASK    			0xFF000000
+#define CMD_BYTE2_SHIFT   			24
+#define CMD_BYTE3_MASK    			0x00FF0000
+#define CMD_BYTE3_SHIFT   			16
+
+/* NFC_FLASH_CM2 Field */
+#define CMD2_MASK				0xFFFFFF07
+#define CMD2_SHIFT				0
+#define CMD_BYTE1_MASK			    	0xFF000000
+#define CMD_BYTE1_SHIFT   			24
+#define CMD_CODE_MASK				0x00FFFF00
+#define CMD_CODE_SHIFT				8
+#define BUFNO_MASK				0x00000006
+#define BUFNO_SHIFT				1
+#define BUSY_MASK				0x00000001
+#define BUSY_SHIFT				0
+#define START_MASK				0x00000001
+#define START_SHIFT				0
+
+/* NFC_COL_ADDR Field */
+#define COL_ADDR_MASK				0x0000FFFF
+#define COL_ADDR_SHIFT				0
+#define COL_ADDR_COL_ADDR2_MASK		0x0000FF00
+#define COL_ADDR_COL_ADDR2_SHIFT		8
+#define COL_ADDR_COL_ADDR1_MASK		0x000000FF
+#define COL_ADDR_COL_ADDR1_SHIFT		0
+
+/* NFC_ROW_ADDR Field */
+#define ROW_ADDR_MASK				0x00FFFFFF
+#define ROW_ADDR_SHIFT				0
+#define ROW_ADDR_CHIP_SEL_RB_MASK		0xF0000000
+#define ROW_ADDR_CHIP_SEL_RB_SHIFT		28
+#define ROW_ADDR_CHIP_SEL_MASK			0x0F000000
+#define ROW_ADDR_CHIP_SEL_SHIFT		24
+#define ROW_ADDR_ROW_ADDR3_MASK		0x00FF0000
+#define ROW_ADDR_ROW_ADDR3_SHIFT		16
+#define ROW_ADDR_ROW_ADDR2_MASK		0x0000FF00
+#define ROW_ADDR_ROW_ADDR2_SHIFT		8
+#define ROW_ADDR_ROW_ADDR1_MASK		0x000000FF
+#define ROW_ADDR_ROW_ADDR1_SHIFT		0
+
+/* NFC_FLASH_COMMAND_REPEAT Field */
+#define COMMAND_REPEAT_MASK			0x0000FFFF
+#define COMMAND_REPEAT_SHIFT			0
+#define COMMAND_REPEAT_REPEAT_COUNT_MASK	0x0000FFFF
+#define COMMAND_REPEAT_REPEAT_COUNT_SHIFT	0
+
+/* NFC_ROW_ADDR_INC Field */
+#define ROW_ADDR_INC_MASK			0x00FFFFFF
+#define ROW_ADDR_INC_SHIFT			0
+#define ROW_ADDR_INC_ROW_ADDR3_INC_MASK	0x00FF0000
+#define ROW_ADDR_INC_ROW_ADDR3_INC_SHIFT	16
+#define ROW_ADDR_INC_ROW_ADDR2_INC_MASK	0x0000FF00
+#define ROW_ADDR_INC_ROW_ADDR2_INC_SHIFT	8
+#define ROW_ADDR_INC_ROW_ADDR1_INC_MASK	0x000000FF
+#define ROW_ADDR_INC_ROW_ADDR1_INC_SHIFT	0
+
+/* NFC_FLASH_STATUS1 Field */
+#define STATUS1_MASK				0xFFFFFFFF
+#define STATUS1_SHIFT				0
+#define STATUS1_ID_BYTE1_MASK			0xFF000000
+#define STATUS1_ID_BYTE1_SHIFT			24
+#define STATUS1_ID_BYTE2_MASK			0x00FF0000
+#define STATUS1_ID_BYTE2_SHIFT			16
+#define STATUS1_ID_BYTE3_MASK			0x0000FF00
+#define STATUS1_ID_BYTE3_SHIFT			8
+#define STATUS1_ID_BYTE4_MASK			0x000000FF
+#define STATUS1_ID_BYTE4_SHIFT			0
+
+/* NFC_FLASH_STATUS2 Field */
+#define STATUS2_MASK				0xFF0000FF
+#define STATUS2_SHIFT				0
+#define STATUS2_ID_BYTE5_MASK			0xFF000000
+#define STATUS2_ID_BYTE5_SHIFT			24
+#define STATUS_BYTE1_MASK			0x000000FF
+#define STATUS2_STATUS_BYTE1_SHIFT		0
+
+/* NFC_DMA1_ADDR Field */
+#define DMA1_ADDR_MASK				0xFFFFFFFF
+#define DMA1_ADDR_SHIFT			0
+#define DMA1_ADDR_DMA1_ADDR_MASK		0xFFFFFFFF
+#define DMA1_ADDR_DMA1_ADDR_SHIFT		0
+
+/* DMA2_ADDR Field */
+#define DMA2_ADDR_MASK				0xFFFFFFFF
+#define DMA2_ADDR_SHIFT			0
+#define DMA2_ADDR_DMA2_ADDR_MASK		0xFFFFFFFF
+#define DMA2_ADDR_DMA2_ADDR_SHIFT		0
+
+/* DMA_CONFIG Field */
+#define DMA_CONFIG_MASK			0xFFFFFFFF
+#define DMA_CONFIG_SHIFT			0
+#define DMA_CONFIG_DMA1_CNT_MASK		0xFFF00000
+#define DMA_CONFIG_DMA1_CNT_SHIFT		20
+#define DMA_CONFIG_DMA2_CNT_MASK		0x000FE000
+#define DMA_CONFIG_DMA2_CNT_SHIFT		13
+#define DMA_CONFIG_DMA2_OFFSET_MASK		0x00001FC0
+#define DMA_CONFIG_DMA2_OFFSET_SHIFT		2
+#define DMA_CONFIG_DMA1_ACT_MASK		0x00000002
+#define DMA_CONFIG_DMA1_ACT_SHIFT		1
+#define DMA_CONFIG_DMA2_ACT_MASK		0x00000001
+#define DMA_CONFIG_DMA2_ACT_SHIFT		0
+
+/* NFC_CACHE_SWAP Field */
+#define CACHE_SWAP_MASK			0x0FFE0FFE
+#define CACHE_SWAP_SHIFT			1
+#define CACHE_SWAP_CACHE_SWAP_ADDR2_MASK	0x0FFE0000
+#define CACHE_SWAP_CACHE_SWAP_ADDR2_SHIFT	17
+#define CACHE_SWAP_CACHE_SWAP_ADDR1_MASK	0x00000FFE
+#define CACHE_SWAP_CACHE_SWAP_ADDR1_SHIFT	1
+
+/* NFC_SECTOR_SIZE Field */
+#define SECTOR_SIZE_MASK			0x00001FFF
+#define SECTOR_SIZE_SHIFT			0
+#define SECTOR_SIZE_SECTOR_SIZE_MASK		0x00001FFF
+#define SECTOR_SIZE_SECTOR_SIZE_SHIFT		0
+
+/* NFC_FLASH_CONFIG Field */
+#define CONFIG_MASK				0xFFFFFFFF
+#define CONFIG_SHIFT				0
+#define CONFIG_STOP_ON_WERR_MASK		0x80000000
+#define CONFIG_STOP_ON_WERR_SHIFT		31
+#define CONFIG_ECC_SRAM_ADDR_MASK		0x7FC00000
+#define CONFIG_ECC_SRAM_ADDR_SHIFT		22
+#define CONFIG_ECC_SRAM_REQ_MASK		0x00200000
+#define CONFIG_ECC_SRAM_REQ_SHIFT		21
+#define CONFIG_DMA_REQ_MASK			0x00100000
+#define CONFIG_DMA_REQ_SHIFT			20
+#define CONFIG_ECC_MODE_MASK			0x000E0000
+#define CONFIG_ECC_MODE_SHIFT			17
+#define CONFIG_FAST_FLASH_MASK			0x00010000
+#define CONFIG_FAST_FLASH_SHIFT		16
+#define CONFIG_ID_COUNT_MASK			0x0000E000
+#define CONFIG_ID_COUNT_SHIFT			13
+#define CONFIG_CMD_TIMEOUT_MASK		0x00001F00
+#define CONFIG_CMD_TIMEOUT_SHIFT		8
+#define CONFIG_16BIT_MASK			0x00000080
+#define CONFIG_16BIT_SHIFT			7
+#define CONFIG_BOOT_MODE_MASK			0x00000040
+#define CONFIG_BOOT_MODE_SHIFT			6
+#define CONFIG_ADDR_AUTO_INCR_MASK		0x00000020
+#define CONFIG_ADDR_AUTO_INCR_SHIFT		5
+#define CONFIG_BUFNO_AUTO_INCR_MASK		0x00000010
+#define CONFIG_BUFNO_AUTO_INCR_SHIFT		4
+#define CONFIG_PAGE_CNT_MASK			0x0000000F
+#define CONFIG_PAGE_CNT_SHIFT			0
+
+/* NFC_IRQ_STATUS Field */
+#define MASK					0xEFFC003F
+#define SHIFT					0
+#define WERR_IRQ_MASK				0x80000000
+#define WERR_IRQ_SHIFT				31
+#define CMD_DONE_IRQ_MASK			0x40000000
+#define CMD_DONE_IRQ_SHIFT			30
+#define IDLE_IRQ_MASK				0x20000000
+#define IDLE_IRQ_SHIFT				29
+#define WERR_STATUS_MASK			0x08000000
+#define WERR_STATUS_SHIFT			27
+#define FLASH_CMD_BUSY_MASK			0x04000000
+#define FLASH_CMD_BUSY_SHIFT			26
+#define RESIDUE_BUSY_MASK			0x02000000
+#define RESIDUE_BUSY_SHIFT			25
+#define ECC_BUSY_MASK				0x01000000
+#define ECC_BUSY_SHIFT				24
+#define DMA_BUSY_MASK				0x00800000
+#define DMA_BUSY_SHIFT				23
+#define WERR_EN_MASK				0x00400000
+#define WERR_EN_SHIFT				22
+#define CMD_DONE_EN_MASK			0x00200000
+#define CMD_DONE_EN_SHIFT			21
+#define IDLE_EN_MASK				0x00100000
+#define IDLE_EN_SHIFT				20
+#define WERR_CLEAR_MASK			0x00080000
+#define WERR_CLEAR_SHIFT			19
+#define CMD_DONE_CLEAR_MASK			0x00040000
+#define CMD_DONE_CLEAR_SHIFT			18
+#define IDLE_CLEAR_MASK			0x00020000
+#define IDLE_CLEAR_SHIFT			17
+#define RESIDUE_BUFF_NO_MASK			0x00000030
+#define RESIDUE_BUFF_NO_SHIFT			4
+#define ECC_BUFF_NO_MASK			0x000000C0
+#define ECC_BUFF_NO_SHIFT			2
+#define DMA_BUFF_NO_MASK			0x00000003
+
+#endif /* MPC5125_NFC_H */
+
diff --git a/drivers/mtd/nand/nand_ids.c b/drivers/mtd/nand/nand_ids.c
index 00cf1b0..6755191 100644
--- a/drivers/mtd/nand/nand_ids.c
+++ b/drivers/mtd/nand/nand_ids.c
@@ -66,6 +66,8 @@ struct nand_flash_dev nand_flash_ids[] = {
 
 	{"NAND 256MiB 3,3V 8-bit",	0x71, 512, 256, 0x4000, 0},
 
+	{"NAND 4GiB 3,3V 8-bit",	0x68, 4096, 4096, 0x100000, 0},
+
 	/*
 	 * These are the new chips with large page size. The pagesize and the
 	 * erasesize is determined from the extended id bytes
