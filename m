Return-Path: <joel.stan@gmail.com>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BMRw4wsDzF3TZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 14:07:40 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id i26-v6so3634179pfo.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 21:07:40 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@ozlabs.org>,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 5/5] powerpc: Remove -mno-sched-epilog
Date: Fri, 14 Sep 2018 13:36:49 +0930
Message-Id: <20180914040649.1794-6-joel@jms.id.au>
In-Reply-To: <20180914040649.1794-1-joel@jms.id.au>
References: <20180914040649.1794-1-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This effectively reverts 7563dc645853 ("powerpc: Work around gcc's
-fno-omit-frame-pointer bug"), a workaround for a bug in GCC 4.1.3 when
building 2.6.26 kernel.

The flag is not supported by clang, but reading the history of the
bug[1] suggests it is no longer required by supported GCC versions, with
GCC 4.6 now being the minimum.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=11414
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Last time this was proposed there was an issue reported:

 https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-September/121214.html

If some machines still have an issue, we could instead wrap this in a
flag check.
---
 arch/powerpc/Makefile                    | 5 -----
 arch/powerpc/kernel/Makefile             | 8 ++++----
 arch/powerpc/kernel/trace/Makefile       | 2 +-
 arch/powerpc/platforms/powermac/Makefile | 2 +-
 arch/powerpc/xmon/Makefile               | 2 +-
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a70639482053..ef8eca40ffef 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -229,11 +229,6 @@ ifdef CONFIG_6xx
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
2.17.1
