Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429XFt6365zF3RF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 05:41:06 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CJYdo6052673
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:41:05 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mf603853k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:41:04 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 13:41:04 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, paulus@ozlabs.org, gromero@linux.vnet.ibm.com,
 mpe@ellerman.id.au, ldufour@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH 10/11] powerpc/tm: Set failure summary
Date: Wed, 12 Sep 2018 16:40:18 -0300
In-Reply-To: <1536781219-13938-1-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
Message-Id: <1536781219-13938-11-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the transaction will be doomed with treckpt., the TEXASR[FS]
should be set, to reflect that the transaction is a failure. This patch
ensures it before recheckpointing, and remove changes from other places
that were calling recheckpoint.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c   | 6 ++++++
 arch/powerpc/kernel/signal_32.c | 2 --
 arch/powerpc/kernel/signal_64.c | 2 --
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5cace1b744b1..77725b2e4dc1 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -937,6 +937,12 @@ void tm_recheckpoint(struct thread_struct *thread)
 	local_irq_save(flags);
 	hard_irq_disable();
 
+	/*
+	 * Make sure the failure summary is set, since the transaction will be
+	 * doomed.
+	 */
+	thread->tm_texasr |= TEXASR_FS;
+
 	/* The TM SPRs are restored here, so that TEXASR.FS can be set
 	 * before the trecheckpoint and no explosion occurs.
 	 */
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 4a1b17409bf3..96956d50538e 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -851,8 +851,6 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	/* Pull in the MSR TM bits from the user context */
 	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr_hi & MSR_TS_MASK);
 
-	/* Make sure the transaction is marked as failed */
-	current->thread.tm_texasr |= TEXASR_FS;
 	/* Make sure restore_tm_state will be called */
 	set_thread_flag(TIF_RESTORE_TM);
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 32402aa23a5e..c84501711b14 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -569,8 +569,6 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 		}
 	}
 #endif
-	/* Make sure the transaction is marked as failed */
-	tsk->thread.tm_texasr |= TEXASR_FS;
 	/* Guarantee that restore_tm_state() will be called */
 	set_thread_flag(TIF_RESTORE_TM);
 
-- 
2.19.0
