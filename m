Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 56B412C0146
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 11:01:29 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 08/10] powerpc/booke64: Add crit/mc/debug support to
 EXCEPTION_COMMON
Date: Thu, 13 Mar 2014 19:00:47 -0500
Message-ID: <1394755249-8856-9-git-send-email-scottwood@freescale.com>
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

Use the proper scratch SPRG and PACA region.  Introduce level-specific
macros to simplify usage and avoid needing to do a bunch of token
pasting throughout EXCEPTION_COMMON().

Now that EXCEPTION_COMMON_DBG() is properly using the debug scratch
register, there's no more need for the caller to move the value to the
GEN scratch first.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S | 63 +++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 0204c39..2beb5bd 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -148,10 +148,8 @@
 	std	r15,PACA_EXMC+EX_R15(r13)
 
 
-/* Core exception code for all exceptions except TLB misses.
- * XXX: Needs to make SPRN_SPRG_GEN depend on exception type
- */
-#define EXCEPTION_COMMON(n, excf)					    \
+/* Core exception code for all exceptions except TLB misses. */
+#define EXCEPTION_COMMON_LVL(n, scratch, excf)				    \
 exc_##n##_common:							    \
 	std	r0,GPR0(r1);		/* save r0 in stackframe */	    \
 	std	r2,GPR2(r1);		/* save r2 in stackframe */	    \
@@ -164,7 +162,7 @@ exc_##n##_common:							    \
 	ACCOUNT_CPU_USER_ENTRY(r10,r11);/* accounting (uses cr0+eq) */	    \
 2:	ld	r3,excf+EX_R10(r13);	/* get back r10 */		    \
 	ld	r4,excf+EX_R11(r13);	/* get back r11 */		    \
-	mfspr	r5,SPRN_SPRG_GEN_SCRATCH;/* get back r13 */		    \
+	mfspr	r5,scratch;		/* get back r13 */		    \
 	std	r12,GPR12(r1);		/* save r12 in stackframe */	    \
 	ld	r2,PACATOC(r13);	/* get kernel TOC into r2 */	    \
 	mflr	r6;			/* save LR in stackframe */	    \
@@ -190,6 +188,15 @@ exc_##n##_common:							    \
 	std	r3,_TRAP(r1);		/* set trap number		*/  \
 	std	r0,RESULT(r1);		/* clear regs->result */
 
