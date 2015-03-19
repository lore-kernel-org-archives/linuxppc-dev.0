Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 325901A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 07:48:10 +1100 (AEDT)
Date: Thu, 19 Mar 2015 21:48:06 +0100
From: Torsten Duwe <duwe@lst.de>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v0 2/4] ppc64le: dynamic ftrace configuration options
Message-ID: <20150319204806.GC19524@lst.de>
References: <20150319203522.GA19524@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150319203522.GA19524@lst.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Switch on -mprofile-kernel, and remove it again
from directories involved in exception handling.
This needs to be done more fine grained, of course.

diff --git a/Makefile b/Makefile
index 1a60bdd..72644e6 100644
--- a/Makefile
+++ b/Makefile
@@ -732,7 +732,10 @@ ifdef CONFIG_FUNCTION_TRACER
 ifdef CONFIG_HAVE_FENTRY
 CC_USING_FENTRY	:= $(call cc-option, -mfentry -DCC_USING_FENTRY)
 endif
-KBUILD_CFLAGS	+= -pg $(CC_USING_FENTRY)
+ifdef CONFIG_HAVE_MPROFILE_KERNEL
+CC_USING_MPROFILE_KERNEL	:= $(call cc-option, -mprofile-kernel -DCC_USING_MPROFILE_KERNEL)
+endif
+KBUILD_CFLAGS	+= -pg $(CC_USING_FENTRY) $(CC_USING_MPROFILE_KERNEL)
 KBUILD_AFLAGS	+= $(CC_USING_FENTRY)
 ifdef CONFIG_DYNAMIC_FTRACE
 	ifdef CONFIG_HAVE_C_RECORDMCOUNT
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4bc7b62..d82d7c8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -93,8 +93,10 @@ config PPC
 	select OF_RESERVED_MEM
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_MPROFILE_KERNEL
 	select SYSCTL_EXCEPTION_TRACE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select VIRT_TO_BUS if !PPC64
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 670c312..688e6f9 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -17,14 +17,14 @@ endif
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog -mprofile-kernel
+CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog -mprofile-kernel
+CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog -mprofile-kernel
+CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog -mprofile-kernel
 # do not trace tracer code
-CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog -mprofile-kernel
 # timers used by tracing
-CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog -mprofile-kernel
 endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
diff --git a/kernel/Makefile b/kernel/Makefile
index 8af7403..3c8821d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -13,8 +13,9 @@ obj-y     = fork.o exec_domain.o panic.o \
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace debug files and internal ftrace files
-CFLAGS_REMOVE_cgroup-debug.o = -pg
-CFLAGS_REMOVE_irq_work.o = -pg
+CFLAGS_REMOVE_cgroup-debug.o = -pg -mprofile-kernel
+CFLAGS_REMOVE_irq_work.o = -pg -mprofile-kernel
+CFLAGS_REMOVE_extable.o = -pg -mprofile-kernel
 endif
 
 # cond_syscall is currently not LTO compatible
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 8541bfd..1cc57c8 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -2,10 +2,10 @@
 obj-y += mutex.o semaphore.o rwsem.o mcs_spinlock.o
 
 ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_lockdep.o = -pg
-CFLAGS_REMOVE_lockdep_proc.o = -pg
-CFLAGS_REMOVE_mutex-debug.o = -pg
-CFLAGS_REMOVE_rtmutex-debug.o = -pg
+CFLAGS_REMOVE_lockdep.o = -pg -mprofile-kernel
+CFLAGS_REMOVE_lockdep_proc.o = -pg -mprofile-kernel
+CFLAGS_REMOVE_mutex-debug.o = -pg -mprofile-kernel
+CFLAGS_REMOVE_rtmutex-debug.o = -pg -mprofile-kernel
 endif
 
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a5da09c..dd53f3d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -52,6 +52,11 @@ config HAVE_FENTRY
 	help
 	  Arch supports the gcc options -pg with -mfentry
 
+config HAVE_MPROFILE_KERNEL
+	bool
+	help
+	  Arch supports the gcc options -pg with -mprofile-kernel
+
 config HAVE_C_RECORDMCOUNT
 	bool
 	help
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 59fa2de..b2f5029 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -6,8 +6,8 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
-CFLAGS_REMOVE_code-patching.o = -pg
-CFLAGS_REMOVE_feature-fixups.o = -pg
+CFLAGS_REMOVE_code-patching.o = -pg -mprofile-kernel
+CFLAGS_REMOVE_feature-fixups.o = -pg -mprofile-kernel
 
 obj-y			:= string.o alloc.o \
 			   crtsavres.o
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index d0130ff..22633af 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -6,6 +6,11 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
+# needed for do_page_fault in fault.c :
+KBUILD_CFLAGS := $(filter-out -mprofile-kernel, $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -pg, $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -DCC_USING_MPROFILE_KERNEL, $(KBUILD_CFLAGS))
+
 obj-y				:= fault.o mem.o pgtable.o gup.o mmap.o \
 				   init_$(CONFIG_WORD_SIZE).o \
 				   pgtable_$(CONFIG_WORD_SIZE).o
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 688e6f9..1f08a53 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -26,6 +26,9 @@ CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog -mprofile-kernel
 # timers used by tracing
 CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog -mprofile-kernel
 endif
+KBUILD_CFLAGS := $(filter-out -mprofile-kernel, $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -pg, $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -DCC_USING_MPROFILE_KERNEL, $(KBUILD_CFLAGS))
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
diff --git a/kernel/Makefile b/kernel/Makefile
index f2f8537..f84c784 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -17,6 +17,9 @@ CFLAGS_REMOVE_cgroup-debug.o = -pg -mprofile-kernel
 CFLAGS_REMOVE_irq_work.o = -pg -mprofile-kernel
 CFLAGS_REMOVE_extable.o = -pg -mprofile-kernel
 endif
+KBUILD_CFLAGS := $(filter-out -mprofile-kernel, $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -pg, $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -DCC_USING_MPROFILE_KERNEL, $(KBUILD_CFLAGS))
 
 # cond_syscall is currently not LTO compatible
 CFLAGS_sys_ni.o = $(DISABLE_LTO)
diff --git a/lib/Makefile b/lib/Makefile
index d6b4bc4..186cf9b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -6,6 +6,9 @@ ifdef CONFIG_FUNCTION_TRACER
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg,,$(ORIG_CFLAGS))
 endif
+KBUILD_CFLAGS := $(filter-out -mprofile-kernel, $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -pg, $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -DCC_USING_MPROFILE_KERNEL, $(KBUILD_CFLAGS))
 
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o dump_stack.o timerqueue.o\
diff --git a/mm/Makefile b/mm/Makefile
index 632ae77..07be08f 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -20,6 +20,10 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   interval_tree.o list_lru.o workingset.o \
 			   iov_iter.o $(mmu-y)
 
+KBUILD_CFLAGS := $(filter-out -mprofile-kernel, $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -pg, $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -DCC_USING_MPROFILE_KERNEL, $(KBUILD_CFLAGS))
+
 obj-y += init-mm.o
 
 ifdef CONFIG_NO_BOOTMEM
