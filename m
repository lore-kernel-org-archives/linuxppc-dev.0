Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B46EB6F62
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2012 06:53:57 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <scottwood@freescale.com>, <leoli@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
Date: Tue, 21 Feb 2012 13:53:15 -0600
Message-ID: <1329853995-7533-1-git-send-email-timur@freescale.com>
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

Remove the "select PHYS_64BIT" from the Kconfig entry for the P1022DS,
so that large physical address support is a selectable option for non-CoreNet
reference boards.

The option is enabled in mpc85xx_[smp_]defconfig so that the default is
unchanged.  However, now it can be deselected.

The P1022DS had this option defined because the default device tree for
this board uses 36-bit addresses.  This had the side-effect of forcing
this option on for all boards that use mpc85xx_[smp_]defconfig.  Some
users may want to disable this feature to create an optimized configuration
for boards with <= 2GB of RAM.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/configs/mpc85xx_defconfig     |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig |    1 +
 arch/powerpc/platforms/85xx/Kconfig        |    1 -
 3 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index f37a2ab..5fb0c8a 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -1,4 +1,5 @@
 CONFIG_PPC_85xx=y
+CONFIG_PHYS_64BIT=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index abdcd31..fb51bc9 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -1,4 +1,5 @@
 CONFIG_PPC_85xx=y
+CONFIG_PHYS_64BIT=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_EXPERIMENTAL=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index d7946be..93d27e2 100644
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
-- 
1.7.3.4
