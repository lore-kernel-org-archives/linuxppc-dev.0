Return-Path: <B42677@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F1E22C009D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2013 13:02:15 +1000 (EST)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/4] mmc: esdhc: Add quirks to support T4240 board
Date: Mon, 8 Jul 2013 10:12:24 +0800
Message-ID: <1373249545-23928-3-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1373249545-23928-1-git-send-email-Haijun.Zhang@freescale.com>
References: <1373249545-23928-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, cjb@laptop.org, AFLEMING@freescale.com,
 Haijun Zhang <haijun.zhang@freescale.com>, cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On T4240 board controllers has an unusable ADMA engine, so use SDMA instead.
Also 3.0v is support on T4240 board even if the capacity detailed only 1.8v
support. Without this quirk SD card will declare voltage not support and

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 5 +++++
 drivers/mmc/host/sdhci.c       | 3 +++
 include/linux/mmc/sdhci.h      | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e2065a4..02edb3d 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -92,6 +92,11 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
+		if (of_device_is_compatible(np, "fsl,t4240-esdhc")) {
+			host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+			host->quirks2 |= SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS30;
+		}
+
 		if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
 		    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
 		    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a78bd4f..de7fa81 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2797,6 +2797,9 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->caps1 :
 			sdhci_readl(host, SDHCI_CAPABILITIES_1);
 
+	if (host->quirks2 & SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS30)
+		caps[0] = caps[0] | SDHCI_CAN_VDD_300;
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e3c6a74..dc608d7 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -98,6 +98,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON		(1<<4)
 /* Controller has a non-standard host control register */
 #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
+/* The host support VS300 even if the capacity detailed not */
+#define SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS30		(1<<6)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.8.0
