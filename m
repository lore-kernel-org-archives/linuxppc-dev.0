Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wqR81wllzDrJr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 22:19:48 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id az12-v6so10991613plb.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 05:19:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v5 4/4] powerpc/kbuild: move -mprofile-kernel check to Kconfig
Date: Wed, 30 May 2018 22:19:22 +1000
Message-Id: <20180530121922.22122-5-npiggin@gmail.com>
In-Reply-To: <20180530121922.22122-1-npiggin@gmail.com>
References: <20180530121922.22122-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This eliminates the workaround that requires disabling
-mprofile-kernel by default in Kconfig.

[ Note: this depends on https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kconfig-shell-v3 ]

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig                            | 16 +---------------
 arch/powerpc/Makefile                           | 13 +------------
 arch/powerpc/include/asm/module.h               |  2 +-
 arch/powerpc/kernel/module_64.c                 |  4 ++--
 arch/powerpc/kernel/trace/ftrace.c              |  6 +++---
 arch/powerpc/tools/gcc-check-mprofile-kernel.sh |  1 -
 6 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0cc41146bc51..736fe35a657d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -461,23 +461,9 @@ config LD_HEAD_STUB_CATCH
 
 	  If unsure, say "N".
 
-config DISABLE_MPROFILE_KERNEL
-	bool "Disable use of mprofile-kernel for kernel tracing"
-	depends on PPC64 && CPU_LITTLE_ENDIAN
-	default y
-	help
-	  Selecting this options disables use of the mprofile-kernel ABI for
-	  kernel tracing. That will cause options such as live patching
-	  (CONFIG_LIVEPATCH) which depend on CONFIG_DYNAMIC_FTRACE_WITH_REGS to
-	  be disabled also.
-
-	  If you have a toolchain which supports mprofile-kernel, then you can
-	  disable this. Otherwise leave it enabled. If you're not sure, say
-	  "Y".
-
 config MPROFILE_KERNEL
 	depends on PPC64 && CPU_LITTLE_ENDIAN
-	def_bool !DISABLE_MPROFILE_KERNEL
+	def_bool $(success,$(srctree)/arch/powerpc/tools/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__)
 
 config IOMMU_HELPER
 	def_bool PPC64
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6faf1d6ad9dd..8eda91e0b8df 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -161,18 +161,7 @@ CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
 endif
 
 ifdef CONFIG_MPROFILE_KERNEL
-    ifeq ($(shell $(srctree)/arch/powerpc/tools/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__),OK)
-        CC_FLAGS_FTRACE := -pg -mprofile-kernel
-        KBUILD_CPPFLAGS += -DCC_USING_MPROFILE_KERNEL
-    else
-        # If the user asked for mprofile-kernel but the toolchain doesn't
-        # support it, emit a warning and deliberately break the build later
-        # with mprofile-kernel-not-supported. We would prefer to make this an
-        # error right here, but then the user would never be able to run
-        # oldconfig to change their configuration.
-        $(warning Compiler does not support mprofile-kernel, set CONFIG_DISABLE_MPROFILE_KERNEL)
-        CC_FLAGS_FTRACE := -mprofile-kernel-not-supported
-    endif
+	CC_FLAGS_FTRACE := -pg -mprofile-kernel
 endif
 
 CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index 4f6573934792..c38b125b7a57 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -14,7 +14,7 @@
 #include <asm-generic/module.h>
 
 
-#ifdef CC_USING_MPROFILE_KERNEL
+#ifdef CONFIG_MPROFILE_KERNEL
 #define MODULE_ARCH_VERMAGIC_FTRACE	"mprofile-kernel "
 #else
 #define MODULE_ARCH_VERMAGIC_FTRACE	""
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index a2636c250b7b..55bccc315e1a 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -462,7 +462,7 @@ static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
 	return (unsigned long)&stubs[i];
 }
 
-#ifdef CC_USING_MPROFILE_KERNEL
+#ifdef CONFIG_MPROFILE_KERNEL
 static bool is_early_mcount_callsite(u32 *instruction)
 {
 	/*
@@ -746,7 +746,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-#ifdef CC_USING_MPROFILE_KERNEL
+#ifdef CONFIG_MPROFILE_KERNEL
 
 #define PACATOC offsetof(struct paca_struct, kernel_toc)
 
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 4741fe112f05..b2272308225a 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -144,7 +144,7 @@ __ftrace_make_nop(struct module *mod,
 		return -EINVAL;
 	}
 
-#ifdef CC_USING_MPROFILE_KERNEL
+#ifdef CONFIG_MPROFILE_KERNEL
 	/* When using -mkernel_profile there is no load to jump over */
 	pop = PPC_INST_NOP;
 
@@ -188,7 +188,7 @@ __ftrace_make_nop(struct module *mod,
 		pr_err("Expected %08x found %08x\n", PPC_INST_LD_TOC, op);
 		return -EINVAL;
 	}
-#endif /* CC_USING_MPROFILE_KERNEL */
+#endif /* CONFIG_MPROFILE_KERNEL */
 
 	if (patch_instruction((unsigned int *)ip, pop)) {
 		pr_err("Patching NOP failed.\n");
@@ -324,7 +324,7 @@ int ftrace_make_nop(struct module *mod,
  * They should effectively be a NOP, and follow formal constraints,
  * depending on the ABI. Return false if they don't.
  */
-#ifndef CC_USING_MPROFILE_KERNEL
+#ifndef CONFIG_MPROFILE_KERNEL
 static int
 expected_nop_sequence(void *ip, unsigned int op0, unsigned int op1)
 {
diff --git a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
index a7dd0e5d9f98..137f3376ac2b 100755
--- a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
+++ b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
@@ -24,5 +24,4 @@ echo -e "#include <linux/compiler.h>\nnotrace int func() { return 0; }" | \
     2> /dev/null | grep -q "_mcount" && \
     exit 1
 
-echo "OK"
 exit 0
-- 
2.17.0
