Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x231.google.com (mail-io0-x231.google.com
 [IPv6:2607:f8b0:4001:c06::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04E9B1A1E5A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 09:58:22 +1000 (AEST)
Received: by ioiz6 with SMTP id z6so72889334ioi.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2015 16:58:19 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>, Geoff Levand <geoff@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] powerpc: Kconfig: remove BE-only platforms from LE kernel
 build
Date: Mon,  7 Sep 2015 07:58:00 +0800
Message-Id: <1441583880-17824-1-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, little endian is only supported on powernv and pseries,
however, Kconfigs still allow us to include other platforms in a LE
kernel, this may result in space wasting or even build error if some
BE-only platforms always assume they are built for a BE kernel. So just
modify the Kconfigs of BE-only platforms to remove them from being built
for a LE kernel.

For 32bit only platforms, nothing needs to be done, because
CPU_LITTLE_ENDIAN depends on PPC64. For 64bit supported platforms, add
CPU_BIG_ENDIAN to dependencies explicitly, so that these platforms will
be disabled for LE [Suggested-by: Cédric Le Goater <clg@fr.ibm.com>].

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/powerpc/platforms/cell/Kconfig     | 4 ++--
 arch/powerpc/platforms/maple/Kconfig    | 2 +-
 arch/powerpc/platforms/pasemi/Kconfig   | 2 +-
 arch/powerpc/platforms/powermac/Kconfig | 2 +-
 arch/powerpc/platforms/ps3/Kconfig      | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 2f23133..808a904 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -25,7 +25,7 @@ config PPC_CELL_NATIVE
 
 config PPC_IBM_CELL_BLADE
 	bool "IBM Cell Blade"
-	depends on PPC64 && PPC_BOOK3S
+	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
 	select PPC_CELL_NATIVE
 	select PPC_OF_PLATFORM_PCI
 	select PCI
@@ -35,7 +35,7 @@ config PPC_IBM_CELL_BLADE
 
 config PPC_CELL_QPACE
 	bool "IBM Cell - QPACE"
-	depends on PPC64 && PPC_BOOK3S
+	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
 	select PPC_CELL_COMMON
 
 config AXON_MSI
diff --git a/arch/powerpc/platforms/maple/Kconfig b/arch/powerpc/platforms/maple/Kconfig
index 1ea621a..e359d0d 100644
--- a/arch/powerpc/platforms/maple/Kconfig
+++ b/arch/powerpc/platforms/maple/Kconfig
@@ -1,5 +1,5 @@
 config PPC_MAPLE
-	depends on PPC64 && PPC_BOOK3S
+	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
 	bool "Maple 970FX Evaluation Board"
 	select PCI
 	select MPIC
diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/pasemi/Kconfig
index a2aeb32..00d4b28 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -1,5 +1,5 @@
 config PPC_PASEMI
-	depends on PPC64 && PPC_BOOK3S
+	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
 	bool "PA Semi SoC-based platforms"
 	default n
 	select MPIC
diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index 607124b..43c6062 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -1,6 +1,6 @@
 config PPC_PMAC
 	bool "Apple PowerMac based machines"
-	depends on PPC_BOOK3S
+	depends on PPC_BOOK3S && CPU_BIG_ENDIAN
 	select MPIC
 	select PCI
 	select PPC_INDIRECT_PCI if PPC32
diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index 56f2740..b27f40f 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -1,6 +1,6 @@
 config PPC_PS3
 	bool "Sony PS3"
-	depends on PPC64 && PPC_BOOK3S
+	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
 	select PPC_CELL
 	select USB_OHCI_LITTLE_ENDIAN
 	select USB_OHCI_BIG_ENDIAN_MMIO
-- 
2.5.1
