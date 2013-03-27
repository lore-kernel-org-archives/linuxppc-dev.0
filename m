Return-Path: <r61911@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 23F9D2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 15:26:17 +1100 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: <linux-mtd@lists.infradead.org>
Subject: [upstream] mtd/ifc: fix ifc driver memory release issue
Date: Wed, 27 Mar 2013 20:25:00 +0800
Message-ID: <1364387100-23013-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Li Hao <b44421@freescale.com>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org, dwmw2@infradead.org,
 Cao Yonghua <b43619@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memory is allocated by devm_kzalloc, so release it using
devm_kfree() instead kfree();

Signed-off-by: Li Hao <b44421@freescale.com>
Signed-off-by: Cao Yonghua <b43619@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 drivers/mtd/nand/fsl_ifc_nand.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index f1f7f12..b574ca4 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -908,7 +908,7 @@ static int fsl_ifc_chip_remove(struct fsl_ifc_mtd *priv)
 
 	ifc_nand_ctrl->chips[priv->bank] = NULL;
 	dev_set_drvdata(priv->dev, NULL);
-	kfree(priv);
+	devm_kfree(priv->dev, priv);
 
 	return 0;
 }
@@ -974,6 +974,7 @@ static int fsl_ifc_nand_probe(struct platform_device *dev)
 		if (!ifc_nand_ctrl) {
 			dev_err(&dev->dev, "failed to allocate memory\n");
 			mutex_unlock(&fsl_ifc_nand_mutex);
+			devm_kfree(&dev->dev, priv);
 			return -ENOMEM;
 		}
 
-- 
1.7.9.5
