Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlhCt61FMzDrF6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 11:23:06 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1K0Iwp5059623
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:04 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g82m8n65p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:04 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 20 Feb 2018 00:23:02 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 08/12] [WIP] powerpc/tm: Fix *unavailable_tm exceptions
Date: Tue, 20 Feb 2018 11:22:37 +1100
In-Reply-To: <20180220002241.29648-1-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
Message-Id: <20180220002241.29648-9-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/kernel/process.c | 11 ++++++++++-
 arch/powerpc/kernel/traps.c   |  3 ---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 574b05fe7d66..8a32fd062a2b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -500,11 +500,20 @@ void giveup_all(struct task_struct *tsk)
 
 	usermsr = tsk->thread.regs->msr;
 
+	/*
+	 * The *_unavailable_tm() functions might call this in a
+	 * transaction but with not FP or VEC or VSX meaning that the
+	 * if condition below will be true, this is bad since we will
+	 * have preformed a reclaim but not set the TIF flag which
+	 * must be set in order to trigger the recheckpoint.
+	 *
+	 * possibleTODO: Move setting the TIF flag into reclaim code
+	 */
+	check_if_tm_restore_required(tsk);
 	if ((usermsr & msr_all_available) == 0)
 		return;
 
 	msr_check_and_set(msr_all_available);
-	check_if_tm_restore_required(tsk);
 
 	WARN_ON((usermsr & MSR_VSX) && !((usermsr & MSR_FP) && (usermsr & MSR_VEC)));
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1e48d157196a..dccfcaf4f603 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1728,7 +1728,6 @@ void fp_unavailable_tm(struct pt_regs *regs)
 	 * If VMX is in use, the VRs now hold checkpointed values,
 	 * so we don't want to load the VRs from the thread_struct.
 	 */
-	tm_recheckpoint(&current->thread);
 }
 
 void altivec_unavailable_tm(struct pt_regs *regs)
@@ -1742,7 +1741,6 @@ void altivec_unavailable_tm(struct pt_regs *regs)
 		 regs->nip, regs->msr);
 	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
 	current->thread.load_vec = 1;
-	tm_recheckpoint(&current->thread);
 	current->thread.used_vr = 1;
 }
 
@@ -1767,7 +1765,6 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 	current->thread.load_vec = 1;
 	current->thread.load_fp = 1;
 
-	tm_recheckpoint(&current->thread);
 }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
-- 
2.16.2
