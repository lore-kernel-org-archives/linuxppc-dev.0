Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdznd56VzzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 16:43:01 +1100 (AEDT)
From: "Tobin C. Harding" <me@tobin.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>
Subject: [PATCH] powerpc: asm: convert directive .llong to .8byte
Date: Thu,  9 Mar 2017 16:42:12 +1100
Message-Id: <1489038132-3523-1-git-send-email-me@tobin.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

.llong is an undocumented PPC specific directive. The generic
equivalent is .quad, but even better (because it's self describing) is
.8byte.

Convert directives .llong -> .8byte

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

Fixes: issue #33 (github)

Patch is not tested. Has been built on Power8

scripts/get_maintainer.pl throws warning:
  Bad divisor in main::vcs_assign: 0

 arch/powerpc/boot/crt0.S                       | 20 ++++++++++----------
 arch/powerpc/include/asm/asm-compat.h          |  2 +-
 arch/powerpc/include/asm/feature-fixups.h      |  6 +++---
 arch/powerpc/include/asm/reg.h                 | 12 ++++++------
 arch/powerpc/kernel/entry_64.S                 |  2 +-
 arch/powerpc/kernel/head_64.S                  |  8 ++++----
 arch/powerpc/kernel/reloc_64.S                 |  6 +++---
 arch/powerpc/kernel/systbl.S                   | 14 +++++++-------
 arch/powerpc/platforms/powernv/opal-wrappers.S |  2 +-
 arch/powerpc/platforms/pseries/hvCall.S        |  2 +-
 arch/powerpc/purgatory/trampoline.S            |  4 ++--
 11 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index 12866cc..dcf2f15 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -26,17 +26,17 @@ _zimage_start_opd:
 
 #ifdef __powerpc64__
 .balign 8
-p_start:	.llong	_start
-p_etext:	.llong	_etext
-p_bss_start:	.llong	__bss_start
-p_end:		.llong	_end
-
-p_toc:		.llong	__toc_start + 0x8000 - p_base
-p_dyn:		.llong	__dynamic_start - p_base
-p_rela:		.llong	__rela_dyn_start - p_base
-p_prom:		.llong	0
+p_start:	.8byte	_start
+p_etext:	.8byte	_etext
+p_bss_start:	.8byte	__bss_start
+p_end:		.8byte	_end
+
+p_toc:		.8byte	__toc_start + 0x8000 - p_base
+p_dyn:		.8byte	__dynamic_start - p_base
+p_rela:		.8byte	__rela_dyn_start - p_base
+p_prom:		.8byte	0
 	.weak	_platform_stack_top
-p_pstack:	.llong	_platform_stack_top
+p_pstack:	.8byte	_platform_stack_top
 #else
 p_start:	.long	_start
 p_etext:	.long	_etext
diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index cee3aa0..7f2a770 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -25,7 +25,7 @@
 #define PPC_LCMPI	stringify_in_c(cmpdi)
 #define PPC_LCMPLI	stringify_in_c(cmpldi)
 #define PPC_LCMP	stringify_in_c(cmpd)
-#define PPC_LONG	stringify_in_c(.llong)
+#define PPC_LONG	stringify_in_c(.8byte)
 #define PPC_LONG_ALIGN	stringify_in_c(.balign 8)
 #define PPC_TLNEI	stringify_in_c(tdnei)
 #define PPC_LLARX(t, a, b, eh)	PPC_LDARX(t, a, b, eh)
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index ddf54f5..78d1f9e 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -19,11 +19,11 @@
  */
 #if defined(CONFIG_PPC64) && !defined(__powerpc64__)
 /* 64 bits kernel, 32 bits code (ie. vdso32) */
-#define FTR_ENTRY_LONG		.llong
+#define FTR_ENTRY_LONG		.8byte
 #define FTR_ENTRY_OFFSET	.long 0xffffffff; .long
 #elif defined(CONFIG_PPC64)
-#define FTR_ENTRY_LONG		.llong
-#define FTR_ENTRY_OFFSET	.llong
+#define FTR_ENTRY_LONG		.8byte
+#define FTR_ENTRY_OFFSET	.8byte
 #else
 #define FTR_ENTRY_LONG		.long
 #define FTR_ENTRY_OFFSET	.long
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index fc879fd..465b577 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1290,12 +1290,12 @@ static inline void msr_check_and_clear(unsigned long bits)
 				".section __ftr_fixup,\"a\"\n"		\
 				".align 3\n"				\
 				"98:\n"					\
-				"	.llong %1\n"			\
-				"	.llong %1\n"			\
-				"	.llong 97b-98b\n"		\
-				"	.llong 99b-98b\n"		\
-				"	.llong 0\n"			\
-				"	.llong 0\n"			\
+				"	.8byte %1\n"			\
+				"	.8byte %1\n"			\
+				"	.8byte 97b-98b\n"		\
+				"	.8byte 99b-98b\n"		\
+				"	.8byte 0\n"			\
+				"	.8byte 0\n"			\
 				".previous"				\
 			: "=r" (rval) \
 			: "i" (CPU_FTR_CELL_TB_BUG), "i" (SPRN_TBRL)); \
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6432d4b..0dca640 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1078,7 +1078,7 @@ rtas_return_loc:
 	b	.	/* prevent speculative execution */
 
 	.align	3
