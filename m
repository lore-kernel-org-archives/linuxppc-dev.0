Return-Path: <B35362@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 25FD51007D4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Dec 2011 16:48:46 +1100 (EST)
From: <shuo.liu@freescale.com>
To: <dwmw2@infradead.org>, <Artem.Bityutskiy@nokia.com>,
 <scottwood@freescale.com>
Subject: [PATCH 1/3] mtd/nand : use elbc_fcm_ctrl->oob to set FPAR_MS bit of
 FPAR
Date: Sun, 4 Dec 2011 12:31:36 +0800
Message-ID: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
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

On both of large-page chip and small-page chip, we always should use
'elbc_fcm_ctrl->oob' to set the FPAR_LP_MS/FPAR_SP_MS bit of FPAR, don't
use a overflowed 'column' to set it.

Signed-off-by: Liu Shuo <b35362@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index cc08a11..6fce7da 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -414,9 +414,17 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		         page_addr, column);
 
 		elbc_fcm_ctrl->column = column;
-		elbc_fcm_ctrl->oob = 0;
 		elbc_fcm_ctrl->use_mdr = 1;
 
+		if (column >= mtd->writesize) {
+			/* OOB area */
+			column -= mtd->writesize;
+			elbc_fcm_ctrl->oob = 1;
+		} else {
+			WARN_ON(column != 0);
+			elbc_fcm_ctrl->oob = 0;
+		}
+
 		fcr = (NAND_CMD_STATUS   << FCR_CMD1_SHIFT) |
 		      (NAND_CMD_SEQIN    << FCR_CMD2_SHIFT) |
 		      (NAND_CMD_PAGEPROG << FCR_CMD3_SHIFT);
@@ -441,16 +449,12 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 			         (FIR_OP_CW1 << FIR_OP6_SHIFT) |
 			         (FIR_OP_RS  << FIR_OP7_SHIFT));
 
-			if (column >= mtd->writesize) {
+			if (elbc_fcm_ctrl->oob)
 				/* OOB area --> READOOB */
-				column -= mtd->writesize;
 				fcr |= NAND_CMD_READOOB << FCR_CMD0_SHIFT;
-				elbc_fcm_ctrl->oob = 1;
-			} else {
-				WARN_ON(column != 0);
+			else
 				/* First 256 bytes --> READ0 */
 				fcr |= NAND_CMD_READ0 << FCR_CMD0_SHIFT;
-			}
 		}
 
 		out_be32(&lbc->fcr, fcr);
-- 
1.7.1
