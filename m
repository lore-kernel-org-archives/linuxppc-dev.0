Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYvDP4S4NzDsW7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:03:01 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8E8309k103698
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 04:03:00 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25exb7k00f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 04:02:59 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 14 Sep 2016 18:02:53 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D78A42BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:02:51 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8E82pIg6619538
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:02:51 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8E82pxe016583
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:02:51 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: mikey@neuling.org, anton@samba.org, wei.guo.simon@gmail.com
Subject: [PATCH 2/2] powerpc: tm: Enable transactional memory (TM) lazily for
 userspace
Date: Wed, 14 Sep 2016 18:02:16 +1000
In-Reply-To: <20160914080216.13833-1-cyrilbur@gmail.com>
References: <20160914080216.13833-1-cyrilbur@gmail.com>
Message-Id: <20160914080216.13833-3-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the MSR TM bit is always set if the hardware is TM capable.
This adds extra overhead as it means the TM SPRS (TFHAR, TEXASR and
TFAIR) must be swapped for each process regardless of if they use TM.

For processes that don't use TM the TM MSR bit can be turned off
allowing the kernel to avoid the expensive swap of the TM registers.

A TM unavailable exception will occur if a thread does use TM and the
kernel will enable MSR_TM and leave it so for some time afterwards.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/processor.h |  1 +
 arch/powerpc/kernel/process.c        | 28 +++++++++++++++++++++++-----
 arch/powerpc/kernel/traps.c          |  9 +++++++++
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index b3e0cfc..c07c31b 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -257,6 +257,7 @@ struct thread_struct {
 	int		used_spe;	/* set if process has used spe */
 #endif /* CONFIG_SPE */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	u8	load_tm;
 	u64		tm_tfhar;	/* Transaction fail handler addr */
 	u64		tm_texasr;	/* Transaction exception & summary */
 	u64		tm_tfiar;	/* Transaction fail instr address reg */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 11f7a64..cd81dd4 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -811,6 +811,12 @@ static inline bool hw_brk_match(struct arch_hw_breakpoint *a,
 }
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+
+static inline bool tm_enabled(struct task_struct *tsk)
+{
+	return tsk && tsk->thread.regs && (tsk->thread.regs->msr & MSR_TM);
+}
+
 static void tm_reclaim_thread(struct thread_struct *thr,
 			      struct thread_info *ti, uint8_t cause)
 {
@@ -891,6 +897,9 @@ void tm_recheckpoint(struct thread_struct *thread,
 {
 	unsigned long flags;
 
+	if (!(thread->regs->msr & MSR_TM))
+		return;
+
 	/* We really can't be interrupted here as the TEXASR registers can't
 	 * change and later in the trecheckpoint code, we have a userspace R1.
 	 * So let's hard disable over this region.
@@ -923,7 +932,7 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
 	 * unavailable later, we are unable to determine which set of FP regs
 	 * need to be restored.
 	 */
-	if (!new->thread.regs)
+	if (!tm_enabled(new))
 		return;
 
 	if (!MSR_TM_ACTIVE(new->thread.regs->msr)){
@@ -954,8 +963,16 @@ static inline void __switch_to_tm(struct task_struct *prev,
 		struct task_struct *new)
 {
 	if (cpu_has_feature(CPU_FTR_TM)) {
-		tm_enable();
-		tm_reclaim_task(prev);
+		if (tm_enabled(prev) || tm_enabled(new))
+			tm_enable();
+
+		if (tm_enabled(prev)) {
+			prev->thread.load_tm++;
+			tm_reclaim_task(prev);
+			if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm == 0)
+				prev->thread.regs->msr &= ~MSR_TM;
+		}
+
 		tm_recheckpoint_new_task(new);
 	}
 }
@@ -1392,6 +1409,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	 * transitions the CPU out of TM mode.  Hence we need to call
 	 * tm_recheckpoint_new_task() (on the same task) to restore the
 	 * checkpointed state back and the TM mode.
+	 *
+	 * Can't pass dst because it isn't ready. Doesn't matter, passing
+	 * dst is only important for __switch_to()
 	 */
 	__switch_to_tm(src, src);
 
@@ -1635,8 +1655,6 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.used_spe = 0;
 #endif /* CONFIG_SPE */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	if (cpu_has_feature(CPU_FTR_TM))
-		regs->msr |= MSR_TM;
 	current->thread.tm_tfhar = 0;
 	current->thread.tm_texasr = 0;
 	current->thread.tm_tfiar = 0;
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index cd40130..9bb3895 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1374,6 +1374,15 @@ void vsx_unavailable_exception(struct pt_regs *regs)
 #ifdef CONFIG_PPC64
 static void tm_unavailable(struct pt_regs *regs)
 {
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (user_mode(regs)) {
+		current->thread.load_tm++;
+		regs->msr |= MSR_TM;
+		tm_enable();
+		tm_restore_sprs(&current->thread);
+		return;
+	}
+#endif
 	pr_emerg("Unrecoverable TM Unavailable Exception "
 			"%lx at %lx\n", regs->trap, regs->nip);
 	die("Unrecoverable TM Unavailable Exception", regs, SIGABRT);
-- 
2.9.3
