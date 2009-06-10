Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 82AF7B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 16:48:53 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <adf502e7c85161d77fdcaca24f55ba6b418c7f04.1244616523.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
Date: Wed, 10 Jun 2009 16:48:51 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the option to build the code under arch/powerpc with -Werror.

The intention is to make it harder for people to inadvertantly introduce
warnings in the arch/powerpc code. It needs to be configurable so that
if a warning is introduced, people can easily work around it while it's
being fixed.

The option is a negative, ie. don't enable -Werror, so that it will be
turned on for allyes and allmodconfig builds.

The default is n, in the hope that developers will build with -Werror,
that will probably lead to some build breaks, I am prepared to be flamed.

It's not enabled for math-emu, which is a steaming pile of warnings.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug      |   17 +++++++++++++++++
 arch/powerpc/kernel/Makefile    |    2 ++
 arch/powerpc/kvm/Makefile       |    2 ++
 arch/powerpc/lib/Makefile       |    2 ++
 arch/powerpc/mm/Makefile        |    2 ++
 arch/powerpc/oprofile/Makefile  |    2 ++
 arch/powerpc/platforms/Makefile |    2 ++
 arch/powerpc/sysdev/Makefile    |    2 ++
 arch/powerpc/xmon/Makefile      |    2 ++
 9 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index d79a902..3b10051 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -2,6 +2,23 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
+config PPC_DISABLE_WERROR
+	bool "Don't build arch/powerpc code with -Werror"
+	default n
+	help
+	  This option tells the compiler NOT to build the code under
+	  arch/powerpc with the -Werror flag (which means warnings
+	  are treated as errors).
+
+	  Only enable this if you are hitting a build failure in the
+	  arch/powerpc code caused by a warning, and you don't feel
+	  inclined to fix it.
+
+config PPC_WERROR
+	bool
+	depends on !PPC_DISABLE_WERROR
+	default y
+
 config PRINT_STACK_DEPTH
 	int "Stack depth to print" if DEBUG_KERNEL
 	default 64
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 65cf365..110ec6d 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -4,6 +4,8 @@
 
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
 ifeq ($(CONFIG_PPC64),y)
 CFLAGS_prom_init.o	+= -mno-minimal-toc
 endif
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 4b2df66..459c7ee 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -2,6 +2,8 @@
 # Makefile for Kernel-based Virtual Machine module
 #
 
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
 EXTRA_CFLAGS += -Ivirt/kvm -Iarch/powerpc/kvm
 
 common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 29b742b..3040dac 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -2,6 +2,8 @@
 # Makefile for ppc-specific library files..
 #
 
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS		+= -mno-minimal-toc
 endif
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index c4bcf07..2d2192e 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux ppc-specific parts of the memory manager.
 #
 
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS	+= -mno-minimal-toc
 endif
diff --git a/arch/powerpc/oprofile/Makefile b/arch/powerpc/oprofile/Makefile
index 2ef6b0d..73e1c2c 100644
--- a/arch/powerpc/oprofile/Makefile
+++ b/arch/powerpc/oprofile/Makefile
@@ -1,3 +1,5 @@
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS	+= -mno-minimal-toc
 endif
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index f741919..a6812ee 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -1,4 +1,6 @@
 
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
 obj-$(CONFIG_FSL_ULI1575)	+= fsl_uli1575.o
 
 obj-$(CONFIG_PPC_PMAC)		+= powermac/
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 2d1c87d..d073bfd 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -1,3 +1,5 @@
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS			+= -mno-minimal-toc
 endif
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 9cb03b7..85ab97a 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -1,5 +1,7 @@
 # Makefile for xmon
 
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
 ifdef CONFIG_PPC64
 EXTRA_CFLAGS += -mno-minimal-toc
 endif
-- 
1.6.2.1
