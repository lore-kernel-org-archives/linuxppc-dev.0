Return-Path: <zajec5@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Rlxs6nqYzDr02
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 18:16:14 +1000 (AEST)
Received: by mail-lf0-x243.google.com with SMTP id b22-v6so14052894lfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 01:16:14 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Cyril Bur <cyrilbur@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org,
 Timothy Pearson <tpearson@raptorengineering.com>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] mtd: powernv_flash: set of_node in mtd's dev
Date: Fri, 13 Jul 2018 10:15:59 +0200
Message-Id: <20180713081559.4373-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rafał Miłecki <rafal@milecki.pl>

This enables some features implemented in mtd subsystem like reading
label and partitioning info from DT.

Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/mtd/devices/powernv_flash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index c1312b141ae0..33593122e49b 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -223,6 +223,7 @@ static int powernv_flash_set_driver_info(struct device *dev,
 	mtd->_read = powernv_flash_read;
 	mtd->_write = powernv_flash_write;
 	mtd->dev.parent = dev;
+	mtd_set_of_node(mtd, dev->of_node);
 	return 0;
 }
 
-- 
2.13.7