+#define EXCEPTION_COMMON(n) \
+	EXCEPTION_COMMON_LVL(n, SPRN_SPRG_GEN_SCRATCH, PACA_EXGEN)
+#define EXCEPTION_COMMON_CRIT(n) \
+	EXCEPTION_COMMON_LVL(n, SPRN_SPRG_CRIT_SCRATCH, PACA_EXCRIT)
+#define EXCEPTION_COMMON_MC(n) \
+	EXCEPTION_COMMON_LVL(n, SPRN_SPRG_MC_SCRATCH, PACA_EXMC)
+#define EXCEPTION_COMMON_DBG(n) \
+	EXCEPTION_COMMON_LVL(n, SPRN_SPRG_DBG_SCRATCH, PACA_EXDBG)
+
 /*
  * This is meant for exceptions that don't immediately hard-enable.  We
  * set a bit in paca->irq_happened to ensure that a subsequent call to
@@ -259,7 +266,7 @@ exc_##n##_bad_stack:							    \
 #define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr, ack)		\
 	START_EXCEPTION(label);						\
 	NORMAL_EXCEPTION_PROLOG(trapnum, intnum, PROLOG_ADDITION_MASKABLE)\
-	EXCEPTION_COMMON(trapnum, PACA_EXGEN)				\
+	EXCEPTION_COMMON(trapnum)					\
 	INTS_DISABLE;							\
 	ack(r8);							\
 	CHECK_NAPPING();						\
@@ -315,7 +322,7 @@ interrupt_end_book3e:
 	START_EXCEPTION(critical_input);
 	CRIT_EXCEPTION_PROLOG(0x100, BOOKE_INTERRUPT_CRITICAL,
 			      PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x100, PACA_EXCRIT)
+//	EXCEPTION_COMMON_CRIT(0x100)
 //	INTS_DISABLE
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
@@ -328,7 +335,7 @@ interrupt_end_book3e:
 	START_EXCEPTION(machine_check);
 	MC_EXCEPTION_PROLOG(0x000, BOOKE_INTERRUPT_MACHINE_CHECK,
 			    PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x000, PACA_EXMC)
+//	EXCEPTION_COMMON_MC(0x000)
 //	INTS_DISABLE
 //	bl	special_reg_save_mc
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -343,7 +350,7 @@ interrupt_end_book3e:
 				PROLOG_ADDITION_2REGS)
 	mfspr	r14,SPRN_DEAR
 	mfspr	r15,SPRN_ESR
-	EXCEPTION_COMMON(0x300, PACA_EXGEN)
+	EXCEPTION_COMMON(0x300)
 	INTS_DISABLE
 	b	storage_fault_common
 
@@ -353,7 +360,7 @@ interrupt_end_book3e:
 				PROLOG_ADDITION_2REGS)
 	li	r15,0
 	mr	r14,r10
-	EXCEPTION_COMMON(0x400, PACA_EXGEN)
+	EXCEPTION_COMMON(0x400)
 	INTS_DISABLE
 	b	storage_fault_common
 
@@ -367,7 +374,7 @@ interrupt_end_book3e:
 				PROLOG_ADDITION_2REGS)
 	mfspr	r14,SPRN_DEAR
 	mfspr	r15,SPRN_ESR
-	EXCEPTION_COMMON(0x600, PACA_EXGEN)
+	EXCEPTION_COMMON(0x600)
 	b	alignment_more	/* no room, go out of line */
 
 /* Program Interrupt */
@@ -375,7 +382,7 @@ interrupt_end_book3e:
 	NORMAL_EXCEPTION_PROLOG(0x700, BOOKE_INTERRUPT_PROGRAM,
 				PROLOG_ADDITION_1REG)
 	mfspr	r14,SPRN_ESR
-	EXCEPTION_COMMON(0x700, PACA_EXGEN)
+	EXCEPTION_COMMON(0x700)
 	INTS_DISABLE
 	std	r14,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -389,7 +396,7 @@ interrupt_end_book3e:
 	NORMAL_EXCEPTION_PROLOG(0x800, BOOKE_INTERRUPT_FP_UNAVAIL,
 				PROLOG_ADDITION_NONE)
 	/* we can probably do a shorter exception entry for that one... */
-	EXCEPTION_COMMON(0x800, PACA_EXGEN)
+	EXCEPTION_COMMON(0x800)
 	ld	r12,_MSR(r1)
 	andi.	r0,r12,MSR_PR;
 	beq-	1f
@@ -406,7 +413,7 @@ interrupt_end_book3e:
 	NORMAL_EXCEPTION_PROLOG(0x200, BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL,
 				PROLOG_ADDITION_NONE)
 	/* we can probably do a shorter exception entry for that one... */
-	EXCEPTION_COMMON(0x200, PACA_EXGEN)
+	EXCEPTION_COMMON(0x200)
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
 	ld	r12,_MSR(r1)
@@ -428,7 +435,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	NORMAL_EXCEPTION_PROLOG(0x220,
 				BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST,
 				PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0x220, PACA_EXGEN)
+	EXCEPTION_COMMON(0x220)
 	INTS_DISABLE
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -454,7 +461,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	START_EXCEPTION(watchdog);
 	CRIT_EXCEPTION_PROLOG(0x9f0, BOOKE_INTERRUPT_WATCHDOG,
 			      PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT)
+//	EXCEPTION_COMMON_CRIT(0x9f0)
 //	INTS_DISABLE
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
@@ -475,7 +482,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	START_EXCEPTION(ap_unavailable);
 	NORMAL_EXCEPTION_PROLOG(0xf20, BOOKE_INTERRUPT_AP_UNAVAIL,
 				PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0xf20, PACA_EXGEN)
