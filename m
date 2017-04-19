Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MNg3YdrzDqFb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:52:51 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JCnEnK127824
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:52:49 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x7283wrw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:52:48 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 18:22:45 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JCqgeR17760496
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:22:42 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JCqfUF020191
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:22:42 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] powerpc: ftrace: minor cleanup
Date: Wed, 19 Apr 2017 18:22:23 +0530
In-Reply-To: <cover.1492605029.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492605029.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <233563a070655a1015210fdb22322b0316615742.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
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
2.12.1
