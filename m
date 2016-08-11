Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9PP02J6mzDrD9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:24 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BNSdaW080383
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:22 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9v82f1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:22 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 12 Aug 2016 09:29:19 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4E1A02BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:17 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BNTHWZ27394148
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:17 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BNTGuJ023400
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:17 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: anton@samba.org, mikey@neuling.org
Subject: [PATCH v2 18/20] powerpc: tm: Always use fp_state and vr_state to
 store live registers
Date: Fri, 12 Aug 2016 09:28:17 +1000
In-Reply-To: <20160811232819.11453-1-cyrilbur@gmail.com>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
Message-Id: <20160811232819.11453-19-cyrilbur@gmail.com>
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
non transactional fp_state holds the live registers. When a thread
has initiated a transaction fp_state holds the checkpointed state and
transact_fp becomes the structure which holds the live state (at this
point it is a transactional state). The same is true for vr_state

This method creates confusion as to where the live state is, in some
circumstances it requires extra work to determine where to put the
live state and prevents the use of common functions designed (probably
before TM) to save the live state.

With this patch pt_regs, fp_state and vr_state all represent the
same thing and the other structures [pending rename] are for
checkpointed state.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/processor.h |   7 +-
 arch/powerpc/kernel/process.c        |  63 +++-----
 arch/powerpc/kernel/ptrace.c         | 278 +++++++++--------------------------
 arch/powerpc/kernel/signal_32.c      |  50 +++----
 arch/powerpc/kernel/signal_64.c      |  53 +++----
 arch/powerpc/kernel/tm.S             |  94 ++++++------
 arch/powerpc/kernel/traps.c          |  12 +-
 7 files changed, 196 insertions(+), 361 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 68e3bf5..feab2ce 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -267,16 +267,13 @@ struct thread_struct {
 	unsigned long	tm_dscr;
 
 	/*
-	 * Transactional FP and VSX 0-31 register set.
-	 * NOTE: the sense of these is the opposite of the integer ckpt_regs!
+	 * Checkpointed FP and VSX 0-31 register set.
 	 *
 	 * When a transaction is active/signalled/scheduled etc., *regs is the
 	 * most recent set of/speculated GPRs with ckpt_regs being the older
 	 * checkpointed regs to which we roll back if transaction aborts.
 	 *
-	 * However, fpr[] is the checkpointed 'base state' of FP regs, and
-	 * transact_fpr[] is the new set of transactional values.
-	 * VRs work the same way.
+	 * These are analogous to how ckpt_regs and pt_regs work
 	 */
 	struct thread_fp_state transact_fp;
 	struct thread_vr_state transact_vr;
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 0cfbc89..6836570 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -808,26 +808,14 @@ static inline bool hw_brk_match(struct arch_hw_breakpoint *a,
 static void tm_reclaim_thread(struct thread_struct *thr,
 			      struct thread_info *ti, uint8_t cause)
 {
-	unsigned long msr_diff = 0;
+	unsigned long msr_diff = thr->regs->msr;
 
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
@@ -846,7 +834,9 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 	if (!MSR_TM_SUSPENDED(mfmsr()))
 		return;
 
-	tm_reclaim(thr, thr->regs->msr, cause);
+	giveup_all(container_of(thr, struct task_struct, thread));
+
+	tm_reclaim(thr, msr_diff, cause);
 
 	/* Having done the reclaim, we now have the checkpointed
 	 * FP/VSX values in the registers.  These might be valid
@@ -948,7 +938,7 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
 	 * If the task was using FP, we non-lazily reload both the original and
 	 * the speculative FP register states.  This is because the kernel
 	 * doesn't see if/when a TM rollback occurs, so if we take an FP
-	 * unavoidable later, we are unable to determine which set of FP regs
+	 * unavailable later, we are unable to determine which set of FP regs
 	 * need to be restored.
 	 */
 	if (!new->thread.regs)
@@ -964,35 +954,27 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
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
+	/*
+	 * The checkpointed state has been restored but the live state has
+	 * not, ensure all the math functionality is turned off to trigger
+	 * restore_math() to reload.
+	 */
+	new->thread.regs->msr &= ~(MSR_FP | MSR_VEC | MSR_VSX);
 
 	TM_DEBUG("*** tm_recheckpoint of pid %d complete "
 		 "(kernel msr 0x%lx)\n",
 		 new->pid, mfmsr());
 }
 
-static inline void __switch_to_tm(struct task_struct *prev)
+static inline void __switch_to_tm(struct task_struct *prev,
+		struct task_struct *new)
 {
 	if (cpu_has_feature(CPU_FTR_TM)) {
 		tm_enable();
 		tm_reclaim_task(prev);
+		tm_recheckpoint_new_task(new);
 	}
 }
 
@@ -1028,7 +1010,7 @@ void restore_tm_state(struct pt_regs *regs)
 
 #else
 #define tm_recheckpoint_new_task(new)
-#define __switch_to_tm(prev)
+#define __switch_to_tm(prev, new)
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 static inline void save_sprs(struct thread_struct *t)
@@ -1189,11 +1171,11 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	 */
 	save_sprs(&prev->thread);
 
-	__switch_to_tm(prev);
-
 	/* Save FPU, Altivec, VSX and SPE state */
 	giveup_all(prev);
 
+	__switch_to_tm(prev, new);
+
 	/*
 	 * We can't take a PMU exception inside _switch() since there is a
 	 * window where the kernel stack SLB and the kernel stack are out
@@ -1201,8 +1183,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	 */
 	hard_irq_disable();
 
-	tm_recheckpoint_new_task(new);
-
 	/*
 	 * Call restore_sprs() before calling _switch(). If we move it after
 	 * _switch() then we miss out on calling it for new tasks. The reason
@@ -1438,8 +1418,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	 * tm_recheckpoint_new_task() (on the same task) to restore the
 	 * checkpointed state back and the TM mode.
 	 */
-	__switch_to_tm(src);
-	tm_recheckpoint_new_task(src);
+	__switch_to_tm(src, src);
 
 	*dst = *src;
 
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 4f3c575..ed53712 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -383,13 +383,9 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 }
 
 /*
- * When the transaction is active, 'transact_fp' holds the current running
- * value of all FPR registers and 'fp_state' holds the last checkpointed
- * value of all FPR registers for the current transaction. When transaction
- * is not active 'fp_state' holds the current running state of all the FPR
- * registers. So this function which returns the current running values of
- * all the FPR registers, needs to know whether any transaction is active
- * or not.
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'transact_fp' holds the last checkpointed
+ * value of all FPR registers for the current transaction.
  *
  * Userspace interface buffer layout:
  *
@@ -397,13 +393,6 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
  *	u64	fpr[32];
  *	u64	fpscr;
  * };
- *
- * There are two config options CONFIG_VSX and CONFIG_PPC_TRANSACTIONAL_MEM
- * which determines the final code in this function. All the combinations of
- * these two config options are possible except the one below as transactional
- * memory config pulls in CONFIG_VSX automatically.
- *
- *	!defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
  */
 static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
@@ -412,50 +401,29 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 #ifdef CONFIG_VSX
 	u64 buf[33];
 	int i;
-#endif
-	flush_fp_to_thread(target);
 
-#if defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
-	/* copy to local buffer then write that out */
-	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
-		flush_altivec_to_thread(target);
-		flush_tmregs_to_thread(target);
-		for (i = 0; i < 32 ; i++)
-			buf[i] = target->thread.TS_TRANS_FPR(i);
-		buf[32] = target->thread.transact_fp.fpscr;
-	} else {
-		for (i = 0; i < 32 ; i++)
-			buf[i] = target->thread.TS_FPR(i);
-		buf[32] = target->thread.fp_state.fpscr;
-	}
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
-#endif
+	flush_fp_to_thread(target);
 
