Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429XFl1bLSzF3RD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 05:40:59 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CJYYXS134497
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:57 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mf5sp8b63-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:57 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 13:40:56 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, paulus@ozlabs.org, gromero@linux.vnet.ibm.com,
 mpe@ellerman.id.au, ldufour@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH 08/11] powerpc/tm: Do not reclaim on ptrace
Date: Wed, 12 Sep 2018 16:40:16 -0300
In-Reply-To: <1536781219-13938-1-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
Message-Id: <1536781219-13938-9-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure that we are not suspended on ptrace and that the registers were
already reclaimed.

Since the data was already reclaimed, there is nothing to be done here
except to restore the SPRs.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/ptrace.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 9667666eb18e..cf6ee9154b11 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -136,12 +136,10 @@ static void flush_tmregs_to_thread(struct task_struct *tsk)
 	if ((!cpu_has_feature(CPU_FTR_TM)) || (tsk != current))
 		return;
 
-	if (MSR_TM_SUSPENDED(mfmsr())) {
-		tm_reclaim_current(TM_CAUSE_SIGNAL);
-	} else {
-		tm_enable();
-		tm_save_sprs(&(tsk->thread));
-	}
+	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
+
+	tm_enable();
+	tm_save_sprs(&(tsk->thread));
 }
 #else
 static inline void flush_tmregs_to_thread(struct task_struct *tsk) { }
-- 
2.19.0
