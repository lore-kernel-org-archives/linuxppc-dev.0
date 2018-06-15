Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416nqr6cZ4zDrcd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2018 03:42:16 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5FHcuet028291
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 13:42:14 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jmh2nt8aj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 13:42:13 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Fri, 15 Jun 2018 13:42:13 -0400
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH 2/3] powerpc/tm: Fix HTM documentation
Date: Fri, 15 Jun 2018 14:42:01 -0300
In-Reply-To: <1529084262-16372-1-git-send-email-leitao@debian.org>
References: <1529084262-16372-1-git-send-email-leitao@debian.org>
Message-Id: <1529084522-17034-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch simply fix part of the documentation on the HTM code.

This fixes reference to old fields that were renamed in commit
000ec280e3dd ("powerpc: tm: Rename transct_(*) to ck(\1)_state").

It also documents better the flow after commit eb5c3f1c8647 ("powerpc:
Always save/restore checkpointed regs during treclaim/trecheckpoint"),
where tm_recheckpoint can recheckpoint what is in ck{fp,vr}_state blindly.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/tm.S    | 10 +++++-----
 arch/powerpc/kernel/traps.c | 15 +++++++++------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index ff12f47a96b6..019d73053cd3 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -95,9 +95,9 @@ EXPORT_SYMBOL_GPL(tm_abort);
  *		   uint8_t cause)
  *
  *	- Performs a full reclaim.  This destroys outstanding
- *	  transactions and updates thread->regs.tm_ckpt_* with the
- *	  original checkpointed state.  Note that thread->regs is
- *	  unchanged.
+ *	  transactions and updates thread.ckpt_regs, thread.ckfp_state and
+ *	  thread.ckvr_state with the original checkpointed state.  Note that
+ *	  thread->regs is unchanged.
  *
  * Purpose is to both abort transactions of, and preserve the state of,
  * a transactions at a context switch. We preserve/restore both sets of process
@@ -260,7 +260,7 @@ _GLOBAL(tm_reclaim)
 
 	/* Altivec (VEC/VMX/VR)*/
 	addi	r7, r3, THREAD_CKVRSTATE
-	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 transact vr state */
+	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 ckvr_state */
 	mfvscr	v0
 	li	r6, VRSTATE_VSCR
 	stvx	v0, r7, r6
@@ -271,7 +271,7 @@ _GLOBAL(tm_reclaim)
 
 	/* Floating Point (FP) */
 	addi	r7, r3, THREAD_CKFPSTATE
-	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 transact fp state */
+	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 ckfp_state */
 	mffs    fr0
 	stfd    fr0,FPSTATE_FPSCR(r7)
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0e17dcb48720..6742b6b3eb37 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1719,16 +1719,19 @@ void fp_unavailable_tm(struct pt_regs *regs)
          * checkpointed FP registers need to be loaded.
 	 */
 	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
-	/* Reclaim didn't save out any FPRs to transact_fprs. */
+
+	/* Reclaim initially saved out bogus (lazy) FPRs to ckfp_state, and
+	 * then it was overwrite by the thr->fp_state by tm_reclaim_thread().
+	 *
+	 * At this point, ck{fp,vr}_state contains the exact values we want to
+	 * recheckpoint.
+	 */
 
 	/* Enable FP for the task: */
 	current->thread.load_fp = 1;
 
-	/* This loads and recheckpoints the FP registers from
-	 * thread.fpr[].  They will remain in registers after the
-	 * checkpoint so we don't need to reload them after.
-	 * If VMX is in use, the VRs now hold checkpointed values,
-	 * so we don't want to load the VRs from the thread_struct.
+	/*
+	 * Recheckpoint all the checkpointed ckpt, ck{fp, vr}_state registers.
 	 */
 	tm_recheckpoint(&current->thread);
 }
-- 
2.16.3
