Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgNVB1WhvzDsms
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:57 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8N6HZLW115356
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:18:55 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25mqb514ec-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:18:54 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 23 Sep 2016 16:18:51 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F1D5A3578062
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:48 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8N6ImuZ55312506
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8N6ImUU031326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:48 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 19/20] powerpc: tm: Rename transct_(*) to ck(\1)_state
Date: Fri, 23 Sep 2016 16:18:25 +1000
In-Reply-To: <20160923061826.30790-1-cyrilbur@gmail.com>
References: <20160923061826.30790-1-cyrilbur@gmail.com>
Message-Id: <20160923061826.30790-20-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make the structures being used for checkpointed state named
consistently with the pt_regs/ckpt_regs.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/processor.h |  8 ++---
 arch/powerpc/kernel/asm-offsets.c    | 12 ++++----
 arch/powerpc/kernel/fpu.S            |  2 +-
 arch/powerpc/kernel/process.c        |  4 +--
 arch/powerpc/kernel/ptrace.c         | 46 +++++++++++++--------------
 arch/powerpc/kernel/signal.h         |  8 ++---
 arch/powerpc/kernel/signal_32.c      | 60 ++++++++++++++++++------------------
 arch/powerpc/kernel/signal_64.c      | 32 +++++++++----------
 arch/powerpc/kernel/tm.S             | 12 ++++----
 arch/powerpc/kernel/vector.S         |  4 +--
 10 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index feab2ce..b3e0cfc 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -147,7 +147,7 @@ typedef struct {
 } mm_segment_t;
 
 #define TS_FPR(i) fp_state.fpr[i][TS_FPROFFSET]
