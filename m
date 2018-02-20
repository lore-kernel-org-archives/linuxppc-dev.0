Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlhCs07N8zDrVm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 11:23:04 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1K0IiTo082204
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:02 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g82scnesc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:01 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 20 Feb 2018 00:23:00 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 06/12] [WIP] powerpc/tm: Remove dead code from
 __switch_to_tm()
Date: Tue, 20 Feb 2018 11:22:35 +1100
In-Reply-To: <20180220002241.29648-1-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
Message-Id: <20180220002241.29648-7-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/kernel/process.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ea75da0fd506..574b05fe7d66 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1027,27 +1027,13 @@ static inline void __switch_to_tm(struct task_struct *prev,
 		struct task_struct *new)
 {
 	/*
-	 * So, with the rework none of this code should not be needed.
-	 * I've left in the reclaim for now. This *should* save us
-	 * from any mistake in the new code. Also the
-	 * enabling/disabling logic of MSR_TM really should be
+	 * The enabling/disabling logic of MSR_TM really should be
 	 * refactored into a common way with MSR_{FP,VEC,VSX}
 	 */
-	if (cpu_has_feature(CPU_FTR_TM)) {
-		if (tm_enabled(prev) || tm_enabled(new))
-			tm_enable();
-
-		if (tm_enabled(prev)) {
-			prev->thread.load_tm++;
-			tm_reclaim_task(prev);
-			/*
-			 * The disabling logic may be confused don't
-			 * disable for now
-			 *
-			 * if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm == 0)
-			 *	prev->thread.regs->msr &= ~MSR_TM;
-			 */
-		}
+	if (cpu_has_feature(CPU_FTR_TM) && tm_enabled(prev)) {
+		prev->thread.load_tm++;
+		if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm == 0)
+			prev->thread.regs->msr &= ~MSR_TM;
 	}
 }
 
-- 
2.16.2
