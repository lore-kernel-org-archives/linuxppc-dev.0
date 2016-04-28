Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwWx83fC6zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 19:38:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc: Define and use PPC_ELF_ABI_v2
Date: Thu, 28 Apr 2016 19:38:47 +1000
Message-Id: <1461836327-15417-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We're approaching 20 locations where we need to check for ELF ABI v2.
That's fine, except the logic is a bit awkward, because we have to check
that _CALL_ELF is defined and then what its value is.

So check it once in asm/types.h and define PPC_ELF_ABI_v2 when ELF ABI
v2 is detected.

We don't add explicit includes of asm/types.h because it's included
basically everywhere via compiler.h.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/code-patching.h | 6 +++---
 arch/powerpc/include/asm/ftrace.h        | 2 +-
 arch/powerpc/include/asm/kprobes.h       | 4 ++--
 arch/powerpc/include/asm/linkage.h       | 2 +-
 arch/powerpc/include/asm/ppc_asm.h       | 4 ++--
 arch/powerpc/include/asm/ptrace.h        | 2 +-
 arch/powerpc/include/asm/sections.h      | 2 +-
 arch/powerpc/include/asm/types.h         | 4 ++++
 arch/powerpc/kernel/entry_64.S           | 2 +-
 arch/powerpc/kernel/head_64.S            | 2 +-
 arch/powerpc/kernel/kprobes.c            | 2 +-
 arch/powerpc/kernel/misc_64.S            | 2 +-
 arch/powerpc/kernel/module_64.c          | 4 ++--
 arch/powerpc/kvm/book3s_interrupts.S     | 2 +-
 arch/powerpc/kvm/book3s_rmhandlers.S     | 2 +-
 15 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 994c60a857ce..d325b35315d3 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -50,7 +50,7 @@ void __patch_exception(int exc, unsigned long addr);
 static inline unsigned long ppc_function_entry(void *func)
 {
 #if defined(CONFIG_PPC64)
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC_ELF_ABI_v2
 	u32 *insn = func;
 
 	/*
@@ -90,7 +90,7 @@ static inline unsigned long ppc_function_entry(void *func)
 
 static inline unsigned long ppc_global_function_entry(void *func)
 {
-#if defined(CONFIG_PPC64) && defined(_CALL_ELF) && _CALL_ELF == 2
+#if defined(CONFIG_PPC64) && defined(PPC_ELF_ABI_v2)
 	/* PPC64 ABIv2 the global entry point is at the address */
 	return (unsigned long)func;
 #else
@@ -106,7 +106,7 @@ static inline unsigned long ppc_global_function_entry(void *func)
  */
 
 /* This must match the definition of STK_GOT in <asm/ppc_asm.h> */
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC_ELF_ABI_v2
 #define R2_STACK_OFFSET         24
 #else
 #define R2_STACK_OFFSET         40
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 50ca7585abe2..0b0bfcaa587a 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -66,7 +66,7 @@ struct dyn_arch_ftrace {
 #endif
 
 #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_PPC64) && !defined(__ASSEMBLY__)
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifdef PPC_ELF_ABI_v2
 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
 static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
 {
diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 039b583db029..f905c908533f 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -41,7 +41,7 @@ typedef ppc_opcode_t kprobe_opcode_t;
 #define MAX_INSN_SIZE 1
 
 #ifdef CONFIG_PPC64
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC_ELF_ABI_v2
 /* PPC64 ABIv2 needs local entry point */
 #define kprobe_lookup_name(name, addr)					\
 {									\
@@ -92,7 +92,7 @@ typedef ppc_opcode_t kprobe_opcode_t;
 		addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);	\
 	}								\
 }
-#endif /* defined(_CALL_ELF) && _CALL_ELF == 2 */
+#endif /* PPC_ELF_ABI_v2 */
 #endif /* CONFIG_PPC64 */
 
 #define flush_insn_slot(p)	do { } while (0)
diff --git a/arch/powerpc/include/asm/linkage.h b/arch/powerpc/include/asm/linkage.h
index e3ad5c72724a..4f04b6c400cf 100644
--- a/arch/powerpc/include/asm/linkage.h
+++ b/arch/powerpc/include/asm/linkage.h
@@ -2,7 +2,7 @@
 #define _ASM_POWERPC_LINKAGE_H
 
 #ifdef CONFIG_PPC64
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifndef PPC_ELF_ABI_v2
 #define cond_syscall(x) \
 	asm ("\t.weak " #x "\n\t.set " #x ", sys_ni_syscall\n"		\
 	     "\t.weak ." #x "\n\t.set ." #x ", .sys_ni_syscall\n")
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 499d9f89435a..e179780ee47a 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -189,7 +189,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #define __STK_REG(i)   (112 + ((i)-14)*8)
 #define STK_REG(i)     __STK_REG(__REG_##i)
 
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC_ELF_ABI_v2
 #define STK_GOT		24
 #define __STK_PARAM(i)	(32 + ((i)-3)*8)
 #else
@@ -198,7 +198,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #endif
 #define STK_PARAM(i)	__STK_PARAM(__REG_##i)
 
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC_ELF_ABI_v2
 
 #define _GLOBAL(name) \
 	.section ".text"; \
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index c0c61fa9cd9e..ee77ce0f06c4 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -47,7 +47,7 @@
 				 STACK_FRAME_OVERHEAD + KERNEL_REDZONE_SIZE)
 #define STACK_FRAME_MARKER	12
 
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC_ELF_ABI_v2
 #define STACK_FRAME_MIN_SIZE	32
 #else
 #define STACK_FRAME_MIN_SIZE	STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index abf5866e08c6..2d81c8bbcc16 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -62,7 +62,7 @@ static inline int overlaps_kvm_tmp(unsigned long start, unsigned long end)
 #endif
 }
 
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifndef PPC_ELF_ABI_v2
 #undef dereference_function_descriptor
 static inline void *dereference_function_descriptor(void *ptr)
 {
diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
index bfb6ded38ffa..be3ebb51ff4b 100644
--- a/arch/powerpc/include/asm/types.h
+++ b/arch/powerpc/include/asm/types.h
@@ -15,6 +15,10 @@
 
 #include <uapi/asm/types.h>
 
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+#define PPC_ELF_ABI_v2
+#endif
+
 #ifndef __ASSEMBLY__
 
 typedef __vector128 vector128;
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 9916d150b28c..6824e0b076f8 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -451,7 +451,7 @@ _GLOBAL(ret_from_kernel_thread)
 	REST_NVGPRS(r1)
 	mtlr	r14
 	mr	r3,r15
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC_ELF_ABI_v2
 	mr	r12,r14
 #endif
 	blrl
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4286775cbde9..274180dafdfa 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -401,7 +401,7 @@ generic_secondary_common_init:
 	ld	r12,CPU_SPEC_RESTORE(r23)
 	cmpdi	0,r12,0
 	beq	3f
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifndef PPC_ELF_ABI_v2
 	ld	r12,0(r12)
 #endif
 	mtctr	r12
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 7c053f281406..99a9a1926f01 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -507,7 +507,7 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	/* setup return addr to the jprobe handler routine */
 	regs->nip = arch_deref_entry_point(jp->entry);
 #ifdef CONFIG_PPC64
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC_ELF_ABI_v2
 	regs->gpr[12] = (unsigned long)jp->entry;
 #else
 	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index f28754c497e5..75d604ae4b48 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -661,7 +661,7 @@ _GLOBAL(kexec_sequence)
 
 #ifndef CONFIG_PPC_BOOK3E
 	/* clear out hardware hash page table and tlb */
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifndef PPC_ELF_ABI_v2
 	ld	r12,0(r27)		/* deref function descriptor */
 #else
 	mr	r12,r27
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 9ce9a25f58b5..f475ce2b7300 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -41,7 +41,7 @@
    this, and makes other things simpler.  Anton?
    --RR.  */
 
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC_ELF_ABI_v2
 
 /* An address is simply the address of the function. */
 typedef unsigned long func_desc_t;
@@ -132,7 +132,7 @@ static u32 ppc64_stub_insns[] = {
 	/* Save current r2 value in magic place on the stack. */
 	0xf8410000|R2_STACK_OFFSET,	/* std     r2,R2_STACK_OFFSET(r1) */
 	0xe98b0020,			/* ld      r12,32(r11) */
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifndef PPC_ELF_ABI_v2
 	/* Set up new r2 from function descriptor */
 	0xe84b0028,			/* ld      r2,40(r11) */
 #endif
diff --git a/arch/powerpc/kvm/book3s_interrupts.S b/arch/powerpc/kvm/book3s_interrupts.S
index d044b8b7c69d..3649d14084b1 100644
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -25,7 +25,7 @@
 #include <asm/exception-64s.h>
 
 #if defined(CONFIG_PPC_BOOK3S_64)
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC_ELF_ABI_v2
 #define FUNC(name) 		name
 #else
 #define FUNC(name) 		GLUE(.,name)
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 16c4d88ba27d..f8cf41f0854f 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -36,7 +36,7 @@
 
 #if defined(CONFIG_PPC_BOOK3S_64)
 
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC_ELF_ABI_v2
 #define FUNC(name) 		name
 #else
 #define FUNC(name) 		GLUE(.,name)
-- 
2.5.0
