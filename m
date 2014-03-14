Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D4D202C00EB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 11:01:20 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 07/10] powerpc/booke64: Remove ints from EXCEPTION_COMMON
Date: Thu, 13 Mar 2014 19:00:46 -0500
Message-ID: <1394755249-8856-8-git-send-email-scottwood@freescale.com>
In-Reply-To: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
References: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Tiejun Chen <tiejun.chen@windriver.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ints parameter was used to optionally insert RECONCILE_IRQ_STATE
into EXCEPTION_COMMON.  However, since it came at the end of
EXCEPTION_COMMON, there was no real benefit for it to be there as
opposed to being called separately by the caller of EXCEPTION_COMMON.

The ints parameter was causing some hassle when trying to add an extra
macro layer.  Besides avoiding that, moving "ints" to the caller makes
the code simpler by:
 - avoiding the asymmetry where INTS_RESTORE_HARD is called separately
by the individual exception, but INTS_DISABLE was not
 - removing the no-op INTS_KEEP
 - not having an unnecessary macro parameter

It also turned out to be necessary to delay the INTS_DISABLE
in the case of special level exceptions until after we saved the
old value of PACAIRQHAPPENED.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S | 82 ++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 89e1133..0204c39 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -151,7 +151,7 @@
 /* Core exception code for all exceptions except TLB misses.
  * XXX: Needs to make SPRN_SPRG_GEN depend on exception type
  */
-#define EXCEPTION_COMMON(n, excf, ints)					    \
+#define EXCEPTION_COMMON(n, excf)					    \
 exc_##n##_common:							    \
 	std	r0,GPR0(r1);		/* save r0 in stackframe */	    \
 	std	r2,GPR2(r1);		/* save r2 in stackframe */	    \
@@ -188,24 +188,20 @@ exc_##n##_common:							    \
 	std	r11,SOFTE(r1);		/* and save it to stackframe */     \
 	std	r12,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame */	    \
 	std	r3,_TRAP(r1);		/* set trap number		*/  \
-	std	r0,RESULT(r1);		/* clear regs->result */	    \
-	ints;
+	std	r0,RESULT(r1);		/* clear regs->result */
 
-/* Variants for the "ints" argument. This one does nothing when we want
- * to keep interrupts in their original state
- */
-#define INTS_KEEP
-
-/* This second version is meant for exceptions that don't immediately
- * hard-enable. We set a bit in paca->irq_happened to ensure that
- * a subsequent call to arch_local_irq_restore() will properly
- * hard-enable and avoid the fast-path, and then reconcile irq state.
+/*
+ * This is meant for exceptions that don't immediately hard-enable.  We
+ * set a bit in paca->irq_happened to ensure that a subsequent call to
+ * arch_local_irq_restore() will properly hard-enable and avoid the
+ * fast-path, and then reconcile irq state.
  */
 #define INTS_DISABLE	RECONCILE_IRQ_STATE(r3,r4)
 
-/* This is called by exceptions that used INTS_KEEP (that did not touch
- * irq indicators in the PACA). This will restore MSR:EE to it's previous
- * value
+/*
+ * This is called by exceptions that don't use INTS_DISABLE (that did not
+ * touch irq indicators in the PACA).  This will restore MSR:EE to it's
+ * previous value
  *
  * XXX In the long run, we may want to open-code it in order to separate the
  *     load from the wrtee, thus limiting the latency caused by the dependency
@@ -263,7 +259,8 @@ exc_##n##_bad_stack:							    \
 #define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr, ack)		\
 	START_EXCEPTION(label);						\
 	NORMAL_EXCEPTION_PROLOG(trapnum, intnum, PROLOG_ADDITION_MASKABLE)\
-	EXCEPTION_COMMON(trapnum, PACA_EXGEN, INTS_DISABLE)		\
+	EXCEPTION_COMMON(trapnum, PACA_EXGEN)				\
+	INTS_DISABLE;							\
 	ack(r8);							\
 	CHECK_NAPPING();						\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
@@ -318,7 +315,8 @@ interrupt_end_book3e:
 	START_EXCEPTION(critical_input);
 	CRIT_EXCEPTION_PROLOG(0x100, BOOKE_INTERRUPT_CRITICAL,
 			      PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE)
+//	EXCEPTION_COMMON(0x100, PACA_EXCRIT)
+//	INTS_DISABLE
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -330,7 +328,8 @@ interrupt_end_book3e:
 	START_EXCEPTION(machine_check);
 	MC_EXCEPTION_PROLOG(0x000, BOOKE_INTERRUPT_MACHINE_CHECK,
 			    PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x000, PACA_EXMC, INTS_DISABLE)
+//	EXCEPTION_COMMON(0x000, PACA_EXMC)
+//	INTS_DISABLE
 //	bl	special_reg_save_mc
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
 //	CHECK_NAPPING();
@@ -344,7 +343,8 @@ interrupt_end_book3e:
 				PROLOG_ADDITION_2REGS)
 	mfspr	r14,SPRN_DEAR
 	mfspr	r15,SPRN_ESR
-	EXCEPTION_COMMON(0x300, PACA_EXGEN, INTS_DISABLE)
+	EXCEPTION_COMMON(0x300, PACA_EXGEN)
+	INTS_DISABLE
 	b	storage_fault_common
 
 /* Instruction Storage Interrupt */
