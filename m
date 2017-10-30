Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQNbP6mfxzDrcb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 16:39:45 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9U5dWKO089974
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 01:39:41 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dwb9bpj9d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 01:39:41 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Mon, 30 Oct 2017 05:39:39 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, leitao@debian.org, gromero@linux.vnet.ibm.com,
 andrew@aj.id.au, jk@ozlabs.org, sam@mendozajonas.com
Subject: [PATCH 2/2] powerpc: Always save/restore checkpointed regs during
 treclaim/trecheckpoint
Date: Mon, 30 Oct 2017 16:39:13 +1100
In-Reply-To: <20171030053913.20455-1-cyrilbur@gmail.com>
References: <20171030053913.20455-1-cyrilbur@gmail.com>
Message-Id: <20171030053913.20455-2-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Lazy save and restore of FP/Altivec means that a userspace process can
be sent to userspace with FP or Altivec disabled and loaded only as
required (by way of an FP/Altivec unavailable exception). Transactional
Memory complicates this situation as a transaction could be started
without FP/Altivec being loaded up. This causes the hardware to
checkpoint incorrect registers. Handling FP/Altivec unavailable
exceptions while a thread is transactional requires a reclaim and
recheckpoint to ensure the CPU has correct state for both sets of
registers.

tm_reclaim() has optimisations to not always save the FP/Altivec
registers to the checkpointed save area. This was originally done
because the caller might have information that the checkpointed
registers aren't valid due to lazy save and restore. We've also been a
little vague as to how tm_reclaim() leaves the FP/Altivec state since it
doesn't necessarily always save it to the thread struct. This has lead
to an (incorrect) assumption that it leaves the checkpointed state on
the CPU.

tm_recheckpoint() has similar optimisations in reverse. It may not
always reload the checkpointed FP/Altivec registers from the thread
struct before the trecheckpoint. It is therefore quite unclear where it
expects to get the state from. This didn't help with the assumption
made about tm_reclaim().

These optimisations sit in what is by definition a slow path. If a
process has to go through a reclaim/recheckpoint then its transaction
will be doomed on returning to userspace. This mean that the process
will be unable to complete its transaction and be forced to its failure
handler. This is already an out if line case for userspace. Furthermore,
the cost of copying 64 times 128 bits from registers isn't very long[0]
(at all) on modern processors. As such it appears these optimisations
have only served to increase code complexity and are unlikely to have
had a measurable performance impact.

Our transactional memory handling has been riddled with bugs. A cause
of this has been difficulty in following the code flow, code complexity
has not been our friend here. It makes sense to remove these
optimisations in favour of a (hopefully) more stable implementation.

This patch does mean that some times the assembly will needlessly save
'junk' registers which will subsequently get overwritten with the
correct value by the C code which calls the assembly function. This
small inefficiency is far outweighed by the reduction in complexity for
general TM code, context switching paths, and transactional facility
unavailable exception handler.

0: I tried to measure it once for other work and found that it was
hiding in the noise of everything else I was working with. I find it
exceedingly likely this will be the case here.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/tm.h   |  5 ++--
 arch/powerpc/kernel/process.c   | 26 +++++++-----------
 arch/powerpc/kernel/signal_32.c |  2 +-
 arch/powerpc/kernel/signal_64.c |  2 +-
 arch/powerpc/kernel/tm.S        | 59 ++++++++++++-----------------------------
 arch/powerpc/kernel/traps.c     | 23 +++++-----------
 6 files changed, 37 insertions(+), 80 deletions(-)

diff --git a/arch/powerpc/include/asm/tm.h b/arch/powerpc/include/asm/tm.h
index 82e06ca3a49b..33d965911bec 100644
--- a/arch/powerpc/include/asm/tm.h
+++ b/arch/powerpc/include/asm/tm.h
@@ -11,10 +11,9 @@
 
 extern void tm_enable(void);
 extern void tm_reclaim(struct thread_struct *thread,
-		       unsigned long orig_msr, uint8_t cause);
+		       uint8_t cause);
 extern void tm_reclaim_current(uint8_t cause);
-extern void tm_recheckpoint(struct thread_struct *thread,
-			    unsigned long orig_msr);
+extern void tm_recheckpoint(struct thread_struct *thread);
 extern void tm_abort(uint8_t cause);
 extern void tm_save_sprs(struct thread_struct *thread);
 extern void tm_restore_sprs(struct thread_struct *thread);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index da900cd86324..fc9b88ccc2a7 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -866,6 +866,10 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 	if (!MSR_TM_SUSPENDED(mfmsr()))
 		return;
 
