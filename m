Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB382C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 13:05:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A4F2083D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 13:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A4F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q8sf3NC8zF3Cm
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 00:05:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q8KX54SqzF1LM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 23:40:48 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA6CYhEh120805
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Nov 2018 07:40:45 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nk818fys6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 07:40:45 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 6 Nov 2018 12:40:44 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 6 Nov 2018 12:40:40 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA6CedTS3932568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Nov 2018 12:40:39 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33647AC05B;
 Tue,  6 Nov 2018 12:40:39 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA81EAC059;
 Tue,  6 Nov 2018 12:40:37 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.97])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  6 Nov 2018 12:40:37 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 05/14] powerpc/tm: Refactor the __switch_to_tm code
Date: Tue,  6 Nov 2018 10:40:19 -0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541508028-31865-1-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18110612-0068-0000-0000-0000035B4982
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009996; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113483; UDB=6.00577209; IPR=6.00893582; 
 MB=3.00024045; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-06 12:40:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110612-0069-0000-0000-000046555960
Message-Id: <1541508028-31865-6-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060112
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mikey@neuling.org, gromero@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>, ldufour@linux.vnet.ibm.com,
 cyrilbur@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

__switch_to_tm is the function that switches between two tasks which might
have TM enabled. This function is clearly split in two parts, the task that
is leaving the CPU, known as 'prev' and the task that is being scheduled,
known as 'new'.

It starts checking if the previous task had TM enable, if so, it increases
the load_tm (this is the only place we increment load_tm). It also saves
the TM SPRs here.

If the previous task was scheduled out with a transaction active, the
failure cause needs to be updated, since it might contain the failure cause
that caused the exception, as TM_CAUSE_MISC. In this case, since there was
a context switch, overwrite the failure cause.

If the previous task has overflowed load_tm, disable TM, putting the
facility save/restore lazy mechanism at lazy mode.

Regarding the 'new' task being scheduled, restoring TM SPRs is enough if
the task had TM enabled when it was de-scheduled. (Checking if a
recheckpoint would be required will be done later, at restore_tm_state()
stage.)

On top of that, both tm_reclaim_task() and tm_recheckpoint_new_task()
functions are not used anymore, removing them.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c | 167 ++++++++++++++++------------------
 1 file changed, 78 insertions(+), 89 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1842fd96b123..73872f751b33 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -912,48 +912,6 @@ void tm_reclaim_current(uint8_t cause)
 	tm_reclaim_thread(&current->thread, cause);
 }
 
-static inline void tm_reclaim_task(struct task_struct *tsk)
-{
-	/* We have to work out if we're switching from/to a task that's in the
-	 * middle of a transaction.
-	 *
-	 * In switching we need to maintain a 2nd register state as
-	 * oldtask->thread.ckpt_regs.  We tm_reclaim(oldproc); this saves the
-	 * checkpointed (tbegin) state in ckpt_regs, ckfp_state and
-	 * ckvr_state
-	 *
-	 * We also context switch (save) TFHAR/TEXASR/TFIAR in here.
-	 */
-	struct thread_struct *thr = &tsk->thread;
-
-	if (!thr->regs)
-		return;
-
-	if (!MSR_TM_ACTIVE(thr->regs->msr))
-		goto out_and_saveregs;
-
-	WARN_ON(tm_suspend_disabled);
-
-	TM_DEBUG("--- tm_reclaim on pid %d (NIP=%lx, "
-		 "ccr=%lx, msr=%lx, trap=%lx)\n",
-		 tsk->pid, thr->regs->nip,
-		 thr->regs->ccr, thr->regs->msr,
-		 thr->regs->trap);
-
-	tm_reclaim_thread(thr, TM_CAUSE_RESCHED);
-
-	TM_DEBUG("--- tm_reclaim on pid %d complete\n",
-		 tsk->pid);
-
-out_and_saveregs:
-	/* Always save the regs here, even if a transaction's not active.
-	 * This context-switches a thread's TM info SPRs.  We do it here to
-	 * be consistent with the restore path (in recheckpoint) which
-	 * cannot happen later in _switch().
-	 */
-	tm_save_sprs(thr);
-}
-
 extern void __tm_recheckpoint(struct thread_struct *thread);
 
 void tm_recheckpoint(struct thread_struct *thread)
@@ -980,59 +938,91 @@ void tm_recheckpoint(struct thread_struct *thread)
 	local_irq_restore(flags);
 }
 
