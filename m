Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSQrR5BRZzDqGw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:27:19 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LGNx8H034750
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 11:27:17 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28rq81dy9g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 11:27:17 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 02:27:15 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 93AF32CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:27:11 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LGR3M547710370
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:27:11 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LGQcHj012363
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:26:39 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/5] kprobes: Skip preparing optprobe if the probe is
 ftrace-based
Date: Tue, 21 Feb 2017 21:56:04 +0530
In-Reply-To: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
References: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
References: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <a37815e7dc703a6d58b113bfefb23caa60016d3d.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
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
index fbc7a70ff33e..7e93500dede7 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -708,13 +708,20 @@ static void kill_optimized_kprobe(struct kprobe *p)
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
@@ -728,7 +735,7 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 
 	INIT_LIST_HEAD(&op->list);
 	op->kp.addr = p->addr;
-	arch_prepare_optimized_kprobe(op, p);
+	__prepare_optimized_kprobe(op, p);
 
 	return &op->kp;
 }
-- 
2.11.0
