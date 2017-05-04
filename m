Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJMhq4fmnzDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 14:38:03 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v444XvIl041588
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 00:37:50 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7vc32bda-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 00:37:50 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 4 May 2017 14:37:47 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v444bbIK2818414
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:45 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v444bCI4009613
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:13 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/8] powerpc/xmon: Disable function_graph tracing while in xmon
Date: Thu,  4 May 2017 10:06:21 +0530
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <cbc1c6d7ed20f905c2d5c914f69c8ba013a17c3b.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

HAVE_FUNCTION_GRAPH_FP_TEST reveals another area (apart from jprobes)
that conflicts with the function_graph tracer: xmon. This is due to the
use of longjmp() in various places in xmon.

To address this, pause function_graph tracing while in xmon.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index da5619847517..22db68347ff6 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -28,6 +28,7 @@
 #include <linux/bug.h>
 #include <linux/nmi.h>
 #include <linux/ctype.h>
+#include <linux/ftrace.h>
 
 #include <asm/debugfs.h>
 #include <asm/ptrace.h>
@@ -459,6 +460,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 
 	local_irq_save(flags);
 	hard_irq_disable();
+	pause_graph_tracing();
 
 	bp = in_breakpoint_table(regs->nip, &offset);
 	if (bp != NULL) {
@@ -655,6 +657,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 
 	touch_nmi_watchdog();
 	local_irq_restore(flags);
+	unpause_graph_tracing();
 
 	return cmd != 'X' && cmd != EOF;
 }
-- 
2.12.2
