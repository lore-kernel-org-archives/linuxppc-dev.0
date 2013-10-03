Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E05182C014D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 00:07:00 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <1373803321-11628-6-git-send-email-gsi@denx.de>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <1373803321-11628-1-git-send-email-gsi@denx.de>
 <1373803321-11628-6-git-send-email-gsi@denx.de>
Date: Thu, 3 Oct 2013 18:06:56 +0400
Message-ID: <CAF0T0X4wiwvYX2RkNXajLUv685wdOdPDQJbEy-eHZhFiJ1mg6w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/5] HACK mmc: mxcmmc: enable clocks for the MPC512x
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, devicetree-discuss@lists.ozlabs.org,
 Alexander Popov <a13xp0p0v88@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
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
---
 drivers/mmc/host/mxcmmc.c |   41 +++++++++++++++++++++++++++---
-----------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index d503635..b9d21cc 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1121,20 +1121,29 @@ static int mxcmci_probe(struct platform_device *pdev)
        host->res = r;
        host->irq = irq;

-       host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-       if (IS_ERR(host->clk_ipg)) {
-               ret = PTR_ERR(host->clk_ipg);
-               goto out_iounmap;
-       }
+       if (!is_mpc512x_mmc(host)) {
+               host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+               if (IS_ERR(host->clk_ipg)) {
+                       ret = PTR_ERR(host->clk_ipg);
+                       goto out_iounmap;
+               }

-       host->clk_per = devm_clk_get(&pdev->dev, "per");
-       if (IS_ERR(host->clk_per)) {
-               ret = PTR_ERR(host->clk_per);
-               goto out_iounmap;
+               host->clk_per = devm_clk_get(&pdev->dev, "per");
+               if (IS_ERR(host->clk_per)) {
+                       ret = PTR_ERR(host->clk_per);
+                       goto out_iounmap;
+               }
+       } else {
+               host->clk_per = devm_clk_get(&pdev->dev, "sdhc_clk");
+               if (IS_ERR(host->clk_per)) {
+                       ret = PTR_ERR(host->clk_per);
+                       goto out_iounmap;
+               }
        }

        clk_prepare_enable(host->clk_per);
-       clk_prepare_enable(host->clk_ipg);
+       if (host->clk_ipg)
+               clk_prepare_enable(host->clk_ipg);

        mxcmci_softreset(host);

@@ -1204,7 +1213,8 @@ out_free_dma:
                dma_release_channel(host->dma);
 out_clk_put:
        clk_disable_unprepare(host->clk_per);
-       clk_disable_unprepare(host->clk_ipg);
+       if (host->clk_ipg)
+               clk_disable_unprepare(host->clk_ipg);
 out_iounmap:
        iounmap(host->base);
 out_free:
@@ -1236,7 +1246,8 @@ static int mxcmci_remove(struct platform_device *pdev)
                dma_release_channel(host->dma);

        clk_disable_unprepare(host->clk_per);
-       clk_disable_unprepare(host->clk_ipg);
+       if (host->clk_ipg)
+               clk_disable_unprepare(host->clk_ipg);

        release_mem_region(host->res->start, resource_size(host->res));

@@ -1255,7 +1266,8 @@ static int mxcmci_suspend(struct device *dev)
        if (mmc)
                ret = mmc_suspend_host(mmc);
        clk_disable_unprepare(host->clk_per);
-       clk_disable_unprepare(host->clk_ipg);
+       if (host->clk_ipg)
+               clk_disable_unprepare(host->clk_ipg);

        return ret;
 }
@@ -1267,7 +1279,8 @@ static int mxcmci_resume(struct device *dev)
        int ret = 0;

        clk_prepare_enable(host->clk_per);
-       clk_prepare_enable(host->clk_ipg);
+       if (host->clk_ipg)
+               clk_prepare_enable(host->clk_ipg);
        if (mmc)
                ret = mmc_resume_host(mmc);


--
1.7.10.4
