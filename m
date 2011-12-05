Return-Path: <r63061@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0E45B1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 21:12:40 +1100 (EST)
From: Xie Xiaobo <X.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] mmc: sdhci-pltfm: Added sdhci-adjust-timeout quirk
Date: Mon, 5 Dec 2011 16:55:20 +0800
Message-ID: <1323075320-9138-1-git-send-email-X.Xie@freescale.com>
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
Content-Type: text/plain
Cc: avorontsov@ru.mvista.com, linux-mmc@vger.kernel.org,
 Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some controller provides an incorrect timeout value for transfers,
So it need the quirk to adjust timeout value to 0xE.
E.g. eSDHC of MPC8536, P1010, and P2020.

Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index a9e12ea..b5d6b3f 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -2,7 +2,7 @@
  * sdhci-pltfm.c Support for SDHCI platform devices
  * Copyright (c) 2009 Intel Corporation
  *
- * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2007, 2011 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  *
  * Authors: Xiaobo Xie <X.Xie@freescale.com>
@@ -68,6 +68,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (of_get_property(np, "sdhci,1-bit-only", NULL))
 			host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
+		if (of_get_property(np, "sdhci,sdhci-adjust-timeout", NULL))
+			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
 		if (sdhci_of_wp_inverted(np))
 			host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
-- 
1.6.4
