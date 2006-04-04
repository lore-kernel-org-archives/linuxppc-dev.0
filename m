Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 04 Apr 2006 13:43:01 +0200
Subject: [PATCH] powerpc: Disable and EOI interrupts in
	machine_crash_shutdown()
Message-Id: <20060404114306.8DC0F679EF@ozlabs.org>
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We've seen several bugs caused by interrupt weirdness in the kdump kernel.
Panicking from an interrupt handler means we fail to EOI the interrupt, and
so the second kernel never gets that interrupt ever again. We also see hangs
on JS20 where we take interrupts in the second kernel early during boot.

This patch fixes both those problems, and although it adds more code to the
crash path I think it is the best solution.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/crash.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: kdump/arch/powerpc/kernel/crash.c
===================================================================
--- kdump.orig/arch/powerpc/kernel/crash.c
+++ kdump/arch/powerpc/kernel/crash.c
@@ -22,6 +22,7 @@
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/types.h>
 
 #include <asm/processor.h>
@@ -174,6 +175,8 @@ static void crash_kexec_prepare_cpus(voi
 
 void default_machine_crash_shutdown(struct pt_regs *regs)
 {
+	unsigned int irq;
+
 	/*
 	 * This function is only called after the system
 	 * has paniced or is otherwise in a critical state.
@@ -186,6 +189,16 @@ void default_machine_crash_shutdown(stru
 	 */
 	local_irq_disable();
 
+	for_each_irq(irq) {
+		struct irq_desc *desc = irq_descp(irq);
+
+		if (desc->status & IRQ_INPROGRESS)
+			desc->handler->end(irq);
+
+		if (!(desc->status & IRQ_DISABLED))
+			desc->handler->disable(irq);
+	}
+
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(1, 0);
 
