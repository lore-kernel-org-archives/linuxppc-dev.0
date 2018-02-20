Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlhCt55cXzDrbP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 11:23:06 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1K0LYof045710
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:04 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g88ybg7n7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:04 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 20 Feb 2018 00:23:02 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 11/12] [WIP] powerpc/tm: Afterthoughts
Date: Tue, 20 Feb 2018 11:22:40 +1100
In-Reply-To: <20180220002241.29648-1-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
Message-Id: <20180220002241.29648-12-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/kernel/process.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 674f75c56172..6ce41ee62b24 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1079,6 +1079,12 @@ static inline void __switch_to_tm(struct task_struct *prev,
 		if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm == 0)
 			prev->thread.regs->msr &= ~MSR_TM;
 	}
+
+	/*
+	 * Now that we're reclaiming on kernel entry, we should never
+	 * get here still with user checkpointed state on the CPU
+	 */
+	BUG_ON(MSR_TM_ACTIVE(mfmsr()));
 }
 
 /*
@@ -1326,7 +1332,17 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	}
 
 	if (current_thread_info()->task->thread.regs) {
-		restore_math(current_thread_info()->task->thread.regs);
+		/*
+		 * Calling this now has reloaded the live state, which
+		 * gets overwritten with the checkpointed state right
+		 * before the trecheckpoint. BUT the MSR still has
+		 * that the live state is on the CPU, which it isn't.
+		 *
+		 * restore_math(current_thread_info()->task->thread.regs);
+		 * Therefore:
+		 */
+		if (!MSR_TM_ACTIVE(current_thread_info()->task->thread.regs->msr))
+			restore_math(current_thread_info()->task->thread.regs);
 
 		/*
 		 * The copy-paste buffer can only store into foreign real
-- 
2.16.2
