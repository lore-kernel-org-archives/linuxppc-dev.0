Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9PP10qQjzDrG1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:24 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BNSZ6e015658
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:22 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24ru30b756-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:22 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 12 Aug 2016 09:29:19 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9C4662BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:17 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BNTHBk27394154
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:17 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BNTHEu023424
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:17 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: anton@samba.org, mikey@neuling.org
Subject: [PATCH v2 19/20] powerpc: tm: Rename transct_(*) to ck(\1)_state
Date: Fri, 12 Aug 2016 09:28:18 +1000
In-Reply-To: <20160811232819.11453-1-cyrilbur@gmail.com>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
Message-Id: <20160811232819.11453-20-cyrilbur@gmail.com>
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
index 6836570..5216e04 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -860,8 +860,8 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
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
index ed53712..1e85d6b 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -384,7 +384,7 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 
 /*
  * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'transact_fp' holds the last checkpointed
+ * value of all FPR registers and 'ckfp_state' holds the last checkpointed
  * value of all FPR registers for the current transaction.
  *
  * Userspace interface buffer layout:
@@ -422,7 +422,7 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 
 /*
  * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'transact_fp' holds the last checkpointed
+ * value of all FPR registers and 'ckfp_state' holds the last checkpointed
  * value of all FPR registers for the current transaction.
  *
  * Userspace interface buffer layout:
@@ -486,7 +486,7 @@ static int vr_active(struct task_struct *target,
 
 /*
  * Regardless of transactions, 'vr_state' holds the current running
- * value of all the VMX registers and 'transact_vr' holds the last
+ * value of all the VMX registers and 'ckvr_state' holds the last
  * checkpointed value of all the VMX registers for the current
  * transaction to fall back on in case it aborts.
  *
@@ -533,7 +533,7 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
 
 /*
  * Regardless of transactions, 'vr_state' holds the current running
- * value of all the VMX registers and 'transact_vr' holds the last
+ * value of all the VMX registers and 'ckvr_state' holds the last
  * checkpointed value of all the VMX registers for the current
  * transaction to fall back on in case it aborts.
  *
@@ -597,7 +597,7 @@ static int vsr_active(struct task_struct *target,
 
 /*
  * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'transact_fp' holds the last
+ * value of all FPR registers and 'ckfp_state' holds the last
  * checkpointed value of all FPR registers for the current
  * transaction.
  *
@@ -630,7 +630,7 @@ static int vsr_get(struct task_struct *target, const struct user_regset *regset,
 
 /*
  * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'transact_fp' holds the last
+ * value of all FPR registers and 'ckfp_state' holds the last
  * checkpointed value of all FPR registers for the current
  * transaction.
  *
@@ -925,7 +925,7 @@ static int tm_cfpr_active(struct task_struct *target,
  *
  * This function gets in transaction checkpointed FPR registers.
  *
- * When the transaction is active 'transact_fp' holds the checkpointed
+ * When the transaction is active 'ckfp_state' holds the checkpointed
  * values for the current transaction to fall back on if it aborts
  * in between. This function gets those checkpointed FPR registers.
  * The userspace interface buffer layout is as follows.
@@ -955,8 +955,8 @@ static int tm_cfpr_get(struct task_struct *target,
 
 	/* copy to local buffer then write that out */
 	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.TS_TRANS_FPR(i);
-	buf[32] = target->thread.transact_fp.fpscr;
+		buf[i] = target->thread.TS_CKFPR(i);
+	buf[32] = target->thread.ckfp_state.fpscr;
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
 }
 
