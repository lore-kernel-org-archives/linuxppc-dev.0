Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSmZC2mXRzDrqF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:39 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85Ngwff121215
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:45:37 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259ckqu2v1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 19:45:37 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 6 Sep 2016 09:45:34 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3AA4C2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:31 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85NjVx651839046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:31 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85NjU7B024797
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:31 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: wei.guo.simon@gmail.com, mikey@neuling.org
Subject: [PATCH v4 03/20] powerpc: Add check_if_tm_restore_required() to
 giveup_all()
Date: Tue,  6 Sep 2016 09:44:31 +1000
In-Reply-To: <20160905234448.5866-1-cyrilbur@gmail.com>
References: <20160905234448.5866-1-cyrilbur@gmail.com>
Message-Id: <20160905234448.5866-4-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

giveup_all() causes FPU/VMX/VSX facilities to be disabled in a threads
MSR. If the thread performing the giveup was transactional, the kernel
must record which facilities were in use before the giveup as the
thread must have these facilities re-enabled on return to userspace.

>From process.c:
 /*
  * This is called if we are on the way out to userspace and the
  * TIF_RESTORE_TM flag is set.  It checks if we need to reload
  * FP and/or vector state and does so if necessary.
  * If userspace is inside a transaction (whether active or
  * suspended) and FP/VMX/VSX instructions have ever been enabled
  * inside that transaction, then we have to keep them enabled
  * and keep the FP/VMX/VSX state loaded while ever the transaction
  * continues.  The reason is that if we didn't, and subsequently
  * got a FP/VMX/VSX unavailable interrupt inside a transaction,
  * we don't know whether it's the same transaction, and thus we
  * don't know which of the checkpointed state and the transactional
  * state to use.
  */

Calling check_if_tm_restore_required() will set TIF_RESTORE_TM and
save the MSR if needed.

Fixes: c208505 ("powerpc: create giveup_all()")
Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index cdf2d20..82308fd 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -445,6 +445,7 @@ void giveup_all(struct task_struct *tsk)
 		return;
 
 	msr_check_and_set(msr_all_available);
+	check_if_tm_restore_required(tsk);
 
 #ifdef CONFIG_PPC_FPU
 	if (usermsr & MSR_FP)
-- 
2.9.3