-#if defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
 	/* copy to local buffer then write that out */
 	for (i = 0; i < 32 ; i++)
 		buf[i] = target->thread.TS_FPR(i);
 	buf[32] = target->thread.fp_state.fpscr;
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
-#endif
-
-#if !defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
+#else
 	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
 		     offsetof(struct thread_fp_state, fpr[32]));
 
+	flush_fp_to_thread(target);
+
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				   &target->thread.fp_state, 0, -1);
 #endif
 }
 
 /*
- * When the transaction is active, 'transact_fp' holds the current running
- * value of all FPR registers and 'fp_state' holds the last checkpointed
- * value of all FPR registers for the current transaction. When transaction
- * is not active 'fp_state' holds the current running state of all the FPR
- * registers. So this function which setss the current running values of
- * all the FPR registers, needs to know whether any transaction is active
- * or not.
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'transact_fp' holds the last checkpointed
+ * value of all FPR registers for the current transaction.
  *
  * Userspace interface buffer layout:
  *
@@ -464,12 +432,6 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
  *	u64	fpscr;
  * };
  *
- * There are two config options CONFIG_VSX and CONFIG_PPC_TRANSACTIONAL_MEM
- * which determines the final code in this function. All the combinations of
- * these two config options are possible except the one below as transactional
- * memory config pulls in CONFIG_VSX automatically.
- *
- *	!defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
  */
 static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
