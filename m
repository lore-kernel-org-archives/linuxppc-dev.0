Return-Path: <B48286@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 043701400EF
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2014 21:08:44 +1000 (EST)
From: Hou Zhiqiang <B48286@freescale.com>
To: <linux-mtd@lists.infradead.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH V4] mtd: m25p80: Modify the name of mtd_info
Date: Mon, 21 Apr 2014 19:06:21 +0800
Message-ID: <1398078381-22452-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Hou Zhiqiang <B48286@freescale.com>,
 mingkai.hu@freescale.com, computersforpeace@gmail.com, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To specify spi flash layouts by "mtdparts=..." in cmdline, we must
give mtd_info a fixed name,because the cmdlinepart's parser will
match the name of mtd_info given in cmdline.
Now, if use DT, the mtd_info's name will be spi->dev->name. It
consists of spi_master->bus_num, and the spi_master->bus_num maybe
dynamically fetched. So, in this case, replace the component bus_num
with thei physical address of spi master.

Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
V4:
	add check no-NULL for pointer of master's device node, and if it failed
	to get physcial address of the master, then name the mtd_info by the
	name of spi->dev.
V3:
	Fix a bug, matching unsigned long long with "%llx".
V2:
	1. Fix some code style issue.
	2. Cast physical address to unsigned long long.

 drivers/mtd/devices/m25p80.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 7eda71d..998b283 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -934,9 +934,11 @@ static int m25p_probe(struct spi_device *spi)
 	struct flash_platform_data	*data;
 	struct m25p			*flash;
 	struct flash_info		*info;
-	unsigned			i;
+	unsigned			i, ret;
 	struct mtd_part_parser_data	ppdata;
 	struct device_node *np = spi->dev.of_node;
+	struct resource res;
+	struct device_node *mnp = spi->master->dev.of_node;
 
 	/* Platform data helps sort out which chip type we have, as
 	 * well as how this board partitions it.  If we don't have
@@ -1009,7 +1011,17 @@ static int m25p_probe(struct spi_device *spi)
 
 	if (data && data->name)
 		flash->mtd.name = data->name;
-	else
+	else if (mnp) {
+		ret = of_address_to_resource(mnp, 0, &res);
+		if (!ret) {
+			flash->mtd.name = kasprintf(GFP_KERNEL, "spi%llx.%d",
+					(unsigned long long)res.start,
+					spi->chip_select);
+			if (!flash->mtd.name)
+				return -ENOMEM;
+		} else
+			dev_dbg(&spi->dev, "failed to get spi master resource\n");
+	} else
 		flash->mtd.name = dev_name(&spi->dev);
 
 	flash->mtd.type = MTD_NORFLASH;
-- 
1.8.5
