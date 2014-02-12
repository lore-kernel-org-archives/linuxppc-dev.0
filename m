Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-x22f.google.com (mail-lb0-x22f.google.com
 [IPv6:2a00:1450:4010:c04::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1D9DD2C0334
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 00:25:46 +1100 (EST)
Received: by mail-lb0-f175.google.com with SMTP id p9so7003177lbv.20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 05:25:42 -0800 (PST)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: [PATCH RFC v7 6/6] HACK mmc: mxcmmc: enable clocks for the MPC512x
Date: Wed, 12 Feb 2014 17:25:08 +0400
Message-Id: <1392211508-23615-7-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1392211508-23615-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1392211508-23615-1-git-send-email-a13xp0p0v88@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gerhard Sittig <gsi@denx.de>

Q&D HACK to enable SD card support without correct COMMON_CLK support,
best viewed with 'git diff -w -b', NOT acceptable for mainline (NAKed)

Signed-off-by: Gerhard Sittig <gsi@denx.de>
[ a13xp0p0v88@gmail.com: resolve little patch conflict ]
---
 drivers/mmc/host/mxcmmc.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index f7199c8..ddefa60 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1123,20 +1123,29 @@ static int mxcmci_probe(struct platform_device *pdev)
 	host->res = r;
 	host->irq = irq;
 
-	host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(host->clk_ipg)) {
-		ret = PTR_ERR(host->clk_ipg);
-		goto out_iounmap;
-	}
+	if (!is_mpc512x_mmc(host)) {
+		host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+		if (IS_ERR(host->clk_ipg)) {
+			ret = PTR_ERR(host->clk_ipg);
+			goto out_iounmap;
+		}
 
-	host->clk_per = devm_clk_get(&pdev->dev, "per");
-	if (IS_ERR(host->clk_per)) {
-		ret = PTR_ERR(host->clk_per);
-		goto out_iounmap;
+		host->clk_per = devm_clk_get(&pdev->dev, "per");
+		if (IS_ERR(host->clk_per)) {
+			ret = PTR_ERR(host->clk_per);
+			goto out_iounmap;
+		}
+	} else {
+		host->clk_per = devm_clk_get(&pdev->dev, "sdhc_clk");
+		if (IS_ERR(host->clk_per)) {
+			ret = PTR_ERR(host->clk_per);
+			goto out_iounmap;
+		}
 	}
 
 	clk_prepare_enable(host->clk_per);
-	clk_prepare_enable(host->clk_ipg);
+	if (host->clk_ipg)
+		clk_prepare_enable(host->clk_ipg);
 
 	mxcmci_softreset(host);
 
@@ -1206,7 +1215,8 @@ out_free_dma:
 		dma_release_channel(host->dma);
 out_clk_put:
 	clk_disable_unprepare(host->clk_per);
-	clk_disable_unprepare(host->clk_ipg);
+	if (host->clk_ipg)
+		clk_disable_unprepare(host->clk_ipg);
 out_iounmap:
 	iounmap(host->base);
 out_free:
@@ -1236,7 +1246,8 @@ static int mxcmci_remove(struct platform_device *pdev)
 		dma_release_channel(host->dma);
 
 	clk_disable_unprepare(host->clk_per);
-	clk_disable_unprepare(host->clk_ipg);
+	if (host->clk_ipg)
+		clk_disable_unprepare(host->clk_ipg);
 
 	release_mem_region(host->res->start, resource_size(host->res));
 
@@ -1252,7 +1263,9 @@ static int mxcmci_suspend(struct device *dev)
 	struct mxcmci_host *host = mmc_priv(mmc);
 
 	clk_disable_unprepare(host->clk_per);
-	clk_disable_unprepare(host->clk_ipg);
+	if (host->clk_ipg)
+		clk_disable_unprepare(host->clk_ipg);
+
 	return 0;
 }
 
@@ -1262,7 +1275,8 @@ static int mxcmci_resume(struct device *dev)
 	struct mxcmci_host *host = mmc_priv(mmc);
 
 	clk_prepare_enable(host->clk_per);
-	clk_prepare_enable(host->clk_ipg);
+	if (host->clk_ipg)
+		clk_prepare_enable(host->clk_ipg);
 	return 0;
 }
 
-- 
1.8.4.2
