Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x229.google.com (mail-yk0-x229.google.com
 [IPv6:2607:f8b0:4002:c07::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A90201A0174
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 23:09:53 +1100 (AEDT)
Received: by ykq142 with SMTP id 142so3820167ykq.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 04:09:51 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 09/11] mmc: kconfig: replace PPC_OF with PPC
Date: Thu, 26 Feb 2015 20:08:21 +0800
Message-Id: <1424952503-8247-10-git-send-email-haokexin@gmail.com>
In-Reply-To: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
References: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, Chris Ball <chris@printf.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PPC_OF is a ppc specific option which is used to mean that the
firmware device tree access functions are available. Since all the
ppc platforms have a device tree, it is aways set to 'y' for ppc.
So it makes no sense to keep a such option in the current kernel.
Replace it with PPC.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: No change.

 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 61ac63a3776a..7858d7a52818 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -132,7 +132,7 @@ config MMC_SDHCI_OF_ARASAN
 config MMC_SDHCI_OF_ESDHC
 	tristate "SDHCI OF support for the Freescale eSDHC controller"
 	depends on MMC_SDHCI_PLTFM
-	depends on PPC_OF
+	depends on PPC
 	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 	help
 	  This selects the Freescale eSDHC controller support.
@@ -144,7 +144,7 @@ config MMC_SDHCI_OF_ESDHC
 config MMC_SDHCI_OF_HLWD
 	tristate "SDHCI OF support for the Nintendo Wii SDHCI controllers"
 	depends on MMC_SDHCI_PLTFM
-	depends on PPC_OF
+	depends on PPC
 	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
-- 
1.9.3
