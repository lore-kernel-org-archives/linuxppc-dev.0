Return-Path: <B21284@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142]) by ozlabs.org (Postfix) with ESMTP id 0FB4A1008C4
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 18:22:38 +1000 (EST)
Received: from mail23-db3 (localhost.localdomain [127.0.0.1])	by
	mail23-db3-R.bigfish.com (Postfix) with ESMTP id B58336A81C6	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 08:07:24 +0000 (UTC)
Received: from DB3EHSMHS003.bigfish.com (unknown [10.3.81.251])	by
	mail23-db3.bigfish.com (Postfix) with ESMTP id 4183396004E	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 08:07:24 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7287AZM012342	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 01:07:21 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o7287BM2014167	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 03:07:16 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
Subject: [PATCH v2 3/6] mtd: m25p80: add support to parse the SPI flash's
	partitions
Date: Mon, 2 Aug 2010 15:52:01 +0800
Message-ID: <1280735524-17547-4-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
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

v2:
 - Move the flash partition function from of_spi.c to MTD driver

 drivers/mtd/devices/m25p80.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 81e49a9..5f00075 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -752,6 +752,31 @@ static const struct spi_device_id *__devinit jedec_probe(struct spi_device *spi)
 	return NULL;
 }
 
+/*
+ * parse_flash_partition - Parse the flash partition on the SPI bus
+ * @spi: Pointer to spi_device device
+ */
+void parse_flash_partition(struct spi_device *spi)
+{
+	struct mtd_partition *parts;
+	struct flash_platform_data *pdata;
+	int nr_parts = 0;
+	struct device_node *np = spi->dev.of_node;
+
+	nr_parts = of_mtd_parse_partitions(&spi->dev, np, &parts);
+	if (!nr_parts)
+		return;
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return;
+
+	pdata->parts = parts;
+	pdata->nr_parts = nr_parts;
+	spi->dev.platform_data = pdata;
+
+	return;
+}
 
 /*
  * board specific setup should have ensured the SPI clock used here
@@ -771,6 +796,10 @@ static int __devinit m25p_probe(struct spi_device *spi)
 	 * a chip ID, try the JEDEC id commands; they'll work for most
 	 * newer chips, even if we don't recognize the particular chip.
 	 */
+
+	/* Parse the flash partition */
+	parse_flash_partition(spi);
+
 	data = spi->dev.platform_data;
 	if (data && data->type) {
 		const struct spi_device_id *plat_id;
-- 
1.6.4
