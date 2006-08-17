Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB6A867B75
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 12:01:52 +1000 (EST)
Subject: [PATCH] Fix irq radix tree remapping typo
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 03:59:27 +0200
Message-Id: <1155779967.11312.143.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Manoj Iyer <manjo@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code for using the radix tree for reverse mapping of interrupts has
a typo that causes it to create incorrect mappings if the software and
hardware numbers happen to be different. This would, among others, cause
the IDE interrupt to fail on js20's. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Please apply to 2.6.18

Index: linux-work/arch/powerpc/kernel/irq.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/irq.c	2006-08-17 09:26:19.000000000 +1000
+++ linux-work/arch/powerpc/kernel/irq.c	2006-08-17 11:27:30.000000000 +1000
@@ -693,7 +693,7 @@ unsigned int irq_radix_revmap(struct irq
 	/* If not there, try to insert it */
 	virq = irq_find_mapping(host, hwirq);
 	if (virq != NO_IRQ)
-		radix_tree_insert(tree, virq, &irq_map[virq]);
+		radix_tree_insert(tree, hwirq, &irq_map[virq]);
  bail:
 	spin_unlock_irqrestore(&irq_big_lock, flags);
 	return virq;
