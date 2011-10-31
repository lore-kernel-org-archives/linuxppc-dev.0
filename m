Return-Path: <B35362@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 5F7C7B6F7D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2011 21:50:39 +1100 (EST)
From: <b35362@freescale.com>
To: <dwmw2@infradead.org>, <Artem.Bityutskiy@nokia.com>
Subject: [PATCH] mtd/nand : set Nand flash page address to FBAR and FPAR
 correctly
Date: Mon, 31 Oct 2011 17:38:20 +0800
Message-ID: <1320053901-23801-2-git-send-email-b35362@freescale.com>
In-Reply-To: <1320053901-23801-1-git-send-email-b35362@freescale.com>
References: <1320053901-23801-1-git-send-email-b35362@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r58472@freescale.com, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, scottwood@freescale.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
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
index 33d8aad..681d8c5 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -167,15 +167,22 @@ static void set_addr(struct mtd_info *mtd, int column, int page_addr, int oob)
 
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
