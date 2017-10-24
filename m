Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yM0Gs4bJyzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 04:13:40 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9OHDM7a060095
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 13:13:36 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dt8a2exv7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 13:13:34 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 24 Oct 2017 11:13:30 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <breno.leitao@debian.org>, Breno Leitao <leitao@debian.org>,
 Gustavo Romero <gusbromero@gmail.com>, Cyril Bur <cyrilbur@gmail.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [PATCH] powerpc/tm: Set ckpt_regs.msr before using it.
Date: Tue, 24 Oct 2017 15:13:05 -0200
Message-Id: <1508865185-11492-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Breno Leitao <breno.leitao@debian.org>

On commit commit f48e91e87e67 ("powerpc/tm: Fix FP and VMX register
corruption"), we check ckpt_regs.msr to see if a feature (as VEC, VSX
and FP) is disabled (thus the hot registers might be bogus during the
reclaim), and then copy the previously saved thread registers, with the
non-bogus values, into the checkpoint area for a later trecheckpoint.
This mechanism is used to recheckpoints the proper register values when
a transaction started using the bogus registers, and these values were
sent to the memory checkpoint area.

I see a problem on this code that ckpt_regs.msr is not properly set when
using it, as for example, when there is a vsx_unavailable_tm() in a code
like the following, the ckpt_regs.msg[FP] is 0;

 1: sleep_until_{fp,vec,vsx} = 0
 2: fadd
 3: tbegin.
 4: beq
 5: xxmrghd
 6: tend.

In this case, line 5 will raise an vsx_unavailable_tm() exception, and
the ckpt_regs.msr[FP] will be zero before memcpy() block, executing the
memcpy even with the the FP registers hot. That is not correct because
we executed a float point instruction on line 2, and MSR[FP] was set to
1.

Fortunately this does not cause a big problem as I can see, other than
this extra memcpy() because treclaim() will later overwrite this wrong
copied value, since it relies on the correct MSR value, which was
updated by giveup_all->check_if_tm_restore_required. There might be a
problem when laziness is being turned on, but I was not able to
reproduce it.

The solution I am proposing is updating ckpt_regs.msr before using it.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Romero <gusbromero@gmail.com>
CC: Cyril Bur <cyrilbur@gmail.com>
CC: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index c051dc2b42ad..773e9c5594e7 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -860,6 +860,9 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 	if (!MSR_TM_SUSPENDED(mfmsr()))
 		return;
 
+	/* Give up all the registers and set ckpt_regs.msr */
+	giveup_all(container_of(thr, struct task_struct, thread));
+
 	/*
 	 * If we are in a transaction and FP is off then we can't have
 	 * used FP inside that transaction. Hence the checkpointed
@@ -879,8 +882,6 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 		memcpy(&thr->ckvr_state, &thr->vr_state,
 		       sizeof(struct thread_vr_state));
 
-	giveup_all(container_of(thr, struct task_struct, thread));
-
 	tm_reclaim(thr, thr->ckpt_regs.msr, cause);
 }
 
-- 
2.14.2
