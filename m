Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 725971A08B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 06:50:40 +1000 (AEST)
Message-Id: <20150713135740.675156414@linutronix.de>
Date: Mon, 13 Jul 2015 20:50:31 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Julia Lawall <Julia.Lawall@lip6.fr>,
 Jiang Liu <jiang.liu@linux.intel.com>
Subject: [patch 20/20] powerpc/cell: Prepare iic_ioexc_cascade for irq
 argument removal
References: <20150713135648.540293392@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The irq argument of most interrupt flow handlers is unused or merily
used instead of a local variable. The handlers which need the irq
argument can retrieve the irq number from the irq descriptor.

Search and update was done with coccinelle and the invaluable help of
Julia Lawall.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/powerpc/platforms/cell/interrupt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: tip/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- tip.orig/arch/powerpc/platforms/cell/interrupt.c
+++ tip/arch/powerpc/platforms/cell/interrupt.c
@@ -99,8 +99,9 @@ static void iic_ioexc_eoi(struct irq_dat
 {
 }
 
-static void iic_ioexc_cascade(unsigned int irq, struct irq_desc *desc)
+static void iic_ioexc_cascade(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct cbe_iic_regs __iomem *node_iic =
 		(void __iomem *)irq_desc_get_handler_data(desc);
