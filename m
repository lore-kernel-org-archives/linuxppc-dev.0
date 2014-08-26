Return-Path: <asierra@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CC751A004D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 03:34:50 +1000 (EST)
Date: Tue, 26 Aug 2014 12:31:38 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <1720585700.271372.1409074298919.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <1991824361.262160.1409074072267.JavaMail.zimbra@xes-inc.com>
Subject: [PATCH v2] fsl_ifc: Support all 8 IFC chip selects
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Freescale's QorIQ T Series processors support 8 IFC chip selects
within a memory map backward compatible with previous P Series
processors which supported only 4 chip selects.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/memory/fsl_ifc.c        |  2 +-
 drivers/mtd/nand/fsl_ifc_nand.c | 17 ++++++++++-------
 include/linux/fsl_ifc.h         | 34 +++++++++++++++++++++++++---------
 3 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index 3d5d792..a539dc2 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -61,7 +61,7 @@ int fsl_ifc_find(phys_addr_t addr_base)
 	if (!fsl_ifc_ctrl_dev || !fsl_ifc_ctrl_dev->regs)
 		return -ENODEV;
 
-	for (i = 0; i < ARRAY_SIZE(fsl_ifc_ctrl_dev->regs->cspr_cs); i++) {
+	for (i = 0; i < fsl_ifc_bank_count(fsl_ifc_ctrl_dev->regs); i++) {
 		u32 cspr = in_be32(&fsl_ifc_ctrl_dev->regs->cspr_cs[i].cspr);
 		if (cspr & CSPR_V && (cspr & CSPR_BA) ==
 				convert_ifc_address(addr_base))
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 2338124..f7b7077 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -31,7 +31,6 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/fsl_ifc.h>
 
-#define FSL_IFC_V1_1_0	0x01010000
 #define ERR_BYTE		0xFF /* Value returned for read
 					bytes when read failed	*/
 #define IFC_TIMEOUT_MSECS	500  /* Maximum number of mSecs to wait
@@ -54,7 +53,7 @@ struct fsl_ifc_mtd {
 /* overview of the fsl ifc controller */
 struct fsl_ifc_nand_ctrl {
 	struct nand_hw_control controller;
-	struct fsl_ifc_mtd *chips[FSL_IFC_BANK_COUNT];
+	struct fsl_ifc_mtd *chips[FSL_IFC_BANK_COUNT_MAX];
 
 	void __iomem *addr;	/* Address of assigned IFC buffer	*/
 	unsigned int page;	/* Last page written to / read from	*/
@@ -877,7 +876,7 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
 	struct nand_chip *chip = &priv->chip;
 	struct nand_ecclayout *layout;
-	u32 csor, ver;
+	u32 csor;
 
 	/* Fill in fsl_ifc_mtd structure */
 	priv->mtd.priv = chip;
@@ -984,8 +983,7 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 		chip->ecc.mode = NAND_ECC_SOFT;
 	}
 
-	ver = ioread32be(&ifc->ifc_rev);
-	if (ver == FSL_IFC_V1_1_0)
+	if (fsl_ifc_version(ifc) == FSL_IFC_VERSION_1_1_0)
 		fsl_ifc_sram_init(priv);
 
 	return 0;
@@ -1044,13 +1042,18 @@ static int fsl_ifc_nand_probe(struct platform_device *dev)
 		return ret;
 	}
 
+	dev_info(&dev->dev, "IFC version %d.%d, %d banks\n",
+		fsl_ifc_version(ifc) >> 24,
+		(fsl_ifc_version(ifc) >> 16) & 0xf,
+		fsl_ifc_bank_count(ifc));
+
 	/* find which chip select it is connected to */
-	for (bank = 0; bank < FSL_IFC_BANK_COUNT; bank++) {
+	for (bank = 0; bank < fsl_ifc_bank_count(ifc); bank++) {
 		if (match_bank(ifc, bank, res.start))
 			break;
 	}
 
-	if (bank >= FSL_IFC_BANK_COUNT) {
+	if (bank >= fsl_ifc_bank_count(ifc)) {
 		dev_err(&dev->dev, "%s: address did not match any chip selects\n",
 			__func__);
 		return -ENODEV;
diff --git a/include/linux/fsl_ifc.h b/include/linux/fsl_ifc.h
index 84d60cb..7a92773 100644
--- a/include/linux/fsl_ifc.h
+++ b/include/linux/fsl_ifc.h
@@ -29,7 +29,16 @@
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 
-#define FSL_IFC_BANK_COUNT 4
+/*
+ * The actual number of banks implemented depends on the IFC version
+ *    - IFC version 1.0 implements 4 banks.
+ *    - IFC version 1.1 onward implements 8 banks.
+ */
+#define FSL_IFC_BANK_COUNT_MAX 8
+
+#define FSL_IFC_VERSION_MASK	0x0F0F0000
+#define FSL_IFC_VERSION_1_0_0	0x01000000
+#define FSL_IFC_VERSION_1_1_0	0x01010000
 
 /*
  * CSPR - Chip Select Property Register
@@ -775,24 +784,24 @@ struct fsl_ifc_regs {
 		__be32 cspr_ext;
 		__be32 cspr;
 		u32 res2;
-	} cspr_cs[FSL_IFC_BANK_COUNT];
-	u32 res3[0x19];
+	} cspr_cs[FSL_IFC_BANK_COUNT_MAX];
+	u32 res3[0xd];
 	struct {
 		__be32 amask;
 		u32 res4[0x2];
-	} amask_cs[FSL_IFC_BANK_COUNT];
-	u32 res5[0x18];
+	} amask_cs[FSL_IFC_BANK_COUNT_MAX];
+	u32 res5[0xc];
 	struct {
 		__be32 csor;
 		__be32 csor_ext;
 		u32 res6;
-	} csor_cs[FSL_IFC_BANK_COUNT];
-	u32 res7[0x18];
+	} csor_cs[FSL_IFC_BANK_COUNT_MAX];
+	u32 res7[0xc];
 	struct {
 		__be32 ftim[4];
 		u32 res8[0x8];
-	} ftim_cs[FSL_IFC_BANK_COUNT];
-	u32 res9[0x60];
+	} ftim_cs[FSL_IFC_BANK_COUNT_MAX];
+	u32 res9[0x30];
 	__be32 rb_stat;
 	u32 res10[0x2];
 	__be32 ifc_gcr;
@@ -834,5 +843,12 @@ struct fsl_ifc_ctrl {
 
 extern struct fsl_ifc_ctrl *fsl_ifc_ctrl_dev;
 
+static inline u32 fsl_ifc_version(struct fsl_ifc_regs *regs) {
+	return ioread32be(&regs->ifc_rev) & FSL_IFC_VERSION_MASK;
+}
+
+static inline int fsl_ifc_bank_count(struct fsl_ifc_regs *regs) {
+	return (fsl_ifc_version(regs) == FSL_IFC_VERSION_1_0_0) ? 4 : 8;
+}
 
 #endif /* __ASM_FSL_IFC_H */
-- 
1.9.1
