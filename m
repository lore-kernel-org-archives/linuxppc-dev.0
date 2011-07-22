Return-Path: <r61911@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D332FB6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 19:36:01 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: <linux-mmc@vger.kernel.org>
Subject: [PATCH 1/2 v2] eSDHC: Access Freescale eSDHC registers by 32-bit
Date: Fri, 22 Jul 2011 18:15:16 +0800
Message-ID: <1311329717-13954-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Xu lei <B33228@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Xu lei <B33228@freescale.com>

For Freescale eSDHC registers only support 32-bit accesses,
this patch ensure that all Freescale eSDHC register accesses
are 32-bit.

Signed-off-by: Xu lei <B33228@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
this patch set replaces previous patches:
https://patchwork.kernel.org/patch/943332/
https://patchwork.kernel.org/patch/943342/
https://patchwork.kernel.org/patch/943322/

The last one is discarded according to the comment from Anton.


just resend with the new patch set. no change for this patch comparing
to previous version.

 drivers/mmc/host/sdhci-of-esdhc.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index ba40d6d..c9a8519 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1,7 +1,7 @@
 /*
  * Freescale eSDHC controller driver.
  *
- * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2007, 2010 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  *
  * Authors: Xiaobo Xie <X.Xie@freescale.com>
@@ -23,11 +23,21 @@
 static u16 esdhc_readw(struct sdhci_host *host, int reg)
 {
 	u16 ret;
+	int base = reg & ~0x3;
+	int shift = (reg & 0x2) * 8;
 
 	if (unlikely(reg == SDHCI_HOST_VERSION))
-		ret = in_be16(host->ioaddr + reg);
+		ret = in_be32(host->ioaddr + base) & 0xffff;
 	else
-		ret = sdhci_be32bs_readw(host, reg);
+		ret = (in_be32(host->ioaddr + base) >> shift) & 0xffff;
+	return ret;
+}
+
+static u8 esdhc_readb(struct sdhci_host *host, int reg)
+{
+	int base = reg & ~0x3;
+	int shift = (reg & 0x3) * 8;
+	u8 ret = (in_be32(host->ioaddr + base) >> shift) & 0xff;
 	return ret;
 }
 
@@ -79,7 +89,7 @@ struct sdhci_of_data sdhci_esdhc = {
 	.ops = {
 		.read_l = sdhci_be32bs_readl,
 		.read_w = esdhc_readw,
-		.read_b = sdhci_be32bs_readb,
+		.read_b = esdhc_readb,
 		.write_l = sdhci_be32bs_writel,
 		.write_w = esdhc_writew,
 		.write_b = esdhc_writeb,
-- 
1.6.0.6
