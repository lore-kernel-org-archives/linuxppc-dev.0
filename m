Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id CA0D5DDEDD
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 03:44:32 +1100 (EST)
Date: Fri, 20 Mar 2009 19:44:31 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 2/3] powerpc: Remove -fno-omit-frame-pointer workarounds
Message-ID: <20090320164431.GB28037@oksana.dev.rtsoft.ru>
References: <20090320164404.GA19933@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090320164404.GA19933@oksana.dev.rtsoft.ru>
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

The workarounds aren't needed any longer since the top level Makefile
doesn't pass -fno-omit-frame-pointer cflag for PowerPC.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/Makefile                    |    5 -----
 arch/powerpc/kernel/Makefile             |   12 ++++++------
 arch/powerpc/platforms/powermac/Makefile |    2 +-
 lib/Kconfig.debug                        |    6 +++---
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 551fc58..1dd7748 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -120,11 +120,6 @@ ifeq ($(CONFIG_6xx),y)
 KBUILD_CFLAGS		+= -mcpu=powerpc
 endif
 
-# Work around a gcc code-gen bug with -fno-omit-frame-pointer.
-ifeq ($(CONFIG_FUNCTION_TRACER),y)
-KBUILD_CFLAGS		+= -mno-sched-epilog
-endif
-
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index dfec3d2..f86caeb 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -14,14 +14,14 @@ endif
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_cputable.o = -pg
+CFLAGS_REMOVE_prom_init.o = -pg
+CFLAGS_REMOVE_btext.o = -pg
+CFLAGS_REMOVE_prom.o = -pg
 # do not trace tracer code
-CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_ftrace.o = -pg
 # timers used by tracing
-CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_time.o = -pg
 endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
index 50f1693..0eb8781 100644
--- a/arch/powerpc/platforms/powermac/Makefile
+++ b/arch/powerpc/platforms/powermac/Makefile
@@ -2,7 +2,7 @@ CFLAGS_bootx_init.o  		+= -fPIC
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-CFLAGS_REMOVE_bootx_init.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_bootx_init.o = -pg
 endif
 
 obj-y				+= pic.o setup.o time.o feature.o pci.o \
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fc8cd1f..713620d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -493,7 +493,7 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	select STACKTRACE
-	select FRAME_POINTER if !MIPS && !PPC && !ARM_UNWIND
+	select FRAME_POINTER if !MIPS && !ARM_UNWIND
 	select KALLSYMS
 	select KALLSYMS_ALL
 
@@ -866,13 +866,13 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
 	depends on !X86_64
 	select STACKTRACE
-	select FRAME_POINTER if !PPC
+	select FRAME_POINTER
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
 config LATENCYTOP
 	bool "Latency measuring infrastructure"
-	select FRAME_POINTER if !MIPS && !PPC
+	select FRAME_POINTER if !MIPS
 	select KALLSYMS
 	select KALLSYMS_ALL
 	select STACKTRACE
-- 
1.5.6.5
