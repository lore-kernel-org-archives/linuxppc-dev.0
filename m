Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46B6E67B65
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 18:27:28 +1000 (EST)
Subject: Re: G5 troubles booting powerpc-git (July 6)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060707012330.f1dea5ac.akpm@osdl.org>
References: <1152197602.14547.10.camel@farscape.rchland.ibm.com>
	<1152226587.9862.19.camel@localhost.localdomain>
	<20060707012330.f1dea5ac.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 18:27:04 +1000
Message-Id: <1152260824.9862.57.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-07-07 at 01:23 -0700, Andrew Morton wrote:
> On Fri, 07 Jul 2006 08:56:27 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > If you look at arch/powerpc/kernel/irq.c from line 479:
> > 
> > 	/* Check if mapping already exist, if it does, call
> > 	 * host->ops->map() to update the flags
> > 	 */
> > 	virq = irq_find_mapping(host, hwirq);
> > 	if (virq != IRQ_NONE) {
> > 		pr_debug("irq: -> existing mapping on virq %d\n", virq);
> > 		host->ops->map(host, virq, hwirq, flags);
> > 		return virq;
> > 	}
> > 
> > What if you comment out the host->ops->map(...) call in there ? Does it
> > help ?
> 
> No, there's no change in behaviour.

Doh ! Ok, looks like a different issue. Can you try this patch ? Please,
do _not_ apply it to your tree as, as it is it will break non-powermac.
It's some work I'm doing to clean up a couple of rough edges in my irq
rework and fix a little misdesign.

If it doesn't fix it, then it's indeed a completely different issue that I'll have to track down tomorrow
hopefully.

Index: linux-irq-work/arch/powerpc/kernel/irq.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/kernel/irq.c	2006-07-07 15:40:27.000000000 +1000
+++ linux-irq-work/arch/powerpc/kernel/irq.c	2006-07-07 15:47:23.000000000 +1000
@@ -391,15 +391,14 @@
 			irq_map[i].host = host;
 			smp_wmb();
 
-			/* Clear some flags */
-			get_irq_desc(i)->status
-				&= ~(IRQ_NOREQUEST | IRQ_LEVEL);
+			/* Clear norequest flags */
+			get_irq_desc(i)->status &= ~IRQ_NOREQUEST;
 
 			/* Legacy flags are left to default at this point,
 			 * one can then use irq_create_mapping() to
 			 * explicitely change them
 			 */
-			ops->map(host, i, i, 0);
+			ops->map(host, i, i);
 		}
 		break;
 	case IRQ_HOST_MAP_LINEAR:
@@ -457,13 +456,11 @@
 }
 
 unsigned int irq_create_mapping(struct irq_host *host,
-				irq_hw_number_t hwirq,
-				unsigned int flags)
+				irq_hw_number_t hwirq)
 {
 	unsigned int virq, hint;
 
-	pr_debug("irq: irq_create_mapping(0x%p, 0x%lx, 0x%x)\n",
-		 host, hwirq, flags);
+	pr_debug("irq: irq_create_mapping(0x%p, 0x%lx)\n", host, hwirq);
 
 	/* Look for default host if nececssary */
 	if (host == NULL)
@@ -482,7 +479,6 @@
 	virq = irq_find_mapping(host, hwirq);
 	if (virq != IRQ_NONE) {
 		pr_debug("irq: -> existing mapping on virq %d\n", virq);
-		host->ops->map(host, virq, hwirq, flags);
 		return virq;
 	}
 
@@ -504,18 +500,18 @@
 	}
 	pr_debug("irq: -> obtained virq %d\n", virq);
 
-	/* Clear some flags */
-	get_irq_desc(virq)->status &= ~(IRQ_NOREQUEST | IRQ_LEVEL);
+	/* Clear IRQ_NOREQUEST flag */
+	get_irq_desc(virq)->status &= ~IRQ_NOREQUEST;
 
 	/* map it */
