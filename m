Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
 [216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1D2E1B6F76
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2011 05:50:22 +1100 (EST)
Received: from mail25-va3 (localhost [127.0.0.1])	by mail25-va3-R.bigfish.com
 (Postfix) with ESMTP id 4E3E11E04CD	for <linuxppc-dev@ozlabs.org>;
 Thu,  3 Nov 2011 18:52:01 +0000 (UTC)
Received: from VA3EHSMHS024.bigfish.com (unknown [10.7.14.254])	by
 mail25-va3.bigfish.com (Postfix) with ESMTP id 140FC1C0043	for
 <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2011 18:52:01 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: do not force PHYS_64BIT on Freescale reference
 boards
Date: Thu, 3 Nov 2011 13:50:15 -0500
Message-ID: <1320346215-21024-1-git-send-email-timur@freescale.com>
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

Kconfig option PHYS_64BIT sets the size of phys_addr_t to 64 bits, which
allows support for a 36-bit physical address space.  With this option, the
kernel can support more than 2GB of RAM, but the larger address size
impacts performance slightly.

By including "select PHYS_64BIT" in the Kconfig for a particular board,
that option is forced enabled, and it becomes impossible to create a 32-bit
kernel.  Instead, we should depend on the defconfig to enable this option.
We still build a 36-bit kernel by default, and we also allow users to build
32-bit kernels if they really want.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/platforms/85xx/Kconfig          |    5 -----
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 4311d02..819c06e 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -1,4 +1,5 @@
 CONFIG_PPC_85xx=y
+CONFIG_PHYS_64BIT=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_EXPERIMENTAL=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 12f5932..6dba779 100644
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
@@ -175,7 +174,6 @@ config P2040_RDB
 	bool "Freescale P2040 RDB"
 	select DEFAULT_UIMAGE
 	select PPC_E500MC
-	select PHYS_64BIT
 	select SWIOTLB
 	select MPC8xxx_GPIO
 	select HAS_RAPIDIO
@@ -187,7 +185,6 @@ config P3041_DS
 	bool "Freescale P3041 DS"
 	select DEFAULT_UIMAGE
 	select PPC_E500MC
-	select PHYS_64BIT
 	select SWIOTLB
 	select MPC8xxx_GPIO
 	select HAS_RAPIDIO
@@ -199,7 +196,6 @@ config P4080_DS
 	bool "Freescale P4080 DS"
 	select DEFAULT_UIMAGE
 	select PPC_E500MC
-	select PHYS_64BIT
 	select SWIOTLB
 	select MPC8xxx_GPIO
 	select HAS_RAPIDIO
@@ -214,7 +210,6 @@ config P5020_DS
 	select DEFAULT_UIMAGE
 	select E500
 	select PPC_E500MC
-	select PHYS_64BIT
 	select SWIOTLB
 	select MPC8xxx_GPIO
 	select HAS_RAPIDIO
-- 
1.7.3.4