@@ -353,7 +353,8 @@ interrupt_end_book3e:
 				PROLOG_ADDITION_2REGS)
 	li	r15,0
 	mr	r14,r10
-	EXCEPTION_COMMON(0x400, PACA_EXGEN, INTS_DISABLE)
+	EXCEPTION_COMMON(0x400, PACA_EXGEN)
+	INTS_DISABLE
 	b	storage_fault_common
 
 /* External Input Interrupt */
@@ -366,7 +367,7 @@ interrupt_end_book3e:
 				PROLOG_ADDITION_2REGS)
 	mfspr	r14,SPRN_DEAR
 	mfspr	r15,SPRN_ESR
-	EXCEPTION_COMMON(0x600, PACA_EXGEN, INTS_KEEP)
+	EXCEPTION_COMMON(0x600, PACA_EXGEN)
 	b	alignment_more	/* no room, go out of line */
 
 /* Program Interrupt */
@@ -374,7 +375,8 @@ interrupt_end_book3e:
 	NORMAL_EXCEPTION_PROLOG(0x700, BOOKE_INTERRUPT_PROGRAM,
 				PROLOG_ADDITION_1REG)
 	mfspr	r14,SPRN_ESR
-	EXCEPTION_COMMON(0x700, PACA_EXGEN, INTS_DISABLE)
+	EXCEPTION_COMMON(0x700, PACA_EXGEN)
+	INTS_DISABLE
 	std	r14,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ld	r14,PACA_EXGEN+EX_R14(r13)
@@ -387,7 +389,7 @@ interrupt_end_book3e:
 	NORMAL_EXCEPTION_PROLOG(0x800, BOOKE_INTERRUPT_FP_UNAVAIL,
 				PROLOG_ADDITION_NONE)
 	/* we can probably do a shorter exception entry for that one... */
-	EXCEPTION_COMMON(0x800, PACA_EXGEN, INTS_KEEP)
+	EXCEPTION_COMMON(0x800, PACA_EXGEN)
 	ld	r12,_MSR(r1)
 	andi.	r0,r12,MSR_PR;
 	beq-	1f
@@ -404,7 +406,7 @@ interrupt_end_book3e:
 	NORMAL_EXCEPTION_PROLOG(0x200, BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL,
 				PROLOG_ADDITION_NONE)
 	/* we can probably do a shorter exception entry for that one... */
