Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLMX3680ZzDqY9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 03:37:55 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9NGbP2j020301
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 12:37:53 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dsjy2ud7c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 12:37:52 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 23 Oct 2017 17:37:50 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: [PATCH 1/4] powerpc/kprobes: Disable preemption before invoking probe
 handler for optprobes
Date: Mon, 23 Oct 2017 22:07:38 +0530
Message-Id: <2a4b854c7fc11db576e3b7ff6dcfda94c64d2842.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Per Documentation/kprobes.txt, probe handlers need to be invoked with
preemption disabled. Update optimized_callback() to do so. Also move
get_kprobe_ctlblk() invocation post preemption disable, since it
accesses pre-cpu data.

This was not an issue so far since optprobes wasn't selected if
CONFIG_PREEMPT was enabled. Commit a30b85df7d599f ("kprobes: Use
synchronize_rcu_tasks() for optprobe with CONFIG_PREEMPT=y") changes
this.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/optprobes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 91e037ab20a1..60ba7f1370a8 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -115,7 +115,6 @@ static unsigned long can_optimize(struct kprobe *p)
 static void optimized_callback(struct optimized_kprobe *op,
 			       struct pt_regs *regs)
 {
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 	unsigned long flags;
 
 	/* This is possible if op is under delayed unoptimizing */
@@ -124,13 +123,14 @@ static void optimized_callback(struct optimized_kprobe *op,
 
 	local_irq_save(flags);
 	hard_irq_disable();
+	preempt_disable();
 
 	if (kprobe_running()) {
 		kprobes_inc_nmissed_count(&op->kp);
 	} else {
 		__this_cpu_write(current_kprobe, &op->kp);
 		regs->nip = (unsigned long)op->kp.addr;
-		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+		get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
 		opt_pre_handler(&op->kp, regs);
 		__this_cpu_write(current_kprobe, NULL);
 	}
@@ -140,6 +140,7 @@ static void optimized_callback(struct optimized_kprobe *op,
 	 * local_irq_restore() will re-enable interrupts,
 	 * if they were hard disabled.
 	 */
+	preempt_enable_no_resched();
 	local_irq_restore(flags);
 }
 NOKPROBE_SYMBOL(optimized_callback);
-- 
2.14.2
