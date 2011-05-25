Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 5CE0BB6F9E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 16:34:20 +1000 (EST)
Subject: [PATCH 8/8] powerpc: fix irq_free_virt by adjusting bounds before loop
From: Milton Miller <miltonm@bga.com>
Message-Id: <irq-free-virt-bounds@mdm.bga.com>
In-Reply-To: <more-irq-cleanups@mdm.bga.com>
References: <more-irq-cleanups@mdm.bga.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 May 2011 01:34:18 -0500
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of looping over each irq and checking against the irq array
bounds, adjust the bounds before looping.

The old code will not free any irq if the irq + count is above
irq_virq_count because the test in the loop is testing irq + count
instead of irq + i.

This code checks the limits to avoid unsigned integer overflows.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
I am not aware of any call sites where the difference matters; I
prepared the refactor while continuing work on the irq host extraction
and noticed the logic error during the code movement.

Index: work.git/arch/powerpc/kernel/irq.c
===================================================================
--- work.git.orig/arch/powerpc/kernel/irq.c	2011-05-24 21:15:55.350096024 -0500
+++ work.git/arch/powerpc/kernel/irq.c	2011-05-24 21:17:16.000097884 -0500
@@ -1007,14 +1007,23 @@ void irq_free_virt(unsigned int virq, un
 	WARN_ON (virq < NUM_ISA_INTERRUPTS);
 	WARN_ON (count == 0 || (virq + count) > irq_virq_count);
 
+	if (virq < NUM_ISA_INTERRUPTS) {
+		if (virq + count < NUM_ISA_INTERRUPTS)
+			return;
+		count  =- NUM_ISA_INTERRUPTS - virq;
+		virq = NUM_ISA_INTERRUPTS;
+	}
+
+	if (count > irq_virq_count || virq > irq_virq_count - count) {
+		if (virq > irq_virq_count)
+			return;
+		count = irq_virq_count - virq;
+	}
+
 	raw_spin_lock_irqsave(&irq_big_lock, flags);
 	for (i = virq; i < (virq + count); i++) {
 		struct irq_host *host;
 
-		if (i < NUM_ISA_INTERRUPTS ||
-		    (virq + count) > irq_virq_count)
-			continue;
-
 		host = irq_map[i].host;
 		irq_map[i].hwirq = host->inval_irq;
 		smp_wmb();
