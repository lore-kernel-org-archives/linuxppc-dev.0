Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id F119BDDDEA
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 21:48:43 +1100 (EST)
Message-ID: <49099022.40908@grandegger.com>
Date: Thu, 30 Oct 2008 11:44:50 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linux-mtd@lists.infradead.org
Subject: [PATCH] NAND: fsl_upm: fix build problem with 2.6.28-rc2
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a problem with building the 2.6.28-rc2 kernel with
FSL UPM NAND support for the TQM8548 modules. For some reason
of_mtd_parse_partitions() requires on argument less in the meantime.
Furthermore, the return value is checks properly.
    
Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

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
