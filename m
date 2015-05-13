Return-Path: <yangbo.lu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0104.outbound.protection.outlook.com [157.56.111.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A07E11A042B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 18:24:36 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <scottwood@freescale.com>
Subject: [PATCH 2/2] mmc: sdhci-pltfm: enable interrupt mode to detect card
Date: Wed, 13 May 2015 16:20:46 +0800
Message-ID: <1431505246-40102-1-git-send-email-yangbo.lu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Yangbo Lu <yangbo.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable interrupt mode to detect card instead of polling mode
for P1020/P4080/P5020/P5040/T1040 by removing the quirk
SDHCI_QUIRK_BROKEN_CARD_DETECTION. This could improve data
transferring performance and avoid the call trace caused by
polling card status sometime.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index c5b01d6..62f4049 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -102,6 +102,13 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+		if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
+			of_device_is_compatible(np, "fsl,p5020-esdhc") ||
+			of_device_is_compatible(np, "fsl,p4080-esdhc") ||
+			of_device_is_compatible(np, "fsl,p1020-esdhc") ||
+			of_device_is_compatible(np, "fsl,t1040-esdhc"))
+			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
 		clk = of_get_property(np, "clock-frequency", &size);
 		if (clk && size == sizeof(*clk) && *clk)
 			pltfm_host->clock = be32_to_cpup(clk);
-- 
2.1.0.27.g96db324
