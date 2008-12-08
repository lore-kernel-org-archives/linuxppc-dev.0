Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4B89DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2008 14:44:57 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mB83il4v028834
	for <linuxppc-dev@ozlabs.org>; Sun, 7 Dec 2008 20:44:53 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id mB83ijtg010660
	for <linuxppc-dev@ozlabs.org>; Sun, 7 Dec 2008 21:44:46 -0600 (CST)
From: Jason Jin <Jason.jin@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] Set the fsl elbc ECCM according the settings in bootloader.
Date: Mon,  8 Dec 2008 11:41:03 +0800
Message-Id: <1228707663-26995-1-git-send-email-Jason.jin@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org,
	Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ECCM maybe set in bootloader, Get ECCM settings from the bootloader,
can avoid the image written by bootloader cannot read out by kernel.

But the limitation of doing it this way is that, it could break large page
NAND if it is written with NAND disabled in u-boot and read with NAND
enabled, or vice versa.

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 4aa5bd6..65929db 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -777,7 +777,9 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	/* Fill in fsl_elbc_mtd structure */
 	priv->mtd.priv = chip;
 	priv->mtd.owner = THIS_MODULE;
-	priv->fmr = 0; /* rest filled in later */
+
+	/* Set the ECCM according to the settings in bootloader.*/
+	priv->fmr = in_be32(&lbc->fmr) & FMR_ECCM;
 
 	/* fill in nand_chip structure */
 	/* set up function call table */
-- 
1.5.4
