Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNgqq1PxYzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 02:57:59 +1000 (AEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rNgqp3y3xz9t42
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Jun 2016 02:57:58 +1000 (AEST)
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u56GrxdH001042
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Jun 2016 12:57:55 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23d9fnk90y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 06 Jun 2016 12:57:54 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 7 Jun 2016 02:57:48 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 881AC3578053
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Jun 2016 02:57:20 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u56GvAMR12386608
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Jun 2016 02:57:15 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u56Gv4ZA001596
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Jun 2016 02:57:05 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org
Subject: [PATCH v4] powerpc: Define and use PPC64_ELF_ABI_v2/v1
Date: Mon,  6 Jun 2016 22:26:10 +0530
In-Reply-To: <1465191592-27569-1-git-send-email-mpe@ellerman.id.au>
References: <1465191592-27569-1-git-send-email-mpe@ellerman.id.au>
Message-Id: <1465232170-16822-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>

We're approaching 20 locations where we need to check for ELF ABI v2.
That's fine, except the logic is a bit awkward, because we have to check
that _CALL_ELF is defined and then what its value is.

So check it once in asm/types.h and define PPC64_ELF_ABI_v2 when ELF ABI
v2 is detected.

We also have a few places where what we're really trying to check is
that we are using the 64-bit v1 ABI, ie. function descriptors. So also
add a #define for that, which simplifies several checks.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
v4 (Naveen):
 - Added #include <asm/types.h> to ftrace.h and linkage.h as they aren't
   currently included there.

v3 (mpe):
 - Added PPC64_ELF_ABI_v1
 - Cleaned up a few more duplicate checks now that CONFIG_PPC64 is implied.

v2 (Naveen):
 - included __powerpc64__ in the check for setting the flag since ABIv2
   is ppc64 specific.
 - renamed flag to PPC64_ELF_ABI_v2 to convey the same.
 - fixed the incorrect change in ftrace.h
 - converted an additional change in ftrace.c

I have tested this with the above changes and it all looks good to me.

Thanks,
Naveen

 arch/powerpc/include/asm/code-patching.h | 10 ++++------
 arch/powerpc/include/asm/ftrace.h        |  8 +++++---
 arch/powerpc/include/asm/kprobes.h       |  8 +++-----
 arch/powerpc/include/asm/linkage.h       |  6 +++---
 arch/powerpc/include/asm/ppc_asm.h       |  4 ++--
 arch/powerpc/include/asm/ptrace.h        |  2 +-
 arch/powerpc/include/asm/sections.h      |  4 ++--
 arch/powerpc/include/asm/types.h         |  8 ++++++++
 arch/powerpc/kernel/entry_64.S           |  2 +-
 arch/powerpc/kernel/ftrace.c             |  4 ++--
 arch/powerpc/kernel/head_64.S            |  2 +-
 arch/powerpc/kernel/kprobes.c            |  6 ++----
 arch/powerpc/kernel/misc_64.S            |  2 +-
 arch/powerpc/kernel/module_64.c          |  4 ++--
 arch/powerpc/kvm/book3s_interrupts.S     |  2 +-
 arch/powerpc/kvm/book3s_rmhandlers.S     |  2 +-
 16 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 994c60a..2015b07 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -49,8 +49,7 @@ void __patch_exception(int exc, unsigned long addr);
 
 static inline unsigned long ppc_function_entry(void *func)
 {
-#if defined(CONFIG_PPC64)
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 	u32 *insn = func;
 
 	/*
@@ -75,14 +74,13 @@ static inline unsigned long ppc_function_entry(void *func)
 		return (unsigned long)(insn + 2);
 	else
 		return (unsigned long)func;
-#else
+#elif defined(PPC64_ELF_ABI_v1)
 	/*
 	 * On PPC64 ABIv1 the function pointer actually points to the
 	 * function's descriptor. The first entry in the descriptor is the
 	 * address of the function text.
 	 */
 	return ((func_descr_t *)func)->entry;
-#endif
 #else
 	return (unsigned long)func;
 #endif
@@ -90,7 +88,7 @@ static inline unsigned long ppc_function_entry(void *func)
 
 static inline unsigned long ppc_global_function_entry(void *func)
 {
-#if defined(CONFIG_PPC64) && defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 	/* PPC64 ABIv2 the global entry point is at the address */
 	return (unsigned long)func;
 #else
@@ -106,7 +104,7 @@ static inline unsigned long ppc_global_function_entry(void *func)
  */
 
 /* This must match the definition of STK_GOT in <asm/ppc_asm.h> */
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 #define R2_STACK_OFFSET         24
 #else
 #define R2_STACK_OFFSET         40
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 50ca758..686c5f7 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_POWERPC_FTRACE
 #define _ASM_POWERPC_FTRACE
 
+#include <asm/types.h>
+
 #ifdef CONFIG_FUNCTION_TRACER
 #define MCOUNT_ADDR		((unsigned long)(_mcount))
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
@@ -65,8 +67,8 @@ struct dyn_arch_ftrace {
 #endif
 #endif
 
-#if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_PPC64) && !defined(__ASSEMBLY__)
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#if defined(CONFIG_FTRACE_SYSCALLS) && !defined(__ASSEMBLY__)
+#ifdef PPC64_ELF_ABI_v1
 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
 static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
 {
@@ -79,6 +81,6 @@ static inline bool arch_syscall_match_sym_name(const char *sym, const char *name
 	return !strcmp(sym + 4, name + 3);
 }
 #endif
-#endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_PPC64 && !__ASSEMBLY__ */
+#endif /* CONFIG_FTRACE_SYSCALLS && !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_FTRACE */
diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 039b583..2c9759bd 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -40,8 +40,7 @@ struct kprobe;
 typedef ppc_opcode_t kprobe_opcode_t;
 #define MAX_INSN_SIZE 1
 
-#ifdef CONFIG_PPC64
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 /* PPC64 ABIv2 needs local entry point */
 #define kprobe_lookup_name(name, addr)					\
 {									\
@@ -49,7 +48,7 @@ typedef ppc_opcode_t kprobe_opcode_t;
 	if (addr)							\
 		addr = (kprobe_opcode_t *)ppc_function_entry(addr);	\
 }
-#else
+#elif defined(PPC64_ELF_ABI_v1)
 /*
  * 64bit powerpc ABIv1 uses function descriptors:
  * - Check for the dot variant of the symbol first.
@@ -92,8 +91,7 @@ typedef ppc_opcode_t kprobe_opcode_t;
 		addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);	\
 	}								\
 }
-#endif /* defined(_CALL_ELF) && _CALL_ELF == 2 */
-#endif /* CONFIG_PPC64 */
+#endif
 
 #define flush_insn_slot(p)	do { } while (0)
 #define kretprobe_blacklist_size 0
diff --git a/arch/powerpc/include/asm/linkage.h b/arch/powerpc/include/asm/linkage.h
index e3ad5c7..0cf5e21 100644
--- a/arch/powerpc/include/asm/linkage.h
+++ b/arch/powerpc/include/asm/linkage.h
@@ -1,8 +1,9 @@
 #ifndef _ASM_POWERPC_LINKAGE_H
 #define _ASM_POWERPC_LINKAGE_H
 
-#ifdef CONFIG_PPC64
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#include <asm/types.h>
+
+#ifdef PPC64_ELF_ABI_v1
 #define cond_syscall(x) \
 	asm ("\t.weak " #x "\n\t.set " #x ", sys_ni_syscall\n"		\
 	     "\t.weak ." #x "\n\t.set ." #x ", .sys_ni_syscall\n")
@@ -10,6 +11,5 @@
 	asm ("\t.globl " #alias "\n\t.set " #alias ", " #name "\n"	\
 	     "\t.globl ." #alias "\n\t.set ." #alias ", ." #name)
 #endif
-#endif
 
 #endif	/* _ASM_POWERPC_LINKAGE_H */
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 2b31632..7b591f9 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -189,7 +189,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #define __STK_REG(i)   (112 + ((i)-14)*8)
 #define STK_REG(i)     __STK_REG(__REG_##i)
 
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 #define STK_GOT		24
 #define __STK_PARAM(i)	(32 + ((i)-3)*8)
 #else
@@ -198,7 +198,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #endif
 #define STK_PARAM(i)	__STK_PARAM(__REG_##i)
 
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 
 #define _GLOBAL(name) \
 	.section ".text"; \
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index c0c61fa..e492368 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -47,7 +47,7 @@
 				 STACK_FRAME_OVERHEAD + KERNEL_REDZONE_SIZE)
 #define STACK_FRAME_MARKER	12
 
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 #define STACK_FRAME_MIN_SIZE	32
 #else
 #define STACK_FRAME_MIN_SIZE	STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index abf5866..7dc006b 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -62,7 +62,7 @@ static inline int overlaps_kvm_tmp(unsigned long start, unsigned long end)
 #endif
 }
 
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifdef PPC64_ELF_ABI_v1
 #undef dereference_function_descriptor
 static inline void *dereference_function_descriptor(void *ptr)
 {
@@ -73,7 +73,7 @@ static inline void *dereference_function_descriptor(void *ptr)
 		ptr = p;
 	return ptr;
 }
-#endif
+#endif /* PPC64_ELF_ABI_v1 */
 
 #endif
 
diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
index bfb6ded..49a0678 100644
--- a/arch/powerpc/include/asm/types.h
+++ b/arch/powerpc/include/asm/types.h
@@ -15,6 +15,14 @@
 
 #include <uapi/asm/types.h>
 
+#ifdef __powerpc64__
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+#define PPC64_ELF_ABI_v2
+#else
+#define PPC64_ELF_ABI_v1
+#endif
+#endif /* __powerpc64__ */
+
 #ifndef __ASSEMBLY__
 
 typedef __vector128 vector128;
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 73e461a..2e0c565 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -453,7 +453,7 @@ _GLOBAL(ret_from_kernel_thread)
 	REST_NVGPRS(r1)
 	mtlr	r14
 	mr	r3,r15
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 	mr	r12,r14
 #endif
 	blrl
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 1123a4d..7af6c4d 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -608,7 +608,7 @@ unsigned long __init arch_syscall_addr(int nr)
 }
 #endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_PPC64 */
 
-#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF != 2)
+#ifdef PPC64_ELF_ABI_v1
 char *arch_ftrace_match_adjust(char *str, const char *search)
 {
 	if (str[0] == '.' && search[0] != '.')
@@ -616,4 +616,4 @@ char *arch_ftrace_match_adjust(char *str, const char *search)
 	else
 		return str;
 }
-#endif /* defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF != 2) */
+#endif /* PPC64_ELF_ABI_v1 */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 2d14774..064cd93 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -401,7 +401,7 @@ generic_secondary_common_init:
 	ld	r12,CPU_SPEC_RESTORE(r23)
 	cmpdi	0,r12,0
 	beq	3f
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifdef PPC64_ELF_ABI_v1
 	ld	r12,0(r12)
 #endif
 	mtctr	r12
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 7c053f2..7d48e3b 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -506,13 +506,11 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 
 	/* setup return addr to the jprobe handler routine */
 	regs->nip = arch_deref_entry_point(jp->entry);
-#ifdef CONFIG_PPC64
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 	regs->gpr[12] = (unsigned long)jp->entry;
-#else
+#elif defined(PPC64_ELF_ABI_v1)
 	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
 #endif
-#endif
 
 	return 1;
 }
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index f28754c..7a85190 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -661,7 +661,7 @@ _GLOBAL(kexec_sequence)
 
 #ifndef CONFIG_PPC_BOOK3E
 	/* clear out hardware hash page table and tlb */
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifdef PPC64_ELF_ABI_v1
 	ld	r12,0(r27)		/* deref function descriptor */
 #else
 	mr	r12,r27
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 9ce9a25..f703f34 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -41,7 +41,7 @@
    this, and makes other things simpler.  Anton?
    --RR.  */
 
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 
 /* An address is simply the address of the function. */
 typedef unsigned long func_desc_t;
@@ -132,7 +132,7 @@ static u32 ppc64_stub_insns[] = {
 	/* Save current r2 value in magic place on the stack. */
 	0xf8410000|R2_STACK_OFFSET,	/* std     r2,R2_STACK_OFFSET(r1) */
 	0xe98b0020,			/* ld      r12,32(r11) */
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifdef PPC64_ELF_ABI_v1
 	/* Set up new r2 from function descriptor */
 	0xe84b0028,			/* ld      r2,40(r11) */
 #endif
diff --git a/arch/powerpc/kvm/book3s_interrupts.S b/arch/powerpc/kvm/book3s_interrupts.S
index d044b8b..901e6fe 100644
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -25,7 +25,7 @@
 #include <asm/exception-64s.h>
 
 #if defined(CONFIG_PPC_BOOK3S_64)
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 #define FUNC(name) 		name
 #else
 #define FUNC(name) 		GLUE(.,name)
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 16c4d88..42a4b23 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -36,7 +36,7 @@
 
 #if defined(CONFIG_PPC_BOOK3S_64)
 
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 #define FUNC(name) 		name
 #else
 #define FUNC(name) 		GLUE(.,name)
-- 
2.8.2
