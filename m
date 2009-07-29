Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 59AEEB7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 03:05:23 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 74335DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 03:05:22 +1000 (EST)
Date: Wed, 29 Jul 2009 21:05:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7/7] hwmon: lm70: Convert to device table matching
Message-ID: <20090729170521.GG4803@oksana.dev.rtsoft.ru>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Jean Delvare <khali@linux-fr.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch makes the code a little bit nicer, and shorter.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/hwmon/lm70.c |   58 +++++++++++++++++--------------------------------
 1 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 3953c22..b4be110 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -32,6 +32,7 @@
 #include <linux/sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/mutex.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 
 
@@ -130,11 +131,21 @@ static DEVICE_ATTR(name, S_IRUGO, lm70_show_name, NULL);
 
 /*----------------------------------------------------------------------*/
 
-static int __devinit common_probe(struct spi_device *spi, int chip)
+static int __devinit lm70_probe(struct spi_device *spi,
+				const struct spi_device_id *id)
 {
+	int chip = (int)id->data;
 	struct lm70 *p_lm70;
 	int status;
 
+	/* signaling is SPI_MODE_0 for both LM70 and TMP121 */
+	if (spi->mode & (SPI_CPOL | SPI_CPHA))
+		return -EINVAL;
+
+	/* 3-wire link (shared SI/SO) for LM70 */
+	if (chip == LM70_CHIP_LM70 && !(spi->mode & SPI_3WIRE))
+		return -EINVAL;
+
 	/* NOTE:  we assume 8-bit words, and convert to 16 bits manually */
 
 	p_lm70 = kzalloc(sizeof *p_lm70, GFP_KERNEL);
@@ -170,26 +181,6 @@ out_dev_reg_failed:
 	return status;
 }
 
-static int __devinit lm70_probe(struct spi_device *spi,
-				const struct spi_device_id *id)
-{
-	/* signaling is SPI_MODE_0 on a 3-wire link (shared SI/SO) */
-	if ((spi->mode & (SPI_CPOL | SPI_CPHA)) || !(spi->mode & SPI_3WIRE))
-		return -EINVAL;
-
-	return common_probe(spi, LM70_CHIP_LM70);
-}
-
-static int __devinit tmp121_probe(struct spi_device *spi,
-				  const struct spi_device_id *id)
-{
-	/* signaling is SPI_MODE_0 with only MISO connected */
-	if (spi->mode & (SPI_CPOL | SPI_CPHA))
-		return -EINVAL;
-
-	return common_probe(spi, LM70_CHIP_TMP121);
-}
-
 static int __devexit lm70_remove(struct spi_device *spi)
 {
 	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
@@ -203,41 +194,32 @@ static int __devexit lm70_remove(struct spi_device *spi)
 	return 0;
 }
 
-static struct spi_driver tmp121_driver = {
-	.driver = {
-		.name	= "tmp121",
-		.owner	= THIS_MODULE,
-	},
-	.probe	= tmp121_probe,
-	.remove	= __devexit_p(lm70_remove),
+
+static const struct spi_device_id lm70_ids[] = {
+	{ "lm70",   (void *)LM70_CHIP_LM70 },
+	{ "tmp121", (void *)LM70_CHIP_TMP121 },
+	{ },
 };
+MODULE_DEVICE_TABLE(spi, lm70_ids);
 
 static struct spi_driver lm70_driver = {
 	.driver = {
 		.name	= "lm70",
 		.owner	= THIS_MODULE,
 	},
+	.id_table = lm70_ids,
 	.probe	= lm70_probe,
 	.remove	= __devexit_p(lm70_remove),
 };
 
 static int __init init_lm70(void)
 {
-	int ret = spi_register_driver(&lm70_driver);
-	if (ret)
-		return ret;
-
-	ret = spi_register_driver(&tmp121_driver);
-	if (ret)
-		spi_unregister_driver(&lm70_driver);
-
-	return ret;
+	return spi_register_driver(&lm70_driver);
 }
 
 static void __exit cleanup_lm70(void)
 {
 	spi_unregister_driver(&lm70_driver);
-	spi_unregister_driver(&tmp121_driver);
 }
 
 module_init(init_lm70);
-- 
1.6.3.3
