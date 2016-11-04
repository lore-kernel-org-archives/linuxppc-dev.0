Return-Path: <yamada.masahiro@socionext.com>
Received: from condef008-v.nifty.com (condef008-v.nifty.com [210.131.4.245])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9JYd1m7xzDvXw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 21:51:49 +1100 (AEDT)
Received: from conuserg-07.nifty.com ([10.26.8.70])by condef008-v.nifty.com
 with ESMTP id uA4AgIdV011903
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 19:42:18 +0900
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-mtd@lists.infradead.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 David Woodhouse <dwmw2@infradead.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/22] mtd: nand: pasemi: return error code of nand_scan() on
 error
Date: Fri,  4 Nov 2016 19:42:56 +0900
Message-Id: <1478256190-7452-9-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
References: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The nand_scan() returns an appropriate error value when it fails.
Use it instead of the fixed error code -ENXIO.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/pasemi_nand.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
index 5de7591..074b8b0 100644
--- a/drivers/mtd/nand/pasemi_nand.c
+++ b/drivers/mtd/nand/pasemi_nand.c
@@ -156,10 +156,9 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 	chip->bbt_options = NAND_BBT_USE_FLASH;
 
 	/* Scan to find existence of the device */
-	if (nand_scan(pasemi_nand_mtd, 1)) {
-		err = -ENXIO;
+	err = nand_scan(pasemi_nand_mtd, 1);
+	if (err)
 		goto out_lpc;
-	}
 
 	if (mtd_device_register(pasemi_nand_mtd, NULL, 0)) {
 		dev_err(dev, "Unable to register MTD device\n");
-- 
1.9.1
