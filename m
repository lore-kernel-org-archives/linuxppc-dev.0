Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1119D1A0784
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 06:50:28 +1000 (AEST)
Message-Id: <20150713135739.995056458@linutronix.de>
Date: Mon, 13 Jul 2015 20:50:18 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [patch 12/20] powerpc/uic: Consolidate chained IRQ handler
 install/remove
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

Chained irq handlers usually set up handler data as well. We now have
a function to set both under irq_desc->lock. Replace the two calls
with one.

Search and conversion was done with coccinelle.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/sysdev/uic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: tip/arch/powerpc/sysdev/uic.c
===================================================================
--- tip.orig/arch/powerpc/sysdev/uic.c
+++ tip/arch/powerpc/sysdev/uic.c
@@ -311,8 +311,8 @@ void __init uic_init_tree(void)
 
 			cascade_virq = irq_of_parse_and_map(np, 0);
 
-			irq_set_handler_data(cascade_virq, uic);
-			irq_set_chained_handler(cascade_virq, uic_irq_cascade);
+			irq_set_chained_handler_and_data(cascade_virq,
+							 uic_irq_cascade, uic);
 
 			/* FIXME: setup critical cascade?? */
 		}
