Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wLv1s50jnzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 May 2017 17:16:33 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, cyrilbur@gmail.com,
 Breno Leitao <brenohl@br.ibm.com>,
 Gustavo Bueno Romero <gromero@br.ibm.com>
Subject: [PATCH 1/2] powerpc/tm: Fix FP and VMX register corruption
Date: Mon,  8 May 2017 17:16:26 +1000
Message-Id: <20170508071627.21851-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In this commit:
  commit dc3106690b20305c3df06b42456fe386dd632ac9
  Author: Cyril Bur <cyrilbur@gmail.com>
  powerpc: tm: Always use fp_state and vr_state to store live registers

A section of code was removed that copied the current state to
checkpointed state.  This should not have been removed.

When an FP unavailable is taken inside a transaction, we need to abort
the transaction. This is because at the time of the tbegin, the FP
state is bogus so the state stored in the checkpointed registers is
incorrect. To fix this, we treclaim (to get the checkpointed GPRs) and
then copy the thread_struct FP live state into the checkpointed
state. We then trecheckpoint so that the FP state is correctly
restored into the CPU.

The coping of the FP registers from live to checkpointed is what was
missing.

This simplifies the logic slightly from the original patch.
tm_reclaim_thread() will now always write the checkpointed FP
state. Either the checkpointed FP statte will be written as part of
the actual treclaim (in tm.S), or it'll be a copy of the live
state. Which one we use is based on MSR[FP] from userspace.

Similarly for VMX.

CC: <stable@vger.kernel.org> # 4.9+
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/process.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d645da302b..6305353237 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -864,6 +864,25 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 	if (!MSR_TM_SUSPENDED(mfmsr()))
 		return;
 
+	/*
+	 * If we are in a transaction and FP is off then we can't have
+	 * used FP inside that transaction. Hence the checkpointed
+	 * state is the same as the live state. We need to copy the
+	 * live state to the checkpointed state so that when the
+	 * transaction is restored, the checkpointed state is correct
+	 * and the aborted transaction sees the correct state.  We use
+	 * ckpt_regs.msr here as that's what tm_reclaim will use to
+	 * determine if it's going to write the checkpointed state or
+	 * not. So either this will write the checkpointed registers,
+	 * or reclaim will.  Similarly for VMX.
+	 */
+	if ((thr->ckpt_regs.msr & MSR_FP) == 0)
+		memcpy(&thr->ckfp_state, &thr->fp_state,
+		       sizeof(struct thread_fp_state));
+	if ((thr->ckpt_regs.msr & MSR_VEC) == 0)
+		memcpy(&thr->ckvr_state, &thr->vr_state,
+		       sizeof(struct thread_vr_state));
+
 	giveup_all(container_of(thr, struct task_struct, thread));
 
 	tm_reclaim(thr, thr->ckpt_regs.msr, cause);
-- 
2.11.0
