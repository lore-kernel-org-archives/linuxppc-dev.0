Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6EF867B54
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 11:37:16 +1000 (EST)
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <45377ED3.9030001@bplan-gmbh.de>
References: <20061019122802.GA26637@aepfle.de> <45377ED3.9030001@bplan-gmbh.de>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 11:37:01 +1000
Message-Id: <1161308221.10524.92.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On CHRP with only a 8259, make sure it's set as the default host.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Can you test this patch ?

Index: linux-cell/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/chrp/setup.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/chrp/setup.c	2006-10-20 11:31:05.000000000 +1000
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
+++ linux-cell/arch/powerpc/sysdev/i8259.c	2006-10-20 11:32:07.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/module.h>
 #include <asm/io.h>
 #include <asm/i8259.h>
 #include <asm/prom.h>
@@ -224,6 +225,12 @@ static struct irq_host_ops i8259_host_op
 	.xlate = i8259_host_xlate,
 };
 
+struct irq_host *i8259_get_host(void)
+{
+	return i8259_host;
+}
+EXPORT_SYMBOL(i8259_get_host);
+
 /**
  * i8259_init - Initialize the legacy controller
  * @node: device node of the legacy PIC (can be NULL, but then, it will match
Index: linux-cell/include/asm-powerpc/i8259.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/i8259.h	2006-10-09 12:03:34.000000000 +1000
+++ linux-cell/include/asm-powerpc/i8259.h	2006-10-20 11:30:19.000000000 +1000
@@ -7,6 +7,7 @@
 #ifdef CONFIG_PPC_MERGE
 extern void i8259_init(struct device_node *node, unsigned long intack_addr);
 extern unsigned int i8259_irq(void);
+extern struct irq_host *i8259_get_host(void);
 #else
 extern void i8259_init(unsigned long intack_addr, int offset);
 extern int i8259_irq(void);
