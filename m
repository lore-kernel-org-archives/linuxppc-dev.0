Return-Path: <B48286@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6404A1400A9
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2014 16:31:01 +1000 (EST)
From: Hou Zhiqiang <B48286@freescale.com>
To: <linux-mtd@lists.infradead.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH V5] mtd: m25p80: modify the name of mtd_info
Date: Mon, 28 Apr 2014 14:28:25 +0800
Message-ID: <1398666505-4907-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: shijie8@gmail.com, Hou Zhiqiang <B48286@freescale.com>,
 scottwood@freescale.com, mingkai.hu@freescale.com, computersforpeace@gmail.com,
 dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To specify spi flash layouts by "mtdparts=..." in cmdline, we must
give mtd_info a fixed name, because the cmdlinepart's parser will
match the name of mtd_info given in cmdline.
Now, if it use DT, the mtd_info's name will be spi->dev->name. It
consists of spi_master->bus_num, and the spi_master->bus_num maybe
dynamically fetched. So, in this case, replace the component bus_num
with the physical address of spi master.

Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
V5:
	Rebase on the latest l2-mtd tree.
V4:
	add check no-NULL for pointer of master's device node, and if it failed
	to get physcial address of the master, then name the mtd_info by the
	name of spi->dev.
V3:
	Fix a bug, matching unsigned long long with "%llx".
V2:
	1. Fix some code style issue.
	2. Cast physical address to unsigned long long.

 drivers/mtd/devices/m25p80.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 1557d8f..329aa2c 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -26,6 +26,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/mtd/spi-nor.h>
+#include <linux/of_address.h>
 
 #define	MAX_CMD_SIZE		6
 struct m25p {
@@ -196,6 +197,8 @@ static int m25p_probe(struct spi_device *spi)
 	struct m25p *flash;
 	struct spi_nor *nor;
 	enum read_mode mode = SPI_NOR_NORMAL;
+	struct resource res;
+	struct device_node *mnp = spi->master->dev.of_node;
 	int ret;
 
 	flash = devm_kzalloc(&spi->dev, sizeof(*flash), GFP_KERNEL);
@@ -228,6 +231,17 @@ static int m25p_probe(struct spi_device *spi)
 	data = dev_get_platdata(&spi->dev);
 	ppdata.of_node = spi->dev.of_node;
 
+	if (mnp) {
+		ret = of_address_to_resource(mnp, 0, &res);
+		if (!ret) {
+			flash->mtd.name = kasprintf(GFP_KERNEL, "spi%llx.%d",
+					(unsigned long long)res.start,
+					spi->chip_select);
+			if (!flash->mtd.name)
+				return -ENOMEM;
+		}
+	}
+
 	return mtd_device_parse_register(&flash->mtd, NULL, &ppdata,
 			data ? data->parts : NULL,
 			data ? data->nr_parts : 0);
-- 
1.8.5
