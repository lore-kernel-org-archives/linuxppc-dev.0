Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MNt1rzHzDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:53:02 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JCnt8V074506
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:52:52 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x74mktew-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:52:51 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 18:22:47 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JCqjp018677788
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:22:45 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JCqirv020250
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:22:44 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] kprobes: Skip preparing optprobe if the probe is
 ftrace-based
Date: Wed, 19 Apr 2017 18:22:25 +0530
In-Reply-To: <cover.1492605029.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492605029.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <63c796a86e56ae64e88ba1fc55ca864789c9b22e.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Masami Hiramatsu <mhiramat@kernel.org>

Skip preparing optprobe if the probe is ftrace-based, since anyway, it
must not be optimized (or already optimized by ftrace).

Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index bb86681c8a10..50c48c5b6490 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -743,13 +743,20 @@ static void kill_optimized_kprobe(struct kprobe *p)
 	arch_remove_optimized_kprobe(op);
 }
 
+static inline
+void __prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
+{
+	if (!kprobe_ftrace(p))
+		arch_prepare_optimized_kprobe(op, p);
+}
+
 /* Try to prepare optimized instructions */
 static void prepare_optimized_kprobe(struct kprobe *p)
 {
 	struct optimized_kprobe *op;
 
 	op = container_of(p, struct optimized_kprobe, kp);
-	arch_prepare_optimized_kprobe(op, p);
+	__prepare_optimized_kprobe(op, p);
 }
 
 /* Allocate new optimized_kprobe and try to prepare optimized instructions */
@@ -763,7 +770,7 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 
 	INIT_LIST_HEAD(&op->list);
 	op->kp.addr = p->addr;
-	arch_prepare_optimized_kprobe(op, p);
+	__prepare_optimized_kprobe(op, p);
 
 	return &op->kp;
 }
-- 
2.12.1
