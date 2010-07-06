Return-Path: <b10812@lc1106.zin33.ap.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3B4DB6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Jul 2010 14:24:40 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o664Oask024105 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 5 Jul 2010 21:24:36 -0700 (MST)
From: Poonam Aggrwal <poonam.aggrwal@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] [NAND FSL eLBC] Modified the NAND FSL elbc driver code to
	correctly determine which chipselect is connected to NAND flash.
Date: Tue,  6 Jul 2010 09:54:33 +0530
Message-Id: <1278390273-32577-1-git-send-email-poonam.aggrwal@freescale.com>
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    The current code that determines which bank/chipselect is used for a
    given NAND instance only worked for 32-bit addresses and assumed
    a 1:1 mapping.  This breaks in 36-bit physical configs.

Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Acked-by: Scott Wood <scottwood@freescale.com>
---
Tested on P2020RDB and P1020RDB platforms.
 drivers/mtd/nand/fsl_elbc_nand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 09228c6..a9b0cfa 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -853,7 +853,7 @@ static int __devinit fsl_elbc_nand_probe(struct of_device *dev,
 		    (in_be32(&lbc->bank[bank].br) & BR_MSEL) == BR_MS_FCM &&
 		    (in_be32(&lbc->bank[bank].br) &
 		     in_be32(&lbc->bank[bank].or) & BR_BA)
-		     == res.start)
+		     == (u32)res.start)
 			break;
 
 	if (bank >= MAX_BANKS) {
-- 
1.5.6.5
