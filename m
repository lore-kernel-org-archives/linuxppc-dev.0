Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 857E11A00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 11:42:25 +1100 (AEDT)
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8726B140FDA
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2015 11:42:23 +1100 (AEDT)
Received: by pfnn128 with SMTP id n128so38301018pfn.0
 for <linuxppc-dev@ozlabs.org>; Wed, 09 Dec 2015 16:42:22 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, Daniel Axtens <dja@axtens.net>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [RFC] powerpc: Enable UBSAN support
Date: Thu, 10 Dec 2015 11:42:03 +1100
Message-Id: <1449708123-7340-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This hooks up UBSAN support for PowerPC.

So far it's found some interesting cases where we don't properly sanitise
input to shifts, including one in our futex handling. Nothing critical,
but interesting and worth fixing.

CC: Andrey Ryabinin <aryabinin@virtuozzo.com>
---

This to be applied on top of next with Andrey's patches:
 1) https://patchwork.kernel.org/patch/7761341/
 2) https://patchwork.kernel.org/patch/7761351/
 3) https://patchwork.kernel.org/patch/7761361/
 4) https://patchwork.kernel.org/patch/7785791/

This is RFC for a couple of reasons:

 - I'd like the original patches to
   s/ARCH_HAS_UBSAN_SANTIZE_ALL/ARCH_HAS_UBSAN_SAN*I*TIZE_ALL/
   (I'm about to send an email about that)

 - I've only tested on LE pseries so far - I want to test on powernv,
   and on BE.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/Kconfig                | 1 +
 arch/powerpc/kernel/Makefile        | 8 +++++++-
 arch/powerpc/kernel/vdso32/Makefile | 1 +
 arch/powerpc/kernel/vdso64/Makefile | 1 +
 arch/powerpc/xmon/Makefile          | 1 +
 5 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 25283796a02e..e197de45d517 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -156,6 +156,7 @@ config PPC
 	select EDAC_ATOMIC_SCRUB
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select HAVE_ARCH_SECCOMP_FILTER
+	select ARCH_HAS_UBSAN_SANTIZE_ALL
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ba336930d448..794f22adf99d 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -136,12 +136,18 @@ endif
 obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
-# Disable GCOV in odd or sensitive code
+# Disable GCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
+UBSAN_SANITIZE_prom_init.o := n
 GCOV_PROFILE_ftrace.o := n
+UBSAN_SANITIZE_ftrace.o := n
 GCOV_PROFILE_machine_kexec_64.o := n
+UBSAN_SANITIZE_machine_kexec_64.o := n
 GCOV_PROFILE_machine_kexec_32.o := n
+UBSAN_SANITIZE_machine_kexec_32.o := n
 GCOV_PROFILE_kprobes.o := n
+UBSAN_SANITIZE_kprobes.o := n
+UBSAN_SANITIZE_vdso.o := n
 
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-$(CONFIG_ALTIVEC)		+= vector.o
diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index 6abffb7a8cd9..cbabd143acae 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -15,6 +15,7 @@ targets := $(obj-vdso32) vdso32.so vdso32.so.dbg
 obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
 
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 ccflags-y := -shared -fno-common -fno-builtin
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso32.so.1 \
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index 8c8f2ae43935..c710802b8fb6 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -8,6 +8,7 @@ targets := $(obj-vdso64) vdso64.so vdso64.so.dbg
 obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
 
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 ccflags-y := -shared -fno-common -fno-builtin
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 1278788d96e3..436062dbb6e2 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -3,6 +3,7 @@
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 
-- 
2.6.2
