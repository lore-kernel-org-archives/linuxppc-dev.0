Return-Path: <wsa+renesas@sang-engineering.com>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 40TP6m1XWdzF214
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Apr 2018 19:14:21 +1000 (AEST)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: dmaengine@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
 Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dmaengine: fsldma: simplify getting .drvdata
Date: Sun, 22 Apr 2018 11:14:11 +0200
Message-Id: <20180422091415.7587-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
References: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply to your tree directly.

 drivers/dma/fsldma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 3eaece888e75..1117b5123a6f 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1328,8 +1328,7 @@ static int fsldma_of_remove(struct platform_device *op)
 #ifdef CONFIG_PM
 static int fsldma_suspend_late(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct fsldma_device *fdev = platform_get_drvdata(pdev);
+	struct fsldma_device *fdev = dev_get_drvdata(dev);
 	struct fsldma_chan *chan;
 	int i;
 
@@ -1360,8 +1359,7 @@ static int fsldma_suspend_late(struct device *dev)
 
 static int fsldma_resume_early(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct fsldma_device *fdev = platform_get_drvdata(pdev);
+	struct fsldma_device *fdev = dev_get_drvdata(dev);
 	struct fsldma_chan *chan;
 	u32 mode;
 	int i;
-- 
2.11.0
