Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D42DDDDE31
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 03:38:45 +1100 (EST)
Date: Wed, 26 Nov 2008 19:38:40 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH for 2.6.28] NAND: fsl_upm: fix build problem with 2.6.28-rc2
Message-ID: <20081126163840.GA21669@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Wolfgang Grandegger <wg@grandegger.com>

The patch fixes following build error:

  CC      drivers/mtd/nand/fsl_upm.o
drivers/mtd/nand/fsl_upm.c: In function 'fun_chip_init':
drivers/mtd/nand/fsl_upm.c:168: warning: passing argument 2 of 'of_mtd_parse_partitions' from incompatible pointer type
drivers/mtd/nand/fsl_upm.c:168: warning: passing argument 3 of 'of_mtd_parse_partitions' from incompatible pointer type
drivers/mtd/nand/fsl_upm.c:168: error: too many arguments to function 'of_mtd_parse_partitions'
make[1]: *** [drivers/mtd/nand/fsl_upm.o] Error 1

The breakage was introduced in 69fd3a8d098faf41a04930afa83757c0555ee360
("[MTD] remove unused mtd parameter in of_mtd_parse_partitions()").

While at it, also add a check for the of_mtd_parse_partitions() return
value.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mtd/nand/fsl_upm.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 024e3ff..a83192f 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -163,9 +163,11 @@ static int __devinit fun_chip_init(struct fsl_upm_nand *fun,
 	ret = parse_mtd_partitions(&fun->mtd, part_types, &fun->parts, 0);
 
 #ifdef CONFIG_MTD_OF_PARTS
-	if (ret == 0)
-		ret = of_mtd_parse_partitions(fun->dev, &fun->mtd,
-					      flash_np, &fun->parts);
+	if (ret == 0) {
+		ret = of_mtd_parse_partitions(fun->dev, flash_np, &fun->parts);
+		if (ret < 0)
+			goto err;
+	}
 #endif
 	if (ret > 0)
 		ret = add_mtd_partitions(&fun->mtd, fun->parts, ret);
-- 
1.5.6.5