@@ -478,44 +440,24 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 #ifdef CONFIG_VSX
 	u64 buf[33];
 	int i;
-#endif
+
 	flush_fp_to_thread(target);
 
-#if defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
 	/* copy to local buffer then write that out */
 	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
 	if (i)
 		return i;
 
-	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
-		flush_altivec_to_thread(target);
-		flush_tmregs_to_thread(target);
-		for (i = 0; i < 32 ; i++)
-			target->thread.TS_TRANS_FPR(i) = buf[i];
-		target->thread.transact_fp.fpscr = buf[32];
-	} else {
-		for (i = 0; i < 32 ; i++)
-			target->thread.TS_FPR(i) = buf[i];
-		target->thread.fp_state.fpscr = buf[32];
-	}
-	return 0;
-#endif
-
-#if defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
-	/* copy to local buffer then write that out */
-	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
-	if (i)
-		return i;
 	for (i = 0; i < 32 ; i++)
 		target->thread.TS_FPR(i) = buf[i];
 	target->thread.fp_state.fpscr = buf[32];
 	return 0;
-#endif
-
-#if !defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
+#else
 	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
 		     offsetof(struct thread_fp_state, fpr[32]));
 
+	flush_fp_to_thread(target);
+
 	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				  &target->thread.fp_state, 0, -1);
 #endif
