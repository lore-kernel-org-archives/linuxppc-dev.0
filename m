Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9782DB7DF9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 10:18:52 +1000 (EST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [59.145.155.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BD4B6DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 10:18:51 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id n6R0Ifpq000999
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 05:48:41 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6R0Ifj41642730
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 05:48:41 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id n6R0IeX1003775
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 10:18:40 +1000
Date: Mon, 27 Jul 2009 05:48:36 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 4/6] Modify process and processor handling code to
	recognise hardware debug registers
Message-ID: <20090727001836.GE13562@in.ibm.com>
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

Modify process handling code to recognise hardware debug registers during copy
and flush operations. Introduce a new TIF_DEBUG task flag to indicate a
process's use of debug register. Load the debug register values into a
new CPU during initialisation.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/process.c |   15 +++++++++++++++
 arch/powerpc/kernel/smp.c     |    2 ++
 2 files changed, 17 insertions(+)

Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/process.c
+++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/process.c
@@ -50,6 +50,7 @@
 #include <asm/syscalls.h>
 #ifdef CONFIG_PPC64
 #include <asm/firmware.h>
+#include <asm/hw_breakpoint.h>
 #endif
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
@@ -254,8 +255,10 @@ void do_dabr(struct pt_regs *regs, unsig
 			11, SIGSEGV) == NOTIFY_STOP)
 		return;
 
+#ifndef CONFIG_PPC64
 	if (debugger_dabr_match(regs))
 		return;
+#endif
 
 	/* Clear the DAC and struct entries.  One shot trigger */
 #if defined(CONFIG_BOOKE)
@@ -372,8 +375,13 @@ struct task_struct *__switch_to(struct t
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_PPC64
+		if (unlikely(test_tsk_thread_flag(new, TIF_DEBUG)))
+			arch_install_thread_hw_breakpoint(new);
+#else
 	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
 		set_dabr(new->thread.dabr);
+#endif /* CONFIG_PPC64 */
 
 #if defined(CONFIG_BOOKE)
 	/* If new thread DAC (HW breakpoint) is the same then leave it */
@@ -550,6 +558,10 @@ void show_regs(struct pt_regs * regs)
 void exit_thread(void)
 {
 	discard_lazy_cpu_state();
+#ifdef CONFIG_PPC64
+	if (unlikely(test_tsk_thread_flag(current, TIF_DEBUG)))
+		flush_thread_hw_breakpoint(current);
+#endif /* CONFIG_PPC64 */
 }
 
 void flush_thread(void)
@@ -672,6 +684,9 @@ int copy_thread(unsigned long clone_flag
 	 * function.
  	 */
 	kregs->nip = *((unsigned long *)ret_from_fork);
+
+	if (unlikely(test_tsk_thread_flag(current, TIF_DEBUG)))
+		copy_thread_hw_breakpoint(current, p, clone_flags);
 #else
 	kregs->nip = (unsigned long)ret_from_fork;
 #endif
Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/smp.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/smp.c
+++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/smp.c
@@ -48,6 +48,7 @@
 #include <asm/vdso_datapage.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
+#include <asm/hw_breakpoint.h>
 #endif
 
 #ifdef DEBUG
@@ -537,6 +538,7 @@ int __devinit start_secondary(void *unus
 
 	local_irq_enable();
 
+	load_debug_registers();
 	cpu_idle();
 	return 0;
 }