-	EXCEPTION_COMMON(0x200, PACA_EXGEN, INTS_KEEP)
+	EXCEPTION_COMMON(0x200, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
 	ld	r12,_MSR(r1)
@@ -426,7 +428,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	NORMAL_EXCEPTION_PROLOG(0x220,
 				BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST,
 				PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0x220, PACA_EXGEN, INTS_DISABLE)
+	EXCEPTION_COMMON(0x220, PACA_EXGEN)
+	INTS_DISABLE
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 #ifdef CONFIG_ALTIVEC
@@ -451,7 +454,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	START_EXCEPTION(watchdog);
 	CRIT_EXCEPTION_PROLOG(0x9f0, BOOKE_INTERRUPT_WATCHDOG,
 			      PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT, INTS_DISABLE)
+//	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT)
+//	INTS_DISABLE
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -471,7 +475,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	START_EXCEPTION(ap_unavailable);
 	NORMAL_EXCEPTION_PROLOG(0xf20, BOOKE_INTERRUPT_AP_UNAVAIL,
 				PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0xf20, PACA_EXGEN, INTS_DISABLE)
+	EXCEPTION_COMMON(0xf20, PACA_EXGEN)
+	INTS_DISABLE
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.unknown_exception
@@ -530,7 +535,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	mfspr	r15,SPRN_SPRG_CRIT_SCRATCH
 	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
 	mfspr	r14,SPRN_DBSR
-	EXCEPTION_COMMON(0xd00, PACA_EXCRIT, INTS_DISABLE)
+	EXCEPTION_COMMON(0xd00, PACA_EXCRIT)
+	INTS_DISABLE
 	std	r14,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	mr	r4,r14
@@ -596,7 +602,8 @@ kernel_dbg_exc:
 	mfspr	r15,SPRN_SPRG_DBG_SCRATCH
 	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
 	mfspr	r14,SPRN_DBSR
-	EXCEPTION_COMMON(0xd08, PACA_EXDBG, INTS_DISABLE)
+	EXCEPTION_COMMON(0xd08, PACA_EXDBG)
+	INTS_DISABLE
 	std	r14,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	mr	r4,r14
@@ -609,7 +616,8 @@ kernel_dbg_exc:
 	START_EXCEPTION(perfmon);
 	NORMAL_EXCEPTION_PROLOG(0x260, BOOKE_INTERRUPT_PERFORMANCE_MONITOR,
 				PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0x260, PACA_EXGEN, INTS_DISABLE)
+	EXCEPTION_COMMON(0x260, PACA_EXGEN)
+	INTS_DISABLE
 	CHECK_NAPPING()
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.performance_monitor_exception
@@ -623,7 +631,8 @@ kernel_dbg_exc:
 	START_EXCEPTION(doorbell_crit);
 	CRIT_EXCEPTION_PROLOG(0x2a0, BOOKE_INTERRUPT_DOORBELL_CRITICAL,
 			      PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x2a0, PACA_EXCRIT, INTS_DISABLE)
+//	EXCEPTION_COMMON(0x2a0, PACA_EXCRIT)
+//	INTS_DISABLE
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -638,7 +647,7 @@ kernel_dbg_exc:
 	START_EXCEPTION(guest_doorbell);
 	GDBELL_EXCEPTION_PROLOG(0x2c0, BOOKE_INTERRUPT_GUEST_DBELL,
 			        PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0x2c0, PACA_EXGEN, INTS_KEEP)
+	EXCEPTION_COMMON(0x2c0, PACA_EXGEN)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.save_nvgprs
 	INTS_RESTORE_HARD
@@ -649,7 +658,8 @@ kernel_dbg_exc:
 	START_EXCEPTION(guest_doorbell_crit);
 	CRIT_EXCEPTION_PROLOG(0x2e0, BOOKE_INTERRUPT_GUEST_DBELL_CRIT,
 			      PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x2e0, PACA_EXCRIT, INTS_DISABLE)
+//	EXCEPTION_COMMON(0x2e0, PACA_EXCRIT)
+//	INTS_DISABLE
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -661,7 +671,7 @@ kernel_dbg_exc:
 	START_EXCEPTION(hypercall);
 	NORMAL_EXCEPTION_PROLOG(0x310, BOOKE_INTERRUPT_HV_SYSCALL,
 			        PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0x310, PACA_EXGEN, INTS_KEEP)
+	EXCEPTION_COMMON(0x310, PACA_EXGEN)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.save_nvgprs
 	INTS_RESTORE_HARD
@@ -672,7 +682,7 @@ kernel_dbg_exc:
 	START_EXCEPTION(ehpriv);
 	NORMAL_EXCEPTION_PROLOG(0x320, BOOKE_INTERRUPT_HV_PRIV,
 			        PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0x320, PACA_EXGEN, INTS_KEEP)
+	EXCEPTION_COMMON(0x320, PACA_EXGEN)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.save_nvgprs
 	INTS_RESTORE_HARD
@@ -683,7 +693,7 @@ kernel_dbg_exc:
 	START_EXCEPTION(lrat_error);
 	NORMAL_EXCEPTION_PROLOG(0x340, BOOKE_INTERRUPT_LRAT_ERROR,
 			        PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0x340, PACA_EXGEN, INTS_KEEP)
+	EXCEPTION_COMMON(0x340, PACA_EXGEN)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.save_nvgprs
 	INTS_RESTORE_HARD
-- 
1.8.3.2
