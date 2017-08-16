Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXJdG5k4wzDrCv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 16:01:38 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] powerpc: Test MSR_FP and MSR_VEC when enabling/flushing
 VSX
Date: Wed, 16 Aug 2017 16:01:14 +1000
Message-Id: <20170816060118.24803-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VSX uses a combination of the old vector registers, the old FP registers
and new "second halves" of the FP registers.

Thus when we need to see the VSX state in the thread struct
(flush_vsx_to_thread) or when we'll use the VSX in the kernel
(enable_kernel_vsx) we need to ensure they are all flushed into
the thread struct if either of them is individually enabled.

Unfortunately we only tested if the whole VSX was enabled, not
if they were individually enabled.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9f3e2c932dcc..883216b4296a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -362,7 +362,8 @@ void enable_kernel_vsx(void)
 
 	cpumsr = msr_check_and_set(MSR_FP|MSR_VEC|MSR_VSX);
 
-	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX)) {
+	if (current->thread.regs &&
+	    (current->thread.regs->msr & (MSR_VSX|MSR_VEC|MSR_FP))) {
 		check_if_tm_restore_required(current);
 		/*
 		 * If a thread has already been reclaimed then the
@@ -386,7 +387,7 @@ void flush_vsx_to_thread(struct task_struct *tsk)
 {
 	if (tsk->thread.regs) {
 		preempt_disable();
-		if (tsk->thread.regs->msr & MSR_VSX) {
+		if (tsk->thread.regs->msr & (MSR_VSX|MSR_VEC|MSR_FP)) {
 			BUG_ON(tsk != current);
 			giveup_vsx(tsk);
 		}
-- 
2.13.4
