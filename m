Return-Path: <fkan@amcc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 019D0B7BBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 10:19:28 +1000 (EST)
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 59E1BDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 10:19:28 +1000 (EST)
From: Feng Kan <fkan@amcc.com>
To: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
Subject: [PATCH 1/1] Fix ECC Correction bug for SMC ordering for NDFC driver.
Date: Thu, 20 Aug 2009 17:19:17 -0700
Message-Id: <1250813957-1786-1-git-send-email-fkan@amcc.com>
Cc: Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix ECC Correction bug where the byte offset location were double
fliped causing correction routine to toggle the wrong byte location
in the ECC segment. The ndfc_calculate_ecc routine change the order
of getting the ECC code.
        /* The NDFC uses Smart Media (SMC) bytes order */
        ecc_code[0] = p[2];
        ecc_code[1] = p[1];
        ecc_code[2] = p[3];
But in the Correction algorithm when calculating the byte offset
location, the b1 is used as the upper part of the address. Which
again reverse the order making the final byte offset address 
location incorrect.
	byte_addr = (addressbits[b1] << 4) + addressbits[b0];
The order is change to read it in straight and let the correction
function to revert it to SMC order.

Signed-off-by: Feng Kan <fkan@amcc.com>
Acked-by: Victor Gallardo <vgallardo@amcc.com>
Acked-by: Prodyut Hazarika <phazarika@amcc.com>
---
 drivers/mtd/nand/ndfc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 5906c40..d9d3e6e 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -101,8 +101,8 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
 	wmb();
 	ecc = in_be32(ndfc->ndfcbase + NDFC_ECC);
 	/* The NDFC uses Smart Media (SMC) bytes order */
-	ecc_code[0] = p[2];
-	ecc_code[1] = p[1];
+	ecc_code[0] = p[1];
+	ecc_code[1] = p[2];
 	ecc_code[2] = p[3];
 
 	return 0;
-- 
1.5.5
