Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJMhQ1wLwzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 14:37:42 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v444XwRp107857
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 00:37:34 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7vsq1dbr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 00:37:34 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 4 May 2017 14:37:31 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v444bLA542598560
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:29 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v444auff009136
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:36:56 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] powerpc/kprobes: Pause function_graph tracing during
 jprobes handling
Date: Thu,  4 May 2017 10:06:14 +0530
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <92bb3fa1bd428d8f556f9a90ff97752c2e8f8dfa.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a crash when function_graph and jprobes are used together.
This is essentially commit 237d28db036e ("ftrace/jprobes/x86: Fix
conflict between jprobes and function graph tracing"), but for powerpc.

Jprobes breaks function_graph tracing since the jprobe hook needs to use
jprobe_return(), which never returns back to the hook, but instead to
the original jprobe'd function. The solution is to momentarily pause
function_graph tracing before invoking the jprobe hook and re-enable it
when returning back to the original jprobe'd function.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 255d28d31ca1..562d18f456d7 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -609,6 +609,15 @@ int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
 #endif
 
+	/*
+	 * jprobes use jprobe_return() which skips the normal return
+	 * path of the function, and this messes up the accounting of the
+	 * function graph tracer.
+	 *
+	 * Pause function graph tracing while performing the jprobe function.
+	 */
+	pause_graph_tracing();
+
 	return 1;
 }
 NOKPROBE_SYMBOL(setjmp_pre_handler);
@@ -634,6 +643,8 @@ int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	 * saved regs...
 	 */
 	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
+	/* It's OK to start function graph tracing again */
+	unpause_graph_tracing();
 	preempt_enable_no_resched();
 	return 1;
 }
-- 
2.12.2