-static inline void tm_recheckpoint_new_task(struct task_struct *new)
+static void tm_change_failure_cause(struct task_struct *task, uint8_t cause)
 {
-	if (!cpu_has_feature(CPU_FTR_TM))
-		return;
-
-	/* Recheckpoint the registers of the thread we're about to switch to.
-	 *
-	 * If the task was using FP, we non-lazily reload both the original and
-	 * the speculative FP register states.  This is because the kernel
-	 * doesn't see if/when a TM rollback occurs, so if we take an FP
-	 * unavailable later, we are unable to determine which set of FP regs
-	 * need to be restored.
-	 */
-	if (!tm_enabled(new))
-		return;
-
-	if (!MSR_TM_ACTIVE(new->thread.regs->msr)){
-		tm_restore_sprs(&new->thread);
-		return;
-	}
-	/* Recheckpoint to restore original checkpointed register state. */
-	TM_DEBUG("*** tm_recheckpoint of pid %d (new->msr 0x%lx)\n",
-		 new->pid, new->thread.regs->msr);
-
-	tm_recheckpoint(&new->thread);
-
-	/*
-	 * The checkpointed state has been restored but the live state has
-	 * not, ensure all the math functionality is turned off to trigger
-	 * restore_math() to reload.
-	 */
-	new->thread.regs->msr &= ~(MSR_FP | MSR_VEC | MSR_VSX);
-
-	TM_DEBUG("*** tm_recheckpoint of pid %d complete "
-		 "(kernel msr 0x%lx)\n",
-		 new->pid, mfmsr());
+	task->thread.tm_texasr &= ~TEXASR_FC;
+	task->thread.tm_texasr |= (unsigned long) cause << TEXASR_FC_LG;
 }
 
 static inline void __switch_to_tm(struct task_struct *prev,
 		struct task_struct *new)
 {
-	if (cpu_has_feature(CPU_FTR_TM)) {
-		if (tm_enabled(prev) || tm_enabled(new))
-			tm_enable();
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return;
+
+	/* The task leaving the CPU was using TM, let's handle it */
+	if (tm_enabled(prev)) {
+		/*
+		 * Load_tm is incremented only when the task is scheduled out
+		 */
+		prev->thread.load_tm++;
+
+		/*
+		 * If TM is enabled for the thread, it needs to, at least,
+		 * save the SPRs
+		 */
+		tm_enable();
+		tm_save_sprs(&prev->thread);
+
+		/*
+		 * If the task being descheduled had an active transaction
+		 * during the exception that brought it here, the
+		 * transaction was reclaimed by TM_KERNEL_ENTRY.
+		 *
+		 * Independently of the TEXASR failure code set at
+		 * TM_KERNEL_ENTRY time, the task is being descheduled, and
+		 * the failure code needs to be updated to reflect it.
+		 */
+		if (MSR_TM_ACTIVE(prev->thread.regs->msr)) {
+			/*
+			 * If there was an IRQ during trecheckpoint, it will
+			 * cause an IRQ to be replayed. This replayed IRQ can
+			 * invoke SCHEDULE_USER, thus, we arrive here with a TM
+			 * active transaction.
+			 * I.e, the task was leaving kernelspace to userspace,
+			 * already trecheckpointed, but there was a IRQ during
+			 * the trecheckpoint process (soft irq disabled), and
+			 * on the IRQ replay, the process was de-scheduled, so,
+			 * SCHEDULE_USER was called and here we are.
+			 *
+			 */
+			if (WARN_ON(MSR_TM_ACTIVE(mfmsr())))
+				tm_reclaim_current(TM_CAUSE_RESCHED);
 
-		if (tm_enabled(prev)) {
-			prev->thread.load_tm++;
-			tm_reclaim_task(prev);
-			if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm == 0)
+			/*
+			 * If rescheduled with TM active, update the
+			 * failure cause
+			 */
+			tm_change_failure_cause(prev, TM_CAUSE_RESCHED);
+		} else {
+			/*
+			 * TM enabled but not transactional. Just disable TM
+			 * if load_tm overflows. This should be the only place
+			 * that disables the TM and reenables the laziness
+			 * save/restore
+			 */
+			if (prev->thread.load_tm == 0)
 				prev->thread.regs->msr &= ~MSR_TM;
 		}
+	}
 
-		tm_recheckpoint_new_task(new);
+	/*
+	 * It is a *bug* if we arrived so late with a transaction active
+	 * (more precisely suspended)
+	 */
+	if (WARN_ON(MSR_TM_ACTIVE(mfmsr()))) {
+		/* Recovery path. 0x99 shouldn't be exported to UAPI */
+		tm_reclaim_current(0x99);
+	}
+
+	/*
+	 * If the next task has TM enabled, restore the SPRs. Do not need to
+	 * care about recheckpoint at this time. It will be done later if
+	 * TIF_RESTORE_TM was set when the task was scheduled out
+	 */
+	if (tm_enabled(new)) {
+		tm_enable();
+		tm_restore_sprs(&new->thread);
 	}
 }
 
@@ -1094,7 +1084,6 @@ void restore_tm_state(struct pt_regs *regs)
 }
 
 #else
-#define tm_recheckpoint_new_task(new)
 #define __switch_to_tm(prev, new)
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
@@ -1599,9 +1588,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	/*
 	 * Flush TM state out so we can copy it.  __switch_to_tm() does this
 	 * flush but it removes the checkpointed state from the current CPU and
-	 * transitions the CPU out of TM mode.  Hence we need to call
-	 * tm_recheckpoint_new_task() (on the same task) to restore the
-	 * checkpointed state back and the TM mode.
+	 * transitions the CPU out of TM mode.  Hence we need to make sure
+	 * TIF_RESTORE_TM is set so restore_tm_state is called to restore the
+	 * checkpointed state and back to TM mode.
 	 *
 	 * Can't pass dst because it isn't ready. Doesn't matter, passing
 	 * dst is only important for __switch_to()
-- 
2.19.0

