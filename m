Return-Path: <B25806@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC2E72C038C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 19:02:40 +1100 (EST)
Received: from mail154-co1 (localhost [127.0.0.1])	by
 mail154-co1-R.bigfish.com (Postfix) with ESMTP id 8C641C601C4	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 08:02:35 +0000 (UTC)
Received: from CO1EHSMHS023.bigfish.com (unknown [10.243.78.231])	by
 mail154-co1.bigfish.com (Postfix) with ESMTP id ED0122004A	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 08:02:32 +0000 (UTC)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] mmc: sdhci-pltfm: Fix timeout on t4240's sdhci controller
Date: Thu, 7 Mar 2013 16:05:35 +0800
Message-ID: <1362643535-2377-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes timeout problems on t4240's sdhci controller:

	mmc0: Too large timeout requested for CMD25!
	mmc0: Too large timeout requested for CMD25!
	mmc0: Too large timeout requested for CMD25!

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 3145a78..9db7b12 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -94,6 +94,7 @@ void sdhci_get_of_property(struct platform_device *pdev)
 
 		if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
 		    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
+		    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
 		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-- 
1.7.6.5