-	if (host->ops->map(host, virq, hwirq, flags)) {
+	smp_wmb();
+	irq_map[virq].hwirq = hwirq;
+	smp_mb();
+	if (host->ops->map(host, virq, hwirq)) {
 		pr_debug("irq: -> mapping failed, freeing\n");
 		irq_free_virt(virq, 1);
 		return NO_IRQ;
 	}
-	smp_wmb();
-	irq_map[virq].hwirq = hwirq;
-	smp_mb();
 	return virq;
 }
 EXPORT_SYMBOL_GPL(irq_create_mapping);
@@ -525,7 +521,8 @@
 {
 	struct irq_host *host;
 	irq_hw_number_t hwirq;
-	unsigned int flags = IRQ_TYPE_NONE;
+	unsigned int type = IRQ_TYPE_NONE;
+	unsigned int virq;
 
 	if (controller == NULL)
 		host = irq_default_host;
@@ -539,11 +536,20 @@
 		hwirq = intspec[0];
 	else {
 		if (host->ops->xlate(host, controller, intspec, intsize,
-				     &hwirq, &flags))
+				     &hwirq, &type))
 			return NO_IRQ;
 	}
 
-	return irq_create_mapping(host, hwirq, flags);
+	/* Create mapping */
+	virq = irq_create_mapping(host, hwirq);
+	if (virq == NO_IRQ)
+		return virq;
+
+	/* Set type if specified and different than the current one */
+	if (type != IRQ_TYPE_NONE &&
+	    type != (get_irq_desc(virq)->status & IRQF_TRIGGER_MASK))
+		set_irq_type(virq, type);
+	return virq;
 }
 EXPORT_SYMBOL_GPL(irq_create_of_mapping);
 
Index: linux-irq-work/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/powermac/pci.c	2006-07-07 15:40:27.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/powermac/pci.c	2006-07-07 15:47:23.000000000 +1000
@@ -46,7 +46,6 @@
 static struct pci_controller *u3_agp;
 static struct pci_controller *u4_pcie;
 static struct pci_controller *u3_ht;
-#define has_second_ohare 0
 #else
 static int has_second_ohare;
 #endif /* CONFIG_PPC64 */
@@ -993,6 +992,7 @@
 		/* Read interrupt from the device-tree */
 		pci_read_irq_line(dev);
 
+#ifdef CONFIG_PPC32
 		/* Fixup interrupt for the modem/ethernet combo controller.
 		 * on machines with a second ohare chip.
 		 * The number in the device tree (27) is bogus (correct for
@@ -1002,8 +1002,11 @@
 		 */
 		if (has_second_ohare &&
 		    dev->vendor == PCI_VENDOR_ID_DEC &&
-		    dev->device == PCI_DEVICE_ID_DEC_TULIP_PLUS)
-			dev->irq = irq_create_mapping(NULL, 60, 0);
+		    dev->device == PCI_DEVICE_ID_DEC_TULIP_PLUS) {
+			dev->irq = irq_create_mapping(NULL, 60);
+			set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
+		}
+#endif /* CONFIG_PPC32 */
 	}
 }
 
Index: linux-irq-work/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/powermac/pic.c	2006-07-07 15:40:27.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/powermac/pic.c	2006-07-07 15:47:23.000000000 +1000
@@ -579,9 +579,10 @@
 		flags |= OF_IMAP_OLDWORLD_MAC;
 	if (get_property(of_chosen, "linux,bootx", NULL) != NULL)
 		flags |= OF_IMAP_NO_PHANDLE;
-	of_irq_map_init(flags);
 #endif /* CONFIG_PPC_32 */
 
+	of_irq_map_init(flags);
+
 	/* We first try to detect Apple's new Core99 chipset, since mac-io
 	 * is quite different on those machines and contains an IBM MPIC2.
 	 */
Index: linux-irq-work/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/sysdev/mpic.c	2006-07-07 15:40:27.000000000 +1000
+++ linux-irq-work/arch/powerpc/sysdev/mpic.c	2006-07-07 15:47:23.000000000 +1000
@@ -337,6 +337,17 @@
 	}
 }
 
+#else /* CONFIG_MPIC_BROKEN_U3 */
+
+static inline int mpic_is_ht_interrupt(struct mpic *mpic, unsigned int source)
+{
+	return 0;
+}
+
+static void __init mpic_scan_ht_pics(struct mpic *mpic)
+{
+}
+
 #endif /* CONFIG_MPIC_BROKEN_U3 */
 
 
