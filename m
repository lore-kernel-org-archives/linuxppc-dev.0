Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjx193KKQzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 16:51:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc/book3s64: Move PPC_DT_CPU_FTRs and enable it by
 default
Date: Thu,  8 Jun 2017 16:51:41 +1000
Message-Id: <1496904701-29372-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PPC_DT_CPU_FTRs is a bit misplaced in menuconfig, it shows up with
other general kernel options. It's really more at home in the "Platform
Support" section, so move it there.

Also enable it by default, for Book3s 64. It does mostly nothing unless
the device tree properties are found, and we will want it enabled
eventually in distro kernels, so turn it on to start getting more
testing.

Fixes: 5a61ef74f269 ("powerpc/64s: Support new device tree binding for discovering CPU features")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig           | 11 -----------
 arch/powerpc/platforms/Kconfig | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4a4a05afcaf7..964da1891ea9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -380,17 +380,6 @@ source "arch/powerpc/platforms/Kconfig"
 
 menu "Kernel options"
 
-config PPC_DT_CPU_FTRS
-	bool "Device-tree based CPU feature discovery & setup"
-	depends on PPC_BOOK3S_64
-	default n
-	help
-	  This enables code to use a new device tree binding for describing CPU
-	  compatibility and features. Saying Y here will attempt to use the new
-	  binding if the firmware provides it. Currently only the skiboot
-	  firmware provides this binding.
-	  If you're not sure say Y.
-
 config HIGHMEM
 	bool "High memory support"
 	depends on PPC32
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 33244e3d9375..4fd64d3f5c44 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -59,6 +59,17 @@ config PPC_OF_BOOT_TRAMPOLINE
 
 	  In case of doubt, say Y
 
+config PPC_DT_CPU_FTRS
+	bool "Device-tree based CPU feature discovery & setup"
+	depends on PPC_BOOK3S_64
+	default y
+	help
+	  This enables code to use a new device tree binding for describing CPU
+	  compatibility and features. Saying Y here will attempt to use the new
+	  binding if the firmware provides it. Currently only the skiboot
+	  firmware provides this binding.
+	  If you're not sure say Y.
+
 config UDBG_RTAS_CONSOLE
 	bool "RTAS based debug console"
 	depends on PPC_RTAS
-- 
2.7.4
