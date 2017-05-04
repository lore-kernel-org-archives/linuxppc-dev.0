Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJMhj1rHKzDqFT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 14:37:57 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v444XxWR043303
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 00:37:46 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7dbjh4wb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 00:37:46 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 4 May 2017 14:37:44 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v444bX2l59572406
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:41 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v444b80v009452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:08 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/8] powerpc/ftrace: Add support for
 HAVE_FUNCTION_GRAPH_FP_TEST for -mprofile-kernel
Date: Thu,  4 May 2017 10:06:19 +0530
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <95e111668b446bb766fb79160b6ebd250c499e37.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is very handy to catch potential crashes due to unexpected
interactions of function_graph tracer with weird things like
jprobes.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/asm-prototypes.h      | 3 ++-
 arch/powerpc/include/asm/ftrace.h              | 3 +++
 arch/powerpc/kernel/trace/ftrace.c             | 4 ++--
 arch/powerpc/kernel/trace/ftrace_64.S          | 1 +
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 1 +
 5 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 7330150bfe34..14964ab80a53 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -124,6 +124,7 @@ extern int __ucmpdi2(u64, u64);
 
 /* tracing */
 void _mcount(void);
-unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip);
+unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip,
+					unsigned long fp);
 
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 686c5f70eb84..2b89043b0c61 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -6,6 +6,9 @@
 #ifdef CONFIG_FUNCTION_TRACER
 #define MCOUNT_ADDR		((unsigned long)(_mcount))
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
+#ifdef CONFIG_MPROFILE_KERNEL
+#define HAVE_FUNCTION_GRAPH_FP_TEST
+#endif
 
 #ifdef __ASSEMBLY__
 
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 32509de6ce4c..7e3e099cdfe4 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -572,7 +572,7 @@ int ftrace_disable_ftrace_graph_caller(void)
  * Hook the return address and push it in the stack of return addrs
  * in current thread info. Return the address we want to divert to.
  */
-unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip)
+unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long fp)
 {
 	struct ftrace_graph_ent trace;
 	unsigned long return_hooker;
@@ -592,7 +592,7 @@ unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip)
 	if (!ftrace_graph_entry(&trace))
 		goto out;
 
-	if (ftrace_push_return_trace(parent, ip, &trace.depth, 0,
+	if (ftrace_push_return_trace(parent, ip, &trace.depth, fp,
 				     NULL) == -EBUSY)
 		goto out;
 
diff --git a/arch/powerpc/kernel/trace/ftrace_64.S b/arch/powerpc/kernel/trace/ftrace_64.S
index e5ccea19821e..57ab4f73a5c4 100644
--- a/arch/powerpc/kernel/trace/ftrace_64.S
+++ b/arch/powerpc/kernel/trace/ftrace_64.S
@@ -68,6 +68,7 @@ _GLOBAL(return_to_handler)
 	 */
 	ld	r2, PACATOC(r13)
 
+	addi	r3, r1, 112
 	bl	ftrace_return_to_handler
 	nop
 
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 981b99dc3029..fb6910e48f22 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -241,6 +241,7 @@ _GLOBAL(ftrace_graph_caller)
 
 	ld	r3, _LINK(r1)
 	subi	r4, r14, MCOUNT_INSN_SIZE	/* load saved original NIP */
+	addi	r5, r1, SWITCH_FRAME_SIZE
 
 	bl	prepare_ftrace_return
 	nop
-- 
2.12.2
