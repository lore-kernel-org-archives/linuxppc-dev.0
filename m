Return-Path: <bobby.prani@gmail.com>
Received: from mail-yk0-x230.google.com (mail-yk0-x230.google.com
 [IPv6:2607:f8b0:4002:c07::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08B191A00F8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 23:04:30 +1000 (EST)
Received: by mail-yk0-f176.google.com with SMTP id 19so7644049ykq.35
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 06:04:28 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc: Fix build failure
Date: Thu, 21 Aug 2014 09:04:31 -0400
Message-Id: <1408626271-13519-1-git-send-email-bobby.prani@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the following build failure

drivers/built-in.o: In function `nhi_init':
nhi.c:(.init.text+0x63390): undefined reference to `ehci_init_driver'

by adding a dependency on USB_EHCI_HCD which supplies the ehci_init_driver().

Also we need to depend on USB_OHCI_HCD similarly

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 arch/powerpc/platforms/44x/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 4d88f6a..3e7deb2 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -216,8 +216,8 @@ config AKEBONO
 	select IBM_EMAC_EMAC4
 	select IBM_EMAC_RGMII_WOL
 	select USB
-	select USB_OHCI_HCD_PLATFORM
-	select USB_EHCI_HCD_PLATFORM
+	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
+	select USB_EHCI_HCD_PLATFORM if USB_EHCI_HCD
 	select MMC_SDHCI
 	select MMC_SDHCI_PLTFM
 	select MMC_SDHCI_OF_476GTR
-- 
1.9.1
