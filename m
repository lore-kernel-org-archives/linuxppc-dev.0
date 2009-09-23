Return-Path: <B22826@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87B49B7B7D
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 19:20:17 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8N9KDfQ023795
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 02:20:14 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n8N9KCYh019466
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 04:20:13 -0500 (CDT)
From: Gao Guanhua <B22826@freescale.com>
To: sdhci-devel@lists.ossman.eu
Subject: [PATCH 1/6] sdhci: Enable cache snooping
Date: Wed, 23 Sep 2009 17:08:07 +0800
Message-Id: <1253696892-15262-1-git-send-email-B22826@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Gao Guanhua <B22826@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enable cache snooping when the sdhc is initialized.
---
 drivers/mmc/host/sdhci.c |    3 +++
 drivers/mmc/host/sdhci.h |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 288e40b..cc6d45c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -178,6 +178,9 @@ static void sdhci_init(struct sdhci_host *host)
 {
 	sdhci_reset(host, SDHCI_RESET_ALL);
 
+	/* Enable cache snooping */
+	sdhci_writel(host, SDHCI_CACHE_SNOOP, SDHCI_HOST_DMA_CONTROL);
+
 	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
 		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
 		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index afda7f1..9ee9622 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -176,6 +176,10 @@
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
 
+/* 40C DMA control register*/
+#define SDHCI_HOST_DMA_CONTROL	0x40C
+#define SDHCI_CACHE_SNOOP	0x40
+
 struct sdhci_ops;
 
 struct sdhci_host {
-- 
1.6.4