@@ -405,11 +416,9 @@
 	unsigned int loops = 100000;
 	struct mpic *mpic = mpic_from_irq(irq);
 	unsigned int src = mpic_irq_to_hw(irq);
-	unsigned long flags;
 
 	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq, src);
 
-	spin_lock_irqsave(&mpic_lock, flags);
 	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
 		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
 		       ~MPIC_VECPRI_MASK);
@@ -420,7 +429,6 @@
 			break;
 		}
 	} while(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK);
-	spin_unlock_irqrestore(&mpic_lock, flags);
 }
 
 static void mpic_mask_irq(unsigned int irq)
@@ -428,11 +436,9 @@
 	unsigned int loops = 100000;
 	struct mpic *mpic = mpic_from_irq(irq);
 	unsigned int src = mpic_irq_to_hw(irq);
-	unsigned long flags;
 
 	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
 
-	spin_lock_irqsave(&mpic_lock, flags);
 	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
 		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) |
 		       MPIC_VECPRI_MASK);
@@ -444,7 +450,6 @@
 			break;
 		}
 	} while(!(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK));
-	spin_unlock_irqrestore(&mpic_lock, flags);
 }
 
 static void mpic_end_irq(unsigned int irq)
@@ -512,8 +517,7 @@
 		mpic_ht_end_irq(mpic, src);
 	mpic_eoi(mpic);
 }
-
-#endif /* CONFIG_MPIC_BROKEN_U3 */
+#endif /* !CONFIG_MPIC_BROKEN_U3 */
 
 #ifdef CONFIG_SMP
 
@@ -560,47 +564,74 @@
 		       mpic_physmask(cpus_addr(tmp)[0]));	
 }
 
-static unsigned int mpic_flags_to_vecpri(unsigned int flags, int *level)
+static unsigned int mpic_type_to_vecpri(unsigned int type)
 {
-	unsigned int vecpri;
-
 	/* Now convert sense value */
-	switch(flags & IRQ_TYPE_SENSE_MASK) {
+	switch(type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_RISING:
-		vecpri = MPIC_VECPRI_SENSE_EDGE |
-			MPIC_VECPRI_POLARITY_POSITIVE;
-		*level = 0;
-		break;
+		return MPIC_VECPRI_SENSE_EDGE | MPIC_VECPRI_POLARITY_POSITIVE;
 	case IRQ_TYPE_EDGE_FALLING:
-		vecpri = MPIC_VECPRI_SENSE_EDGE |
-			MPIC_VECPRI_POLARITY_NEGATIVE;
-		*level = 0;
-		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		return MPIC_VECPRI_SENSE_EDGE | MPIC_VECPRI_POLARITY_NEGATIVE;
 	case IRQ_TYPE_LEVEL_HIGH:
-		vecpri = MPIC_VECPRI_SENSE_LEVEL |
-			MPIC_VECPRI_POLARITY_POSITIVE;
-		*level = 1;
-		break;
+		return MPIC_VECPRI_SENSE_LEVEL | MPIC_VECPRI_POLARITY_POSITIVE;
 	case IRQ_TYPE_LEVEL_LOW:
 	default:
-		vecpri = MPIC_VECPRI_SENSE_LEVEL |
-			MPIC_VECPRI_POLARITY_NEGATIVE;
-		*level = 1;
+		return MPIC_VECPRI_SENSE_LEVEL | MPIC_VECPRI_POLARITY_NEGATIVE;
 	}
-	return vecpri;
+}
+
+static int mpic_set_irq_type(unsigned int virq, unsigned int flow_type)
+{
+	struct mpic *mpic = mpic_from_irq(virq);
+	unsigned int src = mpic_irq_to_hw(virq);
+	struct irq_desc *desc = get_irq_desc(virq);
+	unsigned int vecpri, vold, vnew;
+
+	pr_debug("mpic: set_irq_type(mpic:@%p,virq:%d,src:%d,type:0x%x)\n",
+		 mpic, virq, src, flow_type);
+
+	if (src >= mpic->irq_count)
+		return -EINVAL;
+
+	if (flow_type == IRQ_TYPE_NONE)
+		if (mpic->senses && src < mpic->senses_count)
+			flow_type = mpic->senses[src];
+	if (flow_type == IRQ_TYPE_NONE)
+		flow_type = IRQ_TYPE_LEVEL_LOW;
+
+	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
+	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
+	if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
+		desc->status |= IRQ_LEVEL;
+
+	if (mpic_is_ht_interrupt(mpic, src))
+		vecpri = MPIC_VECPRI_POLARITY_POSITIVE |
+			MPIC_VECPRI_SENSE_EDGE;
+	else
+		vecpri = mpic_type_to_vecpri(flow_type);
+
+	vold = mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI);
+	vnew = vold & ~(MPIC_VECPRI_POLARITY_MASK | MPIC_VECPRI_SENSE_MASK);
+	vnew |= vecpri;
+	if (vold != vnew)
+		mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI, vnew);
+
+	return 0;
 }
 
 static struct irq_chip mpic_irq_chip = {
-	.mask	= mpic_mask_irq,
-	.unmask	= mpic_unmask_irq,
-	.eoi	= mpic_end_irq,
+	.mask		= mpic_mask_irq,
+	.unmask		= mpic_unmask_irq,
+	.eoi		= mpic_end_irq,
+	.set_type	= mpic_set_irq_type,
 };
 
 #ifdef CONFIG_SMP
 static struct irq_chip mpic_ipi_chip = {
-	.mask	= mpic_mask_ipi,
-	.unmask	= mpic_unmask_ipi,
-	.eoi	= mpic_end_ipi,
+	.mask		= mpic_mask_ipi,
+	.unmask		= mpic_unmask_ipi,
+	.eoi		= mpic_end_ipi,
 };
 #endif /* CONFIG_SMP */
 
