Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74F391A0EF5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 06:50:32 +1000 (AEST)
Message-Id: <20150713135740.257774769@linutronix.de>
Date: Mon, 13 Jul 2015 20:50:23 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiang Liu <jiang.liu@linux.intel.com>, Julia Lawall <julia.lawall@lip6.fr>
Subject: [patch 15/20] powerpc/cpm2: Use irq_set_handler_locked()
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

Use irq_set_handler_locked() as it avoids a redundant lookup of the
irq descriptor.

Search and replacement was done with coccinelle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/sysdev/cpm2_pic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: tip/arch/powerpc/sysdev/cpm2_pic.c
===================================================================
--- tip.orig/arch/powerpc/sysdev/cpm2_pic.c
+++ tip/arch/powerpc/sysdev/cpm2_pic.c
@@ -155,9 +155,9 @@ static int cpm2_set_irq_type(struct irq_
 
 	irqd_set_trigger_type(d, flow_type);
 	if (flow_type & IRQ_TYPE_LEVEL_LOW)
-		__irq_set_handler_locked(d->irq, handle_level_irq);
+		irq_set_handler_locked(d, handle_level_irq);
 	else
-		__irq_set_handler_locked(d->irq, handle_edge_irq);
+		irq_set_handler_locked(d, handle_edge_irq);
 
 	/* internal IRQ senses are LEVEL_LOW
 	 * EXT IRQ and Port C IRQ senses are programmable
