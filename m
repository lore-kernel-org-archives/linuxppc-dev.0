Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB68EDE143
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 11:16:54 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4P1GhqP025449
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 11:16:43 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4P1Gi8V192870
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 11:16:44 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4P1GhCq007242
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 11:16:44 +1000
Date: Mon, 25 May 2009 06:46:31 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [Patch 3/6] Modify ptrace code to use Hardware Breakpoint interfaces
Message-ID: <20090525011631.GD11078@in.ibm.com>
References: <20090525004730.944465878@prasadkr_t60p.in.ibm.com>
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
 arch/powerpc/kernel/ptrace.c |   44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

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
@@ -735,9 +736,22 @@ void user_disable_single_step(struct tas
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
@@ -767,6 +781,36 @@ int ptrace_set_debugreg(struct task_stru
 	if (data && !(data & DABR_TRANSLATION))
 		return -EIO;
 
+#ifdef CONFIG_PPC64
+	bp = thread->hbp[0];
+	if (data == 0) {
+		if (bp) {
+			unregister_user_hw_breakpoint(task, bp);
+			kfree(bp);
+			thread->hbp[0] = NULL;
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
 
