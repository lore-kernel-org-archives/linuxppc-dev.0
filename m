Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 952721A05EB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 04:07:44 +1100 (AEDT)
In-Reply-To: <20160125170459.14DB7692CE@newverein.lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Mon, 25 Jan 2016 16:29:54 +0100
Subject: [PATCH v6 4/9] ppc64 ftrace_with_regs configuration variables
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20160125170741.5FAB5692DD@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  * Makefile:
    - globally use -mprofile-kernel in case it's configured
      and available.
  * arch/powerpc/Kconfig / kernel/trace/Kconfig:
    - declare that ppc64le HAVE_MPROFILE_KERNEL and
      HAVE_DYNAMIC_FTRACE_WITH_REGS, and use it.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/powerpc/Kconfig  |  2 ++
 arch/powerpc/Makefile | 10 ++++++++++
 kernel/trace/Kconfig  |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db49e0d..89b1a2a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -97,8 +97,10 @@ config PPC
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
index 96efd82..2f9b527 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -133,6 +133,16 @@ else
 CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
 endif
 
+ifeq ($(CONFIG_PPC64),y)
+ifdef CONFIG_HAVE_MPROFILE_KERNEL
+CC_USING_MPROFILE_KERNEL := $(call cc-option,-mprofile-kernel)
+ifdef CC_USING_MPROFILE_KERNEL
+CC_FLAGS_FTRACE	:= -pg $(CC_USING_MPROFILE_KERNEL)
+KBUILD_CPPFLAGS	+= -DCC_USING_MPROFILE_KERNEL
+endif
+endif
+endif
+
 CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
 CFLAGS-$(CONFIG_POWER4_CPU) += $(call cc-option,-mcpu=power4)
 CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
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
