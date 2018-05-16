Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mGg257hrzF157
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 00:15:26 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id f189-v6so425674pfa.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 07:15:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v4 4/4] powerpc/kbuild: move -mprofile-kernel check to Kconfig
Date: Thu, 17 May 2018 00:14:58 +1000
Message-Id: <20180516141458.18996-5-npiggin@gmail.com>
In-Reply-To: <20180516141458.18996-1-npiggin@gmail.com>
References: <20180516141458.18996-1-npiggin@gmail.com>
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

[ Note: this depends on https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kconfig-shell-v3 ]

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v3:
- Moved a stray hunk back to patch 3 where it belongs.

 arch/powerpc/Kconfig  | 16 +---------------
 arch/powerpc/Makefile | 14 ++------------
 2 files changed, 3 insertions(+), 27 deletions(-)

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
index 6faf1d6ad9dd..8f7a64fe7370 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -161,18 +161,8 @@ CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
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
-- 
2.17.0
