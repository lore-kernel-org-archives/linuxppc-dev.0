Return-Path: <bethencourt@gmail.com>
Received: from mail-wi0-x22b.google.com (mail-wi0-x22b.google.com
 [IPv6:2a00:1450:400c:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB3AB1A0272
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 06:57:23 +1000 (AEST)
Received: by wiclk2 with SMTP id lk2so2015034wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 13:57:18 -0700 (PDT)
Sender: Luis de Bethencourt <bethencourt@gmail.com>
From: Luis de Bethencourt <luis@debethencourt.com>
Date: Wed, 16 Sep 2015 22:57:17 +0200
To: linux-kernel@vger.kernel.org
Cc: Li Yang <leoli@freescale.com>, Zhang Wei <zw@zh-kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH 1/6] dmaengine: fsldma: Fix module autoload for OF platform
 driver
Message-ID: <20150916205717.GA5759@goodgumbo.baconseed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/dma/fsldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 300f821..2209f75 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1512,6 +1512,7 @@ static const struct of_device_id fsldma_of_ids[] = {
 	{ .compatible = "fsl,elo-dma", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, fsldma_of_ids);
 
 static struct platform_driver fsldma_of_driver = {
 	.driver = {
-- 
2.4.6
