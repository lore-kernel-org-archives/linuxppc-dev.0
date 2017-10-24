Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yM2db1YpTzDql4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 06:00:02 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9OIxw6v070513
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 15:00:00 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dtayc98mt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 14:59:59 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 24 Oct 2017 12:59:17 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>, Gustavo Romero <gusbromero@gmail.com>
Subject: [PATCH] powerpc/tm: Make the tm code more readable
Date: Tue, 24 Oct 2017 16:58:59 -0200
Message-Id: <1508871539-26146-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As discussed in the mailing list, renaming tm_disabled global variable
since it has nothing to do with concept we have been using in
tm_enable() and tm_enabled() functions. This will avoid a possible
confusion that tm_enable() would change tm_disable variable.

I am also taking the opportunity to change some comments that still
reference old fields that were changed in commit 000ec280e3dd ("powerpc:
tm: Rename transct_(*) to ck(\1)_state").

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Romero <gusbromero@gmail.com>
---
 arch/powerpc/kernel/prom.c  | 6 +++---
 arch/powerpc/kernel/tm.S    | 8 ++++----
 arch/powerpc/kernel/traps.c | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 101822be525a..654734d2f412 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -660,7 +660,7 @@ static void __init early_reserve_mem(void)
 }
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-static bool tm_disabled __initdata;
+static bool tm_cmdline_disabled __initdata;
 
 static int __init parse_ppc_tm(char *str)
 {
@@ -669,7 +669,7 @@ static int __init parse_ppc_tm(char *str)
 	if (kstrtobool(str, &res))
 		return -EINVAL;
 
-	tm_disabled = !res;
+	tm_cmdline_disabled = !res;
 
 	return 0;
 }
@@ -677,7 +677,7 @@ early_param("ppc_tm", parse_ppc_tm);
 
 static void __init tm_init(void)
 {
-	if (tm_disabled) {
+	if (tm_cmdline_disabled) {
 		pr_info("Disabling hardware transactional memory (HTM)\n");
 		cur_cpu_spec->cpu_user_features2 &=
 			~(PPC_FEATURE2_HTM_NOSC | PPC_FEATURE2_HTM);
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index c4ba37822ba0..65aac4e97ffd 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -83,10 +83,10 @@ _GLOBAL(tm_abort)
  *		   uint8_t cause)
  *
  *	- Performs a full reclaim.  This destroys outstanding
- *	  transactions and updates thread->regs.tm_ckpt_* with the
+ *	  transactions and updates thread->regs.ckpt_regs with the
  *	  original checkpointed state.  Note that thread->regs is
  *	  unchanged.
- *	- FP regs are written back to thread->transact_fpr before
+ *	- FP regs are written back to thread->ckfp_state before
  *	  reclaiming.  These are the transactional (current) versions.
  *
  * Purpose is to both abort transactions of, and preserve the state of,
@@ -258,7 +258,7 @@ _GLOBAL(tm_reclaim)
 	beq	dont_backup_vec
 
 	addi	r7, r3, THREAD_CKVRSTATE
-	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 transact vr state */
+	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 ckvr_state */
 	mfvscr	v0
 	li	r6, VRSTATE_VSCR
 	stvx	v0, r7, r6
@@ -270,7 +270,7 @@ dont_backup_vec:
 	beq	dont_backup_fp
 
 	addi	r7, r3, THREAD_CKFPSTATE
-	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 transact fp state */
+	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 ckfp_state */
 
 	mffs    fr0
 	stfd    fr0,FPSTATE_FPSCR(r7)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 9ae1924c7d1a..0de9b181a490 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1681,13 +1681,13 @@ void fp_unavailable_tm(struct pt_regs *regs)
          * checkpointed FP registers need to be loaded.
 	 */
 	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
-	/* Reclaim didn't save out any FPRs to transact_fprs. */
+	/* Reclaim didn't save out any FPRs to ckfp_state. */
 
 	/* Enable FP for the task: */
 	regs->msr |= (MSR_FP | current->thread.fpexc_mode);
 
 	/* This loads and recheckpoints the FP registers from
-	 * thread.fpr[].  They will remain in registers after the
+	 * thread.ckfp_state[].  They will remain in registers after the
 	 * checkpoint so we don't need to reload them after.
 	 * If VMX is in use, the VRs now hold checkpointed values,
 	 * so we don't want to load the VRs from the thread_struct.
-- 
2.14.2