+	EXCEPTION_COMMON(0xf20)
 	INTS_DISABLE
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -532,10 +539,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	/* Now we mash up things to make it look like we are coming on a
 	 * normal exception
 	 */
-	mfspr	r15,SPRN_SPRG_CRIT_SCRATCH
-	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
 	mfspr	r14,SPRN_DBSR
-	EXCEPTION_COMMON(0xd00, PACA_EXCRIT)
+	EXCEPTION_COMMON_CRIT(0xd00)
 	INTS_DISABLE
 	std	r14,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -599,10 +604,8 @@ kernel_dbg_exc:
 	/* Now we mash up things to make it look like we are coming on a
 	 * normal exception
 	 */
-	mfspr	r15,SPRN_SPRG_DBG_SCRATCH
-	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
 	mfspr	r14,SPRN_DBSR
-	EXCEPTION_COMMON(0xd08, PACA_EXDBG)
+	EXCEPTION_COMMON_DBG(0xd08)
 	INTS_DISABLE
 	std	r14,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -616,7 +619,7 @@ kernel_dbg_exc:
 	START_EXCEPTION(perfmon);
 	NORMAL_EXCEPTION_PROLOG(0x260, BOOKE_INTERRUPT_PERFORMANCE_MONITOR,
 				PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0x260, PACA_EXGEN)
+	EXCEPTION_COMMON(0x260)
 	INTS_DISABLE
 	CHECK_NAPPING()
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -631,7 +634,7 @@ kernel_dbg_exc:
 	START_EXCEPTION(doorbell_crit);
 	CRIT_EXCEPTION_PROLOG(0x2a0, BOOKE_INTERRUPT_DOORBELL_CRITICAL,
 			      PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x2a0, PACA_EXCRIT)
+//	EXCEPTION_COMMON_CRIT(0x2a0)
 //	INTS_DISABLE
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
@@ -647,7 +650,7 @@ kernel_dbg_exc:
 	START_EXCEPTION(guest_doorbell);
 	GDBELL_EXCEPTION_PROLOG(0x2c0, BOOKE_INTERRUPT_GUEST_DBELL,
 			        PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0x2c0, PACA_EXGEN)
+	EXCEPTION_COMMON(0x2c0)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.save_nvgprs
 	INTS_RESTORE_HARD
@@ -658,7 +661,7 @@ kernel_dbg_exc:
 	START_EXCEPTION(guest_doorbell_crit);
 	CRIT_EXCEPTION_PROLOG(0x2e0, BOOKE_INTERRUPT_GUEST_DBELL_CRIT,
 			      PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x2e0, PACA_EXCRIT)
+//	EXCEPTION_COMMON_CRIT(0x2e0)
 //	INTS_DISABLE
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
@@ -671,7 +674,7 @@ kernel_dbg_exc:
 	START_EXCEPTION(hypercall);
 	NORMAL_EXCEPTION_PROLOG(0x310, BOOKE_INTERRUPT_HV_SYSCALL,
 			        PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0x310, PACA_EXGEN)
+	EXCEPTION_COMMON(0x310)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.save_nvgprs
 	INTS_RESTORE_HARD
@@ -682,7 +685,7 @@ kernel_dbg_exc:
 	START_EXCEPTION(ehpriv);
 	NORMAL_EXCEPTION_PROLOG(0x320, BOOKE_INTERRUPT_HV_PRIV,
 			        PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0x320, PACA_EXGEN)
+	EXCEPTION_COMMON(0x320)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.save_nvgprs
 	INTS_RESTORE_HARD
@@ -693,7 +696,7 @@ kernel_dbg_exc:
 	START_EXCEPTION(lrat_error);
 	NORMAL_EXCEPTION_PROLOG(0x340, BOOKE_INTERRUPT_LRAT_ERROR,
 			        PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0x340, PACA_EXGEN)
+	EXCEPTION_COMMON(0x340)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.save_nvgprs
 	INTS_RESTORE_HARD
-- 
1.8.3.2