@@ -543,13 +485,10 @@ static int vr_active(struct task_struct *target,
 }
 
 /*
- * When the transaction is active, 'transact_vr' holds the current running
- * value of all the VMX registers and 'vr_state' holds the last checkpointed
- * value of all the VMX registers for the current transaction to fall back
- * on in case it aborts. When transaction is not active 'vr_state' holds
- * the current running state of all the VMX registers. So this function which
- * gets the current running values of all the VMX registers, needs to know
- * whether any transaction is active or not.
+ * Regardless of transactions, 'vr_state' holds the current running
+ * value of all the VMX registers and 'transact_vr' holds the last
+ * checkpointed value of all the VMX registers for the current
+ * transaction to fall back on in case it aborts.
  *
  * Userspace interface buffer layout:
  *
@@ -563,7 +502,6 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
 		  unsigned int pos, unsigned int count,
 		  void *kbuf, void __user *ubuf)
 {
-	struct thread_vr_state *addr;
 	int ret;
 
 	flush_altivec_to_thread(target);
@@ -571,19 +509,8 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
 	BUILD_BUG_ON(offsetof(struct thread_vr_state, vscr) !=
 		     offsetof(struct thread_vr_state, vr[32]));
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
-		flush_fp_to_thread(target);
-		flush_tmregs_to_thread(target);
-		addr = &target->thread.transact_vr;
-	} else {
-		addr = &target->thread.vr_state;
-	}
-#else
-	addr = &target->thread.vr_state;
-#endif
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  addr, 0,
+				  &target->thread.vr_state, 0,
 				  33 * sizeof(vector128));
 	if (!ret) {
 		/*
@@ -595,14 +522,7 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
 		} vrsave;
 		memset(&vrsave, 0, sizeof(vrsave));
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-		if (MSR_TM_ACTIVE(target->thread.regs->msr))
-			vrsave.word = target->thread.transact_vrsave;
-		else
-			vrsave.word = target->thread.vrsave;
-#else
 		vrsave.word = target->thread.vrsave;
-#endif
 
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
 					  33 * sizeof(vector128), -1);
@@ -612,13 +532,10 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
 }
 
 /*
- * When the transaction is active, 'transact_vr' holds the current running
- * value of all the VMX registers and 'vr_state' holds the last checkpointed
- * value of all the VMX registers for the current transaction to fall back
- * on in case it aborts. When transaction is not active 'vr_state' holds
- * the current running state of all the VMX registers. So this function which
- * sets the current running values of all the VMX registers, needs to know
- * whether any transaction is active or not.
+ * Regardless of transactions, 'vr_state' holds the current running
+ * value of all the VMX registers and 'transact_vr' holds the last
+ * checkpointed value of all the VMX registers for the current
+ * transaction to fall back on in case it aborts.
  *
  * Userspace interface buffer layout:
  *
@@ -632,7 +549,6 @@ static int vr_set(struct task_struct *target, const struct user_regset *regset,
 		  unsigned int pos, unsigned int count,
 		  const void *kbuf, const void __user *ubuf)
 {
-	struct thread_vr_state *addr;
 	int ret;
 
 	flush_altivec_to_thread(target);
@@ -640,19 +556,8 @@ static int vr_set(struct task_struct *target, const struct user_regset *regset,
 	BUILD_BUG_ON(offsetof(struct thread_vr_state, vscr) !=
 		     offsetof(struct thread_vr_state, vr[32]));
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
-		flush_fp_to_thread(target);
-		flush_tmregs_to_thread(target);
-		addr = &target->thread.transact_vr;
-	} else {
-		addr = &target->thread.vr_state;
-	}
-#else
-	addr = &target->thread.vr_state;
-#endif
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 addr, 0,
+				 &target->thread.vr_state, 0,
 				 33 * sizeof(vector128));
 	if (!ret && count > 0) {
 		/*
@@ -664,27 +569,12 @@ static int vr_set(struct task_struct *target, const struct user_regset *regset,
 		} vrsave;
 		memset(&vrsave, 0, sizeof(vrsave));
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-		if (MSR_TM_ACTIVE(target->thread.regs->msr))
-			vrsave.word = target->thread.transact_vrsave;
-		else
-			vrsave.word = target->thread.vrsave;
-#else
 		vrsave.word = target->thread.vrsave;
-#endif
+
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &vrsave,
 					 33 * sizeof(vector128), -1);
-		if (!ret) {
-
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-			if (MSR_TM_ACTIVE(target->thread.regs->msr))
-				target->thread.transact_vrsave = vrsave.word;
-			else
-				target->thread.vrsave = vrsave.word;
-#else
+		if (!ret)
 			target->thread.vrsave = vrsave.word;
-#endif
-		}
 	}
 
 	return ret;
@@ -706,13 +596,10 @@ static int vsr_active(struct task_struct *target,
 }
 
 /*
- * When the transaction is active, 'transact_fp' holds the current running
- * value of all FPR registers and 'fp_state' holds the last checkpointed
- * value of all FPR registers for the current transaction. When transaction
- * is not active 'fp_state' holds the current running state of all the FPR
- * registers. So this function which returns the current running values of
- * all the FPR registers, needs to know whether any transaction is active
- * or not.
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'transact_fp' holds the last
+ * checkpointed value of all FPR registers for the current
+ * transaction.
  *
  * Userspace interface buffer layout:
  *
@@ -727,27 +614,14 @@ static int vsr_get(struct task_struct *target, const struct user_regset *regset,
 	u64 buf[32];
 	int ret, i;
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
-	flush_tmregs_to_thread(target);
-#endif
 	flush_vsx_to_thread(target);
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
-		for (i = 0; i < 32 ; i++)
-			buf[i] = target->thread.
-				transact_fp.fpr[i][TS_VSRLOWOFFSET];
-	} else {
-		for (i = 0; i < 32 ; i++)
-			buf[i] = target->thread.
-				fp_state.fpr[i][TS_VSRLOWOFFSET];
-	}
-#else
 	for (i = 0; i < 32 ; i++)
 		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
-#endif
+
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  buf, 0, 32 * sizeof(double));
 
@@ -755,12 +629,10 @@ static int vsr_get(struct task_struct *target, const struct user_regset *regset,
 }
 
 /*
- * When the transaction is active, 'transact_fp' holds the current running
- * value of all FPR registers and 'fp_state' holds the last checkpointed
- * value of all FPR registers for the current transaction. When transaction
- * is not active 'fp_state' holds the current running state of all the FPR
- * registers. So this function which sets the current running values of all
- * the FPR registers, needs to know whether any transaction is active or not.
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'transact_fp' holds the last
+ * checkpointed value of all FPR registers for the current
+ * transaction.
  *
  * Userspace interface buffer layout:
  *
@@ -775,31 +647,16 @@ static int vsr_set(struct task_struct *target, const struct user_regset *regset,
 	u64 buf[32];
 	int ret,i;
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
-	flush_tmregs_to_thread(target);
-#endif
 	flush_vsx_to_thread(target);
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				 buf, 0, 32 * sizeof(double));
-
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
-		for (i = 0; i < 32 ; i++)
-			target->thread.transact_fp.
-				fpr[i][TS_VSRLOWOFFSET] = buf[i];
-	} else {
+	if (!ret)
 		for (i = 0; i < 32 ; i++)
-			target->thread.fp_state.
-				fpr[i][TS_VSRLOWOFFSET] = buf[i];
-	}
-#else
-	for (i = 0; i < 32 ; i++)
-		target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
-#endif
-
+			target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
 
 	return ret;
 }
@@ -925,9 +782,9 @@ static int tm_cgpr_get(struct task_struct *target,
 	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
 		return -ENODATA;
 
+	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
-	flush_tmregs_to_thread(target);
 
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  &target->thread.ckpt_regs,
@@ -990,9 +847,9 @@ static int tm_cgpr_set(struct task_struct *target,
 	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
 		return -ENODATA;
 
+	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
-	flush_tmregs_to_thread(target);
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				 &target->thread.ckpt_regs,
@@ -1068,7 +925,7 @@ static int tm_cfpr_active(struct task_struct *target,
  *
  * This function gets in transaction checkpointed FPR registers.
  *
- * When the transaction is active 'fp_state' holds the checkpointed
+ * When the transaction is active 'transact_fp' holds the checkpointed
  * values for the current transaction to fall back on if it aborts
  * in between. This function gets those checkpointed FPR registers.
  * The userspace interface buffer layout is as follows.
@@ -1092,14 +949,14 @@ static int tm_cfpr_get(struct task_struct *target,
 	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
 		return -ENODATA;
 
+	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
-	flush_tmregs_to_thread(target);
 
 	/* copy to local buffer then write that out */
 	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.TS_FPR(i);
