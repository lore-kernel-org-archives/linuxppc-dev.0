Return-Path: <r58472@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0483AB700C
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 22:20:14 +1100 (EST)
Received: from mail131-ch1 (localhost [127.0.0.1])	by
 mail131-ch1-R.bigfish.com (Postfix) with ESMTP id 7CC593C01AA	for
 <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 11:20:11 +0000 (UTC)
Received: from CH1EHSMHS030.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.225])	by mail131-ch1.bigfish.com (Postfix) with ESMTP id
 82DD6C0048
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 11:20:09 +0000 (UTC)
From: Li Yang <leoli@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT from
 configurable
Date: Thu, 16 Feb 2012 20:10:09 +0800
Message-ID: <1329394210-1014-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the problem that large physical address support cannot be
disabled when some platforms which only provides 36-bit support
are selected.  According to the philosophy of kernel config
enabling a platform support doesn't mean the kernel is only
running on that platform.  Remove the auto selection of PHYS_64BIT
option for these platforms.  They will need to use a 36bit default
config that selects PHYS_64BIT explicitly.

The reason why we need to keep PHYS_64BIT option configurable is
that enabling it cause negative performance impact on various
aspects like TLB miss and physical address manipulating.  We should
not enable it unless really needed, e.g. use large memory of 4GB
or bigger.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/85xx/Kconfig |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index d7946be..d9bc0bd 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -80,7 +80,6 @@ config P1010_RDB
 config P1022_DS
 	bool "Freescale P1022 DS"
 	select DEFAULT_UIMAGE
-	select PHYS_64BIT	# The DTS has 36-bit addresses
 	select SWIOTLB
 	help
 	  This option enables support for the Freescale P1022DS reference board.
@@ -175,7 +174,6 @@ config P2041_RDB
 	bool "Freescale P2041 RDB"
 	select DEFAULT_UIMAGE
 	select PPC_E500MC
-	select PHYS_64BIT
 	select SWIOTLB
 	select ARCH_REQUIRE_GPIOLIB
 	select GPIO_MPC8XXX
@@ -188,7 +186,6 @@ config P3041_DS
 	bool "Freescale P3041 DS"
 	select DEFAULT_UIMAGE
 	select PPC_E500MC
-	select PHYS_64BIT
 	select SWIOTLB
 	select ARCH_REQUIRE_GPIOLIB
 	select GPIO_MPC8XXX
@@ -201,7 +198,6 @@ config P3060_QDS
 	bool "Freescale P3060 QDS"
 	select DEFAULT_UIMAGE
 	select PPC_E500MC
-	select PHYS_64BIT
 	select SWIOTLB
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
@@ -213,7 +209,6 @@ config P4080_DS
 	bool "Freescale P4080 DS"
 	select DEFAULT_UIMAGE
 	select PPC_E500MC
-	select PHYS_64BIT
 	select SWIOTLB
 	select ARCH_REQUIRE_GPIOLIB
 	select GPIO_MPC8XXX
@@ -229,7 +224,6 @@ config P5020_DS
 	select DEFAULT_UIMAGE
 	select E500
 	select PPC_E500MC
-	select PHYS_64BIT
 	select SWIOTLB
 	select ARCH_REQUIRE_GPIOLIB
 	select GPIO_MPC8XXX
-- 
1.5.4.3
