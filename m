Return-Path: <B35362@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A76BEB6F71
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 21:27:58 +1100 (EST)
From: <shuo.liu@freescale.com>
To: <dwmw2@infradead.org>, <Artem.Bityutskiy@nokia.com>,
 <scottwood@freescale.com>
Subject: [PATCH 1/2] mtd/nand : set Nand flash page address to FBAR and FPAR
 correctly
Date: Fri, 9 Dec 2011 17:42:54 +0800
Message-ID: <1323423775-26951-1-git-send-email-shuo.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org, shuo.liu@freescale.com,
 linux-mtd@lists.infradead.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liu Shuo <b35362@freescale.com>

If we use the Nand flash chip whose number of pages in a block is greater
than 64(for large page), we must treat the low bit of FBAR as being the
high bit of the page address due to the limitation of FCM, it simply uses
the low 6-bits (for large page) of the combined block/page address as the
FPAR component, rather than considering the actual block size.

Signed-off-by: Liu Shuo <b35362@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Tang Yuantian <b29983@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 7db573e..d29479a 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -166,15 +166,22 @@ static void set_addr(struct mtd_info *mtd, int column, int page_addr, int oob)
 
 	elbc_fcm_ctrl->page = page_addr;
 
-	out_be32(&lbc->fbar,
-	         page_addr >> (chip->phys_erase_shift - chip->page_shift));
-
 	if (priv->page_size) {
+		/*
+		 * large page size chip : FPAR[PI] save the lowest 6 bits,
+		 *                        FBAR[BLK] save the other bits.
+		 */
+		out_be32(&lbc->fbar, page_addr >> 6);
 		out_be32(&lbc->fpar,
 		         ((page_addr << FPAR_LP_PI_SHIFT) & FPAR_LP_PI) |
 		         (oob ? FPAR_LP_MS : 0) | column);
 		buf_num = (page_addr & 1) << 2;
 	} else {
+		/*
+		 * small page size chip : FPAR[PI] save the lowest 5 bits,
+		 *                        FBAR[BLK] save the other bits.
+		 */
+		out_be32(&lbc->fbar, page_addr >> 5);
 		out_be32(&lbc->fpar,
 		         ((page_addr << FPAR_SP_PI_SHIFT) & FPAR_SP_PI) |
 		         (oob ? FPAR_SP_MS : 0) | column);
-- 
1.7.1
