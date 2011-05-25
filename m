Return-Path: <miltonm@bga.com>
Subject: [PATCH 2/8] powerpc cell: rename ipi functions to match current
	abstractions
From: Milton Miller <miltonm@bga.com>
Message-Id: <cell-rename-cause-ipi@mdm.bga.com>
In-Reply-To: <more-irq-cleanups@mdm.bga.com>
References: <more-irq-cleanups@mdm.bga.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 May 2011 01:34:18 -0500
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rename functions and arguments to reflect current usage.  iic_cause_ipi
becomes iic_message_pass and iic_ipi_to_irq becomes iic_msg_to_irq,
and iic_request_ipi now takes a message (msg) instead of an ipi number.
Also mesg is renamed to msg.

Commit f1072939b6 (powerpc: Remove checks for MSG_ALL and
MSG_ALL_BUT_SELF) connected the smp_message_pass hook for cell to the
underlying iic_cause_IPI, a platform unique name.  Later 23d72bfd8f
(powerpc: Consolidate ipi message mux and demux) added a cause_ipi
hook to the smp_ops, also used in message passing, but for controllers
that can not send 4 unique messages and require multiplexing.  It is
even more confusing that the both take two arguments, but one is the
small message ordinal and the other is an opaque long data associated
with the cpu.

Since cell iic maps messages one to one to ipi irqs, rename the
function and argument to translate from ipi to message.  Also make it
clear that iic_request_ipi takes a message number as the argument
for which ipi to create and request.

No functionional change, just renames to avoid future confusion.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: work.git/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- work.git.orig/arch/powerpc/platforms/cell/interrupt.c	2011-05-24 20:54:05.150096188 -0500
+++ work.git/arch/powerpc/platforms/cell/interrupt.c	2011-05-24 21:03:30.350097228 -0500
@@ -176,14 +176,14 @@ EXPORT_SYMBOL_GPL(iic_get_target_id);
 #ifdef CONFIG_SMP
 
 /* Use the highest interrupt priorities for IPI */
-static inline int iic_ipi_to_irq(int ipi)
+static inline int iic_msg_to_irq(int msg)
 {
-	return IIC_IRQ_TYPE_IPI + 0xf - ipi;
+	return IIC_IRQ_TYPE_IPI + 0xf - msg;
 }
 
-void iic_cause_IPI(int cpu, int mesg)
+void iic_message_pass(int cpu, int msg)
 {
-	out_be64(&per_cpu(cpu_iic, cpu).regs->generate, (0xf - mesg) << 4);
+	out_be64(&per_cpu(cpu_iic, cpu).regs->generate, (0xf - msg) << 4);
 }
 
 struct irq_host *iic_get_irq_host(int node)
@@ -192,14 +192,14 @@ struct irq_host *iic_get_irq_host(int no
 }
 EXPORT_SYMBOL_GPL(iic_get_irq_host);
 
-static void iic_request_ipi(int ipi)
+static void iic_request_ipi(int msg)
 {
 	int virq;
 
-	virq = irq_create_mapping(iic_host, iic_ipi_to_irq(ipi));
+	virq = irq_create_mapping(iic_host, iic_msg_to_irq(msg));
 	if (virq == NO_IRQ) {
 		printk(KERN_ERR
-		       "iic: failed to map IPI %s\n", smp_ipi_name[ipi]);
+		       "iic: failed to map IPI %s\n", smp_ipi_name[msg]);
 		return;
 	}
 
@@ -207,7 +207,7 @@ static void iic_request_ipi(int ipi)
 	 * If smp_request_message_ipi encounters an error it will notify
 	 * the error.  If a message is not needed it will return non-zero.
 	 */
-	if (smp_request_message_ipi(virq, ipi))
+	if (smp_request_message_ipi(virq, msg))
 		irq_dispose_mapping(virq);
 }
 
Index: work.git/arch/powerpc/platforms/cell/interrupt.h
===================================================================
--- work.git.orig/arch/powerpc/platforms/cell/interrupt.h	2011-05-24 20:47:00.580096118 -0500
+++ work.git/arch/powerpc/platforms/cell/interrupt.h	2011-05-24 20:59:28.580096158 -0500
@@ -75,7 +75,7 @@ enum {
 };
 
 extern void iic_init_IRQ(void);
-extern void iic_cause_IPI(int cpu, int mesg);
+extern void iic_message_pass(int cpu, int msg);
 extern void iic_request_IPIs(void);
 extern void iic_setup_cpu(void);
 
Index: work.git/arch/powerpc/platforms/cell/smp.c
===================================================================
--- work.git.orig/arch/powerpc/platforms/cell/smp.c	2011-05-24 20:47:00.570096092 -0500
+++ work.git/arch/powerpc/platforms/cell/smp.c	2011-05-24 20:56:53.350096175 -0500
@@ -152,7 +152,7 @@ static int smp_cell_cpu_bootable(unsigne
 	return 1;
 }
 static struct smp_ops_t bpa_iic_smp_ops = {
-	.message_pass	= iic_cause_IPI,
+	.message_pass	= iic_message_pass,
 	.probe		= smp_iic_probe,
 	.kick_cpu	= smp_cell_kick_cpu,
 	.setup_cpu	= smp_cell_setup_cpu,
