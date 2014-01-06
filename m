Return-Path: <B48286@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5AC982C0091
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Jan 2014 19:02:15 +1100 (EST)
From: Hou Zhiqiang <b48286@freescale.com>
To: <linux-mtd@lists.infradead.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] mtd: m25p80: Make the name of mtd_info fixed
Date: Mon, 6 Jan 2014 14:34:29 +0800
Message-ID: <1388990069-27066-1-git-send-email-b48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Hou Zhiqiang <b48286@freescale.com>,
 mingkai.hu@freescale.com, computersforpeace@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To give spi flash layout using "mtdparts=..." in cmdline, we must
give mtd_info a fixed name,because the cmdlinepart's parser will
match the name given in cmdline with the mtd_info.

Now, if use OF node, mtd_info's name will be spi->dev->name. It
consists of spi_master->bus_num, and the spi_master->bus_num maybe
dynamically fetched.
So, give the mtd_info a new fiexd name "name.cs", "name" is name of
spi_device_id and "cs" is chip-select in spi_dev.

Signed-off-by: Hou Zhiqiang <b48286@freescale.com>
---
 drivers/mtd/devices/m25p80.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index eb558e8..d1ed480 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -1012,7 +1012,8 @@ static int m25p_probe(struct spi_device *spi)
 	if (data && data->name)
 		flash->mtd.name = data->name;
 	else
-		flash->mtd.name = dev_name(&spi->dev);
+		flash->mtd.name = kasprintf(GFP_KERNEL, "%s.%d",
+				id->name, spi->chip_select);
 
 	flash->mtd.type = MTD_NORFLASH;
 	flash->mtd.writesize = 1;
-- 
1.8.4.1
