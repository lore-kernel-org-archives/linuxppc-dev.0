Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s13sK0CzszDrPy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 19:51:32 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6T9n4Nj075492
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 05:51:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24fdrrffhc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 05:51:30 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 29 Jul 2016 10:51:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0F8BA1B08077
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 10:52:53 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6T9pOsT65077454
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 09:51:24 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6T9pOKO012858
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 03:51:24 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Simon Guo <wei.guo.simon@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH] ppc64: allow ptrace to set TM bits
Date: Fri, 29 Jul 2016 11:51:22 +0200
Message-Id: <1469785882-9892-1-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch allows the MSR bits relative to the Transactional memory
state to be manipulated through the ptrace API.

However, in the case the TM available bit is not set in the
manipulated MSR, the changes are ignored.

When dealing with the checkpointed MSR, we must be sure that the TM
state bits will not be set since the checkpointed state can't be a
transactional one.

This patch is a follow up of the Anshuman's series pushed by Simon
Guo recently, titled "Add new powerpc specific ELF core notes" :
https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-July/146711.html

Cc: Simon Guo <wei.guo.simon@gmail.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 1d8998bd6321..e2c16eb0cabe 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -161,8 +161,12 @@ const char *regs_query_register_name(unsigned int offset)
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 #define MSR_DEBUGCHANGE	0
 #else
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+#define MSR_DEBUGCHANGE	(MSR_TS_MASK | MSR_SE | MSR_BE)
+#else
 #define MSR_DEBUGCHANGE	(MSR_SE | MSR_BE)
 #endif
+#endif
 
 /*
  * Max register writeable via put_reg
@@ -180,6 +184,12 @@ static unsigned long get_user_msr(struct task_struct *task)
 
 static int set_user_msr(struct task_struct *task, unsigned long msr)
 {
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (!(task->thread.regs->msr & MSR_TM)) {
+		/* If TM is not available, discard TM bits changes */
+		msr &= ~(MSR_TM | MSR_TS_MASK);
+	}
+#endif
 	task->thread.regs->msr &= ~MSR_DEBUGCHANGE;
 	task->thread.regs->msr |= msr & MSR_DEBUGCHANGE;
 	return 0;
@@ -193,6 +203,7 @@ static unsigned long get_user_ckpt_msr(struct task_struct *task)
 
 static int set_user_ckpt_msr(struct task_struct *task, unsigned long msr)
 {
+	msr &= ~MSR_TS_MASK; /* Checkpoint state can't be in transaction */
 	task->thread.ckpt_regs.msr &= ~MSR_DEBUGCHANGE;
 	task->thread.ckpt_regs.msr |= msr & MSR_DEBUGCHANGE;
 	return 0;
-- 
2.7.4
