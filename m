Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429XFh0NtKzF3MR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 05:40:55 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CJYPYi104845
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:53 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mf7btmhrr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:53 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 13:40:52 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, paulus@ozlabs.org, gromero@linux.vnet.ibm.com,
 mpe@ellerman.id.au, ldufour@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH 07/11] powerpc/tm: Do not recheckpoint at sigreturn
Date: Wed, 12 Sep 2018 16:40:15 -0300
In-Reply-To: <1536781219-13938-1-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
Message-Id: <1536781219-13938-8-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Do not recheckpoint at signal code return. Just make sure TIF_RESTORE_TM is
set, which will restore on the exit to userspace by restore_tm_state.

All the FP and VEC lazy restore was already done by tm_reclaim_current(),
where it checked if FP/VEC was set, and filled out the ckfp and ckvr
registers area to the expected value.

The current FP/VEC restoration is not necessary, since the transaction will
be aborted and the checkpointed values will be restore.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/signal_32.c | 23 +++--------------------
 arch/powerpc/kernel/signal_64.c | 15 ++-------------
 2 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index e6474a45cef5..4a1b17409bf3 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -850,28 +850,11 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 		return 1;
 	/* Pull in the MSR TM bits from the user context */
 	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr_hi & MSR_TS_MASK);
-	/* Now, recheckpoint.  This loads up all of the checkpointed (older)
-	 * registers, including FP and V[S]Rs.  After recheckpointing, the
-	 * transactional versions should be loaded.
-	 */
-	tm_enable();
+
 	/* Make sure the transaction is marked as failed */
 	current->thread.tm_texasr |= TEXASR_FS;
-	/* This loads the checkpointed FP/VEC state, if used */
-	tm_recheckpoint(&current->thread);
-
-	/* This loads the speculative FP/VEC state, if used */
-	msr_check_and_set(msr & (MSR_FP | MSR_VEC));
-	if (msr & MSR_FP) {
-		load_fp_state(&current->thread.fp_state);
-		regs->msr |= (MSR_FP | current->thread.fpexc_mode);
-	}
-#ifdef CONFIG_ALTIVEC
-	if (msr & MSR_VEC) {
-		load_vr_state(&current->thread.vr_state);
-		regs->msr |= MSR_VEC;
-	}
-#endif
+	/* Make sure restore_tm_state will be called */
+	set_thread_flag(TIF_RESTORE_TM);
 
 	return 0;
 }
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 83d51bf586c7..32402aa23a5e 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -569,21 +569,10 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 		}
 	}
 #endif
-	tm_enable();
 	/* Make sure the transaction is marked as failed */
 	tsk->thread.tm_texasr |= TEXASR_FS;
-	/* This loads the checkpointed FP/VEC state, if used */
-	tm_recheckpoint(&tsk->thread);
-
-	msr_check_and_set(msr & (MSR_FP | MSR_VEC));
-	if (msr & MSR_FP) {
-		load_fp_state(&tsk->thread.fp_state);
-		regs->msr |= (MSR_FP | tsk->thread.fpexc_mode);
-	}
-	if (msr & MSR_VEC) {
-		load_vr_state(&tsk->thread.vr_state);
-		regs->msr |= MSR_VEC;
-	}
+	/* Guarantee that restore_tm_state() will be called */
+	set_thread_flag(TIF_RESTORE_TM);
 
 	return err;
 }
-- 
2.19.0
