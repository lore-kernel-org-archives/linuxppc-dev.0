Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSQrH5HTxzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:27:11 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LGQ1NI011848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 11:27:08 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28rq6y6121-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 11:27:08 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 02:27:05 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D08BB2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:27:02 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LGQsG757147396
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:27:02 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LGQU3K012136
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:26:30 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/5] powerpc: ftrace: minor cleanup
Date: Tue, 21 Feb 2017 21:56:02 +0530
Message-Id: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the stack setup and teardown code to the ftrace_graph_caller().
This way, we don't incur the cost of setting it up unless function graph
is enabled for this function.

Also, remove the extraneous LR restore code after the function graph
stub. LR has previously been restored and neither livepatch_handler()
nor ftrace_graph_caller() return back here.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_64.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6432d4bf08c8..8fd8718722a1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1313,16 +1313,12 @@ ftrace_call:
 #endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	stdu	r1, -112(r1)
 .globl ftrace_graph_call
 ftrace_graph_call:
 	b	ftrace_graph_stub
 _GLOBAL(ftrace_graph_stub)
-	addi	r1, r1, 112
 #endif
 
-	ld	r0,LRSAVE(r1)	/* restore callee's lr at _mcount site */
-	mtlr	r0
 	bctr			/* jump after _mcount site */
 #endif /* CC_USING_MPROFILE_KERNEL */
 
@@ -1446,6 +1442,7 @@ _GLOBAL(ftrace_stub)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 #ifndef CC_USING_MPROFILE_KERNEL
 _GLOBAL(ftrace_graph_caller)
+	stdu	r1, -112(r1)
 	/* load r4 with local address */
 	ld	r4, 128(r1)
 	subi	r4, r4, MCOUNT_INSN_SIZE
@@ -1471,6 +1468,7 @@ _GLOBAL(ftrace_graph_caller)
 
 #else /* CC_USING_MPROFILE_KERNEL */
 _GLOBAL(ftrace_graph_caller)
+	stdu	r1, -112(r1)
 	/* with -mprofile-kernel, parameter regs are still alive at _mcount */
 	std	r10, 104(r1)
 	std	r9, 96(r1)
-- 
2.11.0
