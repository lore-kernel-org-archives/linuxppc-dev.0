Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJMhd6NvkzDqKQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 14:37:53 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v444Xvtt009951
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 00:37:43 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a7rubs9jy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 00:37:43 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 4 May 2017 14:37:40 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v444bUFM6816052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:38 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v444b5SM009404
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:06 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/8] powerpc/ftrace: Eliminate duplicate stack setup for
 ftrace_graph_caller()
Date: Thu,  4 May 2017 10:06:18 +0530
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <1c7bc9c395beda00b8e86785c0624a82cf5ae458.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, ftrace_graph_caller() sets up a separate stack frame to save
some state before calling into prepare_ftrace_return(). Eliminate this
by calling into ftrace_graph_caller() right after the ftrace handler.

We make a few changes to accommodate this:
1. Currently, due to where it is present, ftrace_graph_caller() is not
invoked if the NIP is modified by the ftrace handler, indicating either
a livepatched function or a jprobe'd function. To achieve the same
behavior, we now save/compare against original NIP if function graph is
enabled, in addition to CONFIG_LIVEPATCH.

2. We use r14 for saving the original NIP and r15 for storing the
possibly modified NIP. r15 is later used to determine if the function
has been livepatched.

3. To re-use the same stack frame setup/teardown code, we have
ftrace_graph_caller() save the modified LR in pt_regs.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 70 ++++++++------------------
 1 file changed, 21 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index b1bad68ea6db..981b99dc3029 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -72,9 +72,10 @@ _GLOBAL(ftrace_caller)
 	addi	r3,r3,function_trace_op@toc@l
 	ld	r5,0(r3)
 
-#ifdef CONFIG_LIVEPATCH
+#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_LIVEPATCH)
 	mr	r14,r7		/* remember old NIP */
 #endif
+
 	/* Calculate ip from nip-4 into r3 for call below */
 	subi    r3, r7, MCOUNT_INSN_SIZE
 
@@ -97,10 +98,19 @@ ftrace_call:
 	nop
 
 	/* Load ctr with the possibly modified NIP */
-	ld	r3, _NIP(r1)
-	mtctr	r3
+	ld	r15, _NIP(r1)
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+.globl ftrace_graph_call
+ftrace_graph_call:
+	b	ftrace_graph_stub
+_GLOBAL(ftrace_graph_stub)
+#endif
+
+	mtctr	r15
+
 #ifdef CONFIG_LIVEPATCH
-	cmpd	r14,r3		/* has NIP been altered? */
+	cmpd	r14, r15		/* has NIP been altered? */
 #endif
 
 	/* Restore gprs */
@@ -124,13 +134,6 @@ ftrace_call:
 	bne-	livepatch_handler
 #endif
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-.globl ftrace_graph_call
-ftrace_graph_call:
-	b	ftrace_graph_stub
-_GLOBAL(ftrace_graph_stub)
-#endif
-
 	bctr			/* jump after _mcount site */
 
 _GLOBAL(ftrace_stub)
@@ -233,50 +236,19 @@ livepatch_handler:
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 _GLOBAL(ftrace_graph_caller)
-	stdu	r1, -112(r1)
-	/* with -mprofile-kernel, parameter regs are still alive at _mcount */
-	std	r10, 104(r1)
-	std	r9, 96(r1)
-	std	r8, 88(r1)
-	std	r7, 80(r1)
-	std	r6, 72(r1)
-	std	r5, 64(r1)
-	std	r4, 56(r1)
-	std	r3, 48(r1)
+	cmpd	r14, r15			/* has NIP been altered? */
+	bne-	ftrace_graph_stub
 
-	/* Save callee's TOC in the ABI compliant location */
-	std	r2, 24(r1)
-	ld	r2, PACATOC(r13)	/* get kernel TOC in r2 */
-
-	mfctr	r4		/* ftrace_caller has moved local addr here */
-	std	r4, 40(r1)
-	mflr	r3		/* ftrace_caller has restored LR from stack */
-	subi	r4, r4, MCOUNT_INSN_SIZE
+	ld	r3, _LINK(r1)
+	subi	r4, r14, MCOUNT_INSN_SIZE	/* load saved original NIP */
 
 	bl	prepare_ftrace_return
 	nop
 
 	/*
 	 * prepare_ftrace_return gives us the address we divert to.
-	 * Change the LR to this.
+	 * We save it in pt_regs to be used when we go back.
 	 */
-	mtlr	r3
-
-	ld	r0, 40(r1)
-	mtctr	r0
-	ld	r10, 104(r1)
-	ld	r9, 96(r1)
-	ld	r8, 88(r1)
-	ld	r7, 80(r1)
-	ld	r6, 72(r1)
-	ld	r5, 64(r1)
-	ld	r4, 56(r1)
-	ld	r3, 48(r1)
-
-	/* Restore callee's TOC */
-	ld	r2, 24(r1)
-
-	addi	r1, r1, 112
-	mflr	r0
-	bctr
+	std	r3, _LINK(r1)
+	b	ftrace_graph_stub
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.12.2
