Return-Path: <stripath@apm.com>
Received: from denmail01.amcc.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 94B9F1A02D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 01:43:45 +1000 (AEST)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, ulf.hansson@linaro.org, anton@enomsg.org, arnd@arndb.de
Subject: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from fdt
 in sdhci-pltm.c
Date: Tue, 21 Apr 2015 21:12:39 +0530
Message-Id: <1429630959-32649-3-git-send-email-stripathi@apm.com>
In-Reply-To: <1429630959-32649-1-git-send-email-stripathi@apm.com>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com>
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com,
 Suman Tripathi <stripathi@apm.com>, jcm@redhat.com, linux-mmc@vger.kernel.org,
 patches@apm.com, ddutile@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds some quirks support to be read from fdt.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index bef250e..9f6a4b9 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device *pdev)
 
 		if (of_get_property(np, "broken-cd", NULL))
 			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		
+		if (of_get_property(np, "delay-after-power", NULL))
+			host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
+
+		if (of_get_property(np, "no-hispd", NULL))
+			host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
+
+		if (of_get_property(np, "broken-adma", NULL))
+			host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+		
+		if (of_get_property(np, "broken-dma", NULL))
+			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+
+		if (of_get_property(np, "no-cmd23", NULL))
+			host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
 
 		if (of_get_property(np, "no-1-8-v", NULL))
 			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
-- 
1.8.2.1
