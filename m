Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zX27B3v5lzDqs9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 12:08:37 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1114m32073787
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 20:08:35 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fup355qcd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 20:08:34 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Thu, 1 Feb 2018 01:08:32 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w1118TOc66322644
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Feb 2018 01:08:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C0EDAE053
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 00:59:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD307AE04D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 00:59:52 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 00:59:52 +0000 (GMT)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gromero@linux.vnet.ibm.com
Subject: [PATCH] powerpc/tm: Remove struct thread_info param from
 tm_reclaim_thread()
Date: Thu,  1 Feb 2018 12:07:46 +1100
Message-Id: <20180201010746.413-1-cyrilbur@gmail.com>
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

Just remove it and adjust the callers.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index bfdd783e3916..a47498da6562 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -853,8 +853,7 @@ static inline bool tm_enabled(struct task_struct *tsk)
 	return tsk && tsk->thread.regs && (tsk->thread.regs->msr & MSR_TM);
 }
 
-static void tm_reclaim_thread(struct thread_struct *thr,
-			      struct thread_info *ti, uint8_t cause)
+static void tm_reclaim_thread(struct thread_struct *thr, uint8_t cause)
 {
 	/*
 	 * Use the current MSR TM suspended bit to track if we have
@@ -901,7 +900,7 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 void tm_reclaim_current(uint8_t cause)
 {
 	tm_enable();
-	tm_reclaim_thread(&current->thread, current_thread_info(), cause);
+	tm_reclaim_thread(&current->thread, cause);
 }
 
 static inline void tm_reclaim_task(struct task_struct *tsk)
@@ -932,7 +931,7 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
 		 thr->regs->ccr, thr->regs->msr,
 		 thr->regs->trap);
 
-	tm_reclaim_thread(thr, task_thread_info(tsk), TM_CAUSE_RESCHED);
+	tm_reclaim_thread(thr, TM_CAUSE_RESCHED);
 
 	TM_DEBUG("--- tm_reclaim on pid %d complete\n",
 		 tsk->pid);
-- 
2.16.1
