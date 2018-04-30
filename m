Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Z6JV0NLqzF266
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 11:24:09 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id p10-v6so5262010pgn.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2018 18:24:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 2/2] powerpc/kbuild: move -mprofile-kernel check to Kconfig
Date: Mon, 30 Apr 2018 11:23:51 +1000
Message-Id: <20180430012351.28814-3-npiggin@gmail.com>
In-Reply-To: <20180430012351.28814-1-npiggin@gmail.com>
References: <20180430012351.28814-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This eliminates the workaround that requires disabling
-mprofile-kernel by default in Kconfig.
---
 arch/powerpc/Kconfig                            | 16 +---------------
 arch/powerpc/Makefile                           | 14 ++------------
 arch/powerpc/tools/gcc-check-mprofile-kernel.sh |  4 ++--
 3 files changed, 5 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 512fcc177c87..af527f894f9b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -460,23 +460,9 @@ config LD_HEAD_STUB_CATCH
 
 	  If unsure, say "N".
 
-config DISABLE_MPROFILE_KERNEL
-	bool "Disable use of mprofile-kernel for kernel tracing"
-	depends on PPC64 && CPU_LITTLE_ENDIAN
-	default y
-	help
-	  Selecting this options disables use of the mprofile-kernel ABI for
-	  kernel tracing. That will cause options such as live patching
-	  (CONFIG_LIVEPATCH) which depend on CONFIG_DYNAMIC_FTRACE_WITH_REGS to
-	  be disabled also.
-
-	  If you have a toolchain which supports mprofile-kernel, then you can
-	  disable this. Otherwise leave it enabled. If you're not sure, say
-	  "Y".
-
 config MPROFILE_KERNEL
 	depends on PPC64 && CPU_LITTLE_ENDIAN
-	def_bool !DISABLE_MPROFILE_KERNEL
+	def_bool $(success $(srctree)/arch/powerpc/tools/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__)
 
 config IOMMU_HELPER
 	def_bool PPC64
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 046b5dde9ff5..efab4d66043b 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -158,18 +158,8 @@ CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
 endif
 
 ifdef CONFIG_MPROFILE_KERNEL
-    ifeq ($(shell $(srctree)/arch/powerpc/tools/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__),OK)
-        CC_FLAGS_FTRACE := -pg -mprofile-kernel
-        KBUILD_CPPFLAGS += -DCC_USING_MPROFILE_KERNEL
-    else
-        # If the user asked for mprofile-kernel but the toolchain doesn't
-        # support it, emit a warning and deliberately break the build later
-        # with mprofile-kernel-not-supported. We would prefer to make this an
-        # error right here, but then the user would never be able to run
-        # oldconfig to change their configuration.
-        $(warning Compiler does not support mprofile-kernel, set CONFIG_DISABLE_MPROFILE_KERNEL)
-        CC_FLAGS_FTRACE := -mprofile-kernel-not-supported
-    endif
+	CC_FLAGS_FTRACE := -pg -mprofile-kernel
+	KBUILD_CPPFLAGS += -DCC_USING_MPROFILE_KERNEL
 endif
 
 CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
diff --git a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
index 061f8035bdbe..ec4486a9c4a3 100755
--- a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
+++ b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
@@ -10,13 +10,13 @@ set -o pipefail
 # Test whether the compile option -mprofile-kernel exists and generates
 # profiling code (ie. a call to _mcount()).
 echo "int func() { return 0; }" | \
-    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
+    $* -m64 -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
     grep -q "_mcount"
 
 # Test whether the notrace attribute correctly suppresses calls to _mcount().
 
 echo -e "#include <linux/compiler.h>\nnotrace int func() { return 0; }" | \
-    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
+    $* -m64 -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
     grep -q "_mcount" && \
     exit 1
 
-- 
2.17.0
