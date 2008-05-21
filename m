Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4966FDE354
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 01:41:42 +1000 (EST)
Date: Wed, 21 May 2008 19:41:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/4] [OF] MMC-over-SPI OF constructor
Message-ID: <20080521154140.GC4566@polina.dev.rtsoft.ru>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080521154103.GA32577@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   24 +++++
 drivers/of/Kconfig                           |    6 ++
 drivers/of/Makefile                          |    1 +
 drivers/of/spi_mmc.c                         |  122 ++++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 0 deletions(-)
 create mode 100644 drivers/of/spi_mmc.c

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 011bf5e..474f50a 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -3113,7 +3113,31 @@ platforms are moved over to use the flattened-device-tree model.
 			};
 		};
 
+    t) MMC-over-SPI
 
+      Required properties:
+      - #address-cells : should be 0;
+      - #size-cells : should be 0;
+      - compatible : "linux,mmc-spi".
+      - linux,modalias  - (optional) permissible value is "mmc_spi", only used
+        if dedicated driver failed to probe.
+      - reg : should specify SPI address (chip-select number).
+      - max-speed : (optional) maximum frequency for this device (Hz).
+      - mmc,ocr-mask : (optional) Linux-specific MMC OCR mask (slot voltage).
+      - gpios : (optional) may specify GPIOs in this order: Write-Protect GPIO,
+        Card-Detect GPIO.
+
+      Example:
+
+	mmc-slot@0 {
+		compatible = "linux,mmc-spi";
+		linux,modalias = "mmc_spi";
+		reg = <0>;
+		max-speed = <50000000>;
+		mmc,ocr-mask = <0x00200000>;
+		gpios = <&sdcsr_pio 6 0   /*  WP */
+			 &sdcsr_pio 7 1>; /* nCD */
+	};
 
 VII - Marvell Discovery mv64[345]6x System Controller chips
 ===========================================================
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 3a7a11a..80aaf8b 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -13,3 +13,9 @@ config OF_I2C
 	depends on PPC_OF && I2C
 	help
 	  OpenFirmware I2C accessors
+
+config OF_MMC_SPI
+	def_bool y if MMC_SPI
+	depends on OF_GPIO
+	help
+	  OpenFirmware MMC-over-SPI constructor
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 548772e..f6ee8b3 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -2,3 +2,4 @@ obj-y = base.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
 obj-$(CONFIG_OF_GPIO)   += gpio.o
 obj-$(CONFIG_OF_I2C)	+= of_i2c.o
+obj-$(CONFIG_OF_MMC_SPI)	+= spi_mmc.o
diff --git a/drivers/of/spi_mmc.c b/drivers/of/spi_mmc.c
new file mode 100644
index 0000000..90fff50
--- /dev/null
+++ b/drivers/of/spi_mmc.c
@@ -0,0 +1,122 @@
+/*
+ * OpenFirmware MMC-over-SPI constructor
+ *
+ * Copyright (c) MontaVista Software, Inc. 2008.
+ *
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_of.h>
+#include <linux/spi/mmc_spi.h>
+#include <linux/mmc/host.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+
+struct of_mmc_spi {
+	int wp_gpio;
+	int cd_gpio;
+	struct spi_board_info spi_binfo;
+	struct mmc_spi_platform_data mmc_pdata;
+};
+
+static int mmc_get_ro(struct device *dev)
+{
+	/* luckily spi core copies pdata pointer, not the data */
+	struct of_mmc_spi *oms = container_of(dev->platform_data,
+					      struct of_mmc_spi, mmc_pdata);
+	return gpio_get_value(oms->wp_gpio);
+}
+
+static int __devinit of_mmc_spi_probe(struct of_device *ofdev,
+				      const struct of_device_id *match)
+{
+	int ret = -EINVAL;
+	struct of_mmc_spi *oms = kzalloc(sizeof(*oms), GFP_KERNEL);
+	struct device_node *np = ofdev->node;
+	struct device *dev = &ofdev->dev;
+	const u32 *ocr_mask;
+	int size;
+
+	if (!oms)
+		return -ENOMEM;
+
+	ocr_mask = of_get_property(np, "mmc,ocr-mask", &size);
+	if (ocr_mask && size >= sizeof(ocr_mask))
+		oms->mmc_pdata.ocr_mask = *ocr_mask;
+
+	oms->wp_gpio = of_get_gpio(np, 0);
+	if (gpio_is_valid(oms->wp_gpio)) {
+		ret = gpio_request(oms->wp_gpio, dev->bus_id);
+		if (ret < 0)
+			goto err_wp_gpio;
+		oms->mmc_pdata.get_ro = &mmc_get_ro;
+	}
+
+	oms->cd_gpio = of_get_gpio(np, 1);
+	if (gpio_is_valid(oms->cd_gpio)) {
+		ret = gpio_request(oms->cd_gpio, dev->bus_id);
+		if (ret < 0)
+			goto err_cd_gpio;
+	}
+
+	oms->spi_binfo.platform_data = &oms->mmc_pdata;
+
+	ret = of_spi_device_probe_common(np, &oms->spi_binfo, "mmc_spi");
+	if (ret)
+		goto err_common;
+
+	ret = spi_register_board_info(&oms->spi_binfo, 1);
+	if (ret)
+		goto err_binfo;
+
+	dev_info(dev, "slot with%s write-protect and with%s card-detect "
+		 "recognition\n", gpio_is_valid(oms->wp_gpio) ? "" : "out",
+		 gpio_is_valid(oms->cd_gpio) ? "" : "out");
+
+	return 0;
+err_binfo:
+	of_spi_device_remove_common(np);
+err_common:
+	if (gpio_is_valid(oms->cd_gpio))
+		gpio_free(oms->cd_gpio);
+err_cd_gpio:
+	if (gpio_is_valid(oms->wp_gpio))
+		gpio_free(oms->wp_gpio);
+err_wp_gpio:
+	kfree(oms);
+	return ret;
+}
+
+static const struct of_device_id of_mmc_spi_match[] = {
+	{ .compatible = "linux,mmc-spi", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_mmc_spi_match);
+
+static struct of_platform_driver of_mmc_spi_driver = {
+	.match_table	= of_mmc_spi_match,
+	.probe		= of_mmc_spi_probe,
+	.driver		= {
+		.name	= "of_mmc_spi",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init of_mmc_spi_init(void)
+{
+	return of_register_platform_driver(&of_mmc_spi_driver);
+}
+arch_initcall(of_mmc_spi_init);
+
+/* SPI board infos aren't hot-plugable, thus no module_exit */
+
+MODULE_LICENSE("GPL");
-- 
1.5.5.1
