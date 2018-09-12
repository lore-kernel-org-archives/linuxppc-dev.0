Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429XFT4kdpzF3Rf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 05:40:45 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CJYbaj065552
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:43 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mf5djsrub-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:43 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 13:40:42 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, paulus@ozlabs.org, gromero@linux.vnet.ibm.com,
 mpe@ellerman.id.au, ldufour@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH 04/11] powerpc/tm: Always set TIF_RESTORE_TM on reclaim
Date: Wed, 12 Sep 2018 16:40:12 -0300
In-Reply-To: <1536781219-13938-1-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
Message-Id: <1536781219-13938-5-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the task data was reclaimed (through TM_KERNEL_ENTRY), then it needs to
be recheckpointed later, once exiting to userspace. The recheckpoint is
done by restore_tm_state() function, which is called on our way to
userspace if the task has the TIF_RESTORE_TM flag set.

This patch makes sure the task has TIF_RESTORE_TM tag set every time there
is a reclaim, so, a recheckpoint will be executed later.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index f22f82ce174c..54fddf03b97a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -891,6 +891,9 @@ static void tm_reclaim_thread(struct thread_struct *thr, uint8_t cause)
 
 	tm_reclaim(thr, cause);
 
+	/* Tag it so restore_tm_state will pay attention to this task */
+	set_thread_flag(TIF_RESTORE_TM);
+
 	/*
 	 * If we are in a transaction and FP is off then we can't have
 	 * used FP inside that transaction. Hence the checkpointed
-- 
2.19.0
