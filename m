Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418ml45ckWzF0ph
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 09:00:00 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5IMxVLb146400
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 18:59:58 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jpjdgyd5a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 18:59:58 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 18 Jun 2018 18:59:57 -0400
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Cyril Bur <cyrilbur@gmail.com>, Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 3/4] powerpc/tm: Adjust tm_reclaim_thread() parameters
Date: Mon, 18 Jun 2018 19:59:43 -0300
In-Reply-To: <1529362784-14194-1-git-send-email-leitao@debian.org>
References: <201806160346.lDndh49W%fengguang.wu@intel.com>
 <1529362784-14194-1-git-send-email-leitao@debian.org>
Message-Id: <1529362784-14194-3-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cyril Bur <cyrilbur@gmail.com>

tm_reclaim_thread() doesn't use the parameter anymore, both callers have
to bother getting it as they have no need for a struct thread_info
either.

It was previously used but became unused in commit
dc3106690b20 ("powerpc: tm: Always use fp_state and vr_state to store live
registers")

Just remove it and adjust the callers.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9ef4aea9fffe..f8beee03f00a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -866,8 +866,7 @@ static inline bool tm_enabled(struct task_struct *tsk)
 	return tsk && tsk->thread.regs && (tsk->thread.regs->msr & MSR_TM);
 }
 
-static void tm_reclaim_thread(struct thread_struct *thr,
-			      struct thread_info *ti, uint8_t cause)
+static void tm_reclaim_thread(struct thread_struct *thr, uint8_t cause)
 {
 	/*
 	 * Use the current MSR TM suspended bit to track if we have
@@ -914,7 +913,7 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 void tm_reclaim_current(uint8_t cause)
 {
 	tm_enable();
-	tm_reclaim_thread(&current->thread, current_thread_info(), cause);
+	tm_reclaim_thread(&current->thread, cause);
 }
 
 static inline void tm_reclaim_task(struct task_struct *tsk)
@@ -945,7 +944,7 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
 		 thr->regs->ccr, thr->regs->msr,
 		 thr->regs->trap);
 
-	tm_reclaim_thread(thr, task_thread_info(tsk), TM_CAUSE_RESCHED);
+	tm_reclaim_thread(thr, TM_CAUSE_RESCHED);
 
 	TM_DEBUG("--- tm_reclaim on pid %d complete\n",
 		 tsk->pid);
-- 
2.16.3
