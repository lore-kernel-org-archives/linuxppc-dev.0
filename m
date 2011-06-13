Return-Path: <B21989@freescale.com>
Received: from CH1EHSOBE018.bigfish.com (ch1ehsobe005.messaging.microsoft.com
	[216.32.181.185]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EAF59B6FCB
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jun 2011 13:15:37 +1000 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: fix NAND_CMD_READID read bytes number
Date: Mon, 13 Jun 2011 10:23:12 +0800
Message-ID: <1307931792-30386-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linux-mtd@lists.infradead.org,
	Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

when nand_get_flash_type() is called, it will read 8 bytes of ID instead of 5,
but the driver only read 5 bytes, so kernel will dump error messages like:

fsl-lbc ffe124000.localbus: read_byte beyond end of buffer
fsl-lbc ffe124000.localbus: read_byte beyond end of buffer
fsl-lbc ffe124000.localbus: read_byte beyond end of buffer

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Acked-by: Scott Wood <scottwood@freescale.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 0bb254c..33d8aad 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -339,9 +339,9 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		                    (FIR_OP_UA  << FIR_OP1_SHIFT) |
 		                    (FIR_OP_RBW << FIR_OP2_SHIFT));
 		out_be32(&lbc->fcr, NAND_CMD_READID << FCR_CMD0_SHIFT);
-		/* 5 bytes for manuf, device and exts */
-		out_be32(&lbc->fbcr, 5);
-		elbc_fcm_ctrl->read_bytes = 5;
+		/* nand_get_flash_type() reads 8 bytes of entire ID string */
+		out_be32(&lbc->fbcr, 8);
+		elbc_fcm_ctrl->read_bytes = 8;
 		elbc_fcm_ctrl->use_mdr = 1;
 		elbc_fcm_ctrl->mdr = 0;
 
-- 
1.6.4
