Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjnr62W0jzDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 02:28:54 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7VGPAK2125630
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 12:28:52 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cphwwyhvm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 12:28:51 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 1 Sep 2017 02:28:49 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7VGSkj438666468
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Sep 2017 02:28:46 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7VGSkVf018713
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Sep 2017 02:28:46 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Richard Weinberger <richard@nod.at>
Subject: [PATCH] powerpc/signal: Properly handle return value from
 uprobe_deny_signal()
Date: Thu, 31 Aug 2017 21:55:57 +0530
Message-Id: <20170831162557.24904-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a uprobe is installed on an instruction that we currently do not
emulate, we copy the instruction into a xol buffer and single step
that instruction. If that instruction generates a fault, we abort the
single stepping before invoking the signal handler. Once the signal
handler is done, the uprobe trap is hit again since the instruction is
retried and the process repeats.

We use uprobe_deny_signal() to detect if the xol instruction triggered
a signal. If so, we clear TIF_SIGPENDING and set TIF_UPROBE so that the
signal is not handled until after the single stepping is aborted. In
this case, uprobe_deny_signal() returns true and get_signal() ends up
returning 0. However, in do_signal(), we are not looking at the return
value, but depending on ksig.sig for further action, all with an
uninitialized ksig that is not touched in this scenario. Fix the same
by initializing ksig.sig to 0.

Fixes: 129b69df9c907 ("powerpc: Use get_signal() signal_setup_done()")

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index e9436c5e1e09..3d7539b90010 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -103,7 +103,7 @@ static void check_syscall_restart(struct pt_regs *regs, struct k_sigaction *ka,
 static void do_signal(struct task_struct *tsk)
 {
 	sigset_t *oldset = sigmask_to_save();
-	struct ksignal ksig;
+	struct ksignal ksig = { .sig = 0 };
 	int ret;
 	int is32 = is_32bit_task();
 
-- 
2.14.1
