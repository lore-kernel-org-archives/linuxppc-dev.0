Return-Path: <B22826@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C75E1B7B7E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 19:20:19 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8N9KGYi023807
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 02:20:17 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n8N9KCYl019466
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 04:20:16 -0500 (CDT)
From: Gao Guanhua <B22826@freescale.com>
To: sdhci-devel@lists.ossman.eu
Subject: [PATCH 3/6] P2020DS: Fixup sdhc to use PIO mode
Date: Wed, 23 Sep 2009 17:08:09 +0800
Message-Id: <1253696892-15262-3-git-send-email-B22826@freescale.com>
In-Reply-To: <1253696892-15262-2-git-send-email-B22826@freescale.com>
References: <1253696892-15262-1-git-send-email-B22826@freescale.com>
	<1253696892-15262-2-git-send-email-B22826@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Gao Guanhua <B22826@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SDHC can not work on DMA mode because of the hardware bug,
so we set a broken dma flag and use PIO mode. This patch applies
to Rev1.0.
---
 arch/powerpc/boot/dts/p2020ds.dts |    1 +
 drivers/mmc/host/sdhci-of.c       |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
index be449ba..574ad4f 100644
--- a/arch/powerpc/boot/dts/p2020ds.dts
+++ b/arch/powerpc/boot/dts/p2020ds.dts
@@ -459,6 +459,7 @@
 			reg = <0x2e000 0x1000>;
 			interrupts = <72 0x2>;
 			interrupt-parent = <&mpic>;
+			fsl,sdhci-dma-broken;
 			clock-frequency = <0>;
 		};
 
diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 01ab916..5879483 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -270,6 +270,9 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 	if (sdhci_of_wp_inverted(np))
 		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
+	if (of_get_property(np, "fsl,sdhci-dma-broken", NULL))
+		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
 		of_host->clock = *clk;
-- 
1.6.4