+	giveup_all(container_of(thr, struct task_struct, thread));
+
+	tm_reclaim(thr, cause);
+
 	/*
 	 * If we are in a transaction and FP is off then we can't have
 	 * used FP inside that transaction. Hence the checkpointed
@@ -884,10 +888,6 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 	if ((thr->ckpt_regs.msr & MSR_VEC) == 0)
 		memcpy(&thr->ckvr_state, &thr->vr_state,
 		       sizeof(struct thread_vr_state));
-
-	giveup_all(container_of(thr, struct task_struct, thread));
-
-	tm_reclaim(thr, thr->ckpt_regs.msr, cause);
 }
 
 void tm_reclaim_current(uint8_t cause)
@@ -936,11 +936,9 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
 	tm_save_sprs(thr);
 }
 
-extern void __tm_recheckpoint(struct thread_struct *thread,
-			      unsigned long orig_msr);
+extern void __tm_recheckpoint(struct thread_struct *thread);
 
-void tm_recheckpoint(struct thread_struct *thread,
-		     unsigned long orig_msr)
+void tm_recheckpoint(struct thread_struct *thread)
 {
 	unsigned long flags;
 
@@ -959,15 +957,13 @@ void tm_recheckpoint(struct thread_struct *thread,
 	 */
 	tm_restore_sprs(thread);
 
-	__tm_recheckpoint(thread, orig_msr);
+	__tm_recheckpoint(thread);
 
 	local_irq_restore(flags);
 }
 
 static inline void tm_recheckpoint_new_task(struct task_struct *new)
 {
-	unsigned long msr;
-
 	if (!cpu_has_feature(CPU_FTR_TM))
 		return;
 
@@ -986,13 +982,11 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
 		tm_restore_sprs(&new->thread);
 		return;
 	}
-	msr = new->thread.ckpt_regs.msr;
 	/* Recheckpoint to restore original checkpointed register state. */
-	TM_DEBUG("*** tm_recheckpoint of pid %d "
-		 "(new->msr 0x%lx, new->origmsr 0x%lx)\n",
-		 new->pid, new->thread.regs->msr, msr);
+	TM_DEBUG("*** tm_recheckpoint of pid %d (new->msr 0x%lx)\n",
+		 new->pid, new->thread.regs->msr);
 
-	tm_recheckpoint(&new->thread, msr);
+	tm_recheckpoint(&new->thread);
 
 	/*
 	 * The checkpointed state has been restored but the live state has
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 92fb1c8dbbd8..6fde1ff7396a 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -876,7 +876,7 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	/* Make sure the transaction is marked as failed */
 	current->thread.tm_texasr |= TEXASR_FS;
 	/* This loads the checkpointed FP/VEC state, if used */
-	tm_recheckpoint(&current->thread, msr);
+	tm_recheckpoint(&current->thread);
 
 	/* This loads the speculative FP/VEC state, if used */
 	msr_check_and_set(msr & (MSR_FP | MSR_VEC));
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index b2c002993d78..f395c5b81df9 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -558,7 +558,7 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 	/* Make sure the transaction is marked as failed */
 	tsk->thread.tm_texasr |= TEXASR_FS;
 	/* This loads the checkpointed FP/VEC state, if used */
