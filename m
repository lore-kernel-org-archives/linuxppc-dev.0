Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 8AAC4DDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 20:12:33 +1100 (EST)
From: Wolfgang Grandegegr <wg@grandegger.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCH 1/4] NAND: FSL-UPM: add multi chip support
Date: Tue, 17 Mar 2009 10:12:19 +0100
Message-Id: <1237281143-8768-2-git-send-email-wg@grandegger.com>
In-Reply-To: <1237281143-8768-1-git-send-email-wg@grandegger.com>
References: <1237281143-8768-1-git-send-email-wg@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Wolfgang Grandegger <wg@grandegger.com>

This patch adds support for multi-chip NAND devices to the FSL-UPM
driver. This requires support for multiple GPIOs for the RNB pins.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/mtd/nand/fsl_upm.c |   90 +++++++++++++++++++++++++++++++++----------
 1 files changed, 69 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 7815a40..ca7e85a 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -23,6 +23,8 @@
 #include <linux/io.h>
 #include <asm/fsl_lbc.h>
 
+#define FSL_UPM_NAND_MAX_CHIPS 4
+
 struct fsl_upm_nand {
 	struct device *dev;
 	struct mtd_info mtd;
@@ -36,8 +38,11 @@ struct fsl_upm_nand {
 	uint8_t upm_addr_offset;
 	uint8_t upm_cmd_offset;
 	void __iomem *io_base;
-	int rnb_gpio;
+	int rnb_gpio[FSL_UPM_NAND_MAX_CHIPS];
 	int chip_delay;
+	uint32_t max_chips;
+	uint32_t chip_number;
+	uint32_t chip_offset;
 };
 
 #define to_fsl_upm_nand(mtd) container_of(mtd, struct fsl_upm_nand, mtd)
@@ -46,7 +51,7 @@ static int fun_chip_ready(struct mtd_info *mtd)
 {
 	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
 
-	if (gpio_get_value(fun->rnb_gpio))
+	if (gpio_get_value(fun->rnb_gpio[fun->chip_number]))
 		return 1;
 
 	dev_vdbg(fun->dev, "busy\n");
@@ -55,9 +60,9 @@ static int fun_chip_ready(struct mtd_info *mtd)
 
 static void fun_wait_rnb(struct fsl_upm_nand *fun)
 {
-	int cnt = 1000000;
 
-	if (fun->rnb_gpio >= 0) {
+	if (fun->rnb_gpio[fun->chip_number] >= 0) {
+		int cnt = 1000000;
 		while (--cnt && !fun_chip_ready(&fun->mtd))
 			cpu_relax();
 		if (!cnt)
@@ -92,6 +97,22 @@ static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 	fun_wait_rnb(fun);
 }
 
+static void fun_select_chip(struct mtd_info *mtd, int chip_nr)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
+
+	if (chip_nr == -1) {
+		chip->cmd_ctrl(mtd, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
+	} else if (chip_nr >= 0) {
+		fun->chip_number = chip_nr;
+		chip->IO_ADDR_R = chip->IO_ADDR_W =
+			fun->io_base + chip_nr * fun->chip_offset;
+	} else {
+		BUG();
+	}
+}
+
 static uint8_t fun_read_byte(struct mtd_info *mtd)
 {
 	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
@@ -137,8 +158,10 @@ static int __devinit fun_chip_init(struct fsl_upm_nand *fun,
 	fun->chip.read_buf = fun_read_buf;
 	fun->chip.write_buf = fun_write_buf;
 	fun->chip.ecc.mode = NAND_ECC_SOFT;
+	if (fun->max_chips > 1)
+		fun->chip.select_chip = fun_select_chip;
 
-	if (fun->rnb_gpio >= 0)
+	if (fun->rnb_gpio[0] >= 0)
 		fun->chip.dev_ready = fun_chip_ready;
 
 	fun->mtd.priv = &fun->chip;
@@ -155,7 +178,7 @@ static int __devinit fun_chip_init(struct fsl_upm_nand *fun,
 		goto err;
 	}
 
-	ret = nand_scan(&fun->mtd, 1);
+	ret = nand_scan(&fun->mtd, fun->max_chips);
 	if (ret)
 		goto err;
 
@@ -187,6 +210,7 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	const uint32_t *prop;
 	int ret;
 	int size;
+	int i;
 
 	fun = kzalloc(sizeof(*fun), GFP_KERNEL);
 	if (!fun)
@@ -208,7 +232,7 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	if (!prop || size != sizeof(uint32_t)) {
 		dev_err(&ofdev->dev, "can't get UPM address offset\n");
 		ret = -EINVAL;
-		goto err2;
+		goto err1;
 	}
 	fun->upm_addr_offset = *prop;
 
@@ -216,21 +240,36 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	if (!prop || size != sizeof(uint32_t)) {
 		dev_err(&ofdev->dev, "can't get UPM command offset\n");
 		ret = -EINVAL;
-		goto err2;
+		goto err1;
 	}
 	fun->upm_cmd_offset = *prop;
 
-	fun->rnb_gpio = of_get_gpio(ofdev->node, 0);
-	if (fun->rnb_gpio >= 0) {
-		ret = gpio_request(fun->rnb_gpio, dev_name(&ofdev->dev));
-		if (ret) {
-			dev_err(&ofdev->dev, "can't request RNB gpio\n");
+	prop = of_get_property(ofdev->node, "max-chips", &size);
+	if (prop && size == sizeof(uint32_t)) {
+		fun->max_chips = *prop;
+		if (fun->max_chips >= FSL_UPM_NAND_MAX_CHIPS) {
+			dev_err(&ofdev->dev, "too much chips");
+			ret = -EINVAL;
+			goto err1;
+		}
+	} else {
+		fun->max_chips = 1;
+	}
+
+	for (i = 0; i < fun->max_chips; i++) {
+		fun->rnb_gpio[i] = of_get_gpio(ofdev->node, i);
+		if (fun->rnb_gpio[i] >= 0) {
+			ret = gpio_request(fun->rnb_gpio[i], 
+					   dev_name(&ofdev->dev));
+			if (ret) {
+				dev_err(&ofdev->dev, "can't request RNB gpio\n");
+				goto err2;
+			}
+			gpio_direction_input(fun->rnb_gpio[i]);
+		} else if (fun->rnb_gpio[i]  == -EINVAL) {
+			dev_err(&ofdev->dev, "specified RNB gpio is invalid\n");
 			goto err2;
 		}
-		gpio_direction_input(fun->rnb_gpio);
-	} else if (fun->rnb_gpio == -EINVAL) {
-		dev_err(&ofdev->dev, "specified RNB gpio is invalid\n");
-		goto err2;
 	}
 
 	prop = of_get_property(ofdev->node, "chip-delay", NULL);
@@ -239,6 +278,10 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	else
 		fun->chip_delay = 50;
 
+	prop = of_get_property(ofdev->node, "chip-offset", &size);
+	if (prop && size == sizeof(uint32_t))
+		fun->chip_offset = *prop;
+
 	fun->io_base = devm_ioremap_nocache(&ofdev->dev, io_res.start,
 					  io_res.end - io_res.start + 1);
 	if (!fun->io_base) {
@@ -257,8 +300,10 @@ static int __devinit fun_probe(struct of_device *ofdev,
 
 	return 0;
 err2:
-	if (fun->rnb_gpio >= 0)
-		gpio_free(fun->rnb_gpio);
+	for (i = 0; i < fun->max_chips; i++) {
+		if (fun->rnb_gpio[i] >= 0)
+			gpio_free(fun->rnb_gpio[i]);
+	}
 err1:
 	kfree(fun);
 
@@ -268,12 +313,15 @@ err1:
 static int __devexit fun_remove(struct of_device *ofdev)
 {
 	struct fsl_upm_nand *fun = dev_get_drvdata(&ofdev->dev);
+	int i;
 
 	nand_release(&fun->mtd);
 	kfree(fun->mtd.name);
 
-	if (fun->rnb_gpio >= 0)
-		gpio_free(fun->rnb_gpio);
+        for (i = 0; i < fun->max_chips; i++) {
+                if (fun->rnb_gpio[i] >= 0)
+                        gpio_free(fun->rnb_gpio[i]);
+        }
 
 	kfree(fun);
 
-- 
1.6.0.6
