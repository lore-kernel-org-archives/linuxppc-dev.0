Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CAB2DDE341
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:57:14 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:50 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-ipi-4@bga.com>
In-Reply-To: <patch-ipi-2@bga.com>
Subject: [PATCH 15/16] powerpc cell: use smp_request_message_ipi
Cc: Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cell native has 4 interrupts for ipis, so use the new smp_request_message_ipi
to save pathlength and the data-dependent branch.

This has the side effects of enabling the debugger ipi for kdump and
setting IRQF_PERCPU for the ipi interrupts.  It doesn't undo the virq
mapping if it turns out the ipi is not used.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: next.git/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/cell/interrupt.c	2008-10-04 23:40:24.000000000 -0500
+++ next.git/arch/powerpc/platforms/cell/interrupt.c	2008-10-04 23:44:49.000000000 -0500
@@ -190,38 +190,25 @@ struct irq_host *iic_get_irq_host(int no
 }
 EXPORT_SYMBOL_GPL(iic_get_irq_host);
 
-static irqreturn_t iic_ipi_action(int irq, void *dev_id)
-{
-	int ipi = (int)(long)dev_id;
-
-	smp_message_recv(ipi);
-
-	return IRQ_HANDLED;
-}
-static void iic_request_ipi(int ipi, const char *name)
+static void iic_request_ipi(int ipi)
 {
 	int virq;
 
 	virq = irq_create_mapping(iic_host, iic_ipi_to_irq(ipi));
 	if (virq == NO_IRQ) {
 		printk(KERN_ERR
-		       "iic: failed to map IPI %s\n", name);
+		       "iic: failed to map IPI %s\n", smp_ipi_name[ipi]);
 		return;
 	}
-	if (request_irq(virq, iic_ipi_action, IRQF_DISABLED, name,
-			(void *)(long)ipi))
-		printk(KERN_ERR
-		       "iic: failed to request IPI %s\n", name);
+	smp_request_message_ipi(virq, ipi);
 }
 
 void iic_request_IPIs(void)
 {
-	iic_request_ipi(PPC_MSG_CALL_FUNCTION, "IPI-call");
-	iic_request_ipi(PPC_MSG_RESCHEDULE, "IPI-resched");
-	iic_request_ipi(PPC_MSG_CALL_FUNC_SINGLE, "IPI-call-single");
-#ifdef CONFIG_DEBUGGER
-	iic_request_ipi(PPC_MSG_DEBUGGER_BREAK, "IPI-debug");
-#endif /* CONFIG_DEBUGGER */
+	iic_request_ipi(PPC_MSG_CALL_FUNCTION);
+	iic_request_ipi(PPC_MSG_RESCHEDULE);
+	iic_request_ipi(PPC_MSG_CALL_FUNC_SINGLE);
+	iic_request_ipi(PPC_MSG_DEBUGGER_BREAK);
 }
 
 #endif /* CONFIG_SMP */
