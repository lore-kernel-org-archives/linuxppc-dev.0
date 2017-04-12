Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w31SG5sjrzDqJ0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:54 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CB3ef9089854
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:10:47 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sb7cb0x4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:10:47 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 21:10:43 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3CBASPh37683380
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:36 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3CBA32Q001435
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:04 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] kprobes: Skip preparing optprobe if the probe is
 ftrace-based
Date: Wed, 12 Apr 2017 16:39:24 +0530
In-Reply-To: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <7f7a8996838c31dd294dea11a639390ddd245291.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
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
Though this patch is generic, it is needed for KPROBES_ON_FTRACE to work
on powerpc.

- Naveen


 kernel/kprobes.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6a128f3a7ed1..406889889ce5 100644
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
