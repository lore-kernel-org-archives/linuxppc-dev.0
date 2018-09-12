Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429XFR0Qd0zF3Rp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 05:40:42 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CJYX5l134467
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:40 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mf5sp8awy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:40 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 13:40:39 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, paulus@ozlabs.org, gromero@linux.vnet.ibm.com,
 mpe@ellerman.id.au, ldufour@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH 03/11] powerpc/tm: Recheckpoint when exiting from kernel
Date: Wed, 12 Sep 2018 16:40:11 -0300
In-Reply-To: <1536781219-13938-1-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
Message-Id: <1536781219-13938-4-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the only place we are going to recheckpoint now. Now the task
needs to have TIF_RESTORE_TM flag set, which will get into
restore_tm_state() and execute the recheckpoint if MSR shows that the
transaction was active.

Every time a task is required to recheckpoint, or just have the TM SPRs
restore, the TIF_RESTORE_TM flag should be set and the task MSR should
properly be in a transactional state, which will be checked by
restore_tm_state().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 913c5725cdb2..f22f82ce174c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1069,6 +1069,10 @@ void restore_tm_state(struct pt_regs *regs)
 	if (!MSR_TM_ACTIVE(regs->msr))
 		return;
 
+	tm_enable();
+	/* The only place we recheckpoint */
+	tm_recheckpoint(&current->thread);
+
 	msr_diff = current->thread.ckpt_regs.msr & ~regs->msr;
 	msr_diff &= MSR_FP | MSR_VEC | MSR_VSX;
 
-- 
2.19.0
