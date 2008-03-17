Return-Path: <anton@ozlabs.org>
Date: Sun, 16 Mar 2008 23:27:09 -0500
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix PMU + soft interrupt disable bug
Message-ID: <20080317042709.GA10594@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Since the PMU is an NMI now, it can come at any time we are only soft
disabled. We must hard disable around the two places we allow the kernel
stack SLB and r1 to go out of sync. Otherwise the PMU exception can
force a kernel stack SLB into another slot.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: kernel/arch/powerpc/mm/slb.c
===================================================================
--- kernel.orig/arch/powerpc/mm/slb.c	2007-11-05 11:22:03.000000000 -0600
+++ kernel/arch/powerpc/mm/slb.c	2007-11-05 18:09:45.000000000 -0600
@@ -113,6 +113,12 @@ void slb_flush_and_rebolt(void)
 		slb_shadow_update(get_paca()->kstack, lflags, 2);
 	}
 
+	/*
+	 * We can't take a PMU exception in the following code, so hard
+	 * disable interrupts.
+	 */
+	hard_irq_disable();
+
 	/* We need to do this all in asm, so we're sure we don't touch
 	 * the stack between the slbia and rebolting it. */
 	asm volatile("isync\n"
Index: kernel/arch/powerpc/kernel/process.c
===================================================================
--- kernel.orig/arch/powerpc/kernel/process.c	2007-11-05 18:10:44.000000000 -0600
+++ kernel/arch/powerpc/kernel/process.c	2007-11-05 18:10:46.000000000 -0600
@@ -331,6 +331,12 @@ struct task_struct *__switch_to(struct t
 	account_process_vtime(current);
 	calculate_steal_time();
 
+	/*
+	 * We can't take a PMU exception inside _switch() since there is a
+	 * window where the kernel stack SLB and the kernel stack are out
+	 * of sync. Hard disable here.
+	 */
+	hard_irq_disable();
 	last = _switch(old_thread, new_thread);
 
 	local_irq_restore(flags);
