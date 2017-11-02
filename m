Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yS96c5xRRzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 14:09:28 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA239I72071385
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Nov 2017 23:09:25 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dysq3chy9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 23:09:25 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Thu, 2 Nov 2017 03:09:23 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, leitao@debian.org, gromero@linux.vnet.ibm.com,
 andrew@aj.id.au, jk@ozlabs.org, sam@mendozajonas.com
Subject: [PATCH v3 1/4] powerpc: Don't enable FP/Altivec if not checkpointed
Date: Thu,  2 Nov 2017 14:09:03 +1100
Message-Id: <20171102030906.3061-1-cyrilbur@gmail.com>
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

Lazy save and restore of FP/Altivec cannot be done if a process is
transactional. If a facility was enabled it must remain enabled whenever
a thread is transactional.

Commit dc16b553c949 ("powerpc: Always restore FPU/VEC/VSX if hardware
transactional memory in use") ensures that the facilities are always
enabled if a thread is transactional. A bug in the introduced code may
cause it to inadvertently enable a facility that was (and should remain)
disabled. The problem with this extraneous enablement is that the
registers for the erroneously enabled facility have not been correctly
recheckpointed - the recheckpointing code assumed the facility would
remain disabled.

Further compounding the issue, the transactional {fp,altivec,vsx}
unavailable code has been incorrectly using the MSR to enable
facilities. The presence of the {FP,VEC,VSX} bit in the regs->msr simply
means if the registers are live on the CPU, not if the kernel should
load them before returning to userspace. This has worked due to the bug
mentioned above.

This causes transactional threads which return to their failure handler
to observe incorrect checkpointed registers. Perhaps an example will
help illustrate the problem:

A userspace process is running and uses both FP and Altivec registers.
This process then continues to run for some time without touching
either sets of registers. The kernel subsequently disables the
facilities as part of lazy save and restore. The userspace process then
performs a tbegin and the CPU checkpoints 'junk' FP and Altivec
registers. The process then performs a floating point instruction
triggering a fp unavailable exception in the kernel.

The kernel then loads the FP registers - and only the FP registers.
Since the thread is transactional it must perform a reclaim and
recheckpoint to ensure both the checkpointed registers and the
transactional registers are correct. It then (correctly) enables
MSR[FP] for the process. Later (on exception exist) the kernel also
(inadvertently) enables MSR[VEC]. The process is then returned to
userspace.

Since the act of loading the FP registers doomed the transaction we know
CPU will fail the transaction, restore its checkpointed registers, and
return the process to its failure handler. The problem is that we're
now running with Altivec enabled and the 'junk' checkpointed registers
are restored. The kernel had only recheckpointed FP.

This patch solves this by only activating FP/Altivec if userspace was
using them when it entered the kernel and not simply if the process is
transactional.

Fixes: dc16b553c949 ("powerpc: Always restore FPU/VEC/VSX if hardware
transactional memory in use")

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
V2: Rather than incorrectly using the MSR to enable {FP,VEC,VSX} use
the load_fp and load_vec booleans to help restore_math() make the
correct decision
V3: Put tm_active_with_{fp,altivec}() inside a #ifdef
CONFIG_PPC_TRANSACTIONAL_MEM 


 arch/powerpc/kernel/process.c | 18 ++++++++++++++++--
 arch/powerpc/kernel/traps.c   |  8 ++++----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a0c74bbf3454..cff887e67eb9 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -97,9 +97,23 @@ static inline bool msr_tm_active(unsigned long msr)
 {
 	return MSR_TM_ACTIVE(msr);
 }
+
+static bool tm_active_with_fp(struct task_struct *tsk)
+{
+	return msr_tm_active(tsk->thread.regs->msr) &&
+		(tsk->thread.ckpt_regs.msr & MSR_FP);
+}
+
+static bool tm_active_with_altivec(struct task_struct *tsk)
+{
+	return msr_tm_active(tsk->thread.regs->msr) &&
+		(tsk->thread.ckpt_regs.msr & MSR_VEC);
+}
 #else
 static inline bool msr_tm_active(unsigned long msr) { return false; }
 static inline void check_if_tm_restore_required(struct task_struct *tsk) { }
+static inline bool tm_active_with_fp(struct task_struct *tsk) { return false; }
+static inline bool tm_active_with_altivec(struct task_struct *tsk) { return false; }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 bool strict_msr_control;
@@ -232,7 +246,7 @@ EXPORT_SYMBOL(enable_kernel_fp);
 
 static int restore_fp(struct task_struct *tsk)
 {
-	if (tsk->thread.load_fp || msr_tm_active(tsk->thread.regs->msr)) {
+	if (tsk->thread.load_fp || tm_active_with_fp(tsk)) {
 		load_fp_state(&current->thread.fp_state);
 		current->thread.load_fp++;
 		return 1;
@@ -314,7 +328,7 @@ EXPORT_SYMBOL_GPL(flush_altivec_to_thread);
 static int restore_altivec(struct task_struct *tsk)
 {
 	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
-		(tsk->thread.load_vec || msr_tm_active(tsk->thread.regs->msr))) {
+		(tsk->thread.load_vec || tm_active_with_altivec(tsk))) {
 		load_vr_state(&tsk->thread.vr_state);
 		tsk->thread.used_vr = 1;
 		tsk->thread.load_vec++;
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 13c9dcdcba69..ef6a45969812 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1487,7 +1487,7 @@ void fp_unavailable_tm(struct pt_regs *regs)
 	/* Reclaim didn't save out any FPRs to transact_fprs. */
 
 	/* Enable FP for the task: */
-	regs->msr |= (MSR_FP | current->thread.fpexc_mode);
+	current->thread.load_fp = 1;
 
 	/* This loads and recheckpoints the FP registers from
 	 * thread.fpr[].  They will remain in registers after the
@@ -1516,7 +1516,7 @@ void altivec_unavailable_tm(struct pt_regs *regs)
 		 "MSR=%lx\n",
 		 regs->nip, regs->msr);
 	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
-	regs->msr |= MSR_VEC;
+	current->thread.load_vec = 1;
 	tm_recheckpoint(&current->thread, MSR_VEC);
 	current->thread.used_vr = 1;
 
@@ -1553,8 +1553,8 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 	/* This reclaims FP and/or VR regs if they're already enabled */
 	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
 
-	regs->msr |= MSR_VEC | MSR_FP | current->thread.fpexc_mode |
-		MSR_VSX;
+	current->thread.load_vec = 1;
+	current->thread.load_fp = 1;
 
 	/* This loads & recheckpoints FP and VRs; but we have
 	 * to be sure not to overwrite previously-valid state.
-- 
2.15.0
