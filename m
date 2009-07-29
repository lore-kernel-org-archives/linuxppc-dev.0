Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 35D4CB7B99
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 03:05:17 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 868A2DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 03:05:15 +1000 (EST)
Date: Wed, 29 Jul 2009 21:05:14 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6/7] hwmon: adxx: Convert to device table matching
Message-ID: <20090729170514.GF4803@oksana.dev.rtsoft.ru>
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
 drivers/hwmon/adcxx.c |  106 ++++++++-----------------------------------------
 1 files changed, 17 insertions(+), 89 deletions(-)

diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
index b01c0d5..6b3b057 100644
--- a/drivers/hwmon/adcxx.c
+++ b/drivers/hwmon/adcxx.c
@@ -43,6 +43,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/mutex.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 
 #define DRVNAME		"adcxx"
@@ -157,8 +158,10 @@ static struct sensor_device_attribute ad_input[] = {
 
 /*----------------------------------------------------------------------*/
 
-static int __devinit adcxx_probe(struct spi_device *spi, int channels)
+static int __devinit adcxx_probe(struct spi_device *spi,
+				 const struct spi_device_id *id)
 {
+	int channels = (int)id->data;
 	struct adcxx *adc;
 	int status;
 	int i;
@@ -204,30 +207,6 @@ out_err:
 	return status;
 }
 
-static int __devinit adcxx1s_probe(struct spi_device *spi,
-				   const struct spi_device_id *id)
-{
-	return adcxx_probe(spi, 1);
-}
-
-static int __devinit adcxx2s_probe(struct spi_device *spi,
-				   const struct spi_device_id *id)
-{
-	return adcxx_probe(spi, 2);
-}
-
-static int __devinit adcxx4s_probe(struct spi_device *spi,
-				   const struct spi_device_id *id)
-{
-	return adcxx_probe(spi, 4);
-}
-
-static int __devinit adcxx8s_probe(struct spi_device *spi,
-				   const struct spi_device_id *id)
-{
-	return adcxx_probe(spi, 8);
-}
-
 static int __devexit adcxx_remove(struct spi_device *spi)
 {
 	struct adcxx *adc = dev_get_drvdata(&spi->dev);
@@ -245,79 +224,33 @@ static int __devexit adcxx_remove(struct spi_device *spi)
 	return 0;
 }
 
-static struct spi_driver adcxx1s_driver = {
-	.driver = {
-		.name	= "adcxx1s",
-		.owner	= THIS_MODULE,
-	},
-	.probe	= adcxx1s_probe,
-	.remove	= __devexit_p(adcxx_remove),
+static const struct spi_device_id adcxx_ids[] = {
+	{ "adcxx1s", (void *)1 },
+	{ "adcxx2s", (void *)2 },
+	{ "adcxx4s", (void *)4 },
+	{ "adcxx8s", (void *)8 },
+	{ },
 };
+MODULE_DEVICE_TABLE(spi, adcxx_ids);
 
-static struct spi_driver adcxx2s_driver = {
+static struct spi_driver adcxx_driver = {
 	.driver = {
-		.name	= "adcxx2s",
+		.name	= "adcxx",
 		.owner	= THIS_MODULE,
 	},
-	.probe	= adcxx2s_probe,
-	.remove	= __devexit_p(adcxx_remove),
-};
-
-static struct spi_driver adcxx4s_driver = {
-	.driver = {
-		.name	= "adcxx4s",
-		.owner	= THIS_MODULE,
-	},
-	.probe	= adcxx4s_probe,
-	.remove	= __devexit_p(adcxx_remove),
-};
-
-static struct spi_driver adcxx8s_driver = {
-	.driver = {
-		.name	= "adcxx8s",
-		.owner	= THIS_MODULE,
-	},
-	.probe	= adcxx8s_probe,
+	.id_table = adcxx_ids,
+	.probe	= adcxx_probe,
 	.remove	= __devexit_p(adcxx_remove),
 };
 
 static int __init init_adcxx(void)
 {
-	int status;
-	status = spi_register_driver(&adcxx1s_driver);
-	if (status)
-		goto reg_1_failed;
-
-	status = spi_register_driver(&adcxx2s_driver);
-	if (status)
-		goto reg_2_failed;
-
-	status = spi_register_driver(&adcxx4s_driver);
-	if (status)
-		goto reg_4_failed;
-
-	status = spi_register_driver(&adcxx8s_driver);
-	if (status)
-		goto reg_8_failed;
-
-	return status;
-
-reg_8_failed:
-	spi_unregister_driver(&adcxx4s_driver);
-reg_4_failed:
-	spi_unregister_driver(&adcxx2s_driver);
-reg_2_failed:
-	spi_unregister_driver(&adcxx1s_driver);
-reg_1_failed:
-	return status;
+	return spi_register_driver(&adcxx_driver);
 }
 
 static void __exit exit_adcxx(void)
 {
-	spi_unregister_driver(&adcxx1s_driver);
-	spi_unregister_driver(&adcxx2s_driver);
-	spi_unregister_driver(&adcxx4s_driver);
-	spi_unregister_driver(&adcxx8s_driver);
+	spi_unregister_driver(&adcxx_driver);
 }
 
 module_init(init_adcxx);
@@ -326,8 +259,3 @@ module_exit(exit_adcxx);
 MODULE_AUTHOR("Marc Pignat");
 MODULE_DESCRIPTION("National Semiconductor adcxx8sxxx Linux driver");
 MODULE_LICENSE("GPL");
-
-MODULE_ALIAS("spi:adcxx1s");
-MODULE_ALIAS("spi:adcxx2s");
-MODULE_ALIAS("spi:adcxx4s");
-MODULE_ALIAS("spi:adcxx8s");
-- 
1.6.3.3
