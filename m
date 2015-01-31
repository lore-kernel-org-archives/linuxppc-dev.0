Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22f.google.com (mail-yk0-x22f.google.com
 [IPv6:2607:f8b0:4002:c07::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75DFA1A1175
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:52 +1100 (AEDT)
Received: by mail-yk0-f175.google.com with SMTP id 9so19104188ykp.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:50 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH 11/15] mmc: kconfig: replace PPC_OF with PPC
Date: Sat, 31 Jan 2015 21:47:41 +0800
Message-Id: <1422712065-9403-12-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hao <haokexin@gmail.com>,
 Chris Ball <chris@printf.net>
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
 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f145f1558353..a18dde1078ea 100644
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
