Return-Path: <temerkhanov@yandex.ru>
Received: from smtp15.yandex.ru (smtp15.yandex.ru [77.88.32.85])
	by ozlabs.org (Postfix) with ESMTP id B1ECDDE03F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 19:36:00 +1000 (EST)
Received: from cifronik.21th.com ([62.16.86.116]:29155 "EHLO
	satanklaus.cifronic.local" smtp-auth: "temerkhanov" TLS-CIPHER: <none>
	TLS-PEER-CN1: <none>) by mail.yandex.ru with ESMTP id S1377495AbYHHJas
	(ORCPT <rfc822;linuxppc-dev@ozlabs.org>);
	Fri, 8 Aug 2008 13:30:48 +0400
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Re: Level IRQ handling on Xilinx INTC with ARCH=powerpc
Date: Fri, 8 Aug 2008 13:31:59 +0400
References: <360961217332693@webmail22.yandex.ru>
In-Reply-To: <360961217332693@webmail22.yandex.ru>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QKBnIAoe6EK7Zec"
Message-Id: <200808081332.00331.temerkhanov@yandex.ru>
Reply-To: temerkhanov@cifronik.ru
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_QKBnIAoe6EK7Zec
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've prepared the patch to fix the problem being discussed. It adds a field 
flags to struct irq_chip. If IRQ_CHIP_UNMASK_ACK is set in this field, 
acknowledge is performed before unmasking.

The patch is against 2.6.26

--Boundary-00=_QKBnIAoe6EK7Zec
Content-Type: text/x-diff;
  charset="iso-8859-1";
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

--Boundary-00=_QKBnIAoe6EK7Zec--
