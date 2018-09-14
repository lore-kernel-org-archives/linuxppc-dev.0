Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BNps2cfJzF3V0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 15:09:09 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id k19-v6so3731528pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 22:09:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc: consolidate -mno-sched-epilog into FTRACE flags
Date: Fri, 14 Sep 2018 15:08:53 +1000
Message-Id: <20180914050854.6214-3-npiggin@gmail.com>
In-Reply-To: <20180914050854.6214-1-npiggin@gmail.com>
References: <20180914050854.6214-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile                    | 12 ++++++------
 arch/powerpc/kernel/Makefile             |  8 ++++----
 arch/powerpc/kernel/trace/Makefile       |  2 +-
 arch/powerpc/platforms/powermac/Makefile |  2 +-
 arch/powerpc/xmon/Makefile               |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 2ecd0976914a..be47cf8a0798 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -160,8 +160,13 @@ else
 CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
 endif
 
+ifdef CONFIG_FUNCTION_TRACER
+CC_FLAGS_FTRACE := -pg
 ifdef CONFIG_MPROFILE_KERNEL
-	CC_FLAGS_FTRACE := -pg -mprofile-kernel
+CC_FLAGS_FTRACE += -mprofile-kernel
+endif
+# Work around a gcc code-gen bug with -fno-omit-frame-pointer.
+CC_FLAGS_FTRACE	+= -mno-sched-epilog
 endif
 
 CFLAGS-$(CONFIG_TARGET_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
@@ -229,11 +234,6 @@ ifdef CONFIG_6xx
 KBUILD_CFLAGS		+= -mcpu=powerpc
 endif
 
-# Work around a gcc code-gen bug with -fno-omit-frame-pointer.
-ifdef CONFIG_FUNCTION_TRACER
-KBUILD_CFLAGS		+= -mno-sched-epilog
-endif
-
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 3b66f2c19c84..1e64cfe22a83 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -22,10 +22,10 @@ CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-CFLAGS_REMOVE_cputable.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_prom_init.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_btext.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_prom.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_cputable.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_prom_init.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_btext.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_prom.o = $(CC_FLAGS_FTRACE)
 endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
diff --git a/arch/powerpc/kernel/trace/Makefile b/arch/powerpc/kernel/trace/Makefile
index d22d8bafb643..d868ba42032f 100644
--- a/arch/powerpc/kernel/trace/Makefile
+++ b/arch/powerpc/kernel/trace/Makefile
@@ -7,7 +7,7 @@ subdir-ccflags-$(CONFIG_PPC_WERROR)	:= -Werror
 
 ifdef CONFIG_FUNCTION_TRACER
 # do not trace tracer code
-CFLAGS_REMOVE_ftrace.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
 endif
 
 obj32-$(CONFIG_FUNCTION_TRACER)		+= ftrace_32.o
diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
index f2839eed0f89..561a67d65e4d 100644
--- a/arch/powerpc/platforms/powermac/Makefile
+++ b/arch/powerpc/platforms/powermac/Makefile
@@ -3,7 +3,7 @@ CFLAGS_bootx_init.o  		+= -fPIC
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-CFLAGS_REMOVE_bootx_init.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_bootx_init.o = $(CC_FLAGS_FTRACE)
 endif
 
 obj-y				+= pic.o setup.o time.o feature.o pci.o \
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 1bc3abb237cd..93cc1f1b8b61 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -8,7 +8,7 @@ UBSAN_SANITIZE := n
 
 # Disable ftrace for the entire directory
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
-KBUILD_CFLAGS = $(subst -mno-sched-epilog,,$(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS)))
+KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
 
 ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 
-- 
2.18.0
