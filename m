Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qqZY0SklzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 19:08:49 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4M98jNJ040072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 05:08:47 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4g580fwn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 05:08:46 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 22 May 2018 05:08:33 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] powerpc/kprobes: Fix build error with kprobes disabled.
Date: Tue, 22 May 2018 14:38:20 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180522090820.3307-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/kernel/stacktrace.c: In function ‘save_stack_trace_tsk_reliable’:
arch/powerpc/kernel/stacktrace.c:176:28: error: ‘kretprobe_trampoline’ undeclared (first use in this function); did you mean ‘is_ftrace_trampoline’?
   if (ip == (unsigned long)kretprobe_trampoline)
                            ^~~~~~~~~~~~~~~~~~~~
                            is_ftrace_trampoline
arch/powerpc/kernel/stacktrace.c:176:28: note: each undeclared identifier is reported only once for each function it appears in

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/kernel/stacktrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 26a50603177c..8dd6ba0c7d35 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -168,13 +168,14 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 		 * arch-dependent code, they are generic.
 		 */
 		ip = ftrace_graph_ret_addr(tsk, &graph_idx, ip, NULL);
-
+#ifdef CONFIG_KPROBES
 		/*
 		 * Mark stacktraces with kretprobed functions on them
 		 * as unreliable.
 		 */
 		if (ip == (unsigned long)kretprobe_trampoline)
 			return 1;
+#endif
 
 		if (!trace->skip)
 			trace->entries[trace->nr_entries++] = ip;
-- 
2.17.0
