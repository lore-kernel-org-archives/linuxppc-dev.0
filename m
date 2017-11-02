Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yS96d458TzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 14:09:29 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA2399Gk010916
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Nov 2017 23:09:27 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dyqquaf99-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 23:09:27 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Thu, 2 Nov 2017 03:09:24 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, leitao@debian.org, gromero@linux.vnet.ibm.com,
 andrew@aj.id.au, jk@ozlabs.org, sam@mendozajonas.com
Subject: [PATCH v3 2/4] powerpc: Force reload for recheckpoint during tm {fp,
 vec, vsx} unavailable exception
Date: Thu,  2 Nov 2017 14:09:04 +1100
In-Reply-To: <20171102030906.3061-1-cyrilbur@gmail.com>
References: <20171102030906.3061-1-cyrilbur@gmail.com>
Message-Id: <20171102030906.3061-2-cyrilbur@gmail.com>
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

This patch is a minimal fix for ease of backporting. A more correct fix
which removes the msr parameter to tm_reclaim() and tm_recheckpoint()
altogether has been upstreamed to apply on top of this patch.

Fixes: dc3106690b20 ("powerpc: tm: Always use fp_state and vr_state to
store live registers")

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
V2: Add this patch for ease of backporting the same fix as the next
patch.
V3: No change

 arch/powerpc/kernel/process.c |  4 ++--
 arch/powerpc/kernel/traps.c   | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index cff887e67eb9..bf651f2fd3bd 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -867,6 +867,8 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 	if (!MSR_TM_SUSPENDED(mfmsr()))
 		return;
 
+	giveup_all(container_of(thr, struct task_struct, thread));
+
 	/*
 	 * If we are in a transaction and FP is off then we can't have
 	 * used FP inside that transaction. Hence the checkpointed
@@ -886,8 +888,6 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 		memcpy(&thr->ckvr_state, &thr->vr_state,
 		       sizeof(struct thread_vr_state));
 
-	giveup_all(container_of(thr, struct task_struct, thread));
-
 	tm_reclaim(thr, thr->ckpt_regs.msr, cause);
 }
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ef6a45969812..a7d42c89a257 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1471,6 +1471,12 @@ void facility_unavailable_exception(struct pt_regs *regs)
 
 void fp_unavailable_tm(struct pt_regs *regs)
 {
+	/*
+	 * Save the MSR now because tm_reclaim_current() is likely to
+	 * change it
+	 */
+	unsigned long orig_msr = regs->msr;
+
 	/* Note:  This does not handle any kind of FP laziness. */
 
 	TM_DEBUG("FP Unavailable trap whilst transactional at 0x%lx, MSR=%lx\n",
@@ -1495,10 +1501,10 @@ void fp_unavailable_tm(struct pt_regs *regs)
 	 * If VMX is in use, the VRs now hold checkpointed values,
 	 * so we don't want to load the VRs from the thread_struct.
 	 */
-	tm_recheckpoint(&current->thread, MSR_FP);
+	tm_recheckpoint(&current->thread, orig_msr | MSR_FP);
 
 	/* If VMX is in use, get the transactional values back */
-	if (regs->msr & MSR_VEC) {
+	if (orig_msr & MSR_VEC) {
 		msr_check_and_set(MSR_VEC);
 		load_vr_state(&current->thread.vr_state);
 		/* At this point all the VSX state is loaded, so enable it */
@@ -1508,6 +1514,12 @@ void fp_unavailable_tm(struct pt_regs *regs)
 
 void altivec_unavailable_tm(struct pt_regs *regs)
 {
+	/*
+	 * Save the MSR now because tm_reclaim_current() is likely to
+	 * change it
+	 */
+	unsigned long orig_msr = regs->msr;
+
 	/* See the comments in fp_unavailable_tm().  This function operates
 	 * the same way.
 	 */
@@ -1517,10 +1529,10 @@ void altivec_unavailable_tm(struct pt_regs *regs)
 		 regs->nip, regs->msr);
 	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
 	current->thread.load_vec = 1;
-	tm_recheckpoint(&current->thread, MSR_VEC);
+	tm_recheckpoint(&current->thread, orig_msr | MSR_VEC);
 	current->thread.used_vr = 1;
 
-	if (regs->msr & MSR_FP) {
+	if (orig_msr & MSR_FP) {
 		msr_check_and_set(MSR_FP);
 		load_fp_state(&current->thread.fp_state);
 		regs->msr |= MSR_VSX;
@@ -1559,7 +1571,7 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 	/* This loads & recheckpoints FP and VRs; but we have
 	 * to be sure not to overwrite previously-valid state.
 	 */
-	tm_recheckpoint(&current->thread, regs->msr & ~orig_msr);
+	tm_recheckpoint(&current->thread, orig_msr | MSR_FP | MSR_VEC);
 
 	msr_check_and_set(orig_msr & (MSR_FP | MSR_VEC));
 
-- 
2.15.0
