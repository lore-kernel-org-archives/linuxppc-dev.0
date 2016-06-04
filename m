Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rMRvB57JKzDq7s
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Jun 2016 02:56:38 +1000 (AEST)
Received: from mx0b-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rMRvB1cbzz9t7t
 for <linuxppc-dev@ozlabs.org>; Sun,  5 Jun 2016 02:56:37 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u54GrYXv013979
 for <linuxppc-dev@ozlabs.org>; Sat, 4 Jun 2016 12:56:36 -0400
Message-Id: <201606041656.u54GrYXv013979@mx0a-001b2d01.pphosted.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23bswpf10u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sat, 04 Jun 2016 12:56:35 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 4 Jun 2016 22:26:32 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 09C56125805E
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Jun 2016 22:28:54 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u54GuTke36110408
 for <linuxppc-dev@ozlabs.org>; Sat, 4 Jun 2016 22:26:29 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u54GuSCM031813
 for <linuxppc-dev@ozlabs.org>; Sat, 4 Jun 2016 22:26:29 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: [PATCHv2] powerpc: Define and use PPC64_ELF_ABI_v2
Date: Sat,  4 Jun 2016 22:25:37 +0530
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

We don't add explicit includes of asm/types.h because it's included
basically everywhere via compiler.h.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[changed name to PPC64_ELF_ABI_v2, added check for __powerpc64__, fixes]
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Michael,
I tested this today, and ended up updating it with the below changes:
- included __powerpc64__ in the check for setting the flag since ABIv2
  is ppc64 specific.
- renamed flag to PPC64_ELF_ABI_v2 to convey the same.
- fixed the incorrect change in ftrace.h
- converted an additional change in ftrace.c

