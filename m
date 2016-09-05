Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSmZ66NJ0zDrqk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:34 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85NgxAA128676
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:45:33 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259dpc04yj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 19:45:32 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 6 Sep 2016 09:45:30 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D83BE2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:27 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85NjR2F66322574
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:27 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85NjRIq031560
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:27 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: wei.guo.simon@gmail.com, mikey@neuling.org
Subject: [PATCH v4 02/20] powerpc: Always restore FPU/VEC/VSX if hardware
 transactional memory in use
Date: Tue,  6 Sep 2016 09:44:30 +1000
In-Reply-To: <20160905234448.5866-1-cyrilbur@gmail.com>
References: <20160905234448.5866-1-cyrilbur@gmail.com>
Message-Id: <20160905234448.5866-3-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Comment from arch/powerpc/kernel/process.c:967:
 If userspace is inside a transaction (whether active or
 suspended) and FP/VMX/VSX instructions have ever been enabled
 inside that transaction, then we have to keep them enabled
 and keep the FP/VMX/VSX state loaded while ever the transaction
 continues.  The reason is that if we didn't, and subsequently
 got a FP/VMX/VSX unavailable interrupt inside a transaction,
 we don't know whether it's the same transaction, and thus we
 don't know which of the checkpointed state and the ransactional
 state to use.

restore_math() restore_fp() and restore_altivec() currently may not
restore the registers. It doesn't appear that this is more serious
than a performance penalty. If the math registers aren't restored the
userspace thread will still be run with the facility disabled.
Userspace will not be able to read invalid values. On the first access
it will take an facility unavailable exception and the kernel will
detected an active transaction, at which point it will abort the
transaction. There is the possibility for a pathological case
preventing any progress by transactions, however, transactions
are never guaranteed to make progress.

Fixes: 70fe3d9 ("powerpc: Restore FPU/VEC/VSX if previously used")
Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 58ccf86..cdf2d20 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -88,7 +88,13 @@ static void check_if_tm_restore_required(struct task_struct *tsk)
 		set_thread_flag(TIF_RESTORE_TM);
 	}
 }
+
+static inline bool msr_tm_active(unsigned long msr)
+{
+	return MSR_TM_ACTIVE(msr);
+}
 #else
+static inline bool msr_tm_active(unsigned long msr) { return false; }
 static inline void check_if_tm_restore_required(struct task_struct *tsk) { }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
@@ -208,7 +214,7 @@ void enable_kernel_fp(void)
 EXPORT_SYMBOL(enable_kernel_fp);
 
 static int restore_fp(struct task_struct *tsk) {
-	if (tsk->thread.load_fp) {
+	if (tsk->thread.load_fp || msr_tm_active(tsk->thread.regs->msr)) {
 		load_fp_state(&current->thread.fp_state);
 		current->thread.load_fp++;
 		return 1;
@@ -278,7 +284,8 @@ EXPORT_SYMBOL_GPL(flush_altivec_to_thread);
 
 static int restore_altivec(struct task_struct *tsk)
 {
-	if (cpu_has_feature(CPU_FTR_ALTIVEC) && tsk->thread.load_vec) {
+	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
+		(tsk->thread.load_vec || msr_tm_active(tsk->thread.regs->msr))) {
 		load_vr_state(&tsk->thread.vr_state);
 		tsk->thread.used_vr = 1;
 		tsk->thread.load_vec++;
@@ -464,7 +471,8 @@ void restore_math(struct pt_regs *regs)
 {
 	unsigned long msr;
 
-	if (!current->thread.load_fp && !loadvec(current->thread))
+	if (!msr_tm_active(regs->msr) &&
+		!current->thread.load_fp && !loadvec(current->thread))
 		return;
 
 	msr = regs->msr;
@@ -983,6 +991,13 @@ void restore_tm_state(struct pt_regs *regs)
 	msr_diff = current->thread.ckpt_regs.msr & ~regs->msr;
 	msr_diff &= MSR_FP | MSR_VEC | MSR_VSX;
 
+	/* Ensure that restore_math() will restore */
+	if (msr_diff & MSR_FP)
+		current->thread.load_fp = 1;
+#ifdef CONFIG_ALIVEC
+	if (cpu_has_feature(CPU_FTR_ALTIVEC) && msr_diff & MSR_VEC)
+		current->thread.load_vec = 1;
+#endif
 	restore_math(regs);
 
 	regs->msr |= msr_diff;
-- 
2.9.3
