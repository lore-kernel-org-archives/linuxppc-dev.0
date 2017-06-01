Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdkcq0M3bzDqFb
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 20:49:46 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51Amkee068781
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 06:49:37 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2atdc0d85t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 06:49:36 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 20:49:33 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v51AnNV544105734
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 20:49:31 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v51Amw55027132
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 20:48:58 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/4] powerpc/xmon: Disable ftrace while in xmon
Date: Thu,  1 Jun 2017 16:18:18 +0530
In-Reply-To: <cover.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <7a15c553c743c24f69859945042efd6345beead3.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Disable ftrace when we enter xmon so as not to clobber/pollute the
trace buffer. In addition, we cannot have function_graph enabled while
in xmon since we use setjmp/longjmp which confuses the function call
history maintained by function_graph.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
v2: Disable ftrace, rather than just pausing function_graph.

 arch/powerpc/xmon/xmon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a728e1919613..e51ce32d21fd 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -28,6 +28,7 @@
 #include <linux/bug.h>
 #include <linux/nmi.h>
 #include <linux/ctype.h>
+#include <linux/ftrace.h>
 
 #include <asm/debugfs.h>
 #include <asm/ptrace.h>
@@ -456,10 +457,13 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 	int cpu;
 	int secondary;
 #endif
+	int save_ftrace_enabled;
 
 	local_irq_save(flags);
 	hard_irq_disable();
 
+	save_ftrace_enabled = __ftrace_enabled_save();
+
 	bp = in_breakpoint_table(regs->nip, &offset);
 	if (bp != NULL) {
 		regs->nip = bp->address + offset;
@@ -654,6 +658,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 	insert_cpu_bpts();
 
 	touch_nmi_watchdog();
+	__ftrace_enabled_restore(save_ftrace_enabled);
 	local_irq_restore(flags);
 
 	return cmd != 'X' && cmd != EOF;
-- 
2.12.2