- Naveen

 arch/powerpc/include/asm/code-patching.h | 6 +++---
 arch/powerpc/include/asm/ftrace.h        | 2 +-
 arch/powerpc/include/asm/kprobes.h       | 4 ++--
 arch/powerpc/include/asm/linkage.h       | 2 +-
 arch/powerpc/include/asm/ppc_asm.h       | 4 ++--
 arch/powerpc/include/asm/ptrace.h        | 2 +-
 arch/powerpc/include/asm/sections.h      | 2 +-
 arch/powerpc/include/asm/types.h         | 4 ++++
 arch/powerpc/kernel/entry_64.S           | 2 +-
 arch/powerpc/kernel/ftrace.c             | 4 ++--
 arch/powerpc/kernel/head_64.S            | 2 +-
 arch/powerpc/kernel/kprobes.c            | 2 +-
 arch/powerpc/kernel/misc_64.S            | 2 +-
 arch/powerpc/kernel/module_64.c          | 4 ++--
 arch/powerpc/kvm/book3s_interrupts.S     | 2 +-
 arch/powerpc/kvm/book3s_rmhandlers.S     | 2 +-
 16 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 994c60a..9da8ec0 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -50,7 +50,7 @@ void __patch_exception(int exc, unsigned long addr);
 static inline unsigned long ppc_function_entry(void *func)
 {
 #if defined(CONFIG_PPC64)
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 	u32 *insn = func;
 
 	/*
@@ -90,7 +90,7 @@ static inline unsigned long ppc_function_entry(void *func)
 
 static inline unsigned long ppc_global_function_entry(void *func)
 {
-#if defined(CONFIG_PPC64) && defined(_CALL_ELF) && _CALL_ELF == 2
+#if defined(CONFIG_PPC64) && defined(PPC64_ELF_ABI_v2)
 	/* PPC64 ABIv2 the global entry point is at the address */
 	return (unsigned long)func;
 #else
@@ -106,7 +106,7 @@ static inline unsigned long ppc_global_function_entry(void *func)
  */
 
 /* This must match the definition of STK_GOT in <asm/ppc_asm.h> */
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 #define R2_STACK_OFFSET         24
 #else
 #define R2_STACK_OFFSET         40
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 50ca758..0eace29 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -66,7 +66,7 @@ struct dyn_arch_ftrace {
 #endif
 
 #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_PPC64) && !defined(__ASSEMBLY__)
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifndef PPC64_ELF_ABI_v2
 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
 static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
 {
diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 039b583..0174642 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -41,7 +41,7 @@ typedef ppc_opcode_t kprobe_opcode_t;
 #define MAX_INSN_SIZE 1
 
 #ifdef CONFIG_PPC64
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 /* PPC64 ABIv2 needs local entry point */
 #define kprobe_lookup_name(name, addr)					\
 {									\
@@ -92,7 +92,7 @@ typedef ppc_opcode_t kprobe_opcode_t;
 		addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);	\
 	}								\
 }
-#endif /* defined(_CALL_ELF) && _CALL_ELF == 2 */
+#endif /* PPC64_ELF_ABI_v2 */
 #endif /* CONFIG_PPC64 */
 
 #define flush_insn_slot(p)	do { } while (0)
diff --git a/arch/powerpc/include/asm/linkage.h b/arch/powerpc/include/asm/linkage.h
index e3ad5c7..dbaa53b 100644
--- a/arch/powerpc/include/asm/linkage.h
+++ b/arch/powerpc/include/asm/linkage.h
@@ -2,7 +2,7 @@
 #define _ASM_POWERPC_LINKAGE_H
 
 #ifdef CONFIG_PPC64
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifndef PPC64_ELF_ABI_v2
 #define cond_syscall(x) \
 	asm ("\t.weak " #x "\n\t.set " #x ", sys_ni_syscall\n"		\
 	     "\t.weak ." #x "\n\t.set ." #x ", .sys_ni_syscall\n")
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
index abf5866..57f069f 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -62,7 +62,7 @@ static inline int overlaps_kvm_tmp(unsigned long start, unsigned long end)
 #endif
 }
 
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifndef PPC64_ELF_ABI_v2
 #undef dereference_function_descriptor
 static inline void *dereference_function_descriptor(void *ptr)
 {
diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
index bfb6ded..68b12a8 100644
--- a/arch/powerpc/include/asm/types.h
+++ b/arch/powerpc/include/asm/types.h
@@ -15,6 +15,10 @@
 
 #include <uapi/asm/types.h>
 
+#if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2
+#define PPC64_ELF_ABI_v2
+#endif
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
index 1123a4d..d91ac40 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -608,7 +608,7 @@ unsigned long __init arch_syscall_addr(int nr)
 }
 #endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_PPC64 */
 
-#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF != 2)
+#if defined(CONFIG_PPC64) && !defined(PPC64_ELF_ABI_v2)
 char *arch_ftrace_match_adjust(char *str, const char *search)
 {
 	if (str[0] == '.' && search[0] != '.')
@@ -616,4 +616,4 @@ char *arch_ftrace_match_adjust(char *str, const char *search)
 	else
 		return str;
 }
-#endif /* defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF != 2) */
+#endif /* defined(CONFIG_PPC64) && !defined(PPC64_ELF_ABI_v2) */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 2d14774..21a871f 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -401,7 +401,7 @@ generic_secondary_common_init:
 	ld	r12,CPU_SPEC_RESTORE(r23)
 	cmpdi	0,r12,0
 	beq	3f
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifndef PPC64_ELF_ABI_v2
 	ld	r12,0(r12)
 #endif
 	mtctr	r12
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 7c053f2..a4a3bc8 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -507,7 +507,7 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	/* setup return addr to the jprobe handler routine */
 	regs->nip = arch_deref_entry_point(jp->entry);
 #ifdef CONFIG_PPC64
-#if defined(_CALL_ELF) && _CALL_ELF == 2
+#ifdef PPC64_ELF_ABI_v2
 	regs->gpr[12] = (unsigned long)jp->entry;
 #else
 	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index f28754c..72d540f 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -661,7 +661,7 @@ _GLOBAL(kexec_sequence)
 
 #ifndef CONFIG_PPC_BOOK3E
 	/* clear out hardware hash page table and tlb */
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
+#ifndef PPC64_ELF_ABI_v2
 	ld	r12,0(r27)		/* deref function descriptor */
 #else
 	mr	r12,r27
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 9ce9a25..cd3d7f4 100644
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
+#ifndef PPC64_ELF_ABI_v2
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
