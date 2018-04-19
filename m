Return-Path: <wsa+renesas@sang-engineering.com>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 40Rgwv4yKfzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 00:14:54 +1000 (AEST)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/61] dma: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:37 +0200
Message-Id: <20180419140641.27926-8-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
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

Build tested only. buildbot is happy. Please apply individually.

 drivers/dma/at_hdmac.c  |  9 +++------
 drivers/dma/at_xdmac.c  |  9 +++------
 drivers/dma/fsldma.c    |  6 ++----
 drivers/dma/idma64.c    |  6 ++----
 drivers/dma/ste_dma40.c | 12 ++++--------
 drivers/dma/txx9dmac.c  |  8 +++-----
 6 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index a861b5b4d443..75f38d19fcbe 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2041,8 +2041,7 @@ static void at_dma_shutdown(struct platform_device *pdev)
 
 static int at_dma_prepare(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct at_dma *atdma = platform_get_drvdata(pdev);
+	struct at_dma *atdma = dev_get_drvdata(dev);
 	struct dma_chan *chan, *_chan;
 
 	list_for_each_entry_safe(chan, _chan, &atdma->dma_common.channels,
@@ -2076,8 +2075,7 @@ static void atc_suspend_cyclic(struct at_dma_chan *atchan)
 
 static int at_dma_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct at_dma *atdma = platform_get_drvdata(pdev);
+	struct at_dma *atdma = dev_get_drvdata(dev);
 	struct dma_chan *chan, *_chan;
 
 	/* preserve data */
@@ -2118,8 +2116,7 @@ static void atc_resume_cyclic(struct at_dma_chan *atchan)
 
 static int at_dma_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct at_dma *atdma = platform_get_drvdata(pdev);
+	struct at_dma *atdma = dev_get_drvdata(dev);
 	struct dma_chan *chan, *_chan;
 
 	/* bring back DMA controller */
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 94236ec9d410..4bf72561667c 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1833,8 +1833,7 @@ static void at_xdmac_free_chan_resources(struct dma_chan *chan)
 #ifdef CONFIG_PM
 static int atmel_xdmac_prepare(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
+	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct dma_chan		*chan, *_chan;
 
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
@@ -1853,8 +1852,7 @@ static int atmel_xdmac_prepare(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int atmel_xdmac_suspend(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
+	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct dma_chan		*chan, *_chan;
 
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
@@ -1878,8 +1876,7 @@ static int atmel_xdmac_suspend(struct device *dev)
 
 static int atmel_xdmac_resume(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
+	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct at_xdmac_chan	*atchan;
 	struct dma_chan		*chan, *_chan;
 	int			i;
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
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 1953e57505f4..e5c911200bdb 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -670,8 +670,7 @@ static int idma64_platform_remove(struct platform_device *pdev)
 
 static int idma64_pm_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct idma64_chip *chip = platform_get_drvdata(pdev);
+	struct idma64_chip *chip = dev_get_drvdata(dev);
 
 	idma64_off(chip->idma64);
 	return 0;
@@ -679,8 +678,7 @@ static int idma64_pm_suspend(struct device *dev)
 
 static int idma64_pm_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct idma64_chip *chip = platform_get_drvdata(pdev);
+	struct idma64_chip *chip = dev_get_drvdata(dev);
 
 	idma64_on(chip->idma64);
 	return 0;
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index c2b089af0420..1bc149af990e 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2889,8 +2889,7 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 #ifdef CONFIG_PM_SLEEP
 static int dma40_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct d40_base *base = platform_get_drvdata(pdev);
+	struct d40_base *base = dev_get_drvdata(dev);
 	int ret;
 
 	ret = pm_runtime_force_suspend(dev);
@@ -2904,8 +2903,7 @@ static int dma40_suspend(struct device *dev)
 
 static int dma40_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct d40_base *base = platform_get_drvdata(pdev);
+	struct d40_base *base = dev_get_drvdata(dev);
 	int ret = 0;
 
 	if (base->lcpa_regulator) {
@@ -2970,8 +2968,7 @@ static void d40_save_restore_registers(struct d40_base *base, bool save)
 
 static int dma40_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct d40_base *base = platform_get_drvdata(pdev);
+	struct d40_base *base = dev_get_drvdata(dev);
 
 	d40_save_restore_registers(base, true);
 
@@ -2985,8 +2982,7 @@ static int dma40_runtime_suspend(struct device *dev)
 
 static int dma40_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct d40_base *base = platform_get_drvdata(pdev);
+	struct d40_base *base = dev_get_drvdata(dev);
 
 	d40_save_restore_registers(base, false);
 
diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 4d8c7b9078fd..eb45af71d3a3 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -1244,8 +1244,7 @@ static void txx9dmac_shutdown(struct platform_device *pdev)
 
 static int txx9dmac_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct txx9dmac_dev *ddev = platform_get_drvdata(pdev);
+	struct txx9dmac_dev *ddev = dev_get_drvdata(dev);
 
 	txx9dmac_off(ddev);
 	return 0;
@@ -1253,9 +1252,8 @@ static int txx9dmac_suspend_noirq(struct device *dev)
 
 static int txx9dmac_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct txx9dmac_dev *ddev = platform_get_drvdata(pdev);
-	struct txx9dmac_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct txx9dmac_dev *ddev = dev_get_drvdata(dev);
+	struct txx9dmac_platform_data *pdata = dev_get_platdata(dev);
 	u32 mcr;
 
 	mcr = TXX9_DMA_MCR_MSTEN | MCR_LE;
-- 
2.11.0