-	buf[32] = target->thread.fp_state.fpscr;
+		buf[i] = target->thread.TS_TRANS_FPR(i);
+	buf[32] = target->thread.transact_fp.fpscr;
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
 }
 
@@ -1114,7 +971,7 @@ static int tm_cfpr_get(struct task_struct *target,
  *
  * This function sets in transaction checkpointed FPR registers.
  *
- * When the transaction is active 'fp_state' holds the checkpointed
+ * When the transaction is active 'transact_fp' holds the checkpointed
  * FPR register values for the current transaction to fall back on
  * if it aborts in between. This function sets these checkpointed
  * FPR registers. The userspace interface buffer layout is as follows.
@@ -1138,17 +995,17 @@ static int tm_cfpr_set(struct task_struct *target,
 	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
 		return -ENODATA;
 
+	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
-	flush_tmregs_to_thread(target);
 
 	/* copy to local buffer then write that out */
 	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
 	if (i)
 		return i;
 	for (i = 0; i < 32 ; i++)
-		target->thread.TS_FPR(i) = buf[i];
-	target->thread.fp_state.fpscr = buf[32];
+		target->thread.TS_TRANS_FPR(i) = buf[i];
+	target->thread.transact_fp.fpscr = buf[32];
 	return 0;
 }
 
@@ -1183,7 +1040,7 @@ static int tm_cvmx_active(struct task_struct *target,
  *
  * This function gets in transaction checkpointed VMX registers.
  *
- * When the transaction is active 'vr_state' and 'vr_save' hold
+ * When the transaction is active 'transact_vr' and 'transact_vrsave' hold
  * the checkpointed values for the current transaction to fall
  * back on if it aborts in between. The userspace interface buffer
  * layout is as follows.
@@ -1210,12 +1067,12 @@ static int tm_cvmx_get(struct task_struct *target,
 		return -ENODATA;
 
 	/* Flush the state */
+	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
-	flush_tmregs_to_thread(target);
 
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					&target->thread.vr_state, 0,
+					&target->thread.transact_vr, 0,
 					33 * sizeof(vector128));
 	if (!ret) {
 		/*
@@ -1226,7 +1083,7 @@ static int tm_cvmx_get(struct task_struct *target,
 			u32 word;
 		} vrsave;
 		memset(&vrsave, 0, sizeof(vrsave));
-		vrsave.word = target->thread.vrsave;
+		vrsave.word = target->thread.transact_vrsave;
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
 						33 * sizeof(vector128), -1);
 	}
@@ -1245,7 +1102,7 @@ static int tm_cvmx_get(struct task_struct *target,
  *
  * This function sets in transaction checkpointed VMX registers.
  *
- * When the transaction is active 'vr_state' and 'vr_save' hold
+ * When the transaction is active 'transact_vr' and 'transact_vrsave' hold
  * the checkpointed values for the current transaction to fall
  * back on if it aborts in between. The userspace interface buffer
  * layout is as follows.
@@ -1271,12 +1128,12 @@ static int tm_cvmx_set(struct task_struct *target,
 	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
 		return -ENODATA;
 
+	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
-	flush_tmregs_to_thread(target);
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					&target->thread.vr_state, 0,
+					&target->thread.transact_vr, 0,
 					33 * sizeof(vector128));
 	if (!ret && count > 0) {
 		/*
@@ -1287,11 +1144,11 @@ static int tm_cvmx_set(struct task_struct *target,
 			u32 word;
 		} vrsave;
 		memset(&vrsave, 0, sizeof(vrsave));
-		vrsave.word = target->thread.vrsave;
+		vrsave.word = target->thread.transact_vrsave;
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &vrsave,
 						33 * sizeof(vector128), -1);
 		if (!ret)
-			target->thread.vrsave = vrsave.word;
+			target->thread.transact_vrsave = vrsave.word;
 	}
 
 	return ret;
@@ -1329,7 +1186,7 @@ static int tm_cvsx_active(struct task_struct *target,
  *
  * This function gets in transaction checkpointed VSX registers.
  *
- * When the transaction is active 'fp_state' holds the checkpointed
+ * When the transaction is active 'transact_fp' holds the checkpointed
  * values for the current transaction to fall back on if it aborts
  * in between. This function gets those checkpointed VSX registers.
  * The userspace interface buffer layout is as follows.
@@ -1353,13 +1210,13 @@ static int tm_cvsx_get(struct task_struct *target,
 		return -ENODATA;
 
 	/* Flush the state */
+	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
-	flush_tmregs_to_thread(target);
 	flush_vsx_to_thread(target);
 
 	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
+		buf[i] = target->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET];
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  buf, 0, 32 * sizeof(double));
 
@@ -1377,7 +1234,7 @@ static int tm_cvsx_get(struct task_struct *target,
  *
  * This function sets in transaction checkpointed VSX registers.
  *
- * When the transaction is active 'fp_state' holds the checkpointed
+ * When the transaction is active 'transact_fp' holds the checkpointed
  * VSX register values for the current transaction to fall back on
  * if it aborts in between. This function sets these checkpointed
  * FPR registers. The userspace interface buffer layout is as follows.
@@ -1401,15 +1258,16 @@ static int tm_cvsx_set(struct task_struct *target,
 		return -ENODATA;
 
 	/* Flush the state */
+	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
-	flush_tmregs_to_thread(target);
 	flush_vsx_to_thread(target);
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				 buf, 0, 32 * sizeof(double));
-	for (i = 0; i < 32 ; i++)
-		target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+	if (!ret)
+		for (i = 0; i < 32 ; i++)
+			target->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET] = buf[i];
 
 	return ret;
 }
