Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <b0b55030b7ba669cbdec74a8b89875096ea07622.1239069602.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
Date: Tue,  7 Apr 2009 12:00:41 +1000 (EST)
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add an option, on by default, to build all code under arch/powerpc with
-Werror, which causes gcc to treat warnings as errors.

The intention is to make it harder for people to inadvertantly introduce
errors in the arch/powerpc code. It needs to be configurable so that
if a warning is introduced, people can easily work around it while it's
being fixed.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug      |    8 ++++++++
 arch/powerpc/kernel/Makefile    |    4 ++++
 arch/powerpc/kvm/Makefile       |    4 ++++
 arch/powerpc/lib/Makefile       |    4 ++++
 arch/powerpc/mm/Makefile        |    4 ++++
 arch/powerpc/oprofile/Makefile  |    4 ++++
 arch/powerpc/platforms/Makefile |    4 ++++
 arch/powerpc/sysdev/Makefile    |    4 ++++
 arch/powerpc/xmon/Makefile      |    4 ++++
 9 files changed, 40 insertions(+), 0 deletions(-)

v2: Leave math-emu alone, it's a steaming pile of warnings.

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index a1098e2..58d5c22 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -2,6 +2,14 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
+config PPC_WERROR
+	bool "Build arch/powerpc code with -Werror"
+	default y
+	help
+	  This option tells the compiler to build all of the code under
+	  arch/powerpc with the -Werror flag, which means all warnings
+	  are treated as errors.
+
 config PRINT_STACK_DEPTH
 	int "Stack depth to print" if DEBUG_KERNEL
 	default 64
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 71901fb..b11ef4e 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -12,6 +12,10 @@ CFLAGS_prom_init.o      += -fPIC
 CFLAGS_btext.o		+= -fPIC
 endif
 
+ifeq ($(CONFIG_PPC_WERROR),y)
+EXTRA_CFLAGS += -Werror
+endif
+
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
 CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 4b2df66..51d2337 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -2,6 +2,10 @@
 # Makefile for Kernel-based Virtual Machine module
 #
 
+ifeq ($(CONFIG_PPC_WERROR),y)
+EXTRA_CFLAGS += -Werror
+endif
+
 EXTRA_CFLAGS += -Ivirt/kvm -Iarch/powerpc/kvm
 
 common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 8db3527..536db60 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -2,6 +2,10 @@
 # Makefile for ppc-specific library files..
 #
 
+ifeq ($(CONFIG_PPC_WERROR),y)
+EXTRA_CFLAGS += -Werror
+endif
+
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS		+= -mno-minimal-toc
 endif
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 17290bc..4880a16 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -2,6 +2,10 @@
 # Makefile for the linux ppc-specific parts of the memory manager.
 #
 
+ifeq ($(CONFIG_PPC_WERROR),y)
+EXTRA_CFLAGS += -Werror
+endif
+
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS	+= -mno-minimal-toc
 endif
diff --git a/arch/powerpc/oprofile/Makefile b/arch/powerpc/oprofile/Makefile
index 2ef6b0d..e607c74 100644
--- a/arch/powerpc/oprofile/Makefile
+++ b/arch/powerpc/oprofile/Makefile
@@ -1,3 +1,7 @@
+ifeq ($(CONFIG_PPC_WERROR),y)
+EXTRA_CFLAGS += -Werror
+endif
+
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS	+= -mno-minimal-toc
 endif
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index f741919..b18b921 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -1,4 +1,8 @@
 
+ifeq ($(CONFIG_PPC_WERROR),y)
+EXTRA_CFLAGS += -Werror
+endif
+
 obj-$(CONFIG_FSL_ULI1575)	+= fsl_uli1575.o
 
 obj-$(CONFIG_PPC_PMAC)		+= powermac/
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index b33b28a..508c305 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -1,3 +1,7 @@
+ifeq ($(CONFIG_PPC_WERROR),y)
+EXTRA_CFLAGS += -Werror
+endif
+
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS			+= -mno-minimal-toc
 endif
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 9cb03b7..3348822 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -1,5 +1,9 @@
 # Makefile for xmon
 
+ifeq ($(CONFIG_PPC_WERROR),y)
+EXTRA_CFLAGS += -Werror
+endif
+
 ifdef CONFIG_PPC64
 EXTRA_CFLAGS += -mno-minimal-toc
 endif
-- 
1.6.2.1
