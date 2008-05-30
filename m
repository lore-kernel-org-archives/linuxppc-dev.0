Return-Path: <wg@grandegger.com>
From: Wolfgang Grandegger <wg@grandegger.com>
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH] [NAND] driver extension to support NAND on TQM85xx modules
Date: Fri, 30 May 2008 08:36:32 +0200
Message-Id: <1212129392-27589-1-git-send-email-wg@grandegger.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch extends the FSL UPM NAND driver from Anton Vorontsov to
support for the TQM85xx modules. Unfortunately, the hardware does
not support the R/B pins of the NAND chip and therefore the specified
maximum delay time must used. It therefore re-introduces the chip-delay
property.

Note: this patch is based on a patch Anton Vorontsov posted to this list:
      See http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055587.html.
      It should show up mainstream soon. 

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/mtd/nand/Kconfig   |    2 +-
 drivers/mtd/nand/fsl_upm.c |   30 +++++++++++++++++++++---------
 include/linux/of_gpio.h    |    2 +-
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 5076faf..3a665c8 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -380,7 +380,7 @@ config MTD_NAND_FSL_ELBC
 
 config MTD_NAND_FSL_UPM
 	tristate "Support for NAND on Freescale UPM"
-	depends on MTD_NAND && OF_GPIO && (PPC_83xx || PPC_85xx)
+	depends on MTD_NAND && (PPC_83xx || PPC_85xx)
 	select FSL_LBC
 	help
 	  Enables support for NAND Flash chips wired onto Freescale PowerPC
diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index f91c950..3694837 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -36,6 +36,7 @@ struct fsl_upm_nand {
 	uint8_t upm_cmd_offset;
 	void __iomem *io_base;
 	int rnb_gpio;
+	int chip_delay;
 };
 
 #define to_fsl_upm_nand(mtd) container_of(mtd, struct fsl_upm_nand, mtd)
@@ -44,11 +45,15 @@ static int fun_chip_ready(struct mtd_info *mtd)
 {
 	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
 
-	if (gpio_get_value(fun->rnb_gpio))
-		return 1;
-
-	dev_vdbg(fun->dev, "busy\n");
-	return 0;
+	if (fun->rnb_gpio >= 0) {
+		if (!gpio_get_value(fun->rnb_gpio)) {
+			dev_vdbg(fun->dev, "busy\n");
+			return 0;
+		}
+	} else {
+		udelay(fun->chip_delay);
+	}
+	return 1;
 }
 
 static void fun_wait_rnb(struct fsl_upm_nand *fun)
@@ -58,10 +63,11 @@ static void fun_wait_rnb(struct fsl_upm_nand *fun)
 	if (fun->rnb_gpio >= 0) {
 		while (--cnt && !fun_chip_ready(&fun->mtd))
 			cpu_relax();
+		if (!cnt)
+			dev_err(fun->dev, "tired waiting for RNB\n");
+	} else {
+		fun_chip_ready(&fun->mtd);
 	}
-
-	if (!cnt)
-		dev_err(fun->dev, "tired waiting for RNB\n");
 }
 
 static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
@@ -129,7 +135,7 @@ static int __devinit fun_chip_init(struct fsl_upm_nand *fun,
 	fun->chip.IO_ADDR_R = fun->io_base;
 	fun->chip.IO_ADDR_W = fun->io_base;
 	fun->chip.cmd_ctrl = fun_cmd_ctrl;
-	fun->chip.chip_delay = 50;
+	fun->chip.chip_delay = fun->chip_delay;
 	fun->chip.read_byte = fun_read_byte;
 	fun->chip.read_buf = fun_read_buf;
 	fun->chip.write_buf = fun_write_buf;
@@ -233,6 +239,12 @@ static int __devinit fun_probe(struct of_device *ofdev,
 		goto err2;
 	}
 
+	prop = of_get_property(ofdev->node, "chip-delay", NULL);
+	if (prop)
+		fun->chip_delay = *prop;
+	else
+		fun->chip_delay = 50;
+
 	fun->io_base = devm_ioremap_nocache(&ofdev->dev, io_res.start,
 					  io_res.end - io_res.start + 1);
 	if (!fun->io_base) {
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 2ee97e9..67db101 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -15,7 +15,7 @@
 #define __LINUX_OF_GPIO_H
 
 #include <linux/errno.h>
-#include <asm/gpio.h>
+#include <linux/gpio.h>
 
 #ifdef CONFIG_OF_GPIO
 
-- 
1.5.4.2
