Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C31D0B7EB9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 04:40:35 +1000 (EST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 761ADDDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Sep 2009 04:40:35 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id n83Ibkv1008824
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Sep 2009 04:37:46 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n83IcnOF1446032
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Sep 2009 04:38:49 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n83IeWC9011719
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Sep 2009 04:40:33 +1000
Date: Fri, 4 Sep 2009 00:10:27 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 3/6] PPC64-HWBKPT: Modify ptrace code to use Hardware
	Breakpoint interfaces
Message-ID: <20090903184027.GD4590@in.ibm.com>
References: <20090903183306.875398457@xyz>
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
 
