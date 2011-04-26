Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33886B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Apr 2011 19:35:52 +1000 (EST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/44x: Add multiple chip select support to NDFC driver
Date: Tue, 26 Apr 2011 12:36:46 +0300
Message-Id: <1303810606-2068-1-git-send-email-felix@embedded-sol.com>
Cc: Felix Radensky <felix@embedded-sol.com>, sr@denx.de,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch extends NDFC driver to support all 4 chip selects
available in NDFC NAND controller. Tested on custom 460EX board
with 2 chip select NAND device.

Signed-off-by: Felix Radensky <felix@embedded-sol.com>
---

I'd appreciate some testing on 44x boards with multiple NAND
devices, like bamboo or DU440, as I don't have access to these 
boards.

 drivers/mtd/nand/ndfc.c |   52 +++++++++++++++++++++++++++++++---------------
 1 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index bbe6d45..5e0be1e 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -33,6 +33,7 @@
 #include <linux/of_platform.h>
 #include <asm/io.h>
 
+#define NDFC_MAX_CS    4
 
 struct ndfc_controller {
 	struct platform_device *ofdev;
@@ -46,12 +47,13 @@ struct ndfc_controller {
 #endif
 };
 
-static struct ndfc_controller ndfc_ctrl;
+static struct ndfc_controller ndfc_ctrl[NDFC_MAX_CS];
 
 static void ndfc_select_chip(struct mtd_info *mtd, int chip)
 {
 	uint32_t ccr;
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct nand_chip *nchip = mtd->priv;
+	struct ndfc_controller *ndfc = nchip->priv;
 
 	ccr = in_be32(ndfc->ndfcbase + NDFC_CCR);
 	if (chip >= 0) {
@@ -64,7 +66,8 @@ static void ndfc_select_chip(struct mtd_info *mtd, int chip)
 
 static void ndfc_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct nand_chip *chip = mtd->priv;
+	struct ndfc_controller *ndfc = chip->priv;
 
 	if (cmd == NAND_CMD_NONE)
 		return;
@@ -77,7 +80,8 @@ static void ndfc_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 
 static int ndfc_ready(struct mtd_info *mtd)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct nand_chip *chip = mtd->priv;
+	struct ndfc_controller *ndfc = chip->priv;
 
 	return in_be32(ndfc->ndfcbase + NDFC_STAT) & NDFC_STAT_IS_READY;
 }
@@ -85,7 +89,8 @@ static int ndfc_ready(struct mtd_info *mtd)
 static void ndfc_enable_hwecc(struct mtd_info *mtd, int mode)
 {
 	uint32_t ccr;
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct nand_chip *chip = mtd->priv;
+	struct ndfc_controller *ndfc = chip->priv;
 
 	ccr = in_be32(ndfc->ndfcbase + NDFC_CCR);
 	ccr |= NDFC_CCR_RESET_ECC;
@@ -96,7 +101,8 @@ static void ndfc_enable_hwecc(struct mtd_info *mtd, int mode)
 static int ndfc_calculate_ecc(struct mtd_info *mtd,
 			      const u_char *dat, u_char *ecc_code)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct nand_chip *chip = mtd->priv;
+	struct ndfc_controller *ndfc = chip->priv;
 	uint32_t ecc;
 	uint8_t *p = (uint8_t *)&ecc;
 
@@ -119,7 +125,8 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
  */
 static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct nand_chip *chip = mtd->priv;
+	struct ndfc_controller *ndfc = chip->priv;
 	uint32_t *p = (uint32_t *) buf;
 
 	for(;len > 0; len -= 4)
@@ -128,7 +135,8 @@ static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 
 static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct nand_chip *chip = mtd->priv;
+	struct ndfc_controller *ndfc = chip->priv;
 	uint32_t *p = (uint32_t *) buf;
 
 	for(;len > 0; len -= 4)
@@ -137,7 +145,8 @@ static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 
 static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct nand_chip *chip = mtd->priv;
+	struct ndfc_controller *ndfc = chip->priv;
 	uint32_t *p = (uint32_t *) buf;
 
 	for(;len > 0; len -= 4)
@@ -179,6 +188,7 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 	chip->ecc.mode = NAND_ECC_HW;
 	chip->ecc.size = 256;
 	chip->ecc.bytes = 3;
+	chip->priv = ndfc;
 
 	ndfc->mtd.priv = chip;
 	ndfc->mtd.owner = THIS_MODULE;
@@ -227,15 +237,10 @@ err:
 
 static int __devinit ndfc_probe(struct platform_device *ofdev)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct ndfc_controller *ndfc;
 	const __be32 *reg;
 	u32 ccr;
-	int err, len;
-
-	spin_lock_init(&ndfc->ndfc_control.lock);
-	init_waitqueue_head(&ndfc->ndfc_control.wq);
-	ndfc->ofdev = ofdev;
-	dev_set_drvdata(&ofdev->dev, ndfc);
+	int err, len, cs;
 
 	/* Read the reg property to get the chip select */
 	reg = of_get_property(ofdev->dev.of_node, "reg", &len);
@@ -243,8 +248,21 @@ static int __devinit ndfc_probe(struct platform_device *ofdev)
 		dev_err(&ofdev->dev, "unable read reg property (%d)\n", len);
 		return -ENOENT;
 	}
-	ndfc->chip_select = be32_to_cpu(reg[0]);
 
+	cs = be32_to_cpu(reg[0]);
+	if (cs >= NDFC_MAX_CS) {
+		dev_err(&ofdev->dev, "invalid CS number (%d)\n", cs);
+		return -EINVAL;
+	}
+
+	ndfc = &ndfc_ctrl[cs];
+	ndfc->chip_select = cs;
+
+	spin_lock_init(&ndfc->ndfc_control.lock);
+	init_waitqueue_head(&ndfc->ndfc_control.wq);
+	ndfc->ofdev = ofdev;
+	dev_set_drvdata(&ofdev->dev, ndfc);
+	
 	ndfc->ndfcbase = of_iomap(ofdev->dev.of_node, 0);
 	if (!ndfc->ndfcbase) {
 		dev_err(&ofdev->dev, "failed to get memory\n");
-- 
1.7.4.4
