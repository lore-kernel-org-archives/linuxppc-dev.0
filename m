Return-Path: <wg@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id A1710DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 21:05:59 +1100 (EST)
Message-Id: <20090330100554.947307803@denx.de>
Date: Mon, 30 Mar 2009 12:02:42 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-mtd@lists.infradead.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH v4 1/4] NAND: FSL-UPM: add multi chip support
References: <20090330100241.346785618@denx.de>
Cc: devicetree-discuss@ozlabs.org
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
FDT property "fsl,upm-addr-line-cs-offsets".

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/sysdev/fsl_lbc.c |    2 
 drivers/mtd/nand/fsl_upm.c    |   99 ++++++++++++++++++++++++++++++++----------
 2 files changed, 77 insertions(+), 24 deletions(-)

Index: linux-2.6/arch/powerpc/sysdev/fsl_lbc.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/fsl_lbc.c	2009-03-30 12:01:32.088969299 +0200
+++ linux-2.6/arch/powerpc/sysdev/fsl_lbc.c	2009-03-30 12:01:35.633720577 +0200
@@ -150,7 +150,7 @@
 
 	spin_lock_irqsave(&fsl_lbc_lock, flags);
 
-	out_be32(&fsl_lbc_regs->mar, mar << (32 - upm->width));
+	out_be32(&fsl_lbc_regs->mar, mar);
 
 	switch (upm->width) {
 	case 8:
Index: linux-2.6/drivers/mtd/nand/fsl_upm.c
===================================================================
--- linux-2.6.orig/drivers/mtd/nand/fsl_upm.c	2009-03-30 12:01:32.089969721 +0200
+++ linux-2.6/drivers/mtd/nand/fsl_upm.c	2009-03-30 12:01:35.634720440 +0200
@@ -36,7 +36,10 @@
 	uint8_t upm_addr_offset;
 	uint8_t upm_cmd_offset;
 	void __iomem *io_base;
-	int rnb_gpio;
+	int rnb_gpio[NAND_MAX_CHIPS];
+	uint32_t mchip_offsets[NAND_MAX_CHIPS];
+	uint32_t mchip_count;
+	uint32_t mchip_number;
 	int chip_delay;
 };
 
