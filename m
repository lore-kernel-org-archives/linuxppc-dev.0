Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPZXX0N4gzDr3c
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 14:02:52 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rPZXW39ltz9sxb
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2016 14:02:51 +1000 (AEST)
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u583wuLF036380
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 00:02:49 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9mwhc0h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Jun 2016 00:02:49 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 8 Jun 2016 14:02:45 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EB8252CE808B
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2016 14:02:17 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u584212M51314922
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 14:02:02 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5841ek2030774
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 14:01:41 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH 3/5] powerpc: tm: Always use fp_state and vr_state to store
 live registers
Date: Wed,  8 Jun 2016 14:00:34 +1000
In-Reply-To: <20160608040036.13064-1-cyrilbur@gmail.com>
References: <20160608040036.13064-1-cyrilbur@gmail.com>
Message-Id: <20160608040036.13064-4-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is currently an inconsistency as to how the entire CPU register
state is saved and restored when a thread uses transactional memory
(TM).

Using transactional memory results in the CPU having duplicated
(almost all) of its register state. This duplication results in a set
of registers which can be considered 'live', those being currently
modified by the instructions being executed and another set that is
frozen at a point in time.

On context switch, both sets of state have to be saved and (later)
restored. These two states are often called a variety of different
things. Common terms for the state which only exists after has entered
a transaction (performed a TBEGIN instruction) in hardware is the
'transactional' or 'speculative'.

Between a TBEGIN and a TEND or TABORT (or an event that causes the
hardware to abort), regardless of the use of TSUSPEND the
transactional state can be referred to as the live state.

The second state is often to referred to as the 'checkpointed' state
and is a duplication of the live state when the TBEGIN instruction is
executed. This state is kept in the hardware and will be rolled back
to on transaction failure.

Currently all the registers stored in pt_regs are ALWAYS the live
registers, that is, when a thread has transactional registers their
values are stored in pt_regs and the checkpointed state is in
ckpt_regs. A strange opposite is true for fp_state. When a thread is
non transactional fp_state holds the live registers. When a thread has
initiated a transaction fp_state holds the checkpointed state and
transact_fp becomes the structure which holds the live state (at this
point it is a transactional state). The same is true for vr_state

This method creates confusion as to where the live state is, in some
circumstances it requires extra work to determine where to put the
live state and prevents the use of common functions designed (probably
before TM) to save the live state.

With this patch pt_regs, fp_state and vr_state all represent the same
thing and the other structures [pending rename] are for checkpointed
state.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c   | 44 +++++--------------
 arch/powerpc/kernel/signal_32.c | 50 ++++++++++------------
 arch/powerpc/kernel/signal_64.c | 53 +++++++++++------------
 arch/powerpc/kernel/tm.S        | 95 ++++++++++++++++++++++-------------------
 arch/powerpc/kernel/traps.c     | 12 ++++--
 5 files changed, 116 insertions(+), 138 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ea8a28f..696e0236 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -763,24 +763,12 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 {
 	unsigned long msr_diff = 0;
 
-	/*
-	 * If FP/VSX registers have been already saved to the
-	 * thread_struct, move them to the transact_fp array.
-	 * We clear the TIF_RESTORE_TM bit since after the reclaim
-	 * the thread will no longer be transactional.
-	 */
 	if (test_ti_thread_flag(ti, TIF_RESTORE_TM)) {
-		msr_diff = thr->ckpt_regs.msr & ~thr->regs->msr;
-		if (msr_diff & MSR_FP)
-			memcpy(&thr->transact_fp, &thr->fp_state,
-			       sizeof(struct thread_fp_state));
-		if (msr_diff & MSR_VEC)
-			memcpy(&thr->transact_vr, &thr->vr_state,
-			       sizeof(struct thread_vr_state));
+		msr_diff = (thr->ckpt_regs.msr & ~thr->regs->msr)
+			& (MSR_FP | MSR_VEC | MSR_VSX | MSR_FE0 | MSR_FE1);
+
 		clear_ti_thread_flag(ti, TIF_RESTORE_TM);
-		msr_diff &= MSR_FP | MSR_VEC | MSR_VSX | MSR_FE0 | MSR_FE1;
 	}
-
 	/*
 	 * Use the current MSR TM suspended bit to track if we have
 	 * checkpointed state outstanding.
@@ -799,6 +787,8 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 	if (!MSR_TM_SUSPENDED(mfmsr()))
 		return;
 
+	save_all(container_of(thr, struct task_struct, thread));
+
 	tm_reclaim(thr, thr->regs->msr, cause);
 
 	/* Having done the reclaim, we now have the checkpointed
@@ -901,7 +891,7 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
 	 * If the task was using FP, we non-lazily reload both the original and
 	 * the speculative FP register states.  This is because the kernel
 	 * doesn't see if/when a TM rollback occurs, so if we take an FP
-	 * unavoidable later, we are unable to determine which set of FP regs
+	 * unavailable later, we are unable to determine which set of FP regs
 	 * need to be restored.
 	 */
 	if (!new->thread.regs)
@@ -917,24 +907,10 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
 		 "(new->msr 0x%lx, new->origmsr 0x%lx)\n",
 		 new->pid, new->thread.regs->msr, msr);
 
