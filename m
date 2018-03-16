Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402mwB6Kl8zDrJm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 00:46:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: rostedt@goodmis.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
Subject: [RFC PATCH 2/2] powerpc: Only support DYNAMIC_FTRACE not static
Date: Sat, 17 Mar 2018 00:46:33 +1100
Message-Id: <20180316134633.10584-2-mpe@ellerman.id.au>
In-Reply-To: <20180316134633.10584-1-mpe@ellerman.id.au>
References: <20180316134633.10584-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We've had dynamic ftrace support for over 9 years since Steve first
wrote it, all the distros use dynamic, and static is basically
untested these days, so drop support for static ftrace.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig                           |  1 +
 arch/powerpc/include/asm/ftrace.h              |  4 +---
 arch/powerpc/include/asm/module.h              |  5 -----
 arch/powerpc/kernel/trace/ftrace.c             |  2 --
 arch/powerpc/kernel/trace/ftrace_32.S          | 20 ------------------
 arch/powerpc/kernel/trace/ftrace_64.S          | 29 --------------------------
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  3 ---
 arch/powerpc/kernel/trace/ftrace_64_pg.S       |  2 --
 8 files changed, 2 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd07642..23a325df784a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -189,6 +189,7 @@ config PPC
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_ONLY
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS	if MPROFILE_KERNEL
 	select HAVE_EBPF_JIT			if PPC64
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS	if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 9abddde372ab..e6c34d740ee9 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -48,7 +48,6 @@
 #else /* !__ASSEMBLY__ */
 extern void _mcount(void);
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 # define FTRACE_ADDR ((unsigned long)ftrace_caller)
 # define FTRACE_REGS_ADDR FTRACE_ADDR
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
@@ -60,13 +59,12 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 struct dyn_arch_ftrace {
 	struct module *mod;
 };
-#endif /*  CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #endif
-#endif
+#endif /* CONFIG_FUNCTION_TRACER */
 
 #if defined(CONFIG_FTRACE_SYSCALLS) && !defined(__ASSEMBLY__)
 #ifdef PPC64_ELF_ABI_v1
diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index 7e28442827f1..e09c96d0db69 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -90,11 +90,6 @@ int module_trampoline_target(struct module *mod, unsigned long trampoline,
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs);
-#else
-static inline int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs)
-{
-	return 0;
-}
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 4741fe112f05..c6d196d85260 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -538,7 +538,6 @@ int __init ftrace_dyn_arch_init(void)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 extern void ftrace_graph_call(void);
 extern void ftrace_graph_stub(void);
 
@@ -567,7 +566,6 @@ int ftrace_disable_ftrace_graph_caller(void)
 
 	return ftrace_modify_code(ip, old, new);
 }
-#endif /* CONFIG_DYNAMIC_FTRACE */
 
 /*
  * Hook the return address and push it in the stack of return addrs
diff --git a/arch/powerpc/kernel/trace/ftrace_32.S b/arch/powerpc/kernel/trace/ftrace_32.S
index afef2c076282..2c29098f630f 100644
--- a/arch/powerpc/kernel/trace/ftrace_32.S
+++ b/arch/powerpc/kernel/trace/ftrace_32.S
@@ -14,7 +14,6 @@
 #include <asm/ftrace.h>
 #include <asm/export.h>
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 _GLOBAL(mcount)
 _GLOBAL(_mcount)
 	/*
@@ -47,26 +46,7 @@ _GLOBAL(ftrace_graph_stub)
 	MCOUNT_RESTORE_FRAME
 	/* old link register ends up in ctr reg */
 	bctr
-#else
-_GLOBAL(mcount)
-_GLOBAL(_mcount)
-
-	MCOUNT_SAVE_FRAME
 
-	subi	r3, r3, MCOUNT_INSN_SIZE
-	LOAD_REG_ADDR(r5, ftrace_trace_function)
-	lwz	r5,0(r5)
-
-	mtctr	r5
-	bctrl
-	nop
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	b	ftrace_graph_caller
-#endif
-	MCOUNT_RESTORE_FRAME
-	bctr
-#endif
 EXPORT_SYMBOL(_mcount)
 
 _GLOBAL(ftrace_stub)
diff --git a/arch/powerpc/kernel/trace/ftrace_64.S b/arch/powerpc/kernel/trace/ftrace_64.S
index e5ccea19821e..e25f77c10a72 100644
--- a/arch/powerpc/kernel/trace/ftrace_64.S
+++ b/arch/powerpc/kernel/trace/ftrace_64.S
@@ -14,7 +14,6 @@
 #include <asm/ppc-opcode.h>
 #include <asm/export.h>
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 _GLOBAL(mcount)
 _GLOBAL(_mcount)
 EXPORT_SYMBOL(_mcount)
@@ -23,34 +22,6 @@ EXPORT_SYMBOL(_mcount)
 	mtlr	r0
 	bctr
 
-#else /* CONFIG_DYNAMIC_FTRACE */
-_GLOBAL_TOC(_mcount)
-EXPORT_SYMBOL(_mcount)
-	/* Taken from output of objdump from lib64/glibc */
-	mflr	r3
-	ld	r11, 0(r1)
-	stdu	r1, -112(r1)
-	std	r3, 128(r1)
-	ld	r4, 16(r11)
-
-	subi	r3, r3, MCOUNT_INSN_SIZE
-	LOAD_REG_ADDR(r5,ftrace_trace_function)
-	ld	r5,0(r5)
-	ld	r5,0(r5)
-	mtctr	r5
-	bctrl
-	nop
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	b	ftrace_graph_caller
-#endif
-	ld	r0, 128(r1)
-	mtlr	r0
-	addi	r1, r1, 112
-_GLOBAL(ftrace_stub)
-	blr
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 _GLOBAL(return_to_handler)
 	/* need to save return values */
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 3f3e81852422..625f9b758da7 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -17,7 +17,6 @@
 #include <asm/bug.h>
 #include <asm/ptrace.h>
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 /*
  *
  * ftrace_caller() is the function that replaces _mcount() when ftrace is
@@ -236,8 +235,6 @@ livepatch_handler:
 	blr
 #endif /* CONFIG_LIVEPATCH */
 
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 _GLOBAL(ftrace_graph_caller)
 	stdu	r1, -112(r1)
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.S b/arch/powerpc/kernel/trace/ftrace_64_pg.S
index f095358da96e..f18762827e51 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.S
@@ -14,7 +14,6 @@
 #include <asm/ppc-opcode.h>
 #include <asm/export.h>
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 _GLOBAL_TOC(ftrace_caller)
 	/* Taken from output of objdump from lib64/glibc */
 	mflr	r3
@@ -39,7 +38,6 @@ _GLOBAL(ftrace_graph_stub)
 
 _GLOBAL(ftrace_stub)
 	blr
-#endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 _GLOBAL(ftrace_graph_caller)
-- 
2.14.1
