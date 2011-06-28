Return-Path: <B35362@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A02CBB6F74
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2011 12:45:11 +1000 (EST)
From: <b35362@freescale.com>
To: <dwmw2@infradead.org>
Subject: [PATCH 1/2] mtd/nand : don't free the global data
	fsl_lbc_ctrl_dev->nand in fsl_elbc_chip_remove()
Date: Tue, 28 Jun 2011 09:50:51 +0800
Message-ID: <1309225852-1664-1-git-send-email-b35362@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liu Shuo <b35362@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liu Shuo <b35362@freescale.com>

The global data fsl_lbc_ctrl_dev->nand don't have to be freed in
fsl_elbc_chip_remove(). The right place to do that is in fsl_elbc_nand_remove()
if elbc_fcm_ctrl->counter is zero.

Signed-off-by: Liu Shuo <b35362@freescale.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 0bb254c..a212116 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -829,7 +829,6 @@ static int fsl_elbc_chip_remove(struct fsl_elbc_mtd *priv)
 
 	elbc_fcm_ctrl->chips[priv->bank] = NULL;
 	kfree(priv);
-	kfree(elbc_fcm_ctrl);
 	return 0;
 }
 
-- 
1.7.1
