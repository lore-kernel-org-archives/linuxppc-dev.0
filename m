Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A40E067BFE
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 13:22:33 +1000 (EST)
Subject: [PATCH] powerpc: Fix CHRP platforms with only 8259
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 13:22:27 +1000
Message-Id: <1161746548.22582.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On CHRP platforms with only a 8259 controller, we should set the
default IRQ host to the 8259 driver's one for the IRQ probing
fallbacks to work in case the IRQ tree is incorrect (like on
Pegasos for example). Without this fix, we get a bunch of WARN_ON's
during boot.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This one without the spurrious #include. Please apply to 2.6.19

Index: linux-cell/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/chrp/setup.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/chrp/setup.c	2006-10-25 12:51:18.000000000 +1000
@@ -477,8 +477,10 @@ static void __init chrp_find_8259(void)
 		       " address, polling\n");
 
 	i8259_init(pic, chrp_int_ack);
-	if (ppc_md.get_irq == NULL)
+	if (ppc_md.get_irq == NULL) {
 		ppc_md.get_irq = i8259_irq;
+		irq_set_default_host(i8259_get_host());
+	}
 	if (chrp_mpic != NULL) {
 		cascade_irq = irq_of_parse_and_map(pic, 0);
 		if (cascade_irq == NO_IRQ)
Index: linux-cell/arch/powerpc/sysdev/i8259.c
===================================================================
--- linux-cell.orig/arch/powerpc/sysdev/i8259.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-cell/arch/powerpc/sysdev/i8259.c	2006-10-25 13:19:33.000000000 +1000
@@ -224,6 +224,11 @@ static struct irq_host_ops i8259_host_op
 	.xlate = i8259_host_xlate,
 };
 
+struct irq_host *i8259_get_host(void)
+{
+	return i8259_host;
+}
+
 /**
  * i8259_init - Initialize the legacy controller
  * @node: device node of the legacy PIC (can be NULL, but then, it will match
Index: linux-cell/include/asm-powerpc/i8259.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/i8259.h	2006-10-09 12:03:34.000000000 +1000
+++ linux-cell/include/asm-powerpc/i8259.h	2006-10-25 12:51:18.000000000 +1000
@@ -7,6 +7,7 @@
 #ifdef CONFIG_PPC_MERGE
 extern void i8259_init(struct device_node *node, unsigned long intack_addr);
 extern unsigned int i8259_irq(void);
+extern struct irq_host *i8259_get_host(void);
 #else
 extern void i8259_init(unsigned long intack_addr, int offset);
 extern int i8259_irq(void);
