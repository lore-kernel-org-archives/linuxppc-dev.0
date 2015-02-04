Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x236.google.com (mail-yh0-x236.google.com
 [IPv6:2607:f8b0:4002:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9303B1A097F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 17:34:30 +1100 (AEDT)
Received: by mail-yh0-f54.google.com with SMTP id 29so20510817yhl.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2015 22:34:27 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linux-mmc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] mmc: sdhci-pltfm: remove the unneeded check of disabled device
Date: Wed,  4 Feb 2015 14:33:53 +0800
Message-Id: <1423031633-26915-1-git-send-email-haokexin@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Anton Vorontsov <anton@enomsg.org>,
 Chris Ball <chris@printf.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit cd1e65044d44 ("of/device: Don't register disabled
devices"), the disabled device will not be registered at all. So
we don't need to do the check again in the platform device driver.

And the check in the current code is useless even if we really
run into a disabled device. In this case, it just doesn't parse
the dtb for the infos such as quirks or clock, but it will continue
to try to init the disabled device after that check. So just remove it.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 54 ++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index c5b01d6bb85d..b609c03a9ef8 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -75,43 +75,41 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	u32 bus_width;
 	int size;
 
-	if (of_device_is_available(np)) {
-		if (of_get_property(np, "sdhci,auto-cmd12", NULL))
-			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
+		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
-		if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
-		    (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
-		    bus_width == 1))
-			host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
+	if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
+	    (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
+	    bus_width == 1))
+		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
-		if (sdhci_of_wp_inverted(np))
-			host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
+	if (sdhci_of_wp_inverted(np))
+		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
-		if (of_get_property(np, "broken-cd", NULL))
-			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+	if (of_get_property(np, "broken-cd", NULL))
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
-		if (of_get_property(np, "no-1-8-v", NULL))
-			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+	if (of_get_property(np, "no-1-8-v", NULL))
+		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
-		if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
-			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
-		if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
-		    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
-		    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
-		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
-			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
+	    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
+	    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
+	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-		clk = of_get_property(np, "clock-frequency", &size);
-		if (clk && size == sizeof(*clk) && *clk)
-			pltfm_host->clock = be32_to_cpup(clk);
+	clk = of_get_property(np, "clock-frequency", &size);
+	if (clk && size == sizeof(*clk) && *clk)
+		pltfm_host->clock = be32_to_cpup(clk);
 
-		if (of_find_property(np, "keep-power-in-suspend", NULL))
-			host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
+	if (of_find_property(np, "keep-power-in-suspend", NULL))
+		host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
 
-		if (of_find_property(np, "enable-sdio-wakeup", NULL))
-			host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
-	}
+	if (of_find_property(np, "enable-sdio-wakeup", NULL))
+		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 }
 #else
 void sdhci_get_of_property(struct platform_device *pdev) {}
-- 
1.9.3