-1:	.llong	rtas_restore_regs
+1:	.8byte	rtas_restore_regs
 
 rtas_restore_regs:
 	/* relocation is on at this point */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 1dc5eae..31b3ebc 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -92,13 +92,13 @@ END_FTR_SECTION(0, 1)
 	.balign 8
 	.globl  __secondary_hold_spinloop
 __secondary_hold_spinloop:
-	.llong	0x0
+	.8byte	0x0
 
 	/* Secondary processors write this value with their cpu # */
 	/* after they enter the spin loop immediately below.	  */
 	.globl	__secondary_hold_acknowledge
 __secondary_hold_acknowledge:
-	.llong	0x0
+	.8byte	0x0
 
 #ifdef CONFIG_RELOCATABLE
 	/* This flag is set to 1 by a loader if the kernel should run
@@ -650,7 +650,7 @@ __after_prom_start:
 	bctr
 
 .balign 8
-p_end: .llong _end - copy_to_here
+p_end: .8byte _end - copy_to_here
 
 4:
 	/*
@@ -892,7 +892,7 @@ _GLOBAL(relative_toc)
 	blr
 
 .balign 8
-p_toc:	.llong	__toc_start + 0x8000 - 0b
+p_toc:	.8byte	__toc_start + 0x8000 - 0b
 
 /*
  * This is where the main kernel code starts.
diff --git a/arch/powerpc/kernel/reloc_64.S b/arch/powerpc/kernel/reloc_64.S
index d88736f..e8cfc69 100644
--- a/arch/powerpc/kernel/reloc_64.S
+++ b/arch/powerpc/kernel/reloc_64.S
@@ -82,7 +82,7 @@ _GLOBAL(relocate)
 6:	blr
 
 .balign 8
-p_dyn:	.llong	__dynamic_start - 0b
-p_rela:	.llong	__rela_dyn_start - 0b
-p_st:	.llong	_stext - 0b
+p_dyn:	.8byte	__dynamic_start - 0b
+p_rela:	.8byte	__rela_dyn_start - 0b
+p_st:	.8byte	_stext - 0b
 
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 4d6b1d3..7ccb7f8 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -17,13 +17,13 @@
 #include <asm/ppc_asm.h>
 
 #ifdef CONFIG_PPC64
-#define SYSCALL(func)		.llong	DOTSYM(sys_##func),DOTSYM(sys_##func)
-#define COMPAT_SYS(func)	.llong	DOTSYM(sys_##func),DOTSYM(compat_sys_##func)
-#define PPC_SYS(func)		.llong	DOTSYM(ppc_##func),DOTSYM(ppc_##func)
-#define OLDSYS(func)		.llong	DOTSYM(sys_ni_syscall),DOTSYM(sys_ni_syscall)
-#define SYS32ONLY(func)		.llong	DOTSYM(sys_ni_syscall),DOTSYM(compat_sys_##func)
-#define PPC64ONLY(func)		.llong	DOTSYM(ppc_##func),DOTSYM(sys_ni_syscall)
-#define SYSX(f, f3264, f32)	.llong	DOTSYM(f),DOTSYM(f3264)
+#define SYSCALL(func)		.8byte	DOTSYM(sys_##func),DOTSYM(sys_##func)
+#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func),DOTSYM(compat_sys_##func)
+#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(ppc_##func)
+#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(sys_ni_syscall)
+#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(compat_sys_##func)
+#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(sys_ni_syscall)
+#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f),DOTSYM(f3264)
 #else
 #define SYSCALL(func)		.long	sys_##func
 #define COMPAT_SYS(func)	.long	sys_##func
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index da8a0f7..c007647 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -27,7 +27,7 @@
 
 	.globl opal_tracepoint_refcount
 opal_tracepoint_refcount:
-	.llong	0
+	.8byte	0
 
 	.section	".text"
 
diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
index 74b5b8e..c511a17 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -23,7 +23,7 @@
 
 	.globl hcall_tracepoint_refcount
 hcall_tracepoint_refcount:
-	.llong	0
+	.8byte	0
 
 	.section	".text"
 #endif
diff --git a/arch/powerpc/purgatory/trampoline.S b/arch/powerpc/purgatory/trampoline.S
index f9760cc..c8fcefd 100644
--- a/arch/powerpc/purgatory/trampoline.S
+++ b/arch/powerpc/purgatory/trampoline.S
@@ -104,13 +104,13 @@ master:
 	.balign 8
 	.globl kernel
 kernel:
-	.llong  0x0
+	.8byte  0x0
 	.size kernel, . - kernel
 
 	.balign 8
 	.globl dt_offset
 dt_offset:
-	.llong  0x0
+	.8byte  0x0
 	.size dt_offset, . - dt_offset
 
 
-- 
2.7.4