@@ -611,6 +642,7 @@
 	.mask		= mpic_mask_irq,
 	.unmask		= mpic_unmask_ht_irq,
 	.eoi		= mpic_end_ht_irq,
+	.set_type	= mpic_set_irq_type,
 };
 #endif /* CONFIG_MPIC_BROKEN_U3 */
 
@@ -624,18 +656,12 @@
 }
 
 static int mpic_host_map(struct irq_host *h, unsigned int virq,
-			 irq_hw_number_t hw, unsigned int flags)
+			 irq_hw_number_t hw)
 {
-	struct irq_desc *desc = get_irq_desc(virq);
-	struct irq_chip *chip;
 	struct mpic *mpic = h->host_data;
-	u32 v, vecpri = MPIC_VECPRI_SENSE_LEVEL |
-		MPIC_VECPRI_POLARITY_NEGATIVE;
-	int level;
-	unsigned long iflags;
+	struct irq_chip *chip;
 
-	pr_debug("mpic: map virq %d, hwirq 0x%lx, flags: 0x%x\n",
-		 virq, hw, flags);
+	pr_debug("mpic: map virq %d, hwirq 0x%lx\n", virq, hw);
 
 	if (hw == MPIC_VEC_SPURRIOUS)
 		return -EINVAL;
@@ -654,44 +680,23 @@
 	if (hw >= mpic->irq_count)
 		return -EINVAL;
 
-	/* If no sense provided, check default sense array */
-	if (((flags & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_NONE) &&
-	    mpic->senses && hw < mpic->senses_count)
-		flags |= mpic->senses[hw];
-
-	vecpri = mpic_flags_to_vecpri(flags, &level);
-	if (level)
-		desc->status |= IRQ_LEVEL;
+	/* Default chip */
 	chip = &mpic->hc_irq;
 
 #ifdef CONFIG_MPIC_BROKEN_U3
 	/* Check for HT interrupts, override vecpri */
-	if (mpic_is_ht_interrupt(mpic, hw)) {
-		vecpri &= ~(MPIC_VECPRI_SENSE_MASK |
-			    MPIC_VECPRI_POLARITY_MASK);
-		vecpri |= MPIC_VECPRI_POLARITY_POSITIVE;
+	if (mpic_is_ht_interrupt(mpic, hw))
 		chip = &mpic->hc_ht_irq;
-	}
-#endif
-
-	/* Reconfigure irq. We must preserve the mask bit as we can be called
-	 * while the interrupt is still active (This may change in the future
-	 * but for now, it is the case).
-	 */
-	spin_lock_irqsave(&mpic_lock, iflags);
-	v = mpic_irq_read(hw, MPIC_IRQ_VECTOR_PRI);
-	vecpri = (v &
-		~(MPIC_VECPRI_POLARITY_MASK | MPIC_VECPRI_SENSE_MASK)) |
-		vecpri;
-	if (vecpri != v)
-		mpic_irq_write(hw, MPIC_IRQ_VECTOR_PRI, vecpri);
-	spin_unlock_irqrestore(&mpic_lock, iflags);
+#endif /* CONFIG_MPIC_BROKEN_U3 */
 
-	pr_debug("mpic: mapping as IRQ, vecpri = 0x%08x (was 0x%08x)\n",
-		 vecpri, v);
+	pr_debug("mpic: mapping to irq chip @%p\n", chip);
 
 	set_irq_chip_data(virq, mpic);
 	set_irq_chip_and_handler(virq, chip, handle_fasteoi_irq);
+
+	/* Set default irq type */
+	set_irq_type(virq, IRQ_TYPE_NONE);
+
 	return 0;
 }
 
@@ -906,41 +911,16 @@
 	if (mpic->irq_count == 0)
 		mpic->irq_count = mpic->num_sources;
 
-#ifdef CONFIG_MPIC_BROKEN_U3
 	/* Do the HT PIC fixups on U3 broken mpic */
 	DBG("MPIC flags: %x\n", mpic->flags);
 	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY))
  		mpic_scan_ht_pics(mpic);
