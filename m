Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skZBN038yzDrXY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 20:46:20 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id oz2so1930186pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 03:46:19 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: leoli@freescale.com,
	zw@zh-kernel.org,
	vinod.koul@intel.com
Cc: dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma/fsldma : Unmap region obtained by of_iomap
Date: Wed, 28 Sep 2016 16:15:11 +0530
Message-Id: <1475059511-10114-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Free memory mapping, if probe is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/dma/fsldma.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 911b717..7ba8944 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1351,7 +1351,7 @@ static int fsldma_of_probe(struct platform_device *op)
 	if (!fdev->regs) {
 		dev_err(&op->dev, "unable to ioremap registers\n");
 		err = -ENOMEM;
-		goto out_free_fdev;
+		goto out_free;
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
@@ -1416,6 +1416,8 @@ static int fsldma_of_probe(struct platform_device *op)
 
 out_free_fdev:
 	irq_dispose_mapping(fdev->irq);
+	iounmap(fdev->regs);
+out_free:
 	kfree(fdev);
 out_return:
 	return err;
-- 
1.7.9.5
