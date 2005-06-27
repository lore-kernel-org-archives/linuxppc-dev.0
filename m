Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EAB8067A66
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2005 11:46:50 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 11:42:10 +1000
Message-Id: <1119836530.5133.66.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc32: Bump PMU interrupt priority
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

The Power Management Unit on PowerMacs is very sensitive to timeouts
during async message exchanges. It uses rather crude protocol based on a
shift register with an interrupt and is almost continuously exchanging
messages with the host CPU on laptops.

This patch adds a routine to the open_pic driver to be able to select a
different priority for an interrupt line, and adds use for this to the
PMU driver so that it bumps it's interrupt priority to above the normal
level.

This will allow PMU interrupts to occur while another interrupt is
pending, and thus reduce the risk of machine beeing abruptly shutdown by
the PMU due to a timeout in PMU communication caused by excessive
interrupt latency. The problem is very rare, and usually just doesn't
happen, but it is still useful to make things even more robust.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-ppc/open_pic.h
===================================================================
--- linux-work.orig/include/asm-ppc/open_pic.h	2005-05-02 10:49:57.000000000 +1000
+++ linux-work/include/asm-ppc/open_pic.h	2005-06-25 09:48:05.000000000 +1000
@@ -25,6 +25,11 @@
 #define OPENPIC_VEC_IPI		118	/* and up */
 #define OPENPIC_VEC_SPURIOUS	255
 
+/* Priorities */
+#define OPENPIC_PRIORITY_IPI_BASE	10
+#define OPENPIC_PRIORITY_DEFAULT	4
+#define OPENPIC_PRIORITY_NMI		9	
+
 /* OpenPIC IRQ controller structure */
 extern struct hw_interrupt_type open_pic;
 
@@ -42,6 +47,7 @@
 extern void openpic_set_sources(int first_irq, int num_irqs, void __iomem *isr);
 extern void openpic_init(int linux_irq_offset);
 extern void openpic_init_nmi_irq(u_int irq);
+extern void openpic_set_irq_priority(u_int irq, u_int pri);
 extern void openpic_hookup_cascade(u_int irq, char *name,
 				   int (*cascade_fn)(struct pt_regs *));
 extern u_int openpic_irq(void);
Index: linux-work/arch/ppc/syslib/open_pic.c
===================================================================
--- linux-work.orig/arch/ppc/syslib/open_pic.c	2005-06-25 09:22:56.000000000 +1000
+++ linux-work/arch/ppc/syslib/open_pic.c	2005-06-25 09:48:05.000000000 +1000
@@ -370,8 +370,9 @@
 	/* Initialize IPI interrupts */
 	if ( ppc_md.progress ) ppc_md.progress("openpic: ipi",0x3bb);
 	for (i = 0; i < OPENPIC_NUM_IPI; i++) {
-		/* Disabled, Priority 10..13 */
-		openpic_initipi(i, 10+i, OPENPIC_VEC_IPI+i+offset);
+		/* Disabled, increased priorities 10..13 */
+		openpic_initipi(i, OPENPIC_PRIORITY_IPI_BASE+i,
+				OPENPIC_VEC_IPI+i+offset);
 		/* IPIs are per-CPU */
 		irq_desc[OPENPIC_VEC_IPI+i+offset].status |= IRQ_PER_CPU;
 		irq_desc[OPENPIC_VEC_IPI+i+offset].handler = &open_pic_ipi;
@@ -399,8 +400,9 @@
 		if (sense & IRQ_SENSE_MASK)
 			irq_desc[i+offset].status = IRQ_LEVEL;
 
-		/* Enabled, Priority 8 */
-		openpic_initirq(i, 8, i+offset, (sense & IRQ_POLARITY_MASK),
+		/* Enabled, Default priority */
+		openpic_initirq(i, OPENPIC_PRIORITY_DEFAULT, i+offset,
+				(sense & IRQ_POLARITY_MASK),
 				(sense & IRQ_SENSE_MASK));
 		/* Processor 0 */
 		openpic_mapirq(i, CPU_MASK_CPU0, CPU_MASK_NONE);
@@ -656,6 +658,18 @@
 }
 
 /*
+ * Change the priority of an interrupt
+ */
+void __init
+openpic_set_irq_priority(u_int irq, u_int pri)
+{
+	check_arg_irq(irq);
+	openpic_safe_writefield(&ISR[irq - open_pic_irq_offset]->Vector_Priority,
+				OPENPIC_PRIORITY_MASK,
+				pri << OPENPIC_PRIORITY_SHIFT);
+}
+
+/*
  * Initalize the interrupt source which will generate an NMI.
  * This raises the interrupt's priority from 8 to 9.
  *
@@ -665,9 +679,7 @@
 openpic_init_nmi_irq(u_int irq)
 {
 	check_arg_irq(irq);
-	openpic_safe_writefield(&ISR[irq - open_pic_irq_offset]->Vector_Priority,
-				OPENPIC_PRIORITY_MASK,
-				9 << OPENPIC_PRIORITY_SHIFT);
+	openpic_set_irq_priority(irq, OPENPIC_PRIORITY_NMI);
 }
 
 /*
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2005-06-25 09:22:57.000000000 +1000
+++ linux-work/drivers/macintosh/via-pmu.c	2005-06-25 09:48:05.000000000 +1000
@@ -63,6 +63,10 @@
 #include <asm/backlight.h>
 #endif
 
+#ifdef CONFIG_PPC32
+#include <asm/open_pic.h>
+#endif
+
 /* Some compile options */
 #undef SUSPEND_USES_PMU
 #define DEBUG_SLEEP
@@ -407,6 +411,12 @@
 	batt_req.complete = 1;
 #endif
 
+#ifdef CONFIG_PPC32
+	if (pmu_kind == PMU_KEYLARGO_BASED)
+		openpic_set_irq_priority(vias->intrs[0].line,
+					 OPENPIC_PRIORITY_DEFAULT + 1);
+#endif
+
 	if (request_irq(vias->intrs[0].line, via_pmu_interrupt, 0, "VIA-PMU",
 			(void *)0)) {
 		printk(KERN_ERR "VIA-PMU: can't get irq %d\n",
