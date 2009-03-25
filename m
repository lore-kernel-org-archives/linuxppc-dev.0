Return-Path: <wg@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id CCAC1DDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 21:08:25 +1100 (EST)
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-mtd@lists.infradead.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v3 1/4] NAND: FSL-UPM: add multi chip support
Date: Wed, 25 Mar 2009 11:08:18 +0100
Message-Id: <1237975701-23201-2-git-send-email-wg@grandegger.com>
In-Reply-To: <1237975701-23201-1-git-send-email-wg@grandegger.com>
References: <1237975701-23201-1-git-send-email-wg@grandegger.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for multi-chip NAND devices to the FSL-UPM
driver. This requires support for multiple GPIOs for the RNB pins.
The NAND chips are selected through address lines defined by the
FDT property "chip-offset".

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/sysdev/fsl_lbc.c |    2 +-
 drivers/mtd/nand/fsl_upm.c    |   95 +++++++++++++++++++++++++++++++---------
 2 files changed, 74 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index 0494ee5..dceb8d1 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -150,7 +150,7 @@ int fsl_upm_run_pattern(struct fsl_upm *upm, void __iomem *io_base, u32 mar)
 
 	spin_lock_irqsave(&fsl_lbc_lock, flags);
 
-	out_be32(&fsl_lbc_regs->mar, mar << (32 - upm->width));
+	out_be32(&fsl_lbc_regs->mar, mar);
 
 	switch (upm->width) {
 	case 8:
diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 7815a40..9b314ce 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -36,8 +36,11 @@ struct fsl_upm_nand {
 	uint8_t upm_addr_offset;
 	uint8_t upm_cmd_offset;
 	void __iomem *io_base;
-	int rnb_gpio;
+	int rnb_gpio[NAND_MAX_CHIPS];
 	int chip_delay;
+	uint32_t num_chips;
+	uint32_t chip_number;
+	uint32_t chip_offset;
 };
 
 #define to_fsl_upm_nand(mtd) container_of(mtd, struct fsl_upm_nand, mtd)
@@ -46,7 +49,7 @@ static int fun_chip_ready(struct mtd_info *mtd)
 {
 	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
 
-	if (gpio_get_value(fun->rnb_gpio))
+	if (gpio_get_value(fun->rnb_gpio[fun->chip_number]))
 		return 1;
 
 	dev_vdbg(fun->dev, "busy\n");
@@ -55,9 +58,9 @@ static int fun_chip_ready(struct mtd_info *mtd)
 
 static void fun_wait_rnb(struct fsl_upm_nand *fun)
 {
-	int cnt = 1000000;
 
-	if (fun->rnb_gpio >= 0) {
+	if (fun->rnb_gpio[fun->chip_number] >= 0) {
+		int cnt = 1000000;
 		while (--cnt && !fun_chip_ready(&fun->mtd))
 			cpu_relax();
 		if (!cnt)
@@ -69,7 +72,9 @@ static void fun_wait_rnb(struct fsl_upm_nand *fun)
 
 static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
+	struct nand_chip *chip = mtd->priv;
 	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
+	u32 mar;
 
 	if (!(ctrl & fun->last_ctrl)) {
 		fsl_upm_end_pattern(&fun->upm);
@@ -87,11 +92,30 @@ static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 			fsl_upm_start_pattern(&fun->upm, fun->upm_cmd_offset);
 	}
 
-	fsl_upm_run_pattern(&fun->upm, fun->io_base, cmd);
+	mar = cmd << (32 - fun->upm.width);
+	if (fun->chip_offset && fun->chip_number > 0)
+		mar |= fun->chip_number * fun->chip_offset;
+	fsl_upm_run_pattern(&fun->upm, chip->IO_ADDR_R, mar);
 
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
@@ -137,8 +161,10 @@ static int __devinit fun_chip_init(struct fsl_upm_nand *fun,
 	fun->chip.read_buf = fun_read_buf;
 	fun->chip.write_buf = fun_write_buf;
 	fun->chip.ecc.mode = NAND_ECC_SOFT;
+	if (fun->num_chips > 1)
+		fun->chip.select_chip = fun_select_chip;
 
-	if (fun->rnb_gpio >= 0)
+	if (fun->rnb_gpio[0] >= 0)
 		fun->chip.dev_ready = fun_chip_ready;
 
 	fun->mtd.priv = &fun->chip;
@@ -155,7 +181,7 @@ static int __devinit fun_chip_init(struct fsl_upm_nand *fun,
 		goto err;
 	}
 
-	ret = nand_scan(&fun->mtd, 1);
+	ret = nand_scan(&fun->mtd, fun->num_chips);
 	if (ret)
 		goto err;
 
@@ -187,6 +213,7 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	const uint32_t *prop;
 	int ret;
 	int size;
+	int i;
 
 	fun = kzalloc(sizeof(*fun), GFP_KERNEL);
 	if (!fun)
@@ -208,7 +235,7 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	if (!prop || size != sizeof(uint32_t)) {
 		dev_err(&ofdev->dev, "can't get UPM address offset\n");
 		ret = -EINVAL;
-		goto err2;
+		goto err1;
 	}
 	fun->upm_addr_offset = *prop;
 
@@ -216,21 +243,36 @@ static int __devinit fun_probe(struct of_device *ofdev,
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
+	prop = of_get_property(ofdev->node, "num-chips", &size);
+	if (prop && size == sizeof(uint32_t)) {
+		fun->num_chips = *prop;
+		if (fun->num_chips >= NAND_MAX_CHIPS) {
+			dev_err(&ofdev->dev, "too much chips");
+			ret = -EINVAL;
+			goto err1;
+		}
+	} else {
+		fun->num_chips = 1;
+	}
+
+	for (i = 0; i < fun->num_chips; i++) {
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
@@ -239,6 +281,10 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	else
 		fun->chip_delay = 50;
 
+	prop = of_get_property(ofdev->node, "chip-offset", &size);
+	if (prop && size == sizeof(uint32_t))
+		fun->chip_offset = *prop;
+
 	fun->io_base = devm_ioremap_nocache(&ofdev->dev, io_res.start,
 					  io_res.end - io_res.start + 1);
 	if (!fun->io_base) {
@@ -257,8 +303,10 @@ static int __devinit fun_probe(struct of_device *ofdev,
 
 	return 0;
 err2:
-	if (fun->rnb_gpio >= 0)
-		gpio_free(fun->rnb_gpio);
+	for (i = 0; i < fun->num_chips; i++) {
+		if (fun->rnb_gpio[i] >= 0)
+			gpio_free(fun->rnb_gpio[i]);
+	}
 err1:
 	kfree(fun);
 
@@ -268,12 +316,15 @@ err1:
 static int __devexit fun_remove(struct of_device *ofdev)
 {
 	struct fsl_upm_nand *fun = dev_get_drvdata(&ofdev->dev);
+	int i;
 
 	nand_release(&fun->mtd);
 	kfree(fun->mtd.name);
 
-	if (fun->rnb_gpio >= 0)
-		gpio_free(fun->rnb_gpio);
+        for (i = 0; i < fun->num_chips; i++) {
+                if (fun->rnb_gpio[i] >= 0)
+                        gpio_free(fun->rnb_gpio[i]);
+        }
 
 	kfree(fun);
 
-- 
1.6.0.6
