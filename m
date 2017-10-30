Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQNb80f9PzDqmt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 16:39:29 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9U5dQoO088940
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 01:39:27 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dwdxr9909-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 01:39:27 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Mon, 30 Oct 2017 05:39:19 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, leitao@debian.org, gromero@linux.vnet.ibm.com,
 andrew@aj.id.au, jk@ozlabs.org, sam@mendozajonas.com
Subject: [PATCH 1/2] powerpc: Don't enable FP/Altivec if not checkpointed
Date: Mon, 30 Oct 2017 16:39:12 +1100
Message-Id: <20171030053913.20455-1-cyrilbur@gmail.com>
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
disabled.  The problem with this extraneous enablement is that the
registers for the erroneously enabled facility have not been correctly
recheckpointed - the recheckpointing code assumed the facility would
remain disabled.

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
transactional registers are correct.  It then (correctly) enables
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
 arch/powerpc/kernel/process.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a0c74bbf3454..da900cd86324 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -230,9 +230,15 @@ void enable_kernel_fp(void)
 }
 EXPORT_SYMBOL(enable_kernel_fp);
 
+static int is_transactionally_fp(struct task_struct *tsk)
+{
+	return msr_tm_active(tsk->thread.regs->msr) &&
+		(tsk->thread.ckpt_regs.msr & MSR_FP);
+}
+
 static int restore_fp(struct task_struct *tsk)
 {
-	if (tsk->thread.load_fp || msr_tm_active(tsk->thread.regs->msr)) {
+	if (tsk->thread.load_fp || is_transactionally_fp(tsk)) {
 		load_fp_state(&current->thread.fp_state);
 		current->thread.load_fp++;
 		return 1;
@@ -311,10 +317,17 @@ void flush_altivec_to_thread(struct task_struct *tsk)
 }
 EXPORT_SYMBOL_GPL(flush_altivec_to_thread);
 
+static int is_transactionally_altivec(struct task_struct *tsk)
+{
+	return msr_tm_active(tsk->thread.regs->msr) &&
+		(tsk->thread.ckpt_regs.msr & MSR_VEC);
+}
+
+
 static int restore_altivec(struct task_struct *tsk)
 {
 	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
-		(tsk->thread.load_vec || msr_tm_active(tsk->thread.regs->msr))) {
+		(tsk->thread.load_vec || is_transactionally_altivec(tsk))) {
 		load_vr_state(&tsk->thread.vr_state);
 		tsk->thread.used_vr = 1;
 		tsk->thread.load_vec++;
-- 
2.14.3
