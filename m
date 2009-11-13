Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BD761B7B69
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 07:13:58 +1100 (EST)
Date: Fri, 13 Nov 2009 14:14:15 -0600
From: Scott Wood <scottwood@freescale.com>
To: dwmw2@infradead.org
Subject: [PATCH 3/3] eLBC NAND: give more verbose output on error
Message-ID: <20091113201415.GA8345@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want error information even if the kernel hasn't been built for verbose
debugging.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 5b51ed3..ae30fb6 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -237,12 +237,15 @@ static int fsl_elbc_run_command(struct mtd_info *mtd)
 
 	ctrl->use_mdr = 0;
 
-	dev_vdbg(ctrl->dev,
-	         "fsl_elbc_run_command: stat=%08x mdr=%08x fmr=%08x\n",
-	         ctrl->status, ctrl->mdr, in_be32(&lbc->fmr));
+	if (ctrl->status != LTESR_CC) {
+		dev_info(ctrl->dev,
+		         "command failed: fir %x fcr %x status %x mdr %x\n",
+		         in_be32(&lbc->fir), in_be32(&lbc->fcr),
+		         ctrl->status, ctrl->mdr);
+		return -EIO;
+	}
 
-	/* returns 0 on success otherwise non-zero) */
-	return ctrl->status == LTESR_CC ? 0 : -EIO;
+	return 0;
 }
 
 static void fsl_elbc_do_read(struct nand_chip *chip, int oob)
-- 
1.6.4.4