-#endif /* CONFIG_MPIC_BROKEN_U3 */
 
 	for (i = 0; i < mpic->num_sources; i++) {
 		/* start with vector = source number, and masked */
-		u32 vecpri = MPIC_VECPRI_MASK | i | (8 << MPIC_VECPRI_PRIORITY_SHIFT);
-		int level = 1;
+		u32 vecpri = MPIC_VECPRI_MASK | i |
+			(8 << MPIC_VECPRI_PRIORITY_SHIFT);
 		
-		/* do senses munging */
-		if (mpic->senses && i < mpic->senses_count)
-			vecpri |= mpic_flags_to_vecpri(mpic->senses[i],
-						       &level);
-		else
-			vecpri |= MPIC_VECPRI_SENSE_LEVEL;
-
-		/* deal with broken U3 */
-		if (mpic->flags & MPIC_BROKEN_U3) {
-#ifdef CONFIG_MPIC_BROKEN_U3
-			if (mpic_is_ht_interrupt(mpic, i)) {
-				vecpri &= ~(MPIC_VECPRI_SENSE_MASK |
-					    MPIC_VECPRI_POLARITY_MASK);
-				vecpri |= MPIC_VECPRI_POLARITY_POSITIVE;
-			}
-#else
-			printk(KERN_ERR "mpic: BROKEN_U3 set, but CONFIG doesn't match\n");
-#endif
-		}
-
-		DBG("setup source %d, vecpri: %08x, level: %d\n", i, vecpri,
-		    (level != 0));
-
 		/* init hw */
 		mpic_irq_write(i, MPIC_IRQ_VECTOR_PRI, vecpri);
 		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
@@ -1154,7 +1134,7 @@
 
 	for (i = 0; i < 4; i++) {
 		unsigned int vipi = irq_create_mapping(mpic->irqhost,
-						       MPIC_VEC_IPI_0 + i, 0);
+						       MPIC_VEC_IPI_0 + i);
 		if (vipi == NO_IRQ) {
 			printk(KERN_ERR "Failed to map IPI %d\n", i);
 			break;
Index: linux-irq-work/drivers/macintosh/macio_asic.c
===================================================================
--- linux-irq-work.orig/drivers/macintosh/macio_asic.c	2006-07-07 15:40:27.000000000 +1000
+++ linux-irq-work/drivers/macintosh/macio_asic.c	2006-07-07 15:47:23.000000000 +1000
@@ -330,7 +330,7 @@
 {
 	unsigned int irq;
 
-	irq = irq_create_mapping(NULL, line, 0);
+	irq = irq_create_mapping(NULL, line);
 	if (irq != NO_IRQ) {
 		dev->interrupt[index].start = irq;
 		dev->interrupt[index].flags = IORESOURCE_IRQ;
Index: linux-irq-work/include/asm-powerpc/irq.h
===================================================================
--- linux-irq-work.orig/include/asm-powerpc/irq.h	2006-07-07 15:40:27.000000000 +1000
+++ linux-irq-work/include/asm-powerpc/irq.h	2006-07-07 15:47:23.000000000 +1000
@@ -83,25 +83,24 @@
 	int (*match)(struct irq_host *h, struct device_node *node);
 
 	/* Create or update a mapping between a virtual irq number and a hw
-	 * irq number. This can be called several times for the same mapping
-	 * but with different flags, though unmap shall always be called
-	 * before the virq->hw mapping is changed.
+	 * irq number. This is called only once for a given mapping.
 	 */
-	int (*map)(struct irq_host *h, unsigned int virq,
-		   irq_hw_number_t hw, unsigned int flags);
+	int (*map)(struct irq_host *h, unsigned int virq, irq_hw_number_t hw);
 
 	/* Dispose of such a mapping */
 	void (*unmap)(struct irq_host *h, unsigned int virq);
 
 	/* Translate device-tree interrupt specifier from raw format coming
 	 * from the firmware to a irq_hw_number_t (interrupt line number) and
-	 * trigger flags that can be passed to irq_create_mapping().
-	 * If no translation is provided, raw format is assumed to be one cell
-	 * for interrupt line and default sense.
+	 * type (sense) that can be passed to set_irq_type(). In the absence
+	 * of this callback, irq_create_of_mapping() and irq_of_parse_and_map()
+	 * will return the hw number in the first cell and IRQ_TYPE_NONE for
+	 * the type (which amount to keeping whatever default value the
+	 * interrupt controller has for that line)
 	 */
 	int (*xlate)(struct irq_host *h, struct device_node *ctrler,
 		     u32 *intspec, unsigned int intsize,
-		     irq_hw_number_t *out_hwirq, unsigned int *out_flags);
+		     irq_hw_number_t *out_hwirq, unsigned int *out_type);
 };
 
 struct irq_host {
@@ -193,25 +192,14 @@
  * irq_create_mapping - Map a hardware interrupt into linux virq space
  * @host: host owning this hardware interrupt or NULL for default host
  * @hwirq: hardware irq number in that host space
- * @flags: flags passed to the controller. contains the trigger type among
- *         others. Use IRQ_TYPE_* defined in include/linux/irq.h
  *
  * Only one mapping per hardware interrupt is permitted. Returns a linux
- * virq number. The flags can be used to provide sense information to the
- * controller (typically extracted from the device-tree). If no information
- * is passed, the controller defaults will apply (for example, xics can only
- * do edge so flags are irrelevant for some pseries specific irqs).
- *
- * The device-tree generally contains the trigger info in an encoding that is
- * specific to a given type of controller. In that case, you can directly use
- * host->ops->trigger_xlate() to translate that.
- *
- * It is recommended that new PICs that don't have existing OF bindings chose
- * to use a representation of triggers identical to linux.
+ * virq number.
+ * If the sense/trigger is to be specified, set_irq_type() should be called
+ * on the number returned from that call.
  */
 extern unsigned int irq_create_mapping(struct irq_host *host,
-				       irq_hw_number_t hwirq,
-				       unsigned int flags);
+				       irq_hw_number_t hwirq);
 
 
 /***
@@ -295,7 +283,7 @@
  *
  * This function is identical to irq_create_mapping except that it takes
  * as input informations straight from the device-tree (typically the results
- * of the of_irq_map_*() functions
+ * of the of_irq_map_*() functions.
  */
 extern unsigned int irq_create_of_mapping(struct device_node *controller,
 					  u32 *intspec, unsigned int intsize);
