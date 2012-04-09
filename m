Return-Path: <B32579@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D07DB702A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2012 15:25:45 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH] driver/mtd: IFC NAND: Add support of ONFI NAND flash
Date: Mon, 9 Apr 2012 10:55:22 +0530
Message-ID: <1333949122-10401-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Prabhakar Kushwaha <prabhakar@freescale.com>,
 dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  - Fix NAND_CMD_READID command for ONFI detect.
  - Add NAND_CMD_PARAM command to read the ONFI parameter page.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
Acked-by: Scott Wood <scottwood@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
 Branch master

 drivers/mtd/nand/fsl_ifc_nand.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index c30ac7b..4e7f31e 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -375,21 +375,31 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 
 		return;
 
-	/* READID must read all 8 possible bytes */
 	case NAND_CMD_READID:
+	case NAND_CMD_PARAM: {
+		int timing = IFC_FIR_OP_RB;
+		if (command == NAND_CMD_PARAM)
+			timing = IFC_FIR_OP_RBCD;
+
 		out_be32(&ifc->ifc_nand.nand_fir0,
 				(IFC_FIR_OP_CMD0 << IFC_NAND_FIR0_OP0_SHIFT) |
 				(IFC_FIR_OP_UA  << IFC_NAND_FIR0_OP1_SHIFT) |
-				(IFC_FIR_OP_RB << IFC_NAND_FIR0_OP2_SHIFT));
+				(timing << IFC_NAND_FIR0_OP2_SHIFT));
 		out_be32(&ifc->ifc_nand.nand_fcr0,
-				NAND_CMD_READID << IFC_NAND_FCR0_CMD0_SHIFT);
-		/* 8 bytes for manuf, device and exts */
-		out_be32(&ifc->ifc_nand.nand_fbcr, 8);
-		ifc_nand_ctrl->read_bytes = 8;
+				command << IFC_NAND_FCR0_CMD0_SHIFT);
+		out_be32(&ifc->ifc_nand.row3, column);
+
+		/*
+		 * although currently it's 8 bytes for READID, we always read
+		 * the maximum 256 bytes(for PARAM)
+		 */
+		out_be32(&ifc->ifc_nand.nand_fbcr, 256);
+		ifc_nand_ctrl->read_bytes = 256;
 
 		set_addr(mtd, 0, 0, 0);
 		fsl_ifc_run_command(mtd);
 		return;
+	}
 
 	/* ERASE1 stores the block and page address */
 	case NAND_CMD_ERASE1:
-- 
1.7.5.4
