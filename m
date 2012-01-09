Return-Path: <B32579@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 745DFB6FCC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 23:24:38 +1100 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH 2/2][v2] mtd/nand: Fix IFC driver to support 2K NAND page
Date: Mon, 9 Jan 2012 17:54:26 +0530
Message-ID: <1326111866-13120-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

1) OOB area should be updated irrespective of NAND page size. Earlier it was
updated only for 512byte NAND page.

2) During OOB update fbcr should be equal to OOB size.

Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git (branch next)

 This patch is created on top of IFC driver patch (already floated in mailing
 list). Please find their link:
 http://patchwork.ozlabs.org/patch/133315/
 http://patchwork.ozlabs.org/patch/133316/

 Tested on P1010RDB

  Changes for v2: Incorporated Scott's comments
 	- Added missed NAND_CMD_READOOB
	- Updated function as per Scott's advice

 drivers/mtd/nand/fsl_ifc_nand.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index c0529ea..52bd706d 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -440,22 +440,19 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 			out_be32(&ifc->ifc_nand.nand_fir1,
 				 (IFC_FIR_OP_CW1 << IFC_NAND_FIR1_OP5_SHIFT));
 
-			if (column >= mtd->writesize) {
-				/* OOB area --> READOOB */
-				column -= mtd->writesize;
-				nand_fcr0 |= NAND_CMD_READOOB <<
-						IFC_NAND_FCR0_CMD0_SHIFT;
-				ifc_nand_ctrl->oob = 1;
-			} else if (column < 256)
-				/* First 256 bytes --> READ0 */
+			if (column >= mtd->writesize)
 				nand_fcr0 |=
-				NAND_CMD_READ0 << IFC_NAND_FCR0_CMD0_SHIFT;
+				NAND_CMD_READOOB << IFC_NAND_FCR0_CMD0_SHIFT;
 			else
-				/* Second 256 bytes --> READ1 */
 				nand_fcr0 |=
-				NAND_CMD_READ1 << IFC_NAND_FCR0_CMD0_SHIFT;
+				NAND_CMD_READ0 << IFC_NAND_FCR0_CMD0_SHIFT;
 		}
 
+		if (column >= mtd->writesize) {
+			/* OOB area --> READOOB */
+			column -= mtd->writesize;
+			ifc_nand_ctrl->oob = 1;
+		}
 		out_be32(&ifc->ifc_nand.nand_fcr0, nand_fcr0);
 		set_addr(mtd, column, page_addr, ifc_nand_ctrl->oob);
 		return;
@@ -466,7 +463,7 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		int full_page;
 		if (ifc_nand_ctrl->oob) {
 			out_be32(&ifc->ifc_nand.nand_fbcr,
-					ifc_nand_ctrl->index);
+				ifc_nand_ctrl->index - ifc_nand_ctrl->column);
 			full_page = 0;
 		} else {
 			out_be32(&ifc->ifc_nand.nand_fbcr, 0);
-- 
1.7.5.4
