Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409J2j5RvDzF23F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 15:30:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: rostedt@goodmis.org,
	naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH] powerpc: Only support DYNAMIC_FTRACE not static
Date: Tue, 27 Mar 2018 15:29:06 +1100
Message-Id: <20180327042906.32461-1-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/trace/ftrace.c             |  2 --
 arch/powerpc/kernel/trace/ftrace_32.S          | 20 ------------------
 arch/powerpc/kernel/trace/ftrace_64.S          | 29 --------------------------
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  3 ---
 arch/powerpc/kernel/trace/ftrace_64_pg.S       |  2 --
 7 files changed, 2 insertions(+), 59 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd07642..080651bbc5a6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -162,6 +162,7 @@ config PPC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
+	select DYNAMIC_FTRACE			if FUNCTION_TRACER
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_ATOMIC64			if PPC32
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index f7a23c2dce74..3542ba03a9aa 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -48,7 +48,6 @@
 #else /* !__ASSEMBLY__ */
 extern void _mcount(void);
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
        /* reloction of mcount call site is the same as the address */
@@ -58,13 +57,12 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
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
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 79d2924e75d5..c076a32093fd 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -662,7 +662,6 @@ int __init ftrace_dyn_arch_init(void)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 extern void ftrace_graph_call(void);
 extern void ftrace_graph_stub(void);
 
@@ -691,7 +690,6 @@ int ftrace_disable_ftrace_graph_caller(void)
 
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
index f57822aa2fe8..1d5e68113125 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -17,7 +17,6 @@
 #include <asm/bug.h>
 #include <asm/ptrace.h>
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 /*
  *
  * ftrace_caller()/ftrace_regs_caller() is the function that replaces _mcount()
@@ -311,8 +310,6 @@ livepatch_handler:
 	blr
 #endif /* CONFIG_LIVEPATCH */
 
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 _GLOBAL(ftrace_graph_caller)
 	stdu	r1, -112(r1)
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.S b/arch/powerpc/kernel/trace/ftrace_64_pg.S
index 3d8186832a34..cd7ec8072bc3 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.S
@@ -14,7 +14,6 @@
 #include <asm/ppc-opcode.h>
 #include <asm/export.h>
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 _GLOBAL_TOC(ftrace_caller)
 	lbz	r3, PACA_FTRACE_DISABLED(r13)
 	cmpdi	r3, 0
@@ -43,7 +42,6 @@ _GLOBAL(ftrace_graph_stub)
 
 _GLOBAL(ftrace_stub)
 	blr
-#endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 _GLOBAL(ftrace_graph_caller)
-- 
2.14.1
