Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E6FEDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 07:29:35 +1100 (EST)
Date: Tue, 13 Nov 2007 23:25:21 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] PowerPC: 4xx uic: add mask_ack callback
Message-ID: <20071113202521.GA26295@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071113201559.GA26172@ru.mvista.com>
Cc: dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds uic_mask_ack_irq() callback to PowerPC 4xx uic code 
to avoid kernel crash. It is used for edge-triggered interrupts
by handle_uic_irq().

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/sysdev/uic.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/powerpc/sysdev/uic.c	2007-11-13 18:42:33.000000000 +0300
+++ linux-2.6/arch/powerpc/sysdev/uic.c	2007-11-13 22:28:01.000000000 +0300
@@ -97,6 +97,22 @@ static void uic_ack_irq(unsigned int vir
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
 
+static void uic_mask_ack_irq(unsigned int virq)
+{
+	struct uic *uic = get_irq_chip_data(virq);
+	unsigned int src = uic_irq_to_hw(virq);
+	unsigned long flags;
+	u32 er, sr;
+
+	sr = 1 << (31-src);
+	spin_lock_irqsave(&uic->lock, flags);
+	er = mfdcr(uic->dcrbase + UIC_ER);
+	er &= ~sr;
+	mtdcr(uic->dcrbase + UIC_ER, er);
+	mtdcr(uic->dcrbase + UIC_SR, sr);
+	spin_unlock_irqrestore(&uic->lock, flags);
+}
+
 static int uic_set_irq_type(unsigned int virq, unsigned int flow_type)
 {
 	struct uic *uic = get_irq_chip_data(virq);
@@ -152,7 +168,7 @@ static struct irq_chip uic_irq_chip = {
 	.typename	= " UIC  ",
 	.unmask		= uic_unmask_irq,
 	.mask		= uic_mask_irq,
-/* 	.mask_ack	= uic_mask_irq_and_ack, */
+ 	.mask_ack	= uic_mask_ack_irq,
 	.ack		= uic_ack_irq,
 	.set_type	= uic_set_irq_type,
 };
