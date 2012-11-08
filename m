Return-Path: <B32579@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 431C82C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2012 19:13:27 +1100 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linux-mtd@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] driver/mtd/IFC:Wait tWB time,
 poll R/B before command execution
Date: Thu, 8 Nov 2012 13:42:59 +0530
Message-ID: <1352362380-13568-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Hemant Nautiyal <hemant.nautiyal@freescale.com>,
 Prabhakar Kushwaha <prabhakar@freescale.com>, dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IFC_FIR_OP_CMD0 issues command for execution without checking flash
readiness. It may cause problem if flash is not ready. Instead use
IFC_FIR_OP_CW0 which Wait for tWB time and poll R/B to return high or
time-out, before issuing command.

NAND_CMD_READID command implemention does not fulfill above requirement. So
update its programming.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
Signed-off-by: Hemant Nautiyal <hemant.nautiyal@freescale.com>
---
 Based upon git://git.infradead.org/linux-mtd.git branch master

 drivers/mtd/nand/fsl_ifc_nand.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 8f0dd13..7e5b17c 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -382,7 +382,7 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 			timing = IFC_FIR_OP_RBCD;
 
 		out_be32(&ifc->ifc_nand.nand_fir0,
-				(IFC_FIR_OP_CMD0 << IFC_NAND_FIR0_OP0_SHIFT) |
+				(IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
 				(IFC_FIR_OP_UA  << IFC_NAND_FIR0_OP1_SHIFT) |
 				(timing << IFC_NAND_FIR0_OP2_SHIFT));
 		out_be32(&ifc->ifc_nand.nand_fcr0,
@@ -785,7 +785,7 @@ static void fsl_ifc_sram_init(struct fsl_ifc_mtd *priv)
 
 	/* READID */
 	out_be32(&ifc->ifc_nand.nand_fir0,
-			(IFC_FIR_OP_CMD0 << IFC_NAND_FIR0_OP0_SHIFT) |
+			(IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
 			(IFC_FIR_OP_UA  << IFC_NAND_FIR0_OP1_SHIFT) |
 			(IFC_FIR_OP_RB << IFC_NAND_FIR0_OP2_SHIFT));
 	out_be32(&ifc->ifc_nand.nand_fcr0,
-- 
1.7.9.5
