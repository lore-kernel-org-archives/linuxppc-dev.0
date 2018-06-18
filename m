Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418ml84wZkzF0tr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 09:00:04 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5IMxXdh006089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 19:00:01 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jpfyvn9th-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 19:00:00 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 18 Jun 2018 18:59:59 -0400
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 4/4] powerpc/tm: Do not recheckpoint non-tm task
Date: Mon, 18 Jun 2018 19:59:44 -0300
In-Reply-To: <1529362784-14194-1-git-send-email-leitao@debian.org>
References: <201806160346.lDndh49W%fengguang.wu@intel.com>
 <1529362784-14194-1-git-send-email-leitao@debian.org>
Message-Id: <1529362784-14194-4-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If __switch_to() tries to context switch from task A to task B, and task A
 had task->thread->regs->msr[TM] enabled, then __switch_to_tm() will call
tm_recheckpoint_new_task(), which will call trecheckpoint, for task B, which
 is clearly wrong since task B might not be an active TM user.

This does not cause a lot of damage because tm_recheckpoint() will abort
the call since it realize that the current task does not have msr[TM] bit
set.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index f8beee03f00a..d26a150766ef 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1036,7 +1036,8 @@ static inline void __switch_to_tm(struct task_struct *prev,
 				prev->thread.regs->msr &= ~MSR_TM;
 		}
 
-		tm_recheckpoint_new_task(new);
+		if (tm_enabled(new))
+			tm_recheckpoint_new_task(new);
 	}
 }
 
-- 
2.16.3
