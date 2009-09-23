Return-Path: <B22826@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E67FFB7B81
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 19:20:22 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8N9KKk3023828
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 02:20:20 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n8N9KCYp019466
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 04:20:19 -0500 (CDT)
From: Gao Guanhua <B22826@freescale.com>
To: sdhci-devel@lists.ossman.eu
Subject: [PATCH 5/6] sdhci-of: Set the timeout to the max value
Date: Wed, 23 Sep 2009 17:08:11 +0800
Message-Id: <1253696892-15262-5-git-send-email-B22826@freescale.com>
In-Reply-To: <1253696892-15262-4-git-send-email-B22826@freescale.com>
References: <1253696892-15262-1-git-send-email-B22826@freescale.com>
	<1253696892-15262-2-git-send-email-B22826@freescale.com>
	<1253696892-15262-3-git-send-email-B22826@freescale.com>
	<1253696892-15262-4-git-send-email-B22826@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Gao Guanhua <B22826@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When access the card, the following error is reported:

  mmc0: Got data interrupt 0x00000020 even though no data operation was in progress.
  mmc0: Got data interrupt 0x00000020 even though no data operation was in progress.

so we skip the calculation of timeout and use the max value.
---
 arch/powerpc/boot/dts/p2020ds.dts |    1 +
 drivers/mmc/host/sdhci-of.c       |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
index 8b1056d..29989fb 100644
--- a/arch/powerpc/boot/dts/p2020ds.dts
+++ b/arch/powerpc/boot/dts/p2020ds.dts
@@ -461,6 +461,7 @@
 			interrupt-parent = <&mpic>;
 			fsl,sdhci-dma-broken;
 			fsl,sdhci-ahb2mag-irq-bypass;
+			fsl,sdhci-adjust-timeout;
 			clock-frequency = <0>;
 		};
 
diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 0bc75b3..0ff95d8 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -276,6 +276,9 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 	if (of_get_property(np, "fsl,sdhci-ahb2mag-irq-bypass", NULL))
 		host->quirks |= SDHCI_QUIRK_SET_AHB2MAG_IRQ_BYPASS;
 
+	if (of_get_property(np, "fsl,sdhci-adjust-timeout", NULL))
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
 		of_host->clock = *clk;
-- 
1.6.4
