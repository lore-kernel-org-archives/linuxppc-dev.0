Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sf5R51Cm7zDsgf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 13:56:49 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id n24so1771789pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 20:56:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64: abstract EE/RI handling between E/S cases
Date: Wed, 21 Sep 2016 13:54:08 +1000
Message-Id: <20160921035408.6232-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

This moves some of the ifdefs out of line and hopefully makes things
slightly more readable. Should be no generated code changes.

 arch/powerpc/kernel/entry_64.S | 111 +++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 585b9ca..0a1e33b 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -40,6 +40,54 @@
 #include <asm/ppc-opcode.h>
 
 /*
+ * Interrrupt disabling abstraction between BOOK3E and BOOK3S.
+ * - SET/CLEAR_EE must only be used with RI set.
+ * - SET/CLEAR_RI must only be used with EE clear.
+ * - SET/CLEAR_EE_RI must only be used when both bits get modified.
+ */
+#ifdef CONFIG_PPC_BOOK3E
+
+/* BOOK3E does not have RI handling, so that gets compiled away. */
+#define SET_EE(reg)		wrteei	1
+#define CLEAR_EE(reg)		wrteei	0
+#define SET_RI(reg)
+#define CLEAR_RI(reg)
+#define SET_EE_RI(reg)		SET_EE(reg)
+#define CLEAR_EE_RI(reg		CLEAR_EE(reg)
+
+#else /* CONFIG_PPC_BOOK3E */
+
+/*
+ * BOOK3S mtmsrd L=1 only modifies EE and RI bits of MSR. A single ori
+ * instruction could be used to set both bits in the register without changing
+ * other bits (which do not affect mtmsrd L=1), however it's likely that
+ * instruction scheduling would consider this a dependency.
+ */
+#define SET_EE_RI(reg)		\
+	li	reg,MSR_RI;	\
+	ori	reg,reg,MSR_EE;	\
+	mtmsrd	reg,1
+
+#define CLEAR_EE_RI(reg)	\
+	li	reg,0;		\
+	mtmsrd	reg,1
+
+#define CLEAR_EE(reg)		\
+	li	reg,MSR_RI;	\
+	mtmsrd	reg,1
+
+#define SET_EE(reg)		SET_EE_RI(reg)
+
+#define CLEAR_RI(reg)		CLEAR_EE_RI(reg)
+
+#define SET_RI(reg)		\
+	li	reg,MSR_RI;	\
+	mtmsrd	reg,1
+
+#endif /* CONFIG_PPC_BOOK3E */
+
+
+/*
  * System calls.
  */
 	.section	".toc","aw"
@@ -136,13 +184,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 
-#ifdef CONFIG_PPC_BOOK3E
-	wrteei	1
-#else
-	li	r11,MSR_RI
-	ori	r11,r11,MSR_EE
-	mtmsrd	r11,1
-#endif /* CONFIG_PPC_BOOK3E */
+	SET_EE_RI(r11)
 
 	/* We do need to set SOFTE in the stack frame or the return
 	 * from interrupt will be painful
@@ -191,20 +233,15 @@ system_call:			/* label this so stack traces look sane */
 	/*
 	 * Disable interrupts so current_thread_info()->flags can't change,
 	 * and so that we don't get interrupted after loading SRR0/1.
-	 */
-#ifdef CONFIG_PPC_BOOK3E
-	wrteei	0
-#else
-	/*
+	 *
+	 * BOOK3S:
 	 * For performance reasons we clear RI the same time that we
 	 * clear EE. We only need to clear RI just before we restore r13
 	 * below, but batching it with EE saves us one expensive mtmsrd call.
 	 * We have to be careful to restore RI if we branch anywhere from
 	 * here (eg syscall_exit_work).
 	 */
-	li	r11,0
-	mtmsrd	r11,1
-#endif /* CONFIG_PPC_BOOK3E */
+	CLEAR_EE_RI(r11)
 
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-MAX_ERRNO
@@ -218,15 +255,9 @@ system_call:			/* label this so stack traces look sane */
 	bne	3f
 #endif
 2:	addi    r3,r1,STACK_FRAME_OVERHEAD
-#ifdef CONFIG_PPC_BOOK3S
-	li	r10,MSR_RI
-	mtmsrd	r10,1		/* Restore RI */
-#endif
+	SET_RI(r10) /* See above RI optimisation */
 	bl	restore_math
-#ifdef CONFIG_PPC_BOOK3S
-	li	r11,0
-	mtmsrd	r11,1
-#endif
+	CLEAR_RI(r11)
 	ld	r8,_MSR(r1)
 	ld	r3,RESULT(r1)
 	li	r11,-MAX_ERRNO
@@ -304,13 +335,11 @@ syscall_enosys:
 	b	.Lsyscall_exit
 	
 syscall_exit_work:
-#ifdef CONFIG_PPC_BOOK3S
-	li	r10,MSR_RI
-	mtmsrd	r10,1		/* Restore RI */
-#endif
-	/* If TIF_RESTOREALL is set, don't scribble on either r3 or ccr.
-	 If TIF_NOERROR is set, just save r3 as it is. */
-
+	SET_RI(r10) /* See above RI optimisation */
+	/*
+	 * If TIF_RESTOREALL is set, don't scribble on either r3 or ccr.
+	 * If TIF_NOERROR is set, just save r3 as it is.
+	 */
 	andi.	r0,r9,_TIF_RESTOREALL
 	beq+	0f
 	REST_NVGPRS(r1)
@@ -349,13 +378,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	beq	ret_from_except_lite
 
 	/* Re-enable interrupts */
-#ifdef CONFIG_PPC_BOOK3E
-	wrteei	1
-#else
-	li	r10,MSR_RI
-	ori	r10,r10,MSR_EE
-	mtmsrd	r10,1
-#endif /* CONFIG_PPC_BOOK3E */
+	SET_EE_RI(r10)
 
 	bl	save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -614,12 +637,7 @@ _GLOBAL(ret_from_except_lite)
 	 * can't change between when we test it and when we return
 	 * from the interrupt.
 	 */
-#ifdef CONFIG_PPC_BOOK3E
-	wrteei	0
-#else
-	li	r10,MSR_RI
-	mtmsrd	r10,1		  /* Update machine state */
-#endif /* CONFIG_PPC_BOOK3E */
+	CLEAR_EE(r10)
 
 	CURRENT_THREAD_INFO(r9, r1)
 	ld	r3,_MSR(r1)
@@ -746,12 +764,7 @@ resume_kernel:
 	 * when we return from the interrupt, and so that we don't get
 	 * interrupted after loading SRR0/1.
 	 */
-#ifdef CONFIG_PPC_BOOK3E
-	wrteei	0
-#else
-	li	r10,MSR_RI
-	mtmsrd	r10,1		  /* Update machine state */
-#endif /* CONFIG_PPC_BOOK3E */
+	CLEAR_EE(r10)
 #endif /* CONFIG_PREEMPT */
 
 	.globl	fast_exc_return_irq
-- 
2.9.3
