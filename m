Return-Path: <bobby.prani@gmail.com>
Received: from mail-yh0-x22b.google.com (mail-yh0-x22b.google.com
 [IPv6:2607:f8b0:4002:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 261BB1A0009
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 23:16:03 +1000 (EST)
Received: by mail-yh0-f43.google.com with SMTP id 29so8144752yhl.30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 06:16:01 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc: Fix build failure when CONFIG_USB=y
Date: Thu, 21 Aug 2014 09:16:04 -0400
Message-Id: <1408626964-31554-1-git-send-email-bobby.prani@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are enabling USB unconditionally which results in following build failure

drivers/built-in.o: In function `tb_drom_read': 
(.text+0x1b62b70): undefined reference to `usb_speed_string'
make: *** [vmlinux] Error 

Enable USB only if USB_SUPPORT is set to avoid such failures

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 arch/powerpc/platforms/44x/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 3e7deb2..82f2da2 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -215,7 +215,7 @@ config AKEBONO
 	select NET_VENDOR_IBM
 	select IBM_EMAC_EMAC4
 	select IBM_EMAC_RGMII_WOL
-	select USB
+	select USB if USB_SUPPORT
 	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
 	select USB_EHCI_HCD_PLATFORM if USB_EHCI_HCD
 	select MMC_SDHCI
-- 
1.9.1