-	/* This loads the checkpointed FP/VEC state, if used */
 	tm_recheckpoint(&new->thread, msr);
 
-	/* This loads the speculative FP/VEC state, if used */
-	if (msr & MSR_FP) {
-		do_load_up_transact_fpu(&new->thread);
-		new->thread.regs->msr |=
-			(MSR_FP | new->thread.fpexc_mode);
-	}
-#ifdef CONFIG_ALTIVEC
-	if (msr & MSR_VEC) {
-		do_load_up_transact_altivec(&new->thread);
-		new->thread.regs->msr |= MSR_VEC;
-	}
-#endif
-	/* We may as well turn on VSX too since all the state is restored now */
-	if (msr & MSR_VSX)
-		new->thread.regs->msr |= MSR_VSX;
+	/* Won't restore math get called later? */
+	restore_math(new->thread.regs);
 
 	TM_DEBUG("*** tm_recheckpoint of pid %d complete "
 		 "(kernel msr 0x%lx)\n",
@@ -1108,11 +1084,11 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	 */
 	save_sprs(&prev->thread);
 
-	__switch_to_tm(prev);
-
 	/* Save FPU, Altivec, VSX and SPE state */
 	giveup_all(prev);
 
+	__switch_to_tm(prev);
+
 	/*
 	 * We can't take a PMU exception inside _switch() since there is a
 	 * window where the kernel stack SLB and the kernel stack are out
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index b6aa378..d106b91 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -525,9 +525,6 @@ static int save_tm_user_regs(struct pt_regs *regs,
 	 */
 	regs->msr &= ~MSR_TS_MASK;
 
-	/* Make sure floating point registers are stored in regs */
-	flush_fp_to_thread(current);
-
 	/* Save both sets of general registers */
 	if (save_general_regs(&current->thread.ckpt_regs, frame)
 	    || save_general_regs(regs, tm_frame))
@@ -545,18 +542,17 @@ static int save_tm_user_regs(struct pt_regs *regs,
 #ifdef CONFIG_ALTIVEC
 	/* save altivec registers */
 	if (current->thread.used_vr) {
-		flush_altivec_to_thread(current);
-		if (__copy_to_user(&frame->mc_vregs, &current->thread.vr_state,
+		if (__copy_to_user(&frame->mc_vregs, &current->thread.transact_vr,
 				   ELF_NVRREG * sizeof(vector128)))
 			return 1;
 		if (msr & MSR_VEC) {
 			if (__copy_to_user(&tm_frame->mc_vregs,
-					   &current->thread.transact_vr,
+					   &current->thread.vr_state,
 					   ELF_NVRREG * sizeof(vector128)))
 				return 1;
 		} else {
 			if (__copy_to_user(&tm_frame->mc_vregs,
-					   &current->thread.vr_state,
+					   &current->thread.transact_vr,
 					   ELF_NVRREG * sizeof(vector128)))
 				return 1;
 		}
@@ -573,28 +569,28 @@ static int save_tm_user_regs(struct pt_regs *regs,
 	 * most significant bits of that same vector. --BenH
 	 */
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		current->thread.vrsave = mfspr(SPRN_VRSAVE);
-	if (__put_user(current->thread.vrsave,
+		current->thread.transact_vrsave = mfspr(SPRN_VRSAVE);
+	if (__put_user(current->thread.transact_vrsave,
 		       (u32 __user *)&frame->mc_vregs[32]))
 		return 1;
 	if (msr & MSR_VEC) {
-		if (__put_user(current->thread.transact_vrsave,
+		if (__put_user(current->thread.vrsave,
 			       (u32 __user *)&tm_frame->mc_vregs[32]))
 			return 1;
 	} else {
-		if (__put_user(current->thread.vrsave,
+		if (__put_user(current->thread.transact_vrsave,
 			       (u32 __user *)&tm_frame->mc_vregs[32]))
 			return 1;
 	}
 #endif /* CONFIG_ALTIVEC */
 
-	if (copy_fpr_to_user(&frame->mc_fregs, current))
+	if (copy_transact_fpr_to_user(&frame->mc_fregs, current))
 		return 1;
 	if (msr & MSR_FP) {
-		if (copy_transact_fpr_to_user(&tm_frame->mc_fregs, current))
+		if (copy_fpr_to_user(&tm_frame->mc_fregs, current))
 			return 1;
 	} else {
-		if (copy_fpr_to_user(&tm_frame->mc_fregs, current))
+		if (copy_transact_fpr_to_user(&tm_frame->mc_fregs, current))
 			return 1;
 	}
 
@@ -606,15 +602,14 @@ static int save_tm_user_regs(struct pt_regs *regs,
 	 * contains valid data
 	 */
 	if (current->thread.used_vsr) {
-		flush_vsx_to_thread(current);
-		if (copy_vsx_to_user(&frame->mc_vsregs, current))
+		if (copy_transact_vsx_to_user(&frame->mc_vsregs, current))
 			return 1;
 		if (msr & MSR_VSX) {
-			if (copy_transact_vsx_to_user(&tm_frame->mc_vsregs,
+			if (copy_vsx_to_user(&tm_frame->mc_vsregs,
 						      current))
 				return 1;
 		} else {
-			if (copy_vsx_to_user(&tm_frame->mc_vsregs, current))
+			if (copy_transact_vsx_to_user(&tm_frame->mc_vsregs, current))
 				return 1;
 		}
 
@@ -793,9 +788,9 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	regs->msr &= ~MSR_VEC;
 	if (msr & MSR_VEC) {
 		/* restore altivec registers from the stack */
-		if (__copy_from_user(&current->thread.vr_state, &sr->mc_vregs,
+		if (__copy_from_user(&current->thread.transact_vr, &sr->mc_vregs,
 				     sizeof(sr->mc_vregs)) ||
-		    __copy_from_user(&current->thread.transact_vr,
+		    __copy_from_user(&current->thread.vr_state,
 				     &tm_sr->mc_vregs,
 				     sizeof(sr->mc_vregs)))
 			return 1;
@@ -807,13 +802,13 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	}
 
 	/* Always get VRSAVE back */
-	if (__get_user(current->thread.vrsave,
+	if (__get_user(current->thread.transact_vrsave,
 		       (u32 __user *)&sr->mc_vregs[32]) ||
-	    __get_user(current->thread.transact_vrsave,
+	    __get_user(current->thread.vrsave,
 		       (u32 __user *)&tm_sr->mc_vregs[32]))
 		return 1;
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		mtspr(SPRN_VRSAVE, current->thread.vrsave);
+		mtspr(SPRN_VRSAVE, current->thread.transact_vrsave);
 #endif /* CONFIG_ALTIVEC */
 
 	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
@@ -829,8 +824,8 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 		 * Restore altivec registers from the stack to a local
 		 * buffer, then write this out to the thread_struct
 		 */
-		if (copy_vsx_from_user(current, &sr->mc_vsregs) ||
-		    copy_transact_vsx_from_user(current, &tm_sr->mc_vsregs))
+		if (copy_vsx_from_user(current, &tm_sr->mc_vsregs) ||
+		    copy_transact_vsx_from_user(current, &sr->mc_vsregs))
 			return 1;
 	} else if (current->thread.used_vsr)
 		for (i = 0; i < 32 ; i++) {
@@ -877,13 +872,14 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	tm_recheckpoint(&current->thread, msr);
 
 	/* This loads the speculative FP/VEC state, if used */
+	msr_check_and_set(msr & (MSR_FP | MSR_VEC));
 	if (msr & MSR_FP) {
-		do_load_up_transact_fpu(&current->thread);
+		load_fp_state(&current->thread.fp_state);
 		regs->msr |= (MSR_FP | current->thread.fpexc_mode);
 	}
 #ifdef CONFIG_ALTIVEC
 	if (msr & MSR_VEC) {
-		do_load_up_transact_altivec(&current->thread);
+		load_vr_state(&current->thread.vr_state);
 		regs->msr |= MSR_VEC;
 	}
 #endif
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 2552079..9f9fdb5 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -209,7 +209,6 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 */
 	regs->msr &= ~MSR_TS_MASK;
 
-	flush_fp_to_thread(current);
 
 #ifdef CONFIG_ALTIVEC
 	err |= __put_user(v_regs, &sc->v_regs);
@@ -217,20 +216,19 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 
 	/* save altivec registers */
 	if (current->thread.used_vr) {
-		flush_altivec_to_thread(current);
 		/* Copy 33 vec registers (vr0..31 and vscr) to the stack */
-		err |= __copy_to_user(v_regs, &current->thread.vr_state,
+		err |= __copy_to_user(v_regs, &current->thread.transact_vr,
 				      33 * sizeof(vector128));
 		/* If VEC was enabled there are transactional VRs valid too,
 		 * else they're a copy of the checkpointed VRs.
 		 */
 		if (msr & MSR_VEC)
 			err |= __copy_to_user(tm_v_regs,
-					      &current->thread.transact_vr,
+					      &current->thread.vr_state,
 					      33 * sizeof(vector128));
 		else
 			err |= __copy_to_user(tm_v_regs,
-					      &current->thread.vr_state,
+					      &current->thread.transact_vr,
 					      33 * sizeof(vector128));
 
 		/* set MSR_VEC in the MSR value in the frame to indicate
@@ -242,13 +240,13 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 * use altivec.
 	 */
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		current->thread.vrsave = mfspr(SPRN_VRSAVE);
-	err |= __put_user(current->thread.vrsave, (u32 __user *)&v_regs[33]);
+		current->thread.transact_vrsave = mfspr(SPRN_VRSAVE);
+	err |= __put_user(current->thread.transact_vrsave, (u32 __user *)&v_regs[33]);
 	if (msr & MSR_VEC)
-		err |= __put_user(current->thread.transact_vrsave,
+		err |= __put_user(current->thread.vrsave,
 				  (u32 __user *)&tm_v_regs[33]);
 	else
-		err |= __put_user(current->thread.vrsave,
+		err |= __put_user(current->thread.transact_vrsave,
 				  (u32 __user *)&tm_v_regs[33]);
 
 #else /* CONFIG_ALTIVEC */
@@ -257,11 +255,11 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 #endif /* CONFIG_ALTIVEC */
 
 	/* copy fpr regs and fpscr */
-	err |= copy_fpr_to_user(&sc->fp_regs, current);
+	err |= copy_transact_fpr_to_user(&sc->fp_regs, current);
 	if (msr & MSR_FP)
-		err |= copy_transact_fpr_to_user(&tm_sc->fp_regs, current);
-	else
 		err |= copy_fpr_to_user(&tm_sc->fp_regs, current);
+	else
+		err |= copy_transact_fpr_to_user(&tm_sc->fp_regs, current);
 
 #ifdef CONFIG_VSX
 	/*
@@ -270,16 +268,15 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 * VMX data.
 	 */
 	if (current->thread.used_vsr) {
-		flush_vsx_to_thread(current);
 		v_regs += ELF_NVRREG;
 		tm_v_regs += ELF_NVRREG;
 
-		err |= copy_vsx_to_user(v_regs, current);
+		err |= copy_transact_vsx_to_user(v_regs, current);
 
 		if (msr & MSR_VSX)
-			err |= copy_transact_vsx_to_user(tm_v_regs, current);
-		else
 			err |= copy_vsx_to_user(tm_v_regs, current);
+		else
+			err |= copy_transact_vsx_to_user(tm_v_regs, current);
 
 		/* set MSR_VSX in the MSR value in the frame to
 		 * indicate that sc->vs_reg) contains valid data.
@@ -478,9 +475,9 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 		return -EFAULT;
 	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
 	if (v_regs != NULL && tm_v_regs != NULL && (msr & MSR_VEC) != 0) {
-		err |= __copy_from_user(&current->thread.vr_state, v_regs,
+		err |= __copy_from_user(&current->thread.transact_vr, v_regs,
 					33 * sizeof(vector128));
-		err |= __copy_from_user(&current->thread.transact_vr, tm_v_regs,
+		err |= __copy_from_user(&current->thread.vr_state, tm_v_regs,
 					33 * sizeof(vector128));
 	}
 	else if (current->thread.used_vr) {
@@ -489,9 +486,9 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 	}
 	/* Always get VRSAVE back */
 	if (v_regs != NULL && tm_v_regs != NULL) {
-		err |= __get_user(current->thread.vrsave,
-				  (u32 __user *)&v_regs[33]);
 		err |= __get_user(current->thread.transact_vrsave,
+				  (u32 __user *)&v_regs[33]);
+		err |= __get_user(current->thread.vrsave,
 				  (u32 __user *)&tm_v_regs[33]);
 	}
 	else {
@@ -502,8 +499,8 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 		mtspr(SPRN_VRSAVE, current->thread.vrsave);
 #endif /* CONFIG_ALTIVEC */
 	/* restore floating point */
-	err |= copy_fpr_from_user(current, &sc->fp_regs);
-	err |= copy_transact_fpr_from_user(current, &tm_sc->fp_regs);
+	err |= copy_fpr_from_user(current, &tm_sc->fp_regs);
+	err |= copy_transact_fpr_from_user(current, &sc->fp_regs);
 #ifdef CONFIG_VSX
 	/*
 	 * Get additional VSX data. Update v_regs to point after the
@@ -513,8 +510,8 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 	if (v_regs && ((msr & MSR_VSX) != 0)) {
 		v_regs += ELF_NVRREG;
 		tm_v_regs += ELF_NVRREG;
-		err |= copy_vsx_from_user(current, v_regs);
-		err |= copy_transact_vsx_from_user(current, tm_v_regs);
+		err |= copy_vsx_from_user(current, tm_v_regs);
+		err |= copy_transact_vsx_from_user(current, v_regs);
 	} else {
 		for (i = 0; i < 32 ; i++) {
 			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
@@ -528,17 +525,15 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 	/* This loads the checkpointed FP/VEC state, if used */
 	tm_recheckpoint(&current->thread, msr);
 
-	/* This loads the speculative FP/VEC state, if used */
+	msr_check_and_set(msr & (MSR_FP | MSR_VEC));
 	if (msr & MSR_FP) {
-		do_load_up_transact_fpu(&current->thread);
+		load_fp_state(&current->thread.fp_state);
 		regs->msr |= (MSR_FP | current->thread.fpexc_mode);
 	}
-#ifdef CONFIG_ALTIVEC
 	if (msr & MSR_VEC) {
-		do_load_up_transact_altivec(&current->thread);
+		load_vr_state(&current->thread.vr_state);
 		regs->msr |= MSR_VEC;
 	}
-#endif
 
 	return err;
 }
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index bf8f34a..3741b47 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -108,6 +108,7 @@ _GLOBAL(tm_reclaim)
 	/* We've a struct pt_regs at [r1+STACK_FRAME_OVERHEAD]. */
 
 	std	r3, STK_PARAM(R3)(r1)
+	std	r4, STK_PARAM(R4)(r1)
 	SAVE_NVGPRS(r1)
 
 	/* We need to setup MSR for VSX register save instructions.  Here we
@@ -132,43 +133,6 @@ _GLOBAL(tm_reclaim)
 	mtmsrd	r15
 	std	r14, TM_FRAME_L0(r1)
 
-	/* Stash the stack pointer away for use after reclaim */
-	std	r1, PACAR1(r13)
-
-	/* ******************** FPR/VR/VSRs ************
-	 * Before reclaiming, capture the current/transactional FPR/VR
-	* versions /if used/.
-	 *
-	 * (If VSX used, FP and VMX are implied.  Or, we don't need to look
-	 * at MSR.VSX as copying FP regs if .FP, vector regs if .VMX covers it.)
-	 *
-	 * We're passed the thread's MSR as parameter 2.
-	 *
-	 * We enabled VEC/FP/VSX in the msr above, so we can execute these
-	 * instructions!
-	 */
-	andis.		r0, r4, MSR_VEC@h
-	beq	dont_backup_vec
-
-	addi	r7, r3, THREAD_TRANSACT_VRSTATE
-	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 transact vr state */
-	mfvscr	v0
-	li	r6, VRSTATE_VSCR
-	stvx	v0, r7, r6
-dont_backup_vec:
-	mfspr	r0, SPRN_VRSAVE
-	std	r0, THREAD_TRANSACT_VRSAVE(r3)
-
-	andi.	r0, r4, MSR_FP
-	beq	dont_backup_fp
-
-	addi	r7, r3, THREAD_TRANSACT_FPSTATE
-	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 transact fp state */
-
-	mffs    fr0
-	stfd    fr0,FPSTATE_FPSCR(r7)
-
-dont_backup_fp:
 	/* Do sanity check on MSR to make sure we are suspended */
 	li	r7, (MSR_TS_S)@higher
 	srdi	r6, r14, 32
@@ -176,6 +140,10 @@ dont_backup_fp:
 1:	tdeqi   r6, 0
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0
 
+
+	/* Stash the stack pointer away for use after reclaim */
+	std	r1, PACAR1(r13)
+
 	/* The moment we treclaim, ALL of our GPRs will switch
 	 * to user register state.  (FPRs, CCR etc. also!)
 	 * Use an sprg and a tm_scratch in the PACA to shuffle.
@@ -264,6 +232,43 @@ dont_backup_fp:
 	 * MSR.
 	 */
 
+
+	/* ******************** FPR/VR/VSRs ************
+	 * After reclaiming, capture the checkpointed FPRs/VRs /if used/.
+	 *
+	 * (If VSX used, FP and VMX are implied.  Or, we don't need to look
+	 * at MSR.VSX as copying FP regs if .FP, vector regs if .VMX covers it.)
+	 *
+	 * We're passed the thread's MSR as the second parameter
+	 *
+	 * We enabled VEC/FP/VSX in the msr above, so we can execute these
+	 * instructions!
+	 */
+	ld	r4, STK_PARAM(R4)(r1)		/* Second parameter, MSR * */
+	mr	r3, r12
+	andis.		r0, r4, MSR_VEC@h
+	beq	dont_backup_vec
+
+	addi	r7, r3, THREAD_TRANSACT_VRSTATE
+	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 transact vr state */
+	mfvscr	v0
+	li	r6, VRSTATE_VSCR
+	stvx	v0, r7, r6
+dont_backup_vec:
+	mfspr	r0, SPRN_VRSAVE
+	std	r0, THREAD_TRANSACT_VRSAVE(r3)
+
+	andi.	r0, r4, MSR_FP
+	beq	dont_backup_fp
+
+	addi	r7, r3, THREAD_TRANSACT_FPSTATE
+	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 transact fp state */
+
+	mffs    fr0
+	stfd    fr0,FPSTATE_FPSCR(r7)
+
+dont_backup_fp:
+
 	/* TM regs, incl TEXASR -- these live in thread_struct.  Note they've
 	 * been updated by the treclaim, to explain to userland the failure
 	 * cause (aborted).
@@ -279,6 +284,7 @@ dont_backup_fp:
 
 	/* Restore original MSR/IRQ state & clear TM mode */
 	ld	r14, TM_FRAME_L0(r1)		/* Orig MSR */
+
 	li	r15, 0
 	rldimi  r14, r15, MSR_TS_LG, (63-MSR_TS_LG)-1
 	mtmsrd  r14
@@ -349,28 +355,29 @@ _GLOBAL(__tm_recheckpoint)
 	mtmsr	r5
 
 #ifdef CONFIG_ALTIVEC
-	/* FP and VEC registers:  These are recheckpointed from thread.fpr[]
-	 * and thread.vr[] respectively.  The thread.transact_fpr[] version
-	 * is more modern, and will be loaded subsequently by any FPUnavailable
-	 * trap.
+	/*
+	 * FP and VEC registers: These are recheckpointed from
+	 * thread.ckfp_state and thread.ckvr_state respectively. The
+	 * thread.fp_state[] version holds the 'live' (transactional)
+	 * and will be loaded subsequently by any FPUnavailable trap.
 	 */
 	andis.	r0, r4, MSR_VEC@h
 	beq	dont_restore_vec
 
-	addi	r8, r3, THREAD_VRSTATE
+	addi	r8, r3, THREAD_TRANSACT_VRSTATE
 	li	r5, VRSTATE_VSCR
 	lvx	v0, r8, r5
 	mtvscr	v0
 	REST_32VRS(0, r5, r8)			/* r5 scratch, r8 ptr */
 dont_restore_vec:
-	ld	r5, THREAD_VRSAVE(r3)
+	ld	r5, THREAD_TRANSACT_VRSAVE(r3)
 	mtspr	SPRN_VRSAVE, r5
 #endif
 
 	andi.	r0, r4, MSR_FP
 	beq	dont_restore_fp
 
-	addi	r8, r3, THREAD_FPSTATE
+	addi	r8, r3, THREAD_TRANSACT_FPSTATE
 	lfd	fr0, FPSTATE_FPSCR(r8)
 	MTFSF_L(fr0)
 	REST_32FPRS_VSRS(0, R4, R8)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 9229ba6..3e4c84d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1487,7 +1487,8 @@ void fp_unavailable_tm(struct pt_regs *regs)
 
 	/* If VMX is in use, get the transactional values back */
 	if (regs->msr & MSR_VEC) {
-		do_load_up_transact_altivec(&current->thread);
+		msr_check_and_set(MSR_VEC);
+		load_vr_state(&current->thread.vr_state);
 		/* At this point all the VSX state is loaded, so enable it */
 		regs->msr |= MSR_VSX;
 	}
@@ -1508,7 +1509,8 @@ void altivec_unavailable_tm(struct pt_regs *regs)
 	current->thread.used_vr = 1;
 
 	if (regs->msr & MSR_FP) {
-		do_load_up_transact_fpu(&current->thread);
+		msr_check_and_set(MSR_FP);
+		load_fp_state(&current->thread.fp_state);
 		regs->msr |= MSR_VSX;
 	}
 }
@@ -1547,10 +1549,12 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 	 */
 	tm_recheckpoint(&current->thread, regs->msr & ~orig_msr);
 
+	msr_check_and_set(orig_msr & (MSR_FP | MSR_VEC));
+
 	if (orig_msr & MSR_FP)
-		do_load_up_transact_fpu(&current->thread);
+		load_fp_state(&current->thread.fp_state);
 	if (orig_msr & MSR_VEC)
-		do_load_up_transact_altivec(&current->thread);
+		load_vr_state(&current->thread.vr_state);
 }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
-- 
2.8.3
