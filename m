Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33BFBB7093
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 07:12:12 +1100 (EST)
Date: Fri, 13 Nov 2009 14:12:16 -0600
From: Scott Wood <scottwood@freescale.com>
To: dwmw2@infradead.org
Subject: [PATCH 1/3] eLBC NAND: increase bus timeout to maximum
Message-ID: <20091113201216.GA8313@loki.buserror.net>
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

When a NAND operation is in progress, all other localbus operations
(including NOR flash) will have to wait for access to the bus.  However, the
NAND operation may take longer to complete than the default timeout.  Thus,
if NOR is accessed while a NAND operation is in progress, the NAND operation
will fail.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index ddd37d2..58db278 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -946,6 +946,13 @@ static int __devinit fsl_elbc_ctrl_init(struct fsl_elbc_ctrl *ctrl)
 {
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 
+	/*
+	 * NAND transactions can tie up the bus for a long time, so set the
+	 * bus timeout to max by clearing LBCR[BMT] (highest base counter
+	 * value) and setting LBCR[BMTPS] to the highest prescaler value.
+	 */
+	clrsetbits_be32(&lbc->lbcr, LBCR_BMT, 15);
+
 	/* clear event registers */
 	setbits32(&lbc->ltesr, LTESR_NAND_MASK);
 	out_be32(&lbc->lteatr, 0);
-- 
1.6.4.4
