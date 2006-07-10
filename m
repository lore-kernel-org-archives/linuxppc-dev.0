Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0692067B65
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 16:36:59 +1000 (EST)
Subject: [POWERPC] Fix MPIC OF tree parsing on Apple quad g5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 16:36:46 +1000
Message-Id: <1152513406.1576.56.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The quad g5 currently doesn't boot due to two problems. This patch fixes
the first one:
Apple new way of doing interrupt specifiers in OF for devices using the
HT APIC
isn't properly parsed by the new MPIC driver code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/sysdev/mpic.c	2006-07-10 12:39:08.000000000 +1000
+++ linux-irq-work/arch/powerpc/sysdev/mpic.c	2006-07-10 12:40:24.000000000 +1000
@@ -204,7 +204,7 @@
 	if (fixup->base == NULL)
 		return;
 
-	DBG("startup_ht_interrupt(%u, %u) index: %d\n",
+	DBG("startup_ht_interrupt(0x%x, 0x%x) index: %d\n",
 	    source, irqflags, fixup->index);
 	spin_lock_irqsave(&mpic->fixup_lock, flags);
 	/* Enable and configure */
@@ -227,7 +227,7 @@
 	if (fixup->base == NULL)
 		return;
 
-	DBG("shutdown_ht_interrupt(%u, %u)\n", source, irqflags);
+	DBG("shutdown_ht_interrupt(0x%x, 0x%x)\n", source, irqflags);
 
 	/* Disable */
 	spin_lock_irqsave(&mpic->fixup_lock, flags);
@@ -588,8 +588,8 @@
 	struct irq_desc *desc = get_irq_desc(virq);
 	unsigned int vecpri, vold, vnew;
 
-	pr_debug("mpic: set_irq_type(mpic:@%p,virq:%d,src:%d,type:0x%x)\n",
-		 mpic, virq, src, flow_type);
+	DBG("mpic: set_irq_type(mpic:@%p,virq:%d,src:0x%x,type:0x%x)\n",
+	    mpic, virq, src, flow_type);
 
 	if (src >= mpic->irq_count)
 		return -EINVAL;
@@ -661,15 +661,16 @@
 	struct mpic *mpic = h->host_data;
 	struct irq_chip *chip;
 
-	pr_debug("mpic: map virq %d, hwirq 0x%lx\n", virq, hw);
+	DBG("mpic: map virq %d, hwirq 0x%lx\n", virq, hw);
 
 	if (hw == MPIC_VEC_SPURRIOUS)
 		return -EINVAL;
+
 #ifdef CONFIG_SMP
 	else if (hw >= MPIC_VEC_IPI_0) {
 		WARN_ON(!(mpic->flags & MPIC_PRIMARY));
 
-		pr_debug("mpic: mapping as IPI\n");
+		DBG("mpic: mapping as IPI\n");
 		set_irq_chip_data(virq, mpic);
 		set_irq_chip_and_handler(virq, &mpic->hc_ipi,
 					 handle_percpu_irq);
@@ -689,7 +690,7 @@
 		chip = &mpic->hc_ht_irq;
 #endif /* CONFIG_MPIC_BROKEN_U3 */
 
-	pr_debug("mpic: mapping to irq chip @%p\n", chip);
+	DBG("mpic: mapping to irq chip @%p\n", chip);
 
 	set_irq_chip_data(virq, mpic);
 	set_irq_chip_and_handler(virq, chip, handle_fasteoi_irq);
@@ -713,11 +714,28 @@
 	};
 
 	*out_hwirq = intspec[0];
-	if (intsize > 1 && intspec[1] < 4)
-		*out_flags = map_mpic_senses[intspec[1]];
-	else
+	if (intsize > 1) {
+		u32 mask = 0x3;
+
+		/* Apple invented a new race of encoding on machines with
+		 * an HT APIC. They encode, among others, the index within
+		 * the HT APIC. We don't care about it here since thankfully,
+		 * it appears that they have the APIC already properly
+		 * configured, and thus our current fixup code that reads the
+		 * APIC config works fine. However, we still need to mask out
+		 * bits in the specifier to make sure we only get bit 0 which
+		 * is the level/edge bit (the only sense bit exposed by Apple),
+		 * as their bit 1 means something else.
+		 */
+		if (machine_is(powermac))
+			mask = 0x1;
+		*out_flags = map_mpic_senses[intspec[1] & mask];
+	} else
 		*out_flags = IRQ_TYPE_NONE;
 
+	DBG("mpic: xlate (%d cells: 0x%08x 0x%08x) to line 0x%lx sense 0x%x\n",
+	    intsize, intspec[0], intspec[1], *out_hwirq, *out_flags);
+
 	return 0;
 }
 
