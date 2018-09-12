Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429XFJ5QRqzF3D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 05:40:36 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CJY17Y101610
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:34 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mf8mj1c7b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:34 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 13:40:33 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, paulus@ozlabs.org, gromero@linux.vnet.ibm.com,
 mpe@ellerman.id.au, ldufour@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH 02/11] powerpc/tm: Reclaim on unavailable exception
Date: Wed, 12 Sep 2018 16:40:10 -0300
In-Reply-To: <1536781219-13938-1-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
Message-Id: <1536781219-13938-3-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If there is a FP/VEC/Altivec touch inside a transaction and the facility is
disabled, then a facility unavailable exception is raised and ends up
calling {fp,vec,vsx}_unavailable_tm, which was reclaiming and recheckpointing.

This is not required anymore, since the checkpointed state was reclaimed in
the trap entrace itself, and it will be recheckpointed by restore_tm_state
later.

With this new patchset, we only reclaim at exception entrance (except at
syscall level if the transaction is suspended), and always recheckpoint on
restore_tm_state.

Adding a WARN_ON() warning if we hit the _unavailable_tm() in suspended
mode, i.e, the reclaim was not executed somehow in the trap entrance.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/exceptions-64s.S |  3 +++
 arch/powerpc/kernel/traps.c          | 16 ++++------------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 78aba71a4b2d..4108f3944bdd 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -874,6 +874,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
 	bl	save_nvgprs
+	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
 	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	fp_unavailable_tm
@@ -1216,6 +1217,7 @@ BEGIN_FTR_SECTION
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
 	bl	save_nvgprs
+	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
 	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	altivec_unavailable_tm
@@ -1252,6 +1254,7 @@ BEGIN_FTR_SECTION
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
 	bl	save_nvgprs
+	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
 	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	vsx_unavailable_tm
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index c85adb858271..b973fdb72826 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1749,19 +1749,12 @@ void fp_unavailable_tm(struct pt_regs *regs)
          * transaction, and probably retry but now with FP enabled.  So the
          * checkpointed FP registers need to be loaded.
 	 */
-	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
+	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
 	/* Reclaim didn't save out any FPRs to transact_fprs. */
 
 	/* Enable FP for the task: */
 	current->thread.load_fp = 1;
 
-	/* This loads and recheckpoints the FP registers from
-	 * thread.fpr[].  They will remain in registers after the
-	 * checkpoint so we don't need to reload them after.
-	 * If VMX is in use, the VRs now hold checkpointed values,
-	 * so we don't want to load the VRs from the thread_struct.
-	 */
-	tm_recheckpoint(&current->thread);
 }
 
 void altivec_unavailable_tm(struct pt_regs *regs)
@@ -1773,10 +1766,10 @@ void altivec_unavailable_tm(struct pt_regs *regs)
 	TM_DEBUG("Vector Unavailable trap whilst transactional at 0x%lx,"
 		 "MSR=%lx\n",
 		 regs->nip, regs->msr);
-	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
+	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
 	current->thread.load_vec = 1;
-	tm_recheckpoint(&current->thread);
 	current->thread.used_vr = 1;
+
 }
 
 void vsx_unavailable_tm(struct pt_regs *regs)
@@ -1795,12 +1788,11 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 	current->thread.used_vsr = 1;
 
 	/* This reclaims FP and/or VR regs if they're already enabled */
-	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
+	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
 
 	current->thread.load_vec = 1;
 	current->thread.load_fp = 1;
 
-	tm_recheckpoint(&current->thread);
 }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
-- 
2.19.0
