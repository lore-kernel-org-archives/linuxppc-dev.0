Return-Path: <B36685@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 59945100815
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2011 20:28:39 +1100 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2 v2] mtd/nand: Add ONFI support for FSL NAND controller
Date: Tue, 6 Dec 2011 16:54:15 +0800
Message-ID: <1323161655-19050-2-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1323161655-19050-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1323161655-19050-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, dwmw2@infradead.org, kumar.gala@freescale.com,
 linux-mtd@lists.infradead.org, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- fix NAND_CMD_READID command for ONFI detect.
- add NAND_CMD_PARAM command to read the ONFI parameter page.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
v2: no changes

 drivers/mtd/nand/fsl_elbc_nand.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 4f405a0..b4db407 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -349,19 +349,24 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		fsl_elbc_run_command(mtd);
 		return;
 
-	/* READID must read all 5 possible bytes while CEB is active */
 	case NAND_CMD_READID:
-		dev_vdbg(priv->dev, "fsl_elbc_cmdfunc: NAND_CMD_READID.\n");
+	case NAND_CMD_PARAM:
+		dev_vdbg(priv->dev, "fsl_elbc_cmdfunc: NAND_CMD %x\n", command);
 
 		out_be32(&lbc->fir, (FIR_OP_CM0 << FIR_OP0_SHIFT) |
 		                    (FIR_OP_UA  << FIR_OP1_SHIFT) |
 		                    (FIR_OP_RBW << FIR_OP2_SHIFT));
-		out_be32(&lbc->fcr, NAND_CMD_READID << FCR_CMD0_SHIFT);
-		/* nand_get_flash_type() reads 8 bytes of entire ID string */
-		out_be32(&lbc->fbcr, 8);
-		elbc_fcm_ctrl->read_bytes = 8;
+		out_be32(&lbc->fcr, command << FCR_CMD0_SHIFT);
+		/* reads 8 bytes of entire ID string */
+		if (NAND_CMD_READID == command) {
+			out_be32(&lbc->fbcr, 8);
+			elbc_fcm_ctrl->read_bytes = 8;
+		} else {
+			out_be32(&lbc->fbcr, 256);
+			elbc_fcm_ctrl->read_bytes = 256;
+		}
 		elbc_fcm_ctrl->use_mdr = 1;
-		elbc_fcm_ctrl->mdr = 0;
+		elbc_fcm_ctrl->mdr = column;
 
 		set_addr(mtd, 0, 0, 0);
 		fsl_elbc_run_command(mtd);
-- 
1.6.4
