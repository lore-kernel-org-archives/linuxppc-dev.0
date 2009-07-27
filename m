Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 65426B70D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 10:18:42 +1000 (EST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [59.145.155.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3C077DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 10:18:40 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id n6R0G5Be002397
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 05:46:05 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6R0IWKS2719860
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 05:48:32 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id n6R0IVvf016648
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 10:18:31 +1000
Date: Mon, 27 Jul 2009 05:48:27 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 3/6] Modify ptrace code to use Hardware Breakpoint interfaces
Message-ID: <20090727001324.GD13562@in.ibm.com>
References: <20090726235854.574539012@prasadkr_t60p.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modify the ptrace code to use the hardware breakpoint interfaces for user-space.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
@@ -37,6 +37,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
+#include <asm/hw_breakpoint.h>
 
 /*
  * does not yet catch signals sent when the child dies.
@@ -757,11 +758,24 @@ void user_disable_single_step(struct tas
 
 void ptrace_triggered(struct hw_breakpoint *bp, struct pt_regs *regs)
 {
+	/*
+	 * Unregister the breakpoint request here since ptrace has defined a
+	 * one-shot behaviour for breakpoint exceptions in PPC64.
+	 * The SIGTRAP signal is generated automatically for us in do_dabr().
+	 * We don't have to do anything here
+	 */
+	unregister_user_hw_breakpoint(current, bp);
+	kfree(bp);
 }
 
 int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 			       unsigned long data)
 {
+#ifdef CONFIG_PPC64
+	struct thread_struct *thread = &(task->thread);
+	struct hw_breakpoint *bp;
+	int ret;
+#endif
 	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
 	 *  For embedded processors we support one DAC and no IAC's at the
 	 *  moment.
@@ -791,6 +805,35 @@ int ptrace_set_debugreg(struct task_stru
 	if (data && !(data & DABR_TRANSLATION))
 		return -EIO;
 
+#ifdef CONFIG_PPC64
+	bp = thread->hbp[0];
+	if (data == 0) {
+		if (bp) {
+			unregister_user_hw_breakpoint(task, bp);
+			kfree(bp);
+		}
+		return 0;
+	}
+
+	if (bp) {
+		bp->info.type = data & HW_BREAKPOINT_RW;
+		task->thread.dabr = bp->info.address = data;
+		return modify_user_hw_breakpoint(task, bp);
+	}
+	bp = kzalloc(sizeof(struct hw_breakpoint), GFP_KERNEL);
+	if (!bp)
+		return -ENOMEM;
+
+	/* Store the type of breakpoint */
+	bp->info.type = data & HW_BREAKPOINT_RW;
+	bp->triggered = ptrace_triggered;
+	task->thread.dabr = bp->info.address = data;
+
+	ret = register_user_hw_breakpoint(task, bp);
+	if (ret)
+		return ret;
+#endif /* CONFIG_PPC64 */
+
 	/* Move contents to the DABR register */
 	task->thread.dabr = data;
 
