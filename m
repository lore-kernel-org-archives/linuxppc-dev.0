Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id D0F20B6F98
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 16:34:22 +1000 (EST)
Subject: [PATCH 5/8] powerpc: check desc in handle_one_irq and expand
	generic_handle_irq
From: Milton Miller <miltonm@bga.com>
Message-Id: <generic-handle-irq-not-inline@mdm.bga.com>
In-Reply-To: <more-irq-cleanups@mdm.bga.com>
References: <more-irq-cleanups@mdm.bga.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 May 2011 01:34:18 -0500
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Look up the descriptor and check that it is found in handle_one_irq
before checking if we are on the irq stack, and call the handler
directly using the descriptor if we are on the stack.

We need check irq_to_desc finds the descriptor to avoid a NULL
pointer dereference.  It could have failed because the number from
ppc_md.get_irq was above NR_IRQS, or various exceptional conditions
with sparse irqs (eg race conditions while freeing an irq if its was
not shutdown in the controller).

fe12bc2c99 (genirq: Uninline and sanity check generic_handle_irq())
moved generic_handle_irq out of line to allow its use by interrupt
controllers in modules.  However, handle_one_irq is core arch code.
It already knows the details of struct irq_desc and handling irqs in
the nested irq case.  This will avoid the extra stack frame to return
the value we don't check.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: work.git/arch/powerpc/kernel/irq.c
===================================================================
--- work.git.orig/arch/powerpc/kernel/irq.c	2011-05-21 01:06:49.042239939 -0500
+++ work.git/arch/powerpc/kernel/irq.c	2011-05-21 02:00:41.912586798 -0500
@@ -295,17 +295,20 @@ static inline void handle_one_irq(unsign
 	unsigned long saved_sp_limit;
 	struct irq_desc *desc;
 
+	desc = irq_to_desc(irq);
+	if (!desc)
+		return;
+
 	/* Switch to the irq stack to handle this */
 	curtp = current_thread_info();
 	irqtp = hardirq_ctx[smp_processor_id()];
 
 	if (curtp == irqtp) {
 		/* We're already on the irq stack, just handle it */
-		generic_handle_irq(irq);
+		desc->handle_irq(irq, desc);
 		return;
 	}
 
-	desc = irq_to_desc(irq);
 	saved_sp_limit = current->thread.ksp_limit;
 
 	irqtp->task = curtp->task;
