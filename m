Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8B931A03E6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 04:44:53 +1100 (AEDT)
In-Reply-To: <20160210174221.EBBEC692C8@newverein.lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Wed, 10 Feb 2016 17:25:01 +0100
Subject: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20160210174450.9C065692C8@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  * arch/powerpc/Makefile:
    - globally use -mprofile-kernel in case it's configured,
      available and bug-free.
  * arch/powerpc/gcc-mprofile-kernel-notrace.sh:
    - make sure -mprofile-kernel works and has none of the
      known bugs.
  * arch/powerpc/kernel/ftrace.c:
    - error out on compile with HAVE_DYNAMIC_FTRACE_WITH_REGS
      and a buggy compiler.
  * arch/powerpc/Kconfig / kernel/trace/Kconfig:
    - declare that ppc64le HAVE_MPROFILE_KERNEL and
      HAVE_DYNAMIC_FTRACE_WITH_REGS, and use it.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/powerpc/Kconfig                        |  2 ++
 arch/powerpc/Makefile                       | 17 +++++++++++++++
 arch/powerpc/gcc-mprofile-kernel-notrace.sh | 33 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/ftrace.c                |  5 +++++
 kernel/trace/Kconfig                        |  5 +++++
 5 files changed, 62 insertions(+)
 create mode 100755 arch/powerpc/gcc-mprofile-kernel-notrace.sh

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e4824fd..e5f288c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -94,8 +94,10 @@ config PPC
 	select OF_RESERVED_MEM
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS if PPC64 && CPU_LITTLE_ENDIAN
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_MPROFILE_KERNEL if PPC64 && CPU_LITTLE_ENDIAN
 	select SYSCTL_EXCEPTION_TRACE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select VIRT_TO_BUS if !PPC64
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 96efd82..08a3952 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -133,6 +133,23 @@ else
 CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
 endif
 
+ifeq ($(CONFIG_PPC64),y)
+ifdef CONFIG_HAVE_MPROFILE_KERNEL
+
+ifdef CONFIG_DYNAMIC_FTRACE
+ifeq ($(shell $(CONFIG_SHELL) $(srctree)/arch/powerpc/gcc-mprofile-kernel-notrace.sh $(CC) -I$(srctree)/include -D__KERNEL__), y)
+CC_USING_MPROFILE_KERNEL := -mprofile-kernel
+endif
+endif
+
+ifdef CC_USING_MPROFILE_KERNEL
+CC_FLAGS_FTRACE	:= -pg $(CC_USING_MPROFILE_KERNEL)
+KBUILD_CPPFLAGS	+= -DCC_USING_MPROFILE_KERNEL
+endif
+
+endif
+endif
+
 CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
 CFLAGS-$(CONFIG_POWER4_CPU) += $(call cc-option,-mcpu=power4)
 CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
diff --git a/arch/powerpc/gcc-mprofile-kernel-notrace.sh b/arch/powerpc/gcc-mprofile-kernel-notrace.sh
new file mode 100755
index 0000000..68d6482
--- /dev/null
+++ b/arch/powerpc/gcc-mprofile-kernel-notrace.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+# Test whether the compile option -mprofile-kernel
+# generates profiling code ( = a call to mcount), and
+# whether a function without any global references sets
+# the TOC pointer properly at the beginning, and
+# whether the "notrace" function attribute successfully
+# suppresses the _mcount call.
+
+echo "int func() { return 0; }" | \
+    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
+    grep -q "mcount"
+
+trace_result=$?
+
+echo "int func() { return 0; }" | \
+    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
+    sed -n -e '/func:/,/bl _mcount/p' | grep -q TOC
+
+leaf_toc_result=$?
+
+/bin/echo -e "#include <linux/compiler.h>\nnotrace int func() { return 0; }" | \
+    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
+    grep -q "mcount"
+
+notrace_result=$?
+
+if [ "$trace_result" -eq "0" -a \
+	"$leaf_toc_result" -eq "0" -a \
+	"$notrace_result" -eq "1" ]; then
+	echo y
+else
+	echo n
+fi
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index ef8b916..29b7014 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -28,6 +28,11 @@
 
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) && defined(CONFIG_PPC64) && \
+  !defined(CC_USING_MPROFILE_KERNEL)
+#error "DYNAMIC_FTRACE_WITH_REGS requires working -mprofile-kernel"
+#endif
+
 static unsigned int
 ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
 {
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e45db6b..a138f6d 100644
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
-- 
1.8.5.6
