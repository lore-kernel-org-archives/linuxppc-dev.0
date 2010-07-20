Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by ozlabs.org (Postfix) with ESMTP id 114AEB6EF3
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 12:36:34 +1000 (EST)
Received: from mail187-va3 (localhost.localdomain [127.0.0.1])	by
	mail187-va3-R.bigfish.com (Postfix) with ESMTP id B3607CD85AF	for
	<linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 02:21:24 +0000 (UTC)
Received: from VA3EHSMHS036.bigfish.com (unknown [10.7.14.237])	by
	mail187-va3.bigfish.com (Postfix) with ESMTP id 7026EEE804E	for
	<linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 02:21:24 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6K2LM6V006757	for
	<linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 19:21:23 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o6K2XWDf023963	for <linuxppc-dev@ozlabs.org>;
	Mon, 19 Jul 2010 21:33:38 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/6] of/spi: add support to parse the SPI flash's partitions
Date: Tue, 20 Jul 2010 10:08:22 +0800
Message-ID: <1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
 drivers/of/of_spi.c       |   11 +++++++++++
 drivers/spi/spi_mpc8xxx.c |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
index 5fed7e3..284ca0e 100644
--- a/drivers/of/of_spi.c
+++ b/drivers/of/of_spi.c
@@ -10,6 +10,8 @@
 #include <linux/device.h>
 #include <linux/spi/spi.h>
 #include <linux/of_spi.h>
+#include <linux/spi/flash.h>
+#include <linux/mtd/partitions.h>
 
 /**
  * of_register_spi_devices - Register child devices onto the SPI bus
@@ -26,6 +28,7 @@ void of_register_spi_devices(struct spi_master *master, struct device_node *np)
 	const __be32 *prop;
 	int rc;
 	int len;
+	struct flash_platform_data *pdata;
 
 	for_each_child_of_node(np, nc) {
 		/* Alloc an spi_device */
@@ -81,6 +84,14 @@ void of_register_spi_devices(struct spi_master *master, struct device_node *np)
 		of_node_get(nc);
 		spi->dev.of_node = nc;
 
+		/* Parse the mtd partitions */
+		pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return;
+		pdata->nr_parts = of_mtd_parse_partitions(&master->dev,
+				nc, &pdata->parts);
+		spi->dev.platform_data = pdata;
+
 		/* Register the new device */
 		request_module(spi->modalias);
 		rc = spi_add_device(spi);
diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index efed70e..0fadaeb 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -137,6 +137,7 @@ int mpc8xxx_spi_transfer(struct spi_device *spi,
 
 void mpc8xxx_spi_cleanup(struct spi_device *spi)
 {
+	kfree(spi->dev.platform_data);
 	kfree(spi->controller_state);
 }
 
-- 
1.6.4