@@ -1465,9 +1323,9 @@ static int tm_spr_get(struct task_struct *target,
 		return -ENODEV;
 
 	/* Flush the states */
+	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
-	flush_tmregs_to_thread(target);
 
 	/* TFHAR register */
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
@@ -1521,9 +1379,9 @@ static int tm_spr_set(struct task_struct *target,
 		return -ENODEV;
 
 	/* Flush the states */
+	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
-	flush_tmregs_to_thread(target);
 
 	/* TFHAR register */
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
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
index 7e49984..53db2b3 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -214,7 +214,6 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 */
 	regs->msr &= ~MSR_TS_MASK;
 
-	flush_fp_to_thread(current);
 
 #ifdef CONFIG_ALTIVEC
 	err |= __put_user(v_regs, &sc->v_regs);
@@ -222,20 +221,19 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 
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
@@ -247,13 +245,13 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
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
@@ -262,11 +260,11 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
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
@@ -275,16 +273,15 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
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
@@ -483,9 +480,9 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
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
@@ -494,9 +491,9 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
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
@@ -507,8 +504,8 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
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
@@ -518,8 +515,8 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
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
@@ -533,17 +530,15 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
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
index 298afcf..7b7088d 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -108,6 +108,7 @@ _GLOBAL(tm_reclaim)
 	/* We've a struct pt_regs at [r1+STACK_FRAME_OVERHEAD]. */
 
 	std	r3, STK_PARAM(R3)(r1)
+	std	r4, STK_PARAM(R4)(r1)
 	SAVE_NVGPRS(r1)
 
 	/* We need to setup MSR for VSX register save instructions. */
@@ -126,43 +127,6 @@ _GLOBAL(tm_reclaim)
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
@@ -170,6 +134,9 @@ dont_backup_fp:
 1:	tdeqi   r6, 0
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0
 
+	/* Stash the stack pointer away for use after reclaim */
+	std	r1, PACAR1(r13)
+
 	/* Clear MSR RI since we are about to change r1, EE is already off. */
 	li	r4, 0
 	mtmsrd	r4, 1
@@ -273,6 +240,43 @@ dont_backup_fp:
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
@@ -288,6 +292,7 @@ dont_backup_fp:
 
 	/* Restore original MSR/IRQ state & clear TM mode */
 	ld	r14, TM_FRAME_L0(r1)		/* Orig MSR */
+
 	li	r15, 0
 	rldimi  r14, r15, MSR_TS_LG, (63-MSR_TS_LG)-1
 	mtmsrd  r14
@@ -356,28 +361,29 @@ _GLOBAL(__tm_recheckpoint)
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
index f7e2f2e..8e2304c9 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1498,7 +1498,8 @@ void fp_unavailable_tm(struct pt_regs *regs)
 
 	/* If VMX is in use, get the transactional values back */
 	if (regs->msr & MSR_VEC) {
-		do_load_up_transact_altivec(&current->thread);
+		msr_check_and_set(MSR_VEC);
+		load_vr_state(&current->thread.vr_state);
 		/* At this point all the VSX state is loaded, so enable it */
 		regs->msr |= MSR_VSX;
 	}
@@ -1519,7 +1520,8 @@ void altivec_unavailable_tm(struct pt_regs *regs)
 	current->thread.used_vr = 1;
 
 	if (regs->msr & MSR_FP) {
-		do_load_up_transact_fpu(&current->thread);
+		msr_check_and_set(MSR_FP);
+		load_fp_state(&current->thread.fp_state);
 		regs->msr |= MSR_VSX;
 	}
 }
@@ -1558,10 +1560,12 @@ void vsx_unavailable_tm(struct pt_regs *regs)
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
2.9.2
