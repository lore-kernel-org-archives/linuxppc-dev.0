Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0CC06DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 23:07:39 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m1SC7WXL011000
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 05:07:33 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m1SC7UMR008594
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 06:07:31 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: dwmw2@infradead.org, linux-mtd@lists.infradead.org
Subject: [PATCH] MTD: fix partition scan control logic in physmap_of and
	fsl_elbc_nand
Date: Thu, 28 Feb 2008 20:17:31 +0800
Message-Id: <1204201051-13107-1-git-send-email-leoli@freescale.com>
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The generic rule for partition scan is to try all supported
partition types before an usable partition table is found.
However the original code returns unsuccessful when there is
an error in any of the partition types.

Signed-off-by: Li Yang <leoli@freescale.com>
Cc: Stefan Roese <sr@denx.de>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
---
I later found that Stefan has proposed a similar patch for physmap_of
and Peter proposed another patch to fix cmdlinepart instead.
I'd say that even after cmdlinepart patch is applied the scan control
logic still needs to be fixed.

 drivers/mtd/maps/physmap_of.c    |   12 ++----------
 drivers/mtd/nand/fsl_elbc_nand.c |    7 +------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 49acd41..5ebbbc4 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -225,23 +225,15 @@ static int __devinit of_flash_probe(struct of_device *dev,
 	 * line, these take precedence over device tree information */
 	err = parse_mtd_partitions(info->mtd, part_probe_types,
 	                           &info->parts, 0);
-	if (err < 0)
-		return err;
 
 #ifdef CONFIG_MTD_OF_PARTS
-	if (err == 0) {
+	if (err <= 0)
 		err = of_mtd_parse_partitions(&dev->dev, info->mtd,
 		                              dp, &info->parts);
-		if (err < 0)
-			return err;
-	}
 #endif
 
-	if (err == 0) {
+	if (err <= 0)
 		err = parse_obsolete_partitions(dev, info, dp);
-		if (err < 0)
-			return err;
-	}
 
 	if (err > 0)
 		add_mtd_partitions(info->mtd, info->parts, err);
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index b025dfe..72e9bd9 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -1054,16 +1054,11 @@ static int fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
 	/* First look for RedBoot table or partitions on the command
 	 * line, these take precedence over device tree information */
 	ret = parse_mtd_partitions(&priv->mtd, part_probe_types, &parts, 0);
-	if (ret < 0)
-		goto err;
 
 #ifdef CONFIG_MTD_OF_PARTS
-	if (ret == 0) {
+	if (ret <= 0)
 		ret = of_mtd_parse_partitions(priv->dev, &priv->mtd,
 		                              node, &parts);
-		if (ret < 0)
-			goto err;
-	}
 #endif
 
 	if (ret > 0)
-- 
1.5.4.rc4
