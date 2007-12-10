Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 49E5DDEDDE
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 07:46:21 +1100 (EST)
Date: Mon, 10 Dec 2007 23:49:38 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC 6/7] [POWERPC][NAND] FSL UPM NAND driver
Message-ID: <20071210204938.GF32278@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071210204705.GA31263@localhost.localdomain>
Cc: tglx@linutronix.de, dbrownell@users.sourceforge.net, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's using FSL UPM infrastructure. So far only 8 bit accessors
are implemented.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mtd/nand/Kconfig   |    7 +
 drivers/mtd/nand/Makefile  |    1 +
 drivers/mtd/nand/fsl_upm.c |  310 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 318 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/fsl_upm.c

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 246d451..910b4d5 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -306,4 +306,11 @@ config MTD_ALAUDA
 	  These two (and possibly other) Alauda-based cardreaders for
 	  SmartMedia and xD allow raw flash access.
 
+config MTD_NAND_FSL_UPM
+	tristate "MTD driver for NAND on Freescale UPM"
+	depends on MTD_NAND && FSL_UPM
+	help
+	  Enables support for NAND Flash wired to Freescale processors'
+	  localbus with pre-programmed User-Programmable Machine.
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 3ad6c01..d553ea3 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -29,5 +29,6 @@ obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
 obj-$(CONFIG_MTD_NAND_BASLER_EXCITE)	+= excite_nandflash.o
 obj-$(CONFIG_MTD_NAND_PLATFORM)		+= plat_nand.o
 obj-$(CONFIG_MTD_ALAUDA)		+= alauda.o
+obj-$(CONFIG_MTD_NAND_FSL_UPM)		+= fsl_upm.o
 
 nand-objs := nand_base.o nand_bbt.o
diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
new file mode 100644
index 0000000..a2bddb0
--- /dev/null
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -0,0 +1,310 @@
+/*
+ * Freescale UPM NAND driver.
+ *
+ * Copyright (c) 2007  MontaVista Software, Inc.
+ * Copyright (c) 2007  Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/mtd.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <asm/io.h>
+#include <asm/gpio.h>
+#include <asm/fsl_upm.h>
+
+struct upm_data {
+	struct of_device *ofdev;
+	struct mtd_info mtd;
+	struct nand_chip chip;
+	int last_ctrl;
+#ifdef CONFIG_MTD_PARTITIONS
+	struct mtd_partition *parts;
+#endif
+
+	struct fsl_upm upm;
+
+	int width;
+	int upm_addr_offset;
+	int upm_cmd_offset;
+	void __iomem *io_base;
+	int rnb_gpio;
+	const u32 *wait_pattern;
+	const u32 *wait_write;
+	int chip_delay;
+};
+
+#define to_upm_data(mtd) container_of(mtd, struct upm_data, mtd)
+
+static int upm_chip_ready(struct mtd_info *mtd)
+{
+	struct upm_data *ud = to_upm_data(mtd);
+
+	if (gpio_get_value(ud->rnb_gpio))
+		return 1;
+
+	dev_vdbg(&ud->ofdev->dev, "busy\n");
+	return 0;
+}
+
+static void upm_wait_rnb(struct upm_data *ud)
+{
+	int cnt = 1000000;
+
+	if (ud->rnb_gpio >= 0) {
+		while (--cnt && !upm_chip_ready(&ud->mtd))
+			cpu_relax();
+	}
+
+	if (!cnt)
+		dev_err(&ud->ofdev->dev, "tired waiting for RNB\n");
+}
+
+static void upm_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+{
+	struct upm_data *ud = to_upm_data(mtd);
+
+	if (!(ctrl & ud->last_ctrl)) {
+		fsl_upm_end_pattern(&ud->upm);
+
+		if (cmd == NAND_CMD_NONE)
+			return;
+
+		ud->last_ctrl = ctrl & (NAND_ALE | NAND_CLE);
+	}
+
+	if (ctrl & NAND_CTRL_CHANGE) {
+		if (ctrl & NAND_ALE)
+			fsl_upm_start_pattern(&ud->upm, ud->upm_addr_offset);
+		else if (ctrl & NAND_CLE)
+			fsl_upm_start_pattern(&ud->upm, ud->upm_cmd_offset);
+	}
+
+	fsl_upm_run_pattern(&ud->upm, ud->io_base, ud->width, cmd);
+
+	if (ud->wait_pattern)
+		upm_wait_rnb(ud);
+}
+
+static uint8_t upm_read_byte(struct mtd_info *mtd)
+{
+	struct upm_data *ud = to_upm_data(mtd);
+
+	return in_8(ud->chip.IO_ADDR_R);
+}
+
+static void upm_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+{
+	struct upm_data *ud = to_upm_data(mtd);
+	int i;
+
+	for (i = 0; i < len; i++)
+		buf[i] = in_8(ud->chip.IO_ADDR_R);
+}
+
+static void upm_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct upm_data *ud = to_upm_data(mtd);
+	int i;
+
+	for (i = 0; i < len; i++) {
+		out_8(ud->chip.IO_ADDR_W, buf[i]);
+		if (ud->wait_write)
+			upm_wait_rnb(ud);
+	}
+}
+
+static int __devinit upm_chip_init(struct upm_data *ud)
+{
+	int ret;
+#ifdef CONFIG_MTD_PARTITIONS
+	static const char *part_types[] = { "cmdlinepart", NULL, };
+#endif
+
+	ud->chip.IO_ADDR_R = ud->io_base;
+	ud->chip.IO_ADDR_W = ud->io_base;
+	ud->chip.cmd_ctrl = upm_cmd_ctrl;
+	ud->chip.chip_delay = ud->chip_delay;
+	ud->chip.read_byte = upm_read_byte;
+	ud->chip.read_buf = upm_read_buf;
+	ud->chip.write_buf = upm_write_buf;
+	ud->chip.ecc.mode = NAND_ECC_SOFT;
+
+	if (ud->rnb_gpio != (unsigned int)-1)
+		ud->chip.dev_ready = upm_chip_ready;
+
+	ud->mtd.priv = &ud->chip;
+	ud->mtd.owner = THIS_MODULE;
+
+	ret = nand_scan(&ud->mtd, 1);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_MTD_PARTITIONS
+	ret = parse_mtd_partitions(&ud->mtd, part_types, &ud->parts, 0);
+	if (ret > 0)
+		return add_mtd_partitions(&ud->mtd, ud->parts, ret);
+#endif
+	return add_mtd_device(&ud->mtd);
+}
+
+static int __devinit upm_chip_probe(struct of_device *ofdev,
+				    const struct of_device_id *ofid)
+{
+	struct upm_data *ud;
+	struct resource io_res;
+	const u32 *prop;
+	int ret;
+
+	ud = kzalloc(sizeof(*ud), GFP_KERNEL);
+	if (!ud)
+		return -ENOMEM;
+
+	ret = of_address_to_resource(ofdev->node, 0, &io_res);
+	if (ret) {
+		dev_err(&ofdev->dev, "can't get IO base\n");
+		goto err;
+	}
+
+	ud->width = io_res.end - io_res.start + 1;
+	if (ud->width != 1) {
+		dev_err(&ofdev->dev, "> 8 bit accessors not implemented\n");
+		ret = -ENOSYS;
+		goto err;
+	}
+	ud->width *= 8;
+
+	prop = of_get_property(ofdev->node, "upm", NULL);
+	if (!prop) {
+		dev_err(&ofdev->dev, "can't get UPM to use\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = fsl_upm_get_for(ofdev->node, (const char *)prop, &ud->upm);
+	if (ret) {
+		dev_err(&ofdev->dev, "can't get FSL UPM\n");
+		goto err;
+	}
+
+	prop = of_get_property(ofdev->node, "upm-addr-offset", NULL);
+	if (!prop) {
+		dev_err(&ofdev->dev, "can't get UPM address offset\n");
+		ret = -EINVAL;
+		goto err;
+	}
+	ud->upm_addr_offset = *prop;
+
+	prop = of_get_property(ofdev->node, "upm-cmd-offset", NULL);
+	if (!prop) {
+		dev_err(&ofdev->dev, "can't get UPM command offset\n");
+		ret = -EINVAL;
+		goto err;
+	}
+	ud->upm_cmd_offset = *prop;
+
+	ud->rnb_gpio = of_get_gpio(ofdev->node, 0);
+	if (ud->rnb_gpio >= 0) {
+		ret = gpio_request(ud->rnb_gpio, ofdev->dev.bus_id);
+		if (ret) {
+			dev_err(&ofdev->dev, "can't request RNB gpio\n");
+			goto err;
+		}
+	} else if (ud->rnb_gpio == -EINVAL) {
+		dev_err(&ofdev->dev, "specified RNB gpio is invalid\n");
+		goto err;
+	}
+
+	ud->io_base = devm_ioremap_nocache(&ofdev->dev, io_res.start,
+					  io_res.end - io_res.start + 1);
+	if (!ud->io_base) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ud->ofdev = ofdev;
+	ud->last_ctrl = NAND_CLE;
+	ud->wait_pattern = of_get_property(ofdev->node, "wait-pattern", NULL);
+	ud->wait_write = of_get_property(ofdev->node, "wait-write", NULL);
+
+	prop = of_get_property(ofdev->node, "chip-delay", NULL);
+	if (prop)
+		ud->chip_delay = *prop;
+	else
+		ud->chip_delay = 50;
+
+	ret = upm_chip_init(ud);
+	if (ret)
+		goto err;
+
+	dev_set_drvdata(&ofdev->dev, ud);
+
+	return 0;
+
+err:
+	if (fsl_upm_got(&ud->upm))
+		fsl_upm_free(&ud->upm);
+
+	if (ud->rnb_gpio >= 0)
+		gpio_free(ud->rnb_gpio);
+
+	kfree(ud);
+
+	return ret;
+}
+
+static int __devexit upm_chip_remove(struct of_device *ofdev)
+{
+	struct upm_data *ud = dev_get_drvdata(&ofdev->dev);
+
+	nand_release(&ud->mtd);
+
+	fsl_upm_free(&ud->upm);
+
+	if (ud->rnb_gpio != (unsigned int)-1)
+		gpio_free(ud->rnb_gpio);
+
+	kfree(ud);
+
+	return 0;
+}
+
+static struct of_device_id of_upm_nand_match[] = {
+	{ .compatible = "fsl,upm-nand" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_upm_nand_match);
+
+static struct of_platform_driver of_upm_chip_driver = {
+	.name		= "fsl_upm_nand",
+	.match_table	= of_upm_nand_match,
+	.probe		= upm_chip_probe,
+	.remove		= __devexit_p(upm_chip_remove),
+};
+
+static int __init upm_nand_init(void)
+{
+	return of_register_platform_driver(&of_upm_chip_driver);
+}
+
+static void __exit upm_nand_exit(void)
+{
+	of_unregister_platform_driver(&of_upm_chip_driver);
+}
+
+module_init(upm_nand_init);
+module_exit(upm_nand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Anton Vorontsov <avorontsov@ru.mvista.com>");
+MODULE_DESCRIPTION("Driver for NAND chips working through Freescale "
+		   "LocalBus User-Programmable Machine");
-- 
1.5.2.2
