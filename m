Return-Path: <B22826@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7EEF6B7B80
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 19:20:21 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8N9KIWK023815
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 02:20:18 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n8N9KCYn019466
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 04:20:18 -0500 (CDT)
From: Gao Guanhua <B22826@freescale.com>
To: sdhci-devel@lists.ossman.eu
Subject: [PATCH 4/6] sdhci: Fixup AHB2MAG IRQ bypass hardware workaround
Date: Wed, 23 Sep 2009 17:08:10 +0800
Message-Id: <1253696892-15262-4-git-send-email-B22826@freescale.com>
In-Reply-To: <1253696892-15262-3-git-send-email-B22826@freescale.com>
References: <1253696892-15262-1-git-send-email-B22826@freescale.com>
	<1253696892-15262-2-git-send-email-B22826@freescale.com>
	<1253696892-15262-3-git-send-email-B22826@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Gao Guanhua <B22826@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implemnet the workaround that the bit
DCR[DMA__AHB2MAG_IRQ_BYPASS] cannot be set automatically
when SoC reset.
---
 arch/powerpc/boot/dts/p2020ds.dts |    1 +
 drivers/mmc/host/sdhci-of.c       |    5 ++++-
 drivers/mmc/host/sdhci.c          |    8 ++++++++
 drivers/mmc/host/sdhci.h          |    3 +++
 4 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
index 574ad4f..8b1056d 100644
--- a/arch/powerpc/boot/dts/p2020ds.dts
+++ b/arch/powerpc/boot/dts/p2020ds.dts
@@ -460,6 +460,7 @@
 			interrupts = <72 0x2>;
 			interrupt-parent = <&mpic>;
 			fsl,sdhci-dma-broken;
+			fsl,sdhci-ahb2mag-irq-bypass;
 			clock-frequency = <0>;
 		};
 
diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 5879483..0bc75b3 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -272,6 +272,9 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 
 	if (of_get_property(np, "fsl,sdhci-dma-broken", NULL))
		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+
+	if (of_get_property(np, "fsl,sdhci-ahb2mag-irq-bypass", NULL))
+		host->quirks |= SDHCI_QUIRK_SET_AHB2MAG_IRQ_BYPASS;
 
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cc6d45c..711cbcd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -176,11 +176,19 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 
 static void sdhci_init(struct sdhci_host *host)
 {
+	u32 ctrl;
+
 	sdhci_reset(host, SDHCI_RESET_ALL);
 
 	/* Enable cache snooping */
 	sdhci_writel(host, SDHCI_CACHE_SNOOP, SDHCI_HOST_DMA_CONTROL);
 
+	if (host->quirks & SDHCI_QUIRK_SET_AHB2MAG_IRQ_BYPASS) {
+		ctrl = sdhci_readl(host, SDHCI_HOST_DMA_CONTROL);
+		ctrl |= SDHCI_AHB2MAG_IRQ_BYPASS;
+		sdhci_writel(host, ctrl, SDHCI_HOST_DMA_CONTROL);
+	}
+
 	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
 		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
 		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 9ee9622..cb8beea 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -178,6 +178,7 @@
 
 /* 40C DMA control register*/
 #define SDHCI_HOST_DMA_CONTROL	0x40C
+#define SDHCI_AHB2MAG_IRQ_BYPASS	0x20
 #define SDHCI_CACHE_SNOOP	0x40
 
 struct sdhci_ops;
@@ -238,6 +239,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
 /* Controller uses SDCLK instead of TMCLK for data timeouts */
 #define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
+/* Controller cannot set DCR[DMA__AHB2MAG_IRQ_BYPASS] automatically*/
+#define SDHCI_QUIRK_SET_AHB2MAG_IRQ_BYPASS		(1<<25)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.6.4
