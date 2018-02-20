Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlhCt4JGKzDrVm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 11:23:06 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1K0Mqi6068394
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:04 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g82m8n656-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:03 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 20 Feb 2018 00:23:01 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 01/12] powerpc/tm: Remove struct thread_info param from
 tm_reclaim_thread()
Date: Tue, 20 Feb 2018 11:22:30 +1100
In-Reply-To: <20180220002241.29648-1-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
Message-Id: <20180220002241.29648-2-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tm_reclaim_thread() doesn't use the parameter anymore, both callers have
to bother getting it as they have no need for a struct thread_info
either.

It was previously used but became unused in dc3106690b20 ("powerpc: tm:
Always use fp_state and vr_state to store live registers")

Just remove it and adjust the callers.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1738c4127b32..77dc6d8288eb 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -850,8 +850,7 @@ static inline bool tm_enabled(struct task_struct *tsk)
 	return tsk && tsk->thread.regs && (tsk->thread.regs->msr & MSR_TM);
 }
 
-static void tm_reclaim_thread(struct thread_struct *thr,
-			      struct thread_info *ti, uint8_t cause)
+static void tm_reclaim_thread(struct thread_struct *thr, uint8_t cause)
 {
 	/*
 	 * Use the current MSR TM suspended bit to track if we have
@@ -898,7 +897,7 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 void tm_reclaim_current(uint8_t cause)
 {
 	tm_enable();
-	tm_reclaim_thread(&current->thread, current_thread_info(), cause);
+	tm_reclaim_thread(&current->thread, cause);
 }
 
 static inline void tm_reclaim_task(struct task_struct *tsk)
@@ -929,7 +928,7 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
 		 thr->regs->ccr, thr->regs->msr,
 		 thr->regs->trap);
 
-	tm_reclaim_thread(thr, task_thread_info(tsk), TM_CAUSE_RESCHED);
+	tm_reclaim_thread(thr, TM_CAUSE_RESCHED);
 
 	TM_DEBUG("--- tm_reclaim on pid %d complete\n",
 		 tsk->pid);
-- 
2.16.2
