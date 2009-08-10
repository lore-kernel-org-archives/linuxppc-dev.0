Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4BA1FB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 15:02:51 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <01690a659df1551b20c20c7cb98dbfe790c7c28d.1249880560.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Enable GCOV
Date: Mon, 10 Aug 2009 15:02:51 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make it possible to enable GCOV code coverage measurement on powerpc.

Lightly tested on 64-bit, seems to work as expected.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/Makefile        |    7 +++++++
 arch/powerpc/kernel/vdso32/Makefile |    1 +
 arch/powerpc/kernel/vdso64/Makefile |    2 ++
 arch/powerpc/xmon/Makefile          |    2 ++
 kernel/gcov/Kconfig                 |    2 +-
 5 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 035946f..720e8c3 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -115,6 +115,13 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
 obj-y				+= ppc_save_regs.o
 endif
 
+# Disable GCOV in odd or sensitive code
+GCOV_PROFILE_prom_init.o := n
+GCOV_PROFILE_ftrace.o := n
+GCOV_PROFILE_machine_kexec_64.o := n
+GCOV_PROFILE_machine_kexec_32.o := n
+GCOV_PROFILE_kprobes.o := n
+
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-$(CONFIG_ALTIVEC)		+= vector.o
 extra-$(CONFIG_PPC64)		+= entry_64.o
diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index c3d57bd..b54b816 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -12,6 +12,7 @@ endif
 targets := $(obj-vdso32) vdso32.so vdso32.so.dbg
 obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
 
+GCOV_PROFILE := n
 
 EXTRA_CFLAGS := -shared -fno-common -fno-builtin
 EXTRA_CFLAGS += -nostdlib -Wl,-soname=linux-vdso32.so.1 \
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index fa7f1b8..dd0c8e9 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -7,6 +7,8 @@ obj-vdso64 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o
 targets := $(obj-vdso64) vdso64.so vdso64.so.dbg
 obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
 
+GCOV_PROFILE := n
+
 EXTRA_CFLAGS := -shared -fno-common -fno-builtin
 EXTRA_CFLAGS += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
 		$(call ld-option, -Wl$(comma)--hash-style=sysv)
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 85ab97a..faa81b6 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -2,6 +2,8 @@
 
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
+GCOV_PROFILE := n
+
 ifdef CONFIG_PPC64
 EXTRA_CFLAGS += -mno-minimal-toc
 endif
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 22e9dcf..654efd0 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -34,7 +34,7 @@ config GCOV_KERNEL
 config GCOV_PROFILE_ALL
 	bool "Profile entire Kernel"
 	depends on GCOV_KERNEL
-	depends on S390 || X86
+	depends on S390 || X86 || (PPC && EXPERIMENTAL)
 	default n
 	---help---
 	This options activates profiling for the entire kernel.
-- 
1.6.2.1
