Return-Path: <B32579@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D3C72C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 18:55:25 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linux-mtd@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] driver/mtd:IFC NAND:Initialise internal SRAM before any write
Date: Thu, 13 Sep 2012 14:24:49 +0530
Message-ID: <1347526489-20186-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Prabhakar Kushwaha <prabhakar@freescale.com>,
 dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IFC-1.1.0 uses 28nm techenology for SRAM. This tech has known limitaion for
SRAM i.e. "byte select" is not supported. Hence Read Modify Write is
implemented in IFC for any "system side write" into sram buffer. Reading an
uninitialized memory results in ECC Error from sram wrapper.

Hence we must initialize/prefill SRAM buffer by any data before writing
anything in SRAM from system side. To initialize SRAM user can use "READID"
NAND command with read bytes equal to SRAM size. It will be a one time
activity post boot.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.infradead.org/linux-mtd.git branch master
 The compilation of this patch depends upon following patch.
 http://patchwork.ozlabs.org/patch/177893/
 This patch is currently applied on git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git 
 branch next and status is "Awaiting Upstream"


 drivers/mtd/nand/fsl_ifc_nand.c |   56 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 1f71b54..3d15b92 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -31,6 +31,7 @@
 #include <linux/mtd/nand_ecc.h>
 #include <asm/fsl_ifc.h>
 
+#define FSL_IFC_V1_1_0	0x01010000
 #define ERR_BYTE		0xFF /* Value returned for read
 					bytes when read failed	*/
 #define IFC_TIMEOUT_MSECS	500  /* Maximum number of mSecs to wait
@@ -775,13 +776,62 @@ static int fsl_ifc_chip_init_tail(struct mtd_info *mtd)
 	return 0;
 }
 
+static void fsl_ifc_sram_init(struct fsl_ifc_mtd *priv)
+{
+	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
+	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
+	uint32_t csor = 0, csor_8k = 0, csor_ext = 0;
+	uint32_t cs = priv->bank;
+
+	/* Save CSOR and CSOR_ext */
+	csor = in_be32(&ifc->csor_cs[cs].csor);
+	csor_ext = in_be32(&ifc->csor_cs[cs].csor_ext);
+
+	/* chage PageSize 8K and SpareSize 1K*/
+	csor_8k = (csor & ~(CSOR_NAND_PGS_MASK)) | 0x0018C000;
+	out_be32(&ifc->csor_cs[cs].csor, csor_8k);
+	out_be32(&ifc->csor_cs[cs].csor_ext, 0x0000400);
+
+	/* READID */
+	out_be32(&ifc->ifc_nand.nand_fir0,
+			(IFC_FIR_OP_CMD0 << IFC_NAND_FIR0_OP0_SHIFT) |
+			(IFC_FIR_OP_UA  << IFC_NAND_FIR0_OP1_SHIFT) |
+			(IFC_FIR_OP_RB << IFC_NAND_FIR0_OP2_SHIFT));
+	out_be32(&ifc->ifc_nand.nand_fcr0,
+			NAND_CMD_READID << IFC_NAND_FCR0_CMD0_SHIFT);
+	out_be32(&ifc->ifc_nand.row3, 0x0);
+
+	out_be32(&ifc->ifc_nand.nand_fbcr, 0x0);
+
+	/* Program ROW0/COL0 */
+	out_be32(&ifc->ifc_nand.row0, 0x0);
+	out_be32(&ifc->ifc_nand.col0, 0x0);
+
+	/* set the chip select for NAND Transaction */
+	out_be32(&ifc->ifc_nand.nand_csel, cs << IFC_NAND_CSEL_SHIFT);
+
+	/* start read seq */
+	out_be32(&ifc->ifc_nand.nandseq_strt, IFC_NAND_SEQ_STRT_FIR_STRT);
+
+	/* wait for command complete flag or timeout */
+	wait_event_timeout(ctrl->nand_wait, ctrl->nand_stat,
+			   IFC_TIMEOUT_MSECS * HZ/1000);
+
+	if (ctrl->nand_stat != IFC_NAND_EVTER_STAT_OPC)
+		printk(KERN_ERR "fsl-ifc: Failed to Initialise SRAM\n");
+
+	/* Restore CSOR and CSOR_ext */
+	out_be32(&ifc->csor_cs[cs].csor, csor);
+	out_be32(&ifc->csor_cs[cs].csor_ext, csor_ext);
+}
+
 static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 {
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
 	struct nand_chip *chip = &priv->chip;
 	struct nand_ecclayout *layout;
-	u32 csor;
+	u32 csor, ver;
 
 	/* Fill in fsl_ifc_mtd structure */
 	priv->mtd.priv = chip;
@@ -875,6 +925,10 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 		chip->ecc.mode = NAND_ECC_SOFT;
 	}
 
+	ver = in_be32(&ifc->ifc_rev);
+	if (ver == FSL_IFC_V1_1_0)
+		fsl_ifc_sram_init(priv);
+
 	return 0;
 }
 
-- 
1.7.9.5
