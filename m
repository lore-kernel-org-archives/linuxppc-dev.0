Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECDA61A0279
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 08:09:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: thuth@redhat.com
Subject: [PATCH 3/6] powerpc/kconfig: Move bitness & endian options to the top
Date: Fri,  9 Oct 2015 08:09:14 +1100
Message-Id: <1444338557-14988-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want the 64/32-bit choice, and the little/big endian choice to be at
the very top of the menuconfig. That is because they have the most
effect on what other options are available, so it makes sense to set
them first.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig                   | 36 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype | 36 ----------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db685fa54c5f..ea9377259f15 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1,3 +1,39 @@
+config PPC64
+	bool "64-bit kernel"
+	default n
+	select HAVE_VIRT_CPU_ACCOUNTING
+	select ZLIB_DEFLATE
+	help
+	  This option selects whether a 32-bit or a 64-bit kernel
+	  will be built.
+
+choice
+	prompt "Endianness selection"
+	default CPU_BIG_ENDIAN
+	help
+	  This option selects whether a big endian or little endian kernel will
+	  be built.
+
+config CPU_BIG_ENDIAN
+	bool "Build big endian kernel"
+	help
+	  Build a big endian kernel.
+
+	  If unsure, select this option.
+
+config CPU_LITTLE_ENDIAN
+	bool "Build little endian kernel"
+	depends on PPC_BOOK3S_64
+	select PPC64_BOOT_WRAPPER
+	help
+	  Build a little endian kernel.
+
+	  Note that if cross compiling a little endian kernel,
+	  CROSS_COMPILE must point to a toolchain capable of targeting
+	  little endian powerpc.
+
+endchoice
+
 source "arch/powerpc/platforms/Kconfig.cputype"
 
 config PPC32
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index c140e94c7c72..60b28e63c137 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -1,12 +1,3 @@
-config PPC64
-	bool "64-bit kernel"
-	default n
-	select HAVE_VIRT_CPU_ACCOUNTING
-	select ZLIB_DEFLATE
-	help
-	  This option selects whether a 32-bit or a 64-bit kernel
-	  will be built.
-
 menu "Processor support"
 choice
 	prompt "Processor Type"
@@ -415,33 +406,6 @@ config VDSO32
 	  big endian. That is because the only little endian configuration we
 	  support is ppc64le which is 64-bit only.
 
-choice
-	prompt "Endianness selection"
-	default CPU_BIG_ENDIAN
-	help
-	  This option selects whether a big endian or little endian kernel will
-	  be built.
-
-config CPU_BIG_ENDIAN
-	bool "Build big endian kernel"
-	help
-	  Build a big endian kernel.
-
-	  If unsure, select this option.
-
-config CPU_LITTLE_ENDIAN
-	bool "Build little endian kernel"
-	depends on PPC_BOOK3S_64
-	select PPC64_BOOT_WRAPPER
-	help
-	  Build a little endian kernel.
-
-	  Note that if cross compiling a little endian kernel,
-	  CROSS_COMPILE must point to a toolchain capable of targeting
-	  little endian powerpc.
-
-endchoice
-
 config PPC64_BOOT_WRAPPER
 	def_bool n
 	depends on CPU_LITTLE_ENDIAN
-- 
2.1.4
