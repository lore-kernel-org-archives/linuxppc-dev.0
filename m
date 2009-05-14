Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [59.145.155.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp01.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BEC69DE023
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 23:45:28 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp01.in.ibm.com (8.13.1/8.13.1) with ESMTP id n4EDjLFu001198
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 19:15:21 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4EDjKL31269972
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 19:15:20 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id n4EDjK7D016826
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 23:45:20 +1000
Date: Thu, 14 May 2009 19:15:17 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC Patch 3/6] Modify ptrace code to use Hardware Breakpoint
	interfaces
Message-ID: <20090514134517.GD14229@in.ibm.com>
References: <20090514133312.360702378@prasadkr_t60p.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Modify the ptrace code to use the hardware breakpoint interfaces for user-space.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c             |   48 +++++
Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
@@ -37,6 +37,9 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
+#ifdef CONFIG_PPC64
+#include <asm/hw_breakpoint.h>
+#endif
 
 /*
  * does not yet catch signals sent when the child dies.
@@ -735,9 +738,22 @@ void user_disable_single_step(struct tas
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
+static void ptrace_triggered(struct hw_breakpoint *bp, struct pt_regs *regs)
+{
+	/*
+	 * The SIGTRAP signal is generated automatically for us in do_dabr().
+	 * We don't have to do anything here
+	 */
+}
+
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
@@ -767,6 +783,38 @@ int ptrace_set_debugreg(struct task_stru
 	if (data && !(data & DABR_TRANSLATION))
 		return -EIO;
 
+#ifdef CONFIG_PPC64
+	bp = thread->hbp[0];
+	if ((data & ~HW_BREAKPOINT_ALIGN) == 0) {
+		if (bp) {
+			unregister_user_hw_breakpoint(task, bp);
+			kfree(bp);
+			thread->hbp[0] = NULL;
+		}
+		return 0;
+	}
+
+	if (bp) {
+		bp->info.type = data & DABR_DATA_RW;
+		task->thread.dabr = bp->info.address =
+						(data & ~HW_BREAKPOINT_ALIGN);
+		return modify_user_hw_breakpoint(task, bp);
+	}
+	bp = kzalloc(sizeof(struct hw_breakpoint), GFP_KERNEL);
+	if (!bp)
+		return -ENOMEM;
+
+	/* Store the type of breakpoint */
+	bp->info.type = data & DABR_DATA_RW;
+	bp->triggered = ptrace_triggered;
+	task->thread.dabr = bp->info.address = (data & ~HW_BREAKPOINT_ALIGN);
+
+	ret = register_user_hw_breakpoint(task, bp);
+	if (ret)
+		return ret;
+	set_tsk_thread_flag(task, TIF_DEBUG);
+#endif /* CONFIG_PPC64 */
+
 	/* Move contents to the DABR register */
 	task->thread.dabr = data;
