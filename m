Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8911100B33
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:53 +1100 (EST)
Message-Id: <20110325164141.713396044@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:21 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 11/14] powerpc: xilinx: Cleanup flow type handling
References: <20110325164049.138289403@linutronix.de>
Cc: Lennert Buytenhek <buytenh@secretlab.ca>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The core irq_set_type() function updates the flow type when the chip
callback returns 0. So setting the type is bogus. The core also
updates the LEVEL flag.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/sysdev/xilinx_intc.c |    6 ------
 1 file changed, 6 deletions(-)

Index: linux-2.6-tip/arch/powerpc/sysdev/xilinx_intc.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/xilinx_intc.c
+++ linux-2.6-tip/arch/powerpc/sysdev/xilinx_intc.c
@@ -79,12 +79,6 @@ static void xilinx_intc_mask(struct irq_
 
 static int xilinx_intc_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct irq_desc *desc = irq_to_desc(d->irq);
-
-	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
-	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
-	if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
-		desc->status |= IRQ_LEVEL;
 	return 0;
 }
 