-	tm_recheckpoint(&tsk->thread, msr);
+	tm_recheckpoint(&tsk->thread);
 
 	msr_check_and_set(msr & (MSR_FP | MSR_VEC));
 	if (msr & MSR_FP) {
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index c4ba37822ba0..d89fb0e6f9ed 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -79,15 +79,12 @@ _GLOBAL(tm_abort)
 	blr
 
 /* void tm_reclaim(struct thread_struct *thread,
- *                 unsigned long orig_msr,
  *		   uint8_t cause)
  *
  *	- Performs a full reclaim.  This destroys outstanding
  *	  transactions and updates thread->regs.tm_ckpt_* with the
  *	  original checkpointed state.  Note that thread->regs is
  *	  unchanged.
- *	- FP regs are written back to thread->transact_fpr before
- *	  reclaiming.  These are the transactional (current) versions.
  *
  * Purpose is to both abort transactions of, and preserve the state of,
  * a transactions at a context switch. We preserve/restore both sets of process
@@ -98,9 +95,9 @@ _GLOBAL(tm_abort)
  * Call with IRQs off, stacks get all out of sync for some periods in here!
  */
 _GLOBAL(tm_reclaim)
-	mfcr	r6
+	mfcr	r5
 	mflr	r0
-	stw	r6, 8(r1)
+	stw	r5, 8(r1)
 	std	r0, 16(r1)
 	std	r2, STK_GOT(r1)
 	stdu	r1, -TM_FRAME_SIZE(r1)
@@ -108,7 +105,6 @@ _GLOBAL(tm_reclaim)
 	/* We've a struct pt_regs at [r1+STACK_FRAME_OVERHEAD]. */
 
 	std	r3, STK_PARAM(R3)(r1)
-	std	r4, STK_PARAM(R4)(r1)
 	SAVE_NVGPRS(r1)
 
 	/* We need to setup MSR for VSX register save instructions. */
@@ -138,8 +134,8 @@ _GLOBAL(tm_reclaim)
 	std	r1, PACAR1(r13)
 
 	/* Clear MSR RI since we are about to change r1, EE is already off. */
-	li	r4, 0
-	mtmsrd	r4, 1
+	li	r5, 0
+	mtmsrd	r5, 1
 
 	/*
 	 * BE CAREFUL HERE:
@@ -151,7 +147,7 @@ _GLOBAL(tm_reclaim)
 	 * to user register state.  (FPRs, CCR etc. also!)
 	 * Use an sprg and a tm_scratch in the PACA to shuffle.
 	 */
-	TRECLAIM(R5)				/* Cause in r5 */
+	TRECLAIM(R4)				/* Cause in r4 */
 
 	/* ******************** GPRs ******************** */
 	/* Stash the checkpointed r13 away in the scratch SPR and get the real
@@ -242,40 +238,30 @@ _GLOBAL(tm_reclaim)
 
 
 	/* ******************** FPR/VR/VSRs ************
-	 * After reclaiming, capture the checkpointed FPRs/VRs /if used/.
-	 *
-	 * (If VSX used, FP and VMX are implied.  Or, we don't need to look
-	 * at MSR.VSX as copying FP regs if .FP, vector regs if .VMX covers it.)
-	 *
-	 * We're passed the thread's MSR as the second parameter
+	 * After reclaiming, capture the checkpointed FPRs/VRs.
 	 *
 	 * We enabled VEC/FP/VSX in the msr above, so we can execute these
 	 * instructions!
 	 */
-	ld	r4, STK_PARAM(R4)(r1)		/* Second parameter, MSR * */
 	mr	r3, r12
-	andis.		r0, r4, MSR_VEC@h
-	beq	dont_backup_vec
 
+	/* Altivec (VEC/VMX/VR)*/
 	addi	r7, r3, THREAD_CKVRSTATE
 	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 transact vr state */
 	mfvscr	v0
 	li	r6, VRSTATE_VSCR
 	stvx	v0, r7, r6
-dont_backup_vec:
+
+	/* VRSAVE */
 	mfspr	r0, SPRN_VRSAVE
 	std	r0, THREAD_CKVRSAVE(r3)
 
-	andi.	r0, r4, MSR_FP
-	beq	dont_backup_fp
-
+	/* Floating Point (FP) */
 	addi	r7, r3, THREAD_CKFPSTATE
 	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 transact fp state */
-
 	mffs    fr0
 	stfd    fr0,FPSTATE_FPSCR(r7)
 
-dont_backup_fp:
 
 	/* TM regs, incl TEXASR -- these live in thread_struct.  Note they've
 	 * been updated by the treclaim, to explain to userland the failure
@@ -343,22 +329,19 @@ _GLOBAL(__tm_recheckpoint)
 	 */
 	subi	r7, r7, STACK_FRAME_OVERHEAD
 
+	/* We need to setup MSR for FP/VMX/VSX register save instructions. */
 	mfmsr	r6
-	/* R4 = original MSR to indicate whether thread used FP/Vector etc. */
-
-	/* Enable FP/vec in MSR if necessary! */
-	lis	r5, MSR_VEC@h
+	mr	r5, r6
 	ori	r5, r5, MSR_FP
-	and.	r5, r4, r5
-	beq	restore_gprs			/* if neither, skip both */
-
+#ifdef CONFIG_ALTIVEC
+	oris	r5, r5, MSR_VEC@h
+#endif
 #ifdef CONFIG_VSX
 	BEGIN_FTR_SECTION
-	oris	r5, r5, MSR_VSX@h
+	oris	r5,r5, MSR_VSX@h
 	END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif
-	or	r5, r6, r5			/* Set MSR.FP+.VSX/.VEC */
-	mtmsr	r5
+	mtmsrd	r5
 
 #ifdef CONFIG_ALTIVEC
 	/*
@@ -367,28 +350,20 @@ _GLOBAL(__tm_recheckpoint)
 	 * thread.fp_state[] version holds the 'live' (transactional)
 	 * and will be loaded subsequently by any FPUnavailable trap.
 	 */
-	andis.	r0, r4, MSR_VEC@h
-	beq	dont_restore_vec
-
 	addi	r8, r3, THREAD_CKVRSTATE
 	li	r5, VRSTATE_VSCR
 	lvx	v0, r8, r5
 	mtvscr	v0
 	REST_32VRS(0, r5, r8)			/* r5 scratch, r8 ptr */
-dont_restore_vec:
 	ld	r5, THREAD_CKVRSAVE(r3)
 	mtspr	SPRN_VRSAVE, r5
 #endif
 
-	andi.	r0, r4, MSR_FP
-	beq	dont_restore_fp
-
 	addi	r8, r3, THREAD_CKFPSTATE
 	lfd	fr0, FPSTATE_FPSCR(r8)
 	MTFSF_L(fr0)
 	REST_32FPRS_VSRS(0, R4, R8)
 
-dont_restore_fp:
 	mtmsr	r6				/* FP/Vec off again! */
 
 restore_gprs:
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 13c9dcdcba69..66a3fd42f94c 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1495,7 +1495,7 @@ void fp_unavailable_tm(struct pt_regs *regs)
 	 * If VMX is in use, the VRs now hold checkpointed values,
 	 * so we don't want to load the VRs from the thread_struct.
 	 */
-	tm_recheckpoint(&current->thread, MSR_FP);
+	tm_recheckpoint(&current->thread);
 
 	/* If VMX is in use, get the transactional values back */
 	if (regs->msr & MSR_VEC) {
@@ -1517,7 +1517,7 @@ void altivec_unavailable_tm(struct pt_regs *regs)
 		 regs->nip, regs->msr);
 	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
 	regs->msr |= MSR_VEC;
-	tm_recheckpoint(&current->thread, MSR_VEC);
+	tm_recheckpoint(&current->thread);
 	current->thread.used_vr = 1;
 
 	if (regs->msr & MSR_FP) {
@@ -1529,8 +1529,6 @@ void altivec_unavailable_tm(struct pt_regs *regs)
 
 void vsx_unavailable_tm(struct pt_regs *regs)
 {
-	unsigned long orig_msr = regs->msr;
-
 	/* See the comments in fp_unavailable_tm().  This works similarly,
 	 * though we're loading both FP and VEC registers in here.
 	 *
@@ -1544,12 +1542,6 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 
 	current->thread.used_vsr = 1;
 
-	/* If FP and VMX are already loaded, we have all the state we need */
-	if ((orig_msr & (MSR_FP | MSR_VEC)) == (MSR_FP | MSR_VEC)) {
-		regs->msr |= MSR_VSX;
-		return;
-	}
-
 	/* This reclaims FP and/or VR regs if they're already enabled */
 	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
 
@@ -1559,14 +1551,11 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 	/* This loads & recheckpoints FP and VRs; but we have
 	 * to be sure not to overwrite previously-valid state.
 	 */
-	tm_recheckpoint(&current->thread, regs->msr & ~orig_msr);
-
-	msr_check_and_set(orig_msr & (MSR_FP | MSR_VEC));
+	tm_recheckpoint(&current->thread);
 
-	if (orig_msr & MSR_FP)
-		load_fp_state(&current->thread.fp_state);
-	if (orig_msr & MSR_VEC)
-		load_vr_state(&current->thread.vr_state);
+	msr_check_and_set(MSR_FP | MSR_VEC | MSR_VSX);
+	load_fp_state(&current->thread.fp_state);
+	load_vr_state(&current->thread.vr_state);
 }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
-- 
2.14.3