@@ -971,7 +971,7 @@ static int tm_cfpr_get(struct task_struct *target,
  *
  * This function sets in transaction checkpointed FPR registers.
  *
- * When the transaction is active 'transact_fp' holds the checkpointed
+ * When the transaction is active 'ckfp_state' holds the checkpointed
  * FPR register values for the current transaction to fall back on
  * if it aborts in between. This function sets these checkpointed
  * FPR registers. The userspace interface buffer layout is as follows.
@@ -1004,8 +1004,8 @@ static int tm_cfpr_set(struct task_struct *target,
 	if (i)
 		return i;
 	for (i = 0; i < 32 ; i++)
-		target->thread.TS_TRANS_FPR(i) = buf[i];
-	target->thread.transact_fp.fpscr = buf[32];
+		target->thread.TS_CKFPR(i) = buf[i];
+	target->thread.ckfp_state.fpscr = buf[32];
 	return 0;
 }
 
@@ -1040,7 +1040,7 @@ static int tm_cvmx_active(struct task_struct *target,
  *
  * This function gets in transaction checkpointed VMX registers.
  *
- * When the transaction is active 'transact_vr' and 'transact_vrsave' hold
+ * When the transaction is active 'ckvr_state' and 'ckvrsave' hold
  * the checkpointed values for the current transaction to fall
  * back on if it aborts in between. The userspace interface buffer
  * layout is as follows.
@@ -1072,7 +1072,7 @@ static int tm_cvmx_get(struct task_struct *target,
 	flush_altivec_to_thread(target);
 
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					&target->thread.transact_vr, 0,
+					&target->thread.ckvr_state, 0,
 					33 * sizeof(vector128));
 	if (!ret) {
 		/*
@@ -1083,7 +1083,7 @@ static int tm_cvmx_get(struct task_struct *target,
 			u32 word;
 		} vrsave;
 		memset(&vrsave, 0, sizeof(vrsave));
-		vrsave.word = target->thread.transact_vrsave;
+		vrsave.word = target->thread.ckvrsave;
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
 						33 * sizeof(vector128), -1);
 	}
@@ -1102,7 +1102,7 @@ static int tm_cvmx_get(struct task_struct *target,
  *
  * This function sets in transaction checkpointed VMX registers.
  *
- * When the transaction is active 'transact_vr' and 'transact_vrsave' hold
+ * When the transaction is active 'ckvr_state' and 'ckvrsave' hold
  * the checkpointed values for the current transaction to fall
  * back on if it aborts in between. The userspace interface buffer
  * layout is as follows.
@@ -1133,7 +1133,7 @@ static int tm_cvmx_set(struct task_struct *target,
 	flush_altivec_to_thread(target);
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					&target->thread.transact_vr, 0,
+					&target->thread.ckvr_state, 0,
 					33 * sizeof(vector128));
 	if (!ret && count > 0) {
 		/*
@@ -1144,11 +1144,11 @@ static int tm_cvmx_set(struct task_struct *target,
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
@@ -1186,7 +1186,7 @@ static int tm_cvsx_active(struct task_struct *target,
  *
  * This function gets in transaction checkpointed VSX registers.
  *
- * When the transaction is active 'transact_fp' holds the checkpointed
+ * When the transaction is active 'ckfp_state' holds the checkpointed
  * values for the current transaction to fall back on if it aborts
  * in between. This function gets those checkpointed VSX registers.
  * The userspace interface buffer layout is as follows.
@@ -1216,7 +1216,7 @@ static int tm_cvsx_get(struct task_struct *target,
 	flush_vsx_to_thread(target);
 
 	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET];
+		buf[i] = target->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET];
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  buf, 0, 32 * sizeof(double));
 
@@ -1234,7 +1234,7 @@ static int tm_cvsx_get(struct task_struct *target,
  *
  * This function sets in transaction checkpointed VSX registers.
  *
- * When the transaction is active 'transact_fp' holds the checkpointed
+ * When the transaction is active 'ckfp_state' holds the checkpointed
  * VSX register values for the current transaction to fall back on
  * if it aborts in between. This function sets these checkpointed
  * FPR registers. The userspace interface buffer layout is as follows.
@@ -1267,7 +1267,7 @@ static int tm_cvsx_set(struct task_struct *target,
 				 buf, 0, 32 * sizeof(double));
 	if (!ret)
 		for (i = 0; i < 32 ; i++)
-			target->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+			target->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
 
 	return ret;
 }
diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index be305c8..b1cebf66 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -23,20 +23,20 @@ extern int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 
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
index d106b91..c7d905b 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -315,7 +315,7 @@ unsigned long copy_vsx_from_user(struct task_struct *task,
 }
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-unsigned long copy_transact_fpr_to_user(void __user *to,
+unsigned long copy_ckfpr_to_user(void __user *to,
 				  struct task_struct *task)
 {
 	u64 buf[ELF_NFPREG];
@@ -323,12 +323,12 @@ unsigned long copy_transact_fpr_to_user(void __user *to,
 
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
@@ -337,13 +337,13 @@ unsigned long copy_transact_fpr_from_user(struct task_struct *task,
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
@@ -351,11 +351,11 @@ unsigned long copy_transact_vsx_to_user(void __user *to,
 
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
@@ -364,7 +364,7 @@ unsigned long copy_transact_vsx_from_user(struct task_struct *task,
 	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
 		return 1;
 	for (i = 0; i < ELF_NVSRHALFREG ; i++)
-		task->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+		task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
 	return 0;
 }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
@@ -384,17 +384,17 @@ inline unsigned long copy_fpr_from_user(struct task_struct *task,
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
@@ -542,7 +542,7 @@ static int save_tm_user_regs(struct pt_regs *regs,
 #ifdef CONFIG_ALTIVEC
 	/* save altivec registers */
 	if (current->thread.used_vr) {
-		if (__copy_to_user(&frame->mc_vregs, &current->thread.transact_vr,
+		if (__copy_to_user(&frame->mc_vregs, &current->thread.ckvr_state,
 				   ELF_NVRREG * sizeof(vector128)))
 			return 1;
 		if (msr & MSR_VEC) {
@@ -552,7 +552,7 @@ static int save_tm_user_regs(struct pt_regs *regs,
 				return 1;
 		} else {
 			if (__copy_to_user(&tm_frame->mc_vregs,
-					   &current->thread.transact_vr,
+					   &current->thread.ckvr_state,
 					   ELF_NVRREG * sizeof(vector128)))
 				return 1;
 		}
@@ -569,8 +569,8 @@ static int save_tm_user_regs(struct pt_regs *regs,
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
@@ -578,19 +578,19 @@ static int save_tm_user_regs(struct pt_regs *regs,
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
 
@@ -602,14 +602,14 @@ static int save_tm_user_regs(struct pt_regs *regs,
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
 
@@ -788,7 +788,7 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	regs->msr &= ~MSR_VEC;
 	if (msr & MSR_VEC) {
 		/* restore altivec registers from the stack */
-		if (__copy_from_user(&current->thread.transact_vr, &sr->mc_vregs,
+		if (__copy_from_user(&current->thread.ckvr_state, &sr->mc_vregs,
 				     sizeof(sr->mc_vregs)) ||
 		    __copy_from_user(&current->thread.vr_state,
 				     &tm_sr->mc_vregs,
@@ -797,24 +797,24 @@ static long restore_tm_user_regs(struct pt_regs *regs,
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
@@ -825,12 +825,12 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 		 * buffer, then write this out to the thread_struct
 		 */
 		if (copy_vsx_from_user(current, &tm_sr->mc_vsregs) ||
-		    copy_transact_vsx_from_user(current, &sr->mc_vsregs))
+		    copy_ckvsx_from_user(current, &sr->mc_vsregs))
 			return 1;
 	} else if (current->thread.used_vsr)
 		for (i = 0; i < 32 ; i++) {
 			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
-			current->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET] = 0;
+			current->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
 		}
 #endif /* CONFIG_VSX */
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 53db2b3..45ae2e7 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -222,7 +222,7 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	/* save altivec registers */
 	if (current->thread.used_vr) {
 		/* Copy 33 vec registers (vr0..31 and vscr) to the stack */
-		err |= __copy_to_user(v_regs, &current->thread.transact_vr,
+		err |= __copy_to_user(v_regs, &current->thread.ckvr_state,
 				      33 * sizeof(vector128));
 		/* If VEC was enabled there are transactional VRs valid too,
 		 * else they're a copy of the checkpointed VRs.
@@ -233,7 +233,7 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 					      33 * sizeof(vector128));
 		else
 			err |= __copy_to_user(tm_v_regs,
-					      &current->thread.transact_vr,
+					      &current->thread.ckvr_state,
 					      33 * sizeof(vector128));
 
 		/* set MSR_VEC in the MSR value in the frame to indicate
@@ -245,13 +245,13 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 * use altivec.
 	 */
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		current->thread.transact_vrsave = mfspr(SPRN_VRSAVE);
-	err |= __put_user(current->thread.transact_vrsave, (u32 __user *)&v_regs[33]);
+		current->thread.ckvrsave = mfspr(SPRN_VRSAVE);
+	err |= __put_user(current->thread.ckvrsave, (u32 __user *)&v_regs[33]);
 	if (msr & MSR_VEC)
 		err |= __put_user(current->thread.vrsave,
 				  (u32 __user *)&tm_v_regs[33]);
 	else
-		err |= __put_user(current->thread.transact_vrsave,
+		err |= __put_user(current->thread.ckvrsave,
 				  (u32 __user *)&tm_v_regs[33]);
 
 #else /* CONFIG_ALTIVEC */
@@ -260,11 +260,11 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 #endif /* CONFIG_ALTIVEC */
 
 	/* copy fpr regs and fpscr */
-	err |= copy_transact_fpr_to_user(&sc->fp_regs, current);
+	err |= copy_ckfpr_to_user(&sc->fp_regs, current);
 	if (msr & MSR_FP)
 		err |= copy_fpr_to_user(&tm_sc->fp_regs, current);
 	else
-		err |= copy_transact_fpr_to_user(&tm_sc->fp_regs, current);
+		err |= copy_ckfpr_to_user(&tm_sc->fp_regs, current);
 
 #ifdef CONFIG_VSX
 	/*
@@ -276,12 +276,12 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 		v_regs += ELF_NVRREG;
 		tm_v_regs += ELF_NVRREG;
 
-		err |= copy_transact_vsx_to_user(v_regs, current);
+		err |= copy_ckvsx_to_user(v_regs, current);
 
 		if (msr & MSR_VSX)
 			err |= copy_vsx_to_user(tm_v_regs, current);
 		else
-			err |= copy_transact_vsx_to_user(tm_v_regs, current);
+			err |= copy_ckvsx_to_user(tm_v_regs, current);
 
 		/* set MSR_VSX in the MSR value in the frame to
 		 * indicate that sc->vs_reg) contains valid data.
@@ -480,32 +480,32 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 		return -EFAULT;
 	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
 	if (v_regs != NULL && tm_v_regs != NULL && (msr & MSR_VEC) != 0) {
-		err |= __copy_from_user(&current->thread.transact_vr, v_regs,
+		err |= __copy_from_user(&current->thread.ckvr_state, v_regs,
 					33 * sizeof(vector128));
 		err |= __copy_from_user(&current->thread.vr_state, tm_v_regs,
 					33 * sizeof(vector128));
 	}
 	else if (current->thread.used_vr) {
 		memset(&current->thread.vr_state, 0, 33 * sizeof(vector128));
-		memset(&current->thread.transact_vr, 0, 33 * sizeof(vector128));
+		memset(&current->thread.ckvr_state, 0, 33 * sizeof(vector128));
 	}
 	/* Always get VRSAVE back */
 	if (v_regs != NULL && tm_v_regs != NULL) {
-		err |= __get_user(current->thread.transact_vrsave,
+		err |= __get_user(current->thread.ckvrsave,
 				  (u32 __user *)&v_regs[33]);
 		err |= __get_user(current->thread.vrsave,
 				  (u32 __user *)&tm_v_regs[33]);
 	}
 	else {
 		current->thread.vrsave = 0;
-		current->thread.transact_vrsave = 0;
+		current->thread.ckvrsave = 0;
 	}
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		mtspr(SPRN_VRSAVE, current->thread.vrsave);
 #endif /* CONFIG_ALTIVEC */
 	/* restore floating point */
 	err |= copy_fpr_from_user(current, &tm_sc->fp_regs);
-	err |= copy_transact_fpr_from_user(current, &sc->fp_regs);
+	err |= copy_ckfpr_from_user(current, &sc->fp_regs);
 #ifdef CONFIG_VSX
 	/*
 	 * Get additional VSX data. Update v_regs to point after the
@@ -516,11 +516,11 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 		v_regs += ELF_NVRREG;
 		tm_v_regs += ELF_NVRREG;
 		err |= copy_vsx_from_user(current, tm_v_regs);
-		err |= copy_transact_vsx_from_user(current, v_regs);
+		err |= copy_ckvsx_from_user(current, v_regs);
 	} else {
 		for (i = 0; i < 32 ; i++) {
 			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
-			current->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET] = 0;
+			current->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
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
2.9.2
