Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3B296DE88C
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 05:43:04 +1100 (EST)
Date: Fri, 28 Mar 2008 21:43:03 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] mtd/nand/fsl_elbc_nand: workaround for hangs on MPC837X
Message-ID: <20080328184303.GA25882@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Using current driver on the MPC837X CPUs elbc hangs during nand write.
Reading last byte helps though (thanks to Scott Wood for the idea).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 378b7aa..be4c05d 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -480,7 +480,7 @@ static void fsl_elbc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
 	unsigned int bufsize = mtd->writesize + mtd->oobsize;
 
-	if (len < 0) {
+	if (len <= 0) {
 		dev_err(ctrl->dev, "write_buf of %d bytes", len);
 		ctrl->status = 0;
 		return;
@@ -495,6 +495,16 @@ static void fsl_elbc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 	}
 
 	memcpy_toio(&ctrl->addr[ctrl->index], buf, len);
+#ifdef CONFIG_PPC_MPC837x
+	/*
+	 * This is workaround for the weird elbc hangs on the MPC837X CPUs,
+	 * Scott Wood says: "...perhaps difference in how long it takes a
+	 * write to make it through the localbus compared to a write to IMMR
+	 * is causing problems, and sync isn't helping for some reason."
+	 * Reading back the last byte helps though.
+	 */
+	in_8(&ctrl->addr[ctrl->index] + len - 1);
+#endif
 	ctrl->index += len;
 }
 
-- 
1.5.2.2