@@ -46,7 +49,7 @@
 {
 	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
 
-	if (gpio_get_value(fun->rnb_gpio))
+	if (gpio_get_value(fun->rnb_gpio[fun->mchip_number]))
 		return 1;
 
 	dev_vdbg(fun->dev, "busy\n");
@@ -55,9 +58,9 @@
 
 static void fun_wait_rnb(struct fsl_upm_nand *fun)
 {
-	int cnt = 1000000;
+	if (fun->rnb_gpio[fun->mchip_number] >= 0) {
+		int cnt = 1000000;
 
-	if (fun->rnb_gpio >= 0) {
 		while (--cnt && !fun_chip_ready(&fun->mtd))
 			cpu_relax();
 		if (!cnt)
@@ -69,7 +72,9 @@
 
 static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
+	struct nand_chip *chip = mtd->priv;
 	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
+	u32 mar;
 
 	if (!(ctrl & fun->last_ctrl)) {
 		fsl_upm_end_pattern(&fun->upm);
@@ -87,11 +92,29 @@
 			fsl_upm_start_pattern(&fun->upm, fun->upm_cmd_offset);
 	}
 
-	fsl_upm_run_pattern(&fun->upm, fun->io_base, cmd);
+	mar = (cmd << (32 - fun->upm.width)) |
+		fun->mchip_offsets[fun->mchip_number];
+	fsl_upm_run_pattern(&fun->upm, chip->IO_ADDR_R, mar);
 
 	fun_wait_rnb(fun);
 }
 
+static void fun_select_chip(struct mtd_info *mtd, int mchip_nr)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
+
+	if (mchip_nr == -1) {
+		chip->cmd_ctrl(mtd, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
+	} else if (mchip_nr >= 0) {
+		fun->mchip_number = mchip_nr;
+		chip->IO_ADDR_R = fun->io_base + fun->mchip_offsets[mchip_nr];
+		chip->IO_ADDR_W = chip->IO_ADDR_R;
+	} else {
+		BUG();
+	}
+}
+
 static uint8_t fun_read_byte(struct mtd_info *mtd)
 {
 	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
@@ -137,8 +160,10 @@
 	fun->chip.read_buf = fun_read_buf;
 	fun->chip.write_buf = fun_write_buf;
 	fun->chip.ecc.mode = NAND_ECC_SOFT;
+	if (fun->mchip_count > 1)
+		fun->chip.select_chip = fun_select_chip;
 
-	if (fun->rnb_gpio >= 0)
+	if (fun->rnb_gpio[0] >= 0)
 		fun->chip.dev_ready = fun_chip_ready;
 
 	fun->mtd.priv = &fun->chip;
@@ -155,7 +180,7 @@
 		goto err;
 	}
 
-	ret = nand_scan(&fun->mtd, 1);
+	ret = nand_scan(&fun->mtd, fun->mchip_count);
 	if (ret)
 		goto err;
 
@@ -185,8 +210,10 @@
 	struct fsl_upm_nand *fun;
 	struct resource io_res;
 	const uint32_t *prop;
+	int rnb_gpio;
 	int ret;
 	int size;
+	int i;
 
 	fun = kzalloc(sizeof(*fun), GFP_KERNEL);
 	if (!fun)
@@ -208,7 +235,7 @@
 	if (!prop || size != sizeof(uint32_t)) {
 		dev_err(&ofdev->dev, "can't get UPM address offset\n");
 		ret = -EINVAL;
-		goto err2;
+		goto err1;
 	}
 	fun->upm_addr_offset = *prop;
 
@@ -216,21 +243,40 @@
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
+	prop = of_get_property(ofdev->node,
+			       "fsl,upm-addr-line-cs-offsets", &size);
+	if (prop && (size / sizeof(uint32_t)) > 0) {
+		fun->mchip_count = size / sizeof(uint32_t);
+		if (fun->mchip_count >= NAND_MAX_CHIPS) {
+			dev_err(&ofdev->dev, "too much multiple chips\n");
+			goto err1;
+		}
+		for (i = 0; i < fun->mchip_count; i++)
+			fun->mchip_offsets[i] = prop[i];
+	} else {
+		fun->mchip_count = 1;
+	}
+
+	for (i = 0; i < fun->mchip_count; i++) {
+		fun->rnb_gpio[i] = -1;
+		rnb_gpio = of_get_gpio(ofdev->node, i);
+		if (rnb_gpio >= 0) {
+			ret = gpio_request(rnb_gpio, dev_name(&ofdev->dev));
+			if (ret) {
+				dev_err(&ofdev->dev,
+					"can't request RNB gpio #%d\n", i);
+				goto err2;
+			}
+			gpio_direction_input(rnb_gpio);
+			fun->rnb_gpio[i] = rnb_gpio;
+		} else if (rnb_gpio == -EINVAL) {
+			dev_err(&ofdev->dev, "RNB gpio #%d is invalid\n", i);
 			goto err2;
 		}
-		gpio_direction_input(fun->rnb_gpio);
-	} else if (fun->rnb_gpio == -EINVAL) {
-		dev_err(&ofdev->dev, "specified RNB gpio is invalid\n");
-		goto err2;
 	}
 
 	prop = of_get_property(ofdev->node, "chip-delay", NULL);
@@ -240,7 +286,7 @@
 		fun->chip_delay = 50;
 
 	fun->io_base = devm_ioremap_nocache(&ofdev->dev, io_res.start,
-					  io_res.end - io_res.start + 1);
+					    io_res.end - io_res.start + 1);
 	if (!fun->io_base) {
 		ret = -ENOMEM;
 		goto err2;
@@ -257,8 +303,11 @@
 
 	return 0;
 err2:
-	if (fun->rnb_gpio >= 0)
-		gpio_free(fun->rnb_gpio);
+	for (i = 0; i < fun->mchip_count; i++) {
+		if (fun->rnb_gpio[i] < 0)
+			break;
+		gpio_free(fun->rnb_gpio[i]);
+	}
 err1:
 	kfree(fun);
 
@@ -268,12 +317,16 @@
 static int __devexit fun_remove(struct of_device *ofdev)
 {
 	struct fsl_upm_nand *fun = dev_get_drvdata(&ofdev->dev);
+	int i;
 
 	nand_release(&fun->mtd);
 	kfree(fun->mtd.name);
 
-	if (fun->rnb_gpio >= 0)
-		gpio_free(fun->rnb_gpio);
+	for (i = 0; i < fun->mchip_count; i++) {
+		if (fun->rnb_gpio[i] < 0)
+			break;
+		gpio_free(fun->rnb_gpio[i]);
+	}
 
 	kfree(fun);
 
