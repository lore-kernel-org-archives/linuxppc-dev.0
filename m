Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 89822DDEED
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 10:14:22 +1000 (EST)
Date: Sat, 2 May 2009 04:14:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 1/3] powerpc, Makefile: Make it possible to safely select
	CONFIG_FRAME_POINTER
Message-ID: <20090502001421.GA9342@oksana.dev.rtsoft.ru>
References: <20090502001329.GA11549@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090502001329.GA11549@oksana.dev.rtsoft.ru>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch introduces HAVE_NORMAL_FRAME_POINTER Kconfig symbol. When
defined, the top level Makefile won't add -fno-omit-frame-pointer
cflag (the flag is useless for PowerPC kernels, and also makes gcc
generate wrong code).

Also move ARCH_WANT_FRAME_POINTERS's help text.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Makefile             |    7 +++++--
 arch/powerpc/Kconfig |    1 +
 lib/Kconfig.debug    |   16 ++++++++++------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index b18afad..bfa58ea 100644
--- a/Makefile
+++ b/Makefile
@@ -543,9 +543,12 @@ KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
 endif
 
 ifdef CONFIG_FRAME_POINTER
-KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
+        KBUILD_CFLAGS += -fno-optimize-sibling-calls
+        ifndef CONFIG_HAVE_NORMAL_FRAME_POINTER
+                KBUILD_CFLAGS += -fno-omit-frame-pointer
+        endif
 else
-KBUILD_CFLAGS	+= -fomit-frame-pointer
+        KBUILD_CFLAGS += -fomit-frame-pointer
 endif
 
 ifdef CONFIG_DEBUG_INFO
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4c78045..b29a6c3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -119,6 +119,7 @@ config PPC
 	select HAVE_KPROBES
 	select HAVE_ARCH_KGDB
 	select HAVE_KRETPROBES
+	select HAVE_NORMAL_FRAME_POINTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_LMB
 	select HAVE_DMA_ATTRS if PPC64
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 444002b..1f1633b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -660,20 +660,24 @@ config DEBUG_NOTIFIERS
 	  This is a relatively cheap check but if you care about maximum
 	  performance, say N.
 
-#
-# Select this config option from the architecture Kconfig, if it
-# it is preferred to always offer frame pointers as a config
-# option on the architecture (regardless of KERNEL_DEBUG):
-#
 config ARCH_WANT_FRAME_POINTERS
 	bool
 	help
+	  Select this config option from the architecture Kconfig, if it
+	  it is preferred to always offer frame pointers as a config
+	  option on the architecture (regardless of KERNEL_DEBUG).
+
+config HAVE_NORMAL_FRAME_POINTER
+	bool
+	help
+	  Architectures should select this symbol if their ABI implies
+	  having a frame pointer.
 
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && \
 		(CRIS || M68K || M68KNOMMU || FRV || UML || \
-		 AVR32 || SUPERH || BLACKFIN || MN10300) || \
+		 AVR32 || SUPERH || BLACKFIN || MN10300 || PPC) || \
 		ARCH_WANT_FRAME_POINTERS
 	default y if (DEBUG_INFO && UML) || ARCH_WANT_FRAME_POINTERS
 	help
-- 
1.6.2.2