-#define TS_TRANS_FPR(i) transact_fp.fpr[i][TS_FPROFFSET]
+#define TS_CKFPR(i) ckfp_state.fpr[i][TS_FPROFFSET]
 
 /* FP and VSX 0-31 register set */
 struct thread_fp_state {
@@ -275,9 +275,9 @@ struct thread_struct {
 	 *
 	 * These are analogous to how ckpt_regs and pt_regs work
 	 */
-	struct thread_fp_state transact_fp;
-	struct thread_vr_state transact_vr;
-	unsigned long	transact_vrsave;
+	struct thread_fp_state ckfp_state; /* Checkpointed FP state */
+	struct thread_vr_state ckvr_state; /* Checkpointed VR state */
+	unsigned long	ckvrsave; /* Checkpointed VRSAVE */
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
 	void*		kvm_shadow_vcpu; /* KVM internal data */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b89d14c..dd0fc33 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -142,12 +142,12 @@ int main(void)
 	DEFINE(THREAD_TM_PPR, offsetof(struct thread_struct, tm_ppr));
 	DEFINE(THREAD_TM_DSCR, offsetof(struct thread_struct, tm_dscr));
 	DEFINE(PT_CKPT_REGS, offsetof(struct thread_struct, ckpt_regs));
-	DEFINE(THREAD_TRANSACT_VRSTATE, offsetof(struct thread_struct,
-						 transact_vr));
-	DEFINE(THREAD_TRANSACT_VRSAVE, offsetof(struct thread_struct,
-					    transact_vrsave));
-	DEFINE(THREAD_TRANSACT_FPSTATE, offsetof(struct thread_struct,
-						 transact_fp));
+	DEFINE(THREAD_CKVRSTATE, offsetof(struct thread_struct,
+						 ckvr_state));
+	DEFINE(THREAD_CKVRSAVE, offsetof(struct thread_struct,
+					    ckvrsave));
+	DEFINE(THREAD_CKFPSTATE, offsetof(struct thread_struct,
+						 ckfp_state));
 	/* Local pt_regs on stack for Transactional Memory funcs. */
 	DEFINE(TM_FRAME_SIZE, STACK_FRAME_OVERHEAD +
 	       sizeof(struct pt_regs) + 16);
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 15da2b5..181c187 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -68,7 +68,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	SYNC
 	MTMSRD(r5)
 
-	addi	r7,r3,THREAD_TRANSACT_FPSTATE
+	addi	r7,r3,THREAD_CKFPSTATE
 	lfd	fr0,FPSTATE_FPSCR(r7)
 	MTFSF_L(fr0)
 	REST_32FPVSRS(0, R4, R7)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 6e9a054..e220330 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -851,8 +851,8 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
 	 *
 	 * In switching we need to maintain a 2nd register state as
 	 * oldtask->thread.ckpt_regs.  We tm_reclaim(oldproc); this saves the
-	 * checkpointed (tbegin) state in ckpt_regs and saves the transactional
-	 * (current) FPRs into oldtask->thread.transact_fpr[].
+	 * checkpointed (tbegin) state in ckpt_regs, ckfp_state and
+	 * ckvr_state
 	 *
 	 * We also context switch (save) TFHAR/TEXASR/TFIAR in here.
 	 */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 7ae744f..b1ec62f 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -404,7 +404,7 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 
 /*
  * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'transact_fp' holds the last checkpointed
+ * value of all FPR registers and 'ckfp_state' holds the last checkpointed
  * value of all FPR registers for the current transaction.
  *
  * Userspace interface buffer layout:
@@ -442,7 +442,7 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 
 /*
  * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'transact_fp' holds the last checkpointed
+ * value of all FPR registers and 'ckfp_state' holds the last checkpointed
  * value of all FPR registers for the current transaction.
  *
  * Userspace interface buffer layout:
@@ -506,7 +506,7 @@ static int vr_active(struct task_struct *target,
 
 /*
  * Regardless of transactions, 'vr_state' holds the current running
- * value of all the VMX registers and 'transact_vr' holds the last
+ * value of all the VMX registers and 'ckvr_state' holds the last
  * checkpointed value of all the VMX registers for the current
  * transaction to fall back on in case it aborts.
  *
@@ -553,7 +553,7 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
 
 /*
  * Regardless of transactions, 'vr_state' holds the current running
- * value of all the VMX registers and 'transact_vr' holds the last
+ * value of all the VMX registers and 'ckvr_state' holds the last
  * checkpointed value of all the VMX registers for the current
  * transaction to fall back on in case it aborts.
  *
@@ -617,7 +617,7 @@ static int vsr_active(struct task_struct *target,
 
 /*
  * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'transact_fp' holds the last
+ * value of all FPR registers and 'ckfp_state' holds the last
  * checkpointed value of all FPR registers for the current
  * transaction.
  *
@@ -650,7 +650,7 @@ static int vsr_get(struct task_struct *target, const struct user_regset *regset,
 
 /*
  * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'transact_fp' holds the last
+ * value of all FPR registers and 'ckfp_state' holds the last
  * checkpointed value of all FPR registers for the current
  * transaction.
  *
@@ -945,7 +945,7 @@ static int tm_cfpr_active(struct task_struct *target,
  *
  * This function gets in transaction checkpointed FPR registers.
  *
- * When the transaction is active 'transact_fp' holds the checkpointed
+ * When the transaction is active 'ckfp_state' holds the checkpointed
  * values for the current transaction to fall back on if it aborts
  * in between. This function gets those checkpointed FPR registers.
  * The userspace interface buffer layout is as follows.
@@ -975,8 +975,8 @@ static int tm_cfpr_get(struct task_struct *target,
 
 	/* copy to local buffer then write that out */
 	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.TS_TRANS_FPR(i);
-	buf[32] = target->thread.transact_fp.fpscr;
+		buf[i] = target->thread.TS_CKFPR(i);
+	buf[32] = target->thread.ckfp_state.fpscr;
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
 }
 
@@ -991,7 +991,7 @@ static int tm_cfpr_get(struct task_struct *target,
  *
  * This function sets in transaction checkpointed FPR registers.
  *
- * When the transaction is active 'transact_fp' holds the checkpointed
+ * When the transaction is active 'ckfp_state' holds the checkpointed
  * FPR register values for the current transaction to fall back on
  * if it aborts in between. This function sets these checkpointed
  * FPR registers. The userspace interface buffer layout is as follows.
@@ -1024,8 +1024,8 @@ static int tm_cfpr_set(struct task_struct *target,
 	if (i)
 		return i;
 	for (i = 0; i < 32 ; i++)
-		target->thread.TS_TRANS_FPR(i) = buf[i];
-	target->thread.transact_fp.fpscr = buf[32];
+		target->thread.TS_CKFPR(i) = buf[i];
+	target->thread.ckfp_state.fpscr = buf[32];
 	return 0;
 }
 
@@ -1060,7 +1060,7 @@ static int tm_cvmx_active(struct task_struct *target,
  *
  * This function gets in transaction checkpointed VMX registers.
  *
- * When the transaction is active 'transact_vr' and 'transact_vrsave' hold
+ * When the transaction is active 'ckvr_state' and 'ckvrsave' hold
  * the checkpointed values for the current transaction to fall
  * back on if it aborts in between. The userspace interface buffer
  * layout is as follows.
@@ -1092,7 +1092,7 @@ static int tm_cvmx_get(struct task_struct *target,
 	flush_altivec_to_thread(target);
 
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					&target->thread.transact_vr, 0,
+					&target->thread.ckvr_state, 0,
 					33 * sizeof(vector128));
 	if (!ret) {
 		/*
@@ -1103,7 +1103,7 @@ static int tm_cvmx_get(struct task_struct *target,
 			u32 word;
 		} vrsave;
 		memset(&vrsave, 0, sizeof(vrsave));
-		vrsave.word = target->thread.transact_vrsave;
+		vrsave.word = target->thread.ckvrsave;
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
 						33 * sizeof(vector128), -1);
 	}
@@ -1122,7 +1122,7 @@ static int tm_cvmx_get(struct task_struct *target,
  *
  * This function sets in transaction checkpointed VMX registers.
  *
- * When the transaction is active 'transact_vr' and 'transact_vrsave' hold
+ * When the transaction is active 'ckvr_state' and 'ckvrsave' hold
  * the checkpointed values for the current transaction to fall
  * back on if it aborts in between. The userspace interface buffer
  * layout is as follows.
@@ -1153,7 +1153,7 @@ static int tm_cvmx_set(struct task_struct *target,
 	flush_altivec_to_thread(target);
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					&target->thread.transact_vr, 0,
+					&target->thread.ckvr_state, 0,
 					33 * sizeof(vector128));
 	if (!ret && count > 0) {
 		/*
@@ -1164,11 +1164,11 @@ static int tm_cvmx_set(struct task_struct *target,
 			u32 word;
 		} vrsave;
 		memset(&vrsave, 0, sizeof(vrsave));
-		vrsave.word = target->thread.transact_vrsave;
+		vrsave.word = target->thread.ckvrsave;
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &vrsave,
 						33 * sizeof(vector128), -1);
 		if (!ret)
-			target->thread.transact_vrsave = vrsave.word;
+			target->thread.ckvrsave = vrsave.word;
 	}
 
 	return ret;
@@ -1206,7 +1206,7 @@ static int tm_cvsx_active(struct task_struct *target,
  *
  * This function gets in transaction checkpointed VSX registers.
  *
- * When the transaction is active 'transact_fp' holds the checkpointed
+ * When the transaction is active 'ckfp_state' holds the checkpointed
  * values for the current transaction to fall back on if it aborts
  * in between. This function gets those checkpointed VSX registers.
  * The userspace interface buffer layout is as follows.
@@ -1236,7 +1236,7 @@ static int tm_cvsx_get(struct task_struct *target,
 	flush_vsx_to_thread(target);
 
 	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET];
+		buf[i] = target->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET];
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  buf, 0, 32 * sizeof(double));
 
@@ -1254,7 +1254,7 @@ static int tm_cvsx_get(struct task_struct *target,
  *
  * This function sets in transaction checkpointed VSX registers.
  *
- * When the transaction is active 'transact_fp' holds the checkpointed
+ * When the transaction is active 'ckfp_state' holds the checkpointed
  * VSX register values for the current transaction to fall back on
  * if it aborts in between. This function sets these checkpointed
  * FPR registers. The userspace interface buffer layout is as follows.
@@ -1287,7 +1287,7 @@ static int tm_cvsx_set(struct task_struct *target,
 				 buf, 0, 32 * sizeof(double));
 	if (!ret)
 		for (i = 0; i < 32 ; i++)
-			target->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+			target->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
 
 	return ret;
 }
diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index 254ca07..7c59d88 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -23,22 +23,22 @@ extern int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 extern unsigned long copy_fpr_to_user(void __user *to,
 				      struct task_struct *task);
-extern unsigned long copy_transact_fpr_to_user(void __user *to,
+extern unsigned long copy_ckfpr_to_user(void __user *to,
 					       struct task_struct *task);
 extern unsigned long copy_fpr_from_user(struct task_struct *task,
 					void __user *from);
-extern unsigned long copy_transact_fpr_from_user(struct task_struct *task,
+extern unsigned long copy_ckfpr_from_user(struct task_struct *task,
 						 void __user *from);
 extern unsigned long get_tm_stackpointer(struct task_struct *tsk);
 
 #ifdef CONFIG_VSX
 extern unsigned long copy_vsx_to_user(void __user *to,
 				      struct task_struct *task);
-extern unsigned long copy_transact_vsx_to_user(void __user *to,
+extern unsigned long copy_ckvsx_to_user(void __user *to,
 					       struct task_struct *task);
 extern unsigned long copy_vsx_from_user(struct task_struct *task,
 					void __user *from);
-extern unsigned long copy_transact_vsx_from_user(struct task_struct *task,
+extern unsigned long copy_ckvsx_from_user(struct task_struct *task,
 						 void __user *from);
 #endif
 
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 3b9356b..27aa913 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -316,7 +316,7 @@ unsigned long copy_vsx_from_user(struct task_struct *task,
 }
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-unsigned long copy_transact_fpr_to_user(void __user *to,
+unsigned long copy_ckfpr_to_user(void __user *to,
 				  struct task_struct *task)
 {
 	u64 buf[ELF_NFPREG];
@@ -324,12 +324,12 @@ unsigned long copy_transact_fpr_to_user(void __user *to,
 
 	/* save FPR copy to local buffer then write to the thread_struct */
 	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
-		buf[i] = task->thread.TS_TRANS_FPR(i);
-	buf[i] = task->thread.transact_fp.fpscr;
+		buf[i] = task->thread.TS_CKFPR(i);
+	buf[i] = task->thread.ckfp_state.fpscr;
 	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
 }
 
-unsigned long copy_transact_fpr_from_user(struct task_struct *task,
+unsigned long copy_ckfpr_from_user(struct task_struct *task,
 					  void __user *from)
 {
 	u64 buf[ELF_NFPREG];
@@ -338,13 +338,13 @@ unsigned long copy_transact_fpr_from_user(struct task_struct *task,
 	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
 		return 1;
 	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
-		task->thread.TS_TRANS_FPR(i) = buf[i];
-	task->thread.transact_fp.fpscr = buf[i];
+		task->thread.TS_CKFPR(i) = buf[i];
+	task->thread.ckfp_state.fpscr = buf[i];
 
 	return 0;
 }
 
-unsigned long copy_transact_vsx_to_user(void __user *to,
+unsigned long copy_ckvsx_to_user(void __user *to,
 				  struct task_struct *task)
 {
 	u64 buf[ELF_NVSRHALFREG];
@@ -352,11 +352,11 @@ unsigned long copy_transact_vsx_to_user(void __user *to,
 
 	/* save FPR copy to local buffer then write to the thread_struct */
 	for (i = 0; i < ELF_NVSRHALFREG; i++)
-		buf[i] = task->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET];
+		buf[i] = task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET];
 	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
 }
 
-unsigned long copy_transact_vsx_from_user(struct task_struct *task,
+unsigned long copy_ckvsx_from_user(struct task_struct *task,
 					  void __user *from)
 {
 	u64 buf[ELF_NVSRHALFREG];
@@ -365,7 +365,7 @@ unsigned long copy_transact_vsx_from_user(struct task_struct *task,
 	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
 		return 1;
 	for (i = 0; i < ELF_NVSRHALFREG ; i++)
-		task->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+		task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
 	return 0;
 }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
@@ -385,17 +385,17 @@ inline unsigned long copy_fpr_from_user(struct task_struct *task,
 }
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-inline unsigned long copy_transact_fpr_to_user(void __user *to,
+inline unsigned long copy_ckfpr_to_user(void __user *to,
 					 struct task_struct *task)
 {
-	return __copy_to_user(to, task->thread.transact_fp.fpr,
+	return __copy_to_user(to, task->thread.ckfp_state.fpr,
 			      ELF_NFPREG * sizeof(double));
 }
 
-inline unsigned long copy_transact_fpr_from_user(struct task_struct *task,
+inline unsigned long copy_ckfpr_from_user(struct task_struct *task,
 						 void __user *from)
 {
-	return __copy_from_user(task->thread.transact_fp.fpr, from,
+	return __copy_from_user(task->thread.ckfp_state.fpr, from,
 				ELF_NFPREG * sizeof(double));
 }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
@@ -543,7 +543,7 @@ static int save_tm_user_regs(struct pt_regs *regs,
 #ifdef CONFIG_ALTIVEC
 	/* save altivec registers */
 	if (current->thread.used_vr) {
-		if (__copy_to_user(&frame->mc_vregs, &current->thread.transact_vr,
+		if (__copy_to_user(&frame->mc_vregs, &current->thread.ckvr_state,
 				   ELF_NVRREG * sizeof(vector128)))
 			return 1;
 		if (msr & MSR_VEC) {
@@ -553,7 +553,7 @@ static int save_tm_user_regs(struct pt_regs *regs,
 				return 1;
 		} else {
 			if (__copy_to_user(&tm_frame->mc_vregs,
-					   &current->thread.transact_vr,
+					   &current->thread.ckvr_state,
 					   ELF_NVRREG * sizeof(vector128)))
 				return 1;
 		}
@@ -570,8 +570,8 @@ static int save_tm_user_regs(struct pt_regs *regs,
 	 * most significant bits of that same vector. --BenH
 	 */
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		current->thread.transact_vrsave = mfspr(SPRN_VRSAVE);
-	if (__put_user(current->thread.transact_vrsave,
+		current->thread.ckvrsave = mfspr(SPRN_VRSAVE);
+	if (__put_user(current->thread.ckvrsave,
 		       (u32 __user *)&frame->mc_vregs[32]))
 		return 1;
 	if (msr & MSR_VEC) {
@@ -579,19 +579,19 @@ static int save_tm_user_regs(struct pt_regs *regs,
 			       (u32 __user *)&tm_frame->mc_vregs[32]))
 			return 1;
 	} else {
-		if (__put_user(current->thread.transact_vrsave,
+		if (__put_user(current->thread.ckvrsave,
 			       (u32 __user *)&tm_frame->mc_vregs[32]))
 			return 1;
 	}
 #endif /* CONFIG_ALTIVEC */
 
-	if (copy_transact_fpr_to_user(&frame->mc_fregs, current))
+	if (copy_ckfpr_to_user(&frame->mc_fregs, current))
 		return 1;
 	if (msr & MSR_FP) {
 		if (copy_fpr_to_user(&tm_frame->mc_fregs, current))
 			return 1;
 	} else {
-		if (copy_transact_fpr_to_user(&tm_frame->mc_fregs, current))
+		if (copy_ckfpr_to_user(&tm_frame->mc_fregs, current))
 			return 1;
 	}
 
@@ -603,14 +603,14 @@ static int save_tm_user_regs(struct pt_regs *regs,
 	 * contains valid data
 	 */
 	if (current->thread.used_vsr) {
-		if (copy_transact_vsx_to_user(&frame->mc_vsregs, current))
+		if (copy_ckvsx_to_user(&frame->mc_vsregs, current))
 			return 1;
 		if (msr & MSR_VSX) {
 			if (copy_vsx_to_user(&tm_frame->mc_vsregs,
 						      current))
 				return 1;
 		} else {
-			if (copy_transact_vsx_to_user(&tm_frame->mc_vsregs, current))
+			if (copy_ckvsx_to_user(&tm_frame->mc_vsregs, current))
 				return 1;
 		}
 
@@ -792,7 +792,7 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	regs->msr &= ~MSR_VEC;
 	if (msr & MSR_VEC) {
 		/* restore altivec registers from the stack */
-		if (__copy_from_user(&current->thread.transact_vr, &sr->mc_vregs,
+		if (__copy_from_user(&current->thread.ckvr_state, &sr->mc_vregs,
 				     sizeof(sr->mc_vregs)) ||
 		    __copy_from_user(&current->thread.vr_state,
 				     &tm_sr->mc_vregs,
@@ -802,24 +802,24 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	} else if (current->thread.used_vr) {
 		memset(&current->thread.vr_state, 0,
 		       ELF_NVRREG * sizeof(vector128));
-		memset(&current->thread.transact_vr, 0,
+		memset(&current->thread.ckvr_state, 0,
 		       ELF_NVRREG * sizeof(vector128));
 	}
 
 	/* Always get VRSAVE back */
-	if (__get_user(current->thread.transact_vrsave,
+	if (__get_user(current->thread.ckvrsave,
 		       (u32 __user *)&sr->mc_vregs[32]) ||
 	    __get_user(current->thread.vrsave,
 		       (u32 __user *)&tm_sr->mc_vregs[32]))
 		return 1;
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		mtspr(SPRN_VRSAVE, current->thread.transact_vrsave);
+		mtspr(SPRN_VRSAVE, current->thread.ckvrsave);
 #endif /* CONFIG_ALTIVEC */
 
 	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
 
 	if (copy_fpr_from_user(current, &sr->mc_fregs) ||
-	    copy_transact_fpr_from_user(current, &tm_sr->mc_fregs))
+	    copy_ckfpr_from_user(current, &tm_sr->mc_fregs))
 		return 1;
 
 #ifdef CONFIG_VSX
@@ -830,13 +830,13 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 		 * buffer, then write this out to the thread_struct
 		 */
 		if (copy_vsx_from_user(current, &tm_sr->mc_vsregs) ||
-		    copy_transact_vsx_from_user(current, &sr->mc_vsregs))
+		    copy_ckvsx_from_user(current, &sr->mc_vsregs))
 			return 1;
 		current->thread.used_vsr = true;
 	} else if (current->thread.used_vsr)
 		for (i = 0; i < 32 ; i++) {
 			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
-			current->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET] = 0;
+			current->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
 		}
 #endif /* CONFIG_VSX */
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index af58af5..96698fd 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -228,7 +228,7 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	/* save altivec registers */
 	if (tsk->thread.used_vr) {
 		/* Copy 33 vec registers (vr0..31 and vscr) to the stack */
-		err |= __copy_to_user(v_regs, &tsk->thread.transact_vr,
+		err |= __copy_to_user(v_regs, &tsk->thread.ckvr_state,
 				      33 * sizeof(vector128));
 		/* If VEC was enabled there are transactional VRs valid too,
 		 * else they're a copy of the checkpointed VRs.
@@ -239,7 +239,7 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 					      33 * sizeof(vector128));
 		else
 			err |= __copy_to_user(tm_v_regs,
-					      &tsk->thread.transact_vr,
+					      &tsk->thread.ckvr_state,
 					      33 * sizeof(vector128));
 
 		/* set MSR_VEC in the MSR value in the frame to indicate
@@ -251,13 +251,13 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 * use altivec.
 	 */
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		tsk->thread.transact_vrsave = mfspr(SPRN_VRSAVE);
-	err |= __put_user(tsk->thread.transact_vrsave, (u32 __user *)&v_regs[33]);
+		tsk->thread.ckvrsave = mfspr(SPRN_VRSAVE);
+	err |= __put_user(tsk->thread.ckvrsave, (u32 __user *)&v_regs[33]);
 	if (msr & MSR_VEC)
 		err |= __put_user(tsk->thread.vrsave,
 				  (u32 __user *)&tm_v_regs[33]);
 	else
-		err |= __put_user(tsk->thread.transact_vrsave,
+		err |= __put_user(tsk->thread.ckvrsave,
 				  (u32 __user *)&tm_v_regs[33]);
 
 #else /* CONFIG_ALTIVEC */
@@ -266,11 +266,11 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 #endif /* CONFIG_ALTIVEC */
 
 	/* copy fpr regs and fpscr */
-	err |= copy_transact_fpr_to_user(&sc->fp_regs, tsk);
+	err |= copy_ckfpr_to_user(&sc->fp_regs, tsk);
 	if (msr & MSR_FP)
 		err |= copy_fpr_to_user(&tm_sc->fp_regs, tsk);
 	else
-		err |= copy_transact_fpr_to_user(&tm_sc->fp_regs, tsk);
+		err |= copy_ckfpr_to_user(&tm_sc->fp_regs, tsk);
 
 #ifdef CONFIG_VSX
 	/*
@@ -282,12 +282,12 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 		v_regs += ELF_NVRREG;
 		tm_v_regs += ELF_NVRREG;
 
-		err |= copy_transact_vsx_to_user(v_regs, tsk);
+		err |= copy_ckvsx_to_user(v_regs, tsk);
 
 		if (msr & MSR_VSX)
 			err |= copy_vsx_to_user(tm_v_regs, tsk);
 		else
-			err |= copy_transact_vsx_to_user(tm_v_regs, tsk);
+			err |= copy_ckvsx_to_user(tm_v_regs, tsk);
 
 		/* set MSR_VSX in the MSR value in the frame to
 		 * indicate that sc->vs_reg) contains valid data.
@@ -497,7 +497,7 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 		return -EFAULT;
 	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
 	if (v_regs != NULL && tm_v_regs != NULL && (msr & MSR_VEC) != 0) {
-		err |= __copy_from_user(&tsk->thread.transact_vr, v_regs,
+		err |= __copy_from_user(&tsk->thread.ckvr_state, v_regs,
 					33 * sizeof(vector128));
 		err |= __copy_from_user(&tsk->thread.vr_state, tm_v_regs,
 					33 * sizeof(vector128));
@@ -505,25 +505,25 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 	}
 	else if (tsk->thread.used_vr) {
 		memset(&tsk->thread.vr_state, 0, 33 * sizeof(vector128));
-		memset(&tsk->thread.transact_vr, 0, 33 * sizeof(vector128));
+		memset(&tsk->thread.ckvr_state, 0, 33 * sizeof(vector128));
 	}
 	/* Always get VRSAVE back */
 	if (v_regs != NULL && tm_v_regs != NULL) {
-		err |= __get_user(tsk->thread.transact_vrsave,
+		err |= __get_user(tsk->thread.ckvrsave,
 				  (u32 __user *)&v_regs[33]);
 		err |= __get_user(tsk->thread.vrsave,
 				  (u32 __user *)&tm_v_regs[33]);
 	}
 	else {
 		tsk->thread.vrsave = 0;
-		tsk->thread.transact_vrsave = 0;
+		tsk->thread.ckvrsave = 0;
 	}
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		mtspr(SPRN_VRSAVE, tsk->thread.vrsave);
 #endif /* CONFIG_ALTIVEC */
 	/* restore floating point */
 	err |= copy_fpr_from_user(tsk, &tm_sc->fp_regs);
-	err |= copy_transact_fpr_from_user(tsk, &sc->fp_regs);
+	err |= copy_ckfpr_from_user(tsk, &sc->fp_regs);
 #ifdef CONFIG_VSX
 	/*
 	 * Get additional VSX data. Update v_regs to point after the
@@ -534,12 +534,12 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 		v_regs += ELF_NVRREG;
 		tm_v_regs += ELF_NVRREG;
 		err |= copy_vsx_from_user(tsk, tm_v_regs);
-		err |= copy_transact_vsx_from_user(tsk, v_regs);
+		err |= copy_ckvsx_from_user(tsk, v_regs);
 		tsk->thread.used_vsr = true;
 	} else {
 		for (i = 0; i < 32 ; i++) {
 			tsk->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
-			tsk->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET] = 0;
+			tsk->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
 		}
 	}
 #endif
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 7b7088d..3a2d041 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -257,19 +257,19 @@ _GLOBAL(tm_reclaim)
 	andis.		r0, r4, MSR_VEC@h
 	beq	dont_backup_vec
 
-	addi	r7, r3, THREAD_TRANSACT_VRSTATE
+	addi	r7, r3, THREAD_CKVRSTATE
 	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 transact vr state */
 	mfvscr	v0
 	li	r6, VRSTATE_VSCR
 	stvx	v0, r7, r6
 dont_backup_vec:
 	mfspr	r0, SPRN_VRSAVE
-	std	r0, THREAD_TRANSACT_VRSAVE(r3)
+	std	r0, THREAD_CKVRSAVE(r3)
 
 	andi.	r0, r4, MSR_FP
 	beq	dont_backup_fp
 
-	addi	r7, r3, THREAD_TRANSACT_FPSTATE
+	addi	r7, r3, THREAD_CKFPSTATE
 	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 transact fp state */
 
 	mffs    fr0
@@ -370,20 +370,20 @@ _GLOBAL(__tm_recheckpoint)
 	andis.	r0, r4, MSR_VEC@h
 	beq	dont_restore_vec
 
-	addi	r8, r3, THREAD_TRANSACT_VRSTATE
+	addi	r8, r3, THREAD_CKVRSTATE
 	li	r5, VRSTATE_VSCR
 	lvx	v0, r8, r5
 	mtvscr	v0
 	REST_32VRS(0, r5, r8)			/* r5 scratch, r8 ptr */
 dont_restore_vec:
-	ld	r5, THREAD_TRANSACT_VRSAVE(r3)
+	ld	r5, THREAD_CKVRSAVE(r3)
 	mtspr	SPRN_VRSAVE, r5
 #endif
 
 	andi.	r0, r4, MSR_FP
 	beq	dont_restore_fp
 
-	addi	r8, r3, THREAD_TRANSACT_FPSTATE
+	addi	r8, r3, THREAD_CKFPSTATE
 	lfd	fr0, FPSTATE_FPSCR(r8)
 	MTFSF_L(fr0)
 	REST_32FPRS_VSRS(0, R4, R8)
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 616a6d8..7dc4021 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -23,10 +23,10 @@ _GLOBAL(do_load_up_transact_altivec)
 	li	r4,1
 	stw	r4,THREAD_USED_VR(r3)
 
-	li	r10,THREAD_TRANSACT_VRSTATE+VRSTATE_VSCR
+	li	r10,THREAD_CKVRSTATE+VRSTATE_VSCR
 	lvx	v0,r10,r3
 	mtvscr	v0
-	addi	r10,r3,THREAD_TRANSACT_VRSTATE
+	addi	r10,r3,THREAD_CKVRSTATE
 	REST_32VRS(0,r4,r10)
 
 	blr
-- 
2.10.0
