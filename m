Return-Path: <temerkhanov@yandex.ru>
Received: from smtp9.yandex.ru (smtp9.yandex.ru [213.180.223.91])
	by ozlabs.org (Postfix) with ESMTP id D7D0EDE3CA
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 22:55:28 +1000 (EST)
Received: from cifronik.21th.com ([62.16.86.116]:5849 "EHLO
	satanklaus.cifronic.local" smtp-auth: "temerkhanov" TLS-CIPHER: <none>
	TLS-PEER-CN1: <none>) by mail.yandex.ru with ESMTP id S6571103AbYHYMzX
	(ORCPT <rfc822;linuxppc-dev@ozlabs.org>);
	Mon, 25 Aug 2008 16:55:23 +0400
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [RFC] Fix level IRQ handling on Xilinx INTC with ARCH=powerpc
Date: Mon, 25 Aug 2008 16:55:59 +0400
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gvqsIIEygnkyRGA"
Message-Id: <200808251656.00247.temerkhanov@yandex.ru>
Reply-To: temerkhanov@cifronik.ru
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_gvqsIIEygnkyRGA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This fixes the missing acknowledge at the end of handle_level_irq().

It adds a field flags to struct irq_chip. If IRQ_CHIP_UNMASK_ACK is set in 
this field, acknowledge is performed before unmasking.

--Boundary-00=_gvqsIIEygnkyRGA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fix-level-irq-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix-level-irq-handling.patch"

diff -r 6b0915754563 arch/powerpc/sysdev/xilinx_intc.c
--- a/arch/powerpc/sysdev/xilinx_intc.c	Mon Jul 28 19:59:22 2008 +0400
+++ b/arch/powerpc/sysdev/xilinx_intc.c	Fri Aug 08 13:13:52 2008 +0400
@@ -73,6 +73,7 @@
 	.mask = xilinx_intc_mask,
 	.unmask = xilinx_intc_unmask,
 	.ack = xilinx_intc_ack,
+	.flags = IRQ_CHIP_UNMASK_ACK,
 };
 
 /*
@@ -107,8 +108,8 @@
 	}
 	regs = ioremap(res.start, 32);
 
-	printk(KERN_INFO "Xilinx intc at 0x%08LX mapped to 0x%p\n",
-		res.start, regs);
+	printk(KERN_INFO "Xilinx intc at 0x%p mapped to 0x%p\n",
+		(void *)res.start, regs);
 
 	/* Setup interrupt controller */
 	out_be32(regs + XINTC_IER, 0); /* disable all irqs */
diff -r 6b0915754563 include/linux/irq.h
--- a/include/linux/irq.h	Mon Jul 28 19:59:22 2008 +0400
+++ b/include/linux/irq.h	Fri Aug 08 13:13:52 2008 +0400
@@ -114,6 +114,9 @@
 	int		(*retrigger)(unsigned int irq);
 	int		(*set_type)(unsigned int irq, unsigned int flow_type);
 	int		(*set_wake)(unsigned int irq, unsigned int on);
+
+	unsigned int	flags;
+#define IRQ_CHIP_UNMASK_ACK	0x00000001
 
 	/* Currently used only by UML, might disappear one day.*/
 #ifdef CONFIG_IRQ_RELEASE_METHOD
diff -r 6b0915754563 kernel/irq/chip.c
--- a/kernel/irq/chip.c	Mon Jul 28 19:59:22 2008 +0400
+++ b/kernel/irq/chip.c	Fri Aug 08 13:13:52 2008 +0400
@@ -377,8 +377,12 @@
 
 	spin_lock(&desc->lock);
 	desc->status &= ~IRQ_INPROGRESS;
-	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-		desc->chip->unmask(irq);
+	if (!(desc->status & IRQ_DISABLED)) {
+		if (desc->chip->flags & IRQ_CHIP_UNMASK_ACK)
+			desc->chip->ack(irq);
+		if (desc->chip->unmask)
+			desc->chip->unmask(irq);
+	}
 out_unlock:
 	spin_unlock(&desc->lock);
 }

--Boundary-00=_gvqsIIEygnkyRGA--
