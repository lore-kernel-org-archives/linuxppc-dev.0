Return-Path: <B35362@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
 [216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F3076100950
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 12:57:46 +1100 (EST)
From: <b35362@freescale.com>
To: <dwmw2@infradead.org>, <Artem.Bityutskiy@nokia.com>,
 <scottwood@freescale.com>
Subject: [PATCH 2/3] mtd/nand : set correct length to FBCR for a non-full-page
 write
Date: Thu, 24 Nov 2011 08:41:45 +0800
Message-ID: <1322095306-13156-2-git-send-email-b35362@freescale.com>
In-Reply-To: <1322095306-13156-1-git-send-email-b35362@freescale.com>
References: <1322095306-13156-1-git-send-email-b35362@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liu Shuo <b35362@freescale.com>

When we do a non-full-page write, the length be set to FBCR should
not be 'elbc_fcm_ctrl->index', it should be 'elbc_fcm_ctrl->index -
elbc_fcm_ctrl->column'.

Signed-off-by: Liu Shuo <b35362@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 6fce7da..d634c5f 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -474,7 +474,8 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		 */
 		if (elbc_fcm_ctrl->oob || elbc_fcm_ctrl->column != 0 ||
 		    elbc_fcm_ctrl->index != mtd->writesize + mtd->oobsize)
-			out_be32(&lbc->fbcr, elbc_fcm_ctrl->index);
+			out_be32(&lbc->fbcr,
+				elbc_fcm_ctrl->index - elbc_fcm_ctrl->column);
 		else
 			out_be32(&lbc->fbcr, 0);
 
-- 
1.7.1
