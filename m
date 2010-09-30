Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 474C9B73BF
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 18:26:12 +1000 (EST)
Received: from mail87-va3 (localhost.localdomain [127.0.0.1])	by
	mail87-va3-R.bigfish.com (Postfix) with ESMTP id 7C6DD9B813B	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 08:26:08 +0000 (UTC)
Received: from VA3EHSMHS024.bigfish.com (unknown [10.7.14.251])	by
	mail87-va3.bigfish.com (Postfix) with ESMTP id 11B651E004E	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 08:26:08 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8U8Q6oT006861	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 01:26:06 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8U8fXHE017737	for <linuxppc-dev@ozlabs.org>;
	Thu, 30 Sep 2010 03:41:49 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-mtd@lists.infradead.org
Subject: [PATCH v3 5/7] mtd: m25p80: add support to parse the SPI flash's
	partitions
Date: Thu, 30 Sep 2010 16:00:44 +0800
Message-ID: <1285833646-12006-6-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1285833646-12006-5-git-send-email-Mingkai.hu@freescale.com>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-4-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-5-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Mingkai Hu <Mingkai.hu@freescale.com>
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
v3:
 - Move the SPI flash partition code to the probe function.

 drivers/mtd/devices/m25p80.c |   39 +++++++++++++++++++++++++++------------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 6f512b5..47d53c7 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -772,7 +772,7 @@ static const struct spi_device_id *__devinit jedec_probe(struct spi_device *spi)
 static int __devinit m25p_probe(struct spi_device *spi)
 {
 	const struct spi_device_id	*id = spi_get_device_id(spi);
-	struct flash_platform_data	*data;
+	struct flash_platform_data	data, *pdata;
 	struct m25p			*flash;
 	struct flash_info		*info;
 	unsigned			i;
@@ -782,13 +782,27 @@ static int __devinit m25p_probe(struct spi_device *spi)
 	 * a chip ID, try the JEDEC id commands; they'll work for most
 	 * newer chips, even if we don't recognize the particular chip.
 	 */
-	data = spi->dev.platform_data;
-	if (data && data->type) {
+	pdata = spi->dev.platform_data;
+	if (!pdata && spi->dev.of_node) {
+		int nr_parts;
+		struct mtd_partition *parts;
+		struct device_node *np = spi->dev.of_node;
+
+		nr_parts = of_mtd_parse_partitions(&spi->dev, np, &parts);
+		if (nr_parts) {
+			pdata = &data;
+			memset(pdata, 0, sizeof(*pdata));
+			pdata->parts = parts;
+			pdata->nr_parts = nr_parts;
+		}
+	}
+
+	if (pdata && pdata->type) {
 		const struct spi_device_id *plat_id;
 
 		for (i = 0; i < ARRAY_SIZE(m25p_ids) - 1; i++) {
 			plat_id = &m25p_ids[i];
-			if (strcmp(data->type, plat_id->name))
+			if (strcmp(pdata->type, plat_id->name))
 				continue;
 			break;
 		}
@@ -796,7 +810,8 @@ static int __devinit m25p_probe(struct spi_device *spi)
 		if (i < ARRAY_SIZE(m25p_ids) - 1)
 			id = plat_id;
 		else
-			dev_warn(&spi->dev, "unrecognized id %s\n", data->type);
+			dev_warn(&spi->dev, "unrecognized id %s\n",
+					pdata->type);
 	}
 
 	info = (void *)id->driver_data;
@@ -847,8 +862,8 @@ static int __devinit m25p_probe(struct spi_device *spi)
 		write_sr(flash, 0);
 	}
 
-	if (data && data->name)
-		flash->mtd.name = data->name;
+	if (pdata && pdata->name)
+		flash->mtd.name = pdata->name;
 	else
 		flash->mtd.name = dev_name(&spi->dev);
 
@@ -919,9 +934,9 @@ static int __devinit m25p_probe(struct spi_device *spi)
 					part_probes, &parts, 0);
 		}
 
-		if (nr_parts <= 0 && data && data->parts) {
-			parts = data->parts;
-			nr_parts = data->nr_parts;
+		if (nr_parts <= 0 && pdata && pdata->parts) {
+			parts = pdata->parts;
+			nr_parts = pdata->nr_parts;
 		}
 
 		if (nr_parts > 0) {
@@ -937,9 +952,9 @@ static int __devinit m25p_probe(struct spi_device *spi)
 			flash->partitioned = 1;
 			return add_mtd_partitions(&flash->mtd, parts, nr_parts);
 		}
-	} else if (data && data->nr_parts)
+	} else if (pdata && pdata->nr_parts)
 		dev_warn(&spi->dev, "ignoring %d default partitions on %s\n",
-				data->nr_parts, data->name);
+				pdata->nr_parts, pdata->name);
 
 	return add_mtd_device(&flash->mtd) == 1 ? -ENODEV : 0;
 }
-- 
1.6.4
