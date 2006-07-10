Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25A9A67B63
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 16:33:10 +1000 (EST)
Subject: [POWERPC] Fix trigger handling in the new irq code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 16:32:45 +1000
Message-Id: <1152513165.1576.51.camel@localhost.localdomain>
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

This patch slightly reworks the new irq code to fix a small design
error. I removed the passing of the trigger to the map() calls entirely,
it was not a good idea to have one call do two different things. It also
fixes a couple of corner cases.

Mapping a linux virtual irq to a physical irq now does only that.
Setting the trigger is a different action which has a different call.

The main changes are:

  - I no longer call host->ops->map() for an already mapped irq, I just
return the virtual number that was already mapped. It was called before
to give an opportunity to change the trigger, but that was causing
issues as that could happen while the interrupt was in use by a device,
and because of the trigger change, map would potentially muck around
with things in a racy way. That was causing much burden on a given's
controller implementation of map() to get it right. This is much simpler
now. map() is only called on the initial mapping of an irq, meaning that
you know that this irq is _not_ being used. You can initialize the
hardware if you want (though you don't have to).

 - Controllers that can handle different type of triggers
(level/edge/etc...) now implement the standard irq_chip->set_type() call
as defined by the generic code. That means that you can use the standard
set_irq_type() to configure an irq line manually if you wish or (though
I don't like that interface), pass explicit trigger flags to
request_irq() as defined by the generic kernel interfaces. Also, using
those interfaces guarantees that your controller set_type callback is
called with the descriptor lock held, thus providing locking against
activity on the same interrupt (including mask/unmask/etc...)
automatically. A result is that, for example, MPIC's own map()
implementation calls irq_set_type(NONE) to configure the hardware to the
default triggers.

 - To allow the above, the irq_map array entry for the new mapped
interrupt
is now set before map() callback is called for the controller.

 - The irq_create_of_mapping() (also used by irq_of_parse_and_map())
function for mapping interrupts from the device-tree now also call the
separate set_irq_type(), and only does so if there is a change in the
trigger type.

 - While I was at it, I changed pci_read_irq_line() (which is the helper
I would expect most archs to use in their pcibios_fixup() to get the PCI
interrupt routing from the device tree) to also handle a fallback when
the DT mapping fails consisting of reading the PCI_INTERRUPT_PIN to know
wether the device has an interrupt at all, and the the
PCI_INTERRUPT_LINE
to get an interrupt number from the device. That number is then mapped
using the default controller, and the trigger is set to level low.
That default behaviour works for several platforms that don't have a
proper
interrupt tree like Pegasos. If it doesn't work for your platform, then
either provide a proper interrupt tree from the firmware so that
fallback
isn't needed, or don't call pci_read_irq_line()

 - Add back a bit that got dropped by my main rework patch for properly
clearing
pending IPIs on pSeries when using a kexec
 
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note: this patch is a pre-requisite for the next one fixing boot on the
Quad g5.
Please merge asap

Index: linux-irq-work/arch/powerpc/kernel/irq.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/kernel/irq.c	2006-07-07 17:49:20.000000000 +1000
+++ linux-irq-work/arch/powerpc/kernel/irq.c	2006-07-10 12:39:16.000000000 +1000
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
@@ -525,25 +521,38 @@
 {
 	struct irq_host *host;
 	irq_hw_number_t hwirq;
-	unsigned int flags = IRQ_TYPE_NONE;
+	unsigned int type = IRQ_TYPE_NONE;
+	unsigned int virq;
 
 	if (controller == NULL)
 		host = irq_default_host;
 	else
 		host = irq_find_host(controller);
-	if (host == NULL)
+	if (host == NULL) {
+		printk(KERN_WARNING "irq: no irq host found for %s !\n",
+		       controller->full_name);
 		return NO_IRQ;
+	}
 
 	/* If host has no translation, then we assume interrupt line */
 	if (host->ops->xlate == NULL)
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
--- linux-irq-work.orig/arch/powerpc/platforms/powermac/pci.c	2006-07-07 17:49:20.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/powermac/pci.c	2006-07-10 12:53:20.000000000 +1000
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/irq.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -24,10 +25,7 @@
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/grackle.h>
-#ifdef CONFIG_PPC64
-//#include <asm/iommu.h>
 #include <asm/ppc-pci.h>
-#endif
 
 #undef DEBUG
 
@@ -46,7 +44,6 @@
 static struct pci_controller *u3_agp;
 static struct pci_controller *u4_pcie;
 static struct pci_controller *u3_ht;
-#define has_second_ohare 0
 #else
 static int has_second_ohare;
 #endif /* CONFIG_PPC64 */
@@ -993,6 +990,7 @@
 		/* Read interrupt from the device-tree */
 		pci_read_irq_line(dev);
 
+#ifdef CONFIG_PPC32
 		/* Fixup interrupt for the modem/ethernet combo controller.
 		 * on machines with a second ohare chip.
 		 * The number in the device tree (27) is bogus (correct for
@@ -1002,8 +1000,11 @@
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
--- linux-irq-work.orig/arch/powerpc/platforms/powermac/pic.c	2006-07-07 17:49:20.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/powermac/pic.c	2006-07-08 09:37:18.000000000 +1000
@@ -291,7 +291,7 @@
 }
 
 static int pmac_pic_host_map(struct irq_host *h, unsigned int virq,
-			     irq_hw_number_t hw, unsigned int flags)
+			     irq_hw_number_t hw)
 {
 	struct irq_desc *desc = get_irq_desc(virq);
 	int level;
@@ -318,6 +318,7 @@
 			       unsigned int *out_flags)
 
 {
+	*out_flags = IRQ_TYPE_NONE;
 	*out_hwirq = *intspec;
 	return 0;
 }
@@ -434,7 +435,7 @@
 
 	printk(KERN_INFO "irq: System has %d possible interrupts\n", max_irqs);
 #ifdef CONFIG_XMON
-	setup_irq(irq_create_mapping(NULL, 20, 0), &xmon_action);
+	setup_irq(irq_create_mapping(NULL, 20), &xmon_action);
 #endif
 }
 #endif /* CONFIG_PPC32 */
@@ -579,9 +580,10 @@
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
--- linux-irq-work.orig/arch/powerpc/sysdev/mpic.c	2006-07-07 17:49:20.000000000 +1000
+++ linux-irq-work/arch/powerpc/sysdev/mpic.c	2006-07-10 12:52:01.000000000 +1000
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
--- linux-irq-work.orig/drivers/macintosh/macio_asic.c	2006-07-07 17:49:20.000000000 +1000
+++ linux-irq-work/drivers/macintosh/macio_asic.c	2006-07-08 09:36:20.000000000 +1000
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
--- linux-irq-work.orig/include/asm-powerpc/irq.h	2006-07-07 17:49:20.000000000 +1000
+++ linux-irq-work/include/asm-powerpc/irq.h	2006-07-08 09:36:20.000000000 +1000
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
Index: linux-irq-work/arch/powerpc/kernel/ibmebus.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/kernel/ibmebus.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-irq-work/arch/powerpc/kernel/ibmebus.c	2006-07-08 11:05:35.000000000 +1000
@@ -323,7 +323,7 @@
 			unsigned long irq_flags, const char * devname,
 			void *dev_id)
 {
-	unsigned int irq = irq_create_mapping(NULL, ist, 0);
+	unsigned int irq = irq_create_mapping(NULL, ist);
 	
 	if (irq == NO_IRQ)
 		return -EINVAL;
Index: linux-irq-work/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/cell/interrupt.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/cell/interrupt.c	2006-07-08 09:41:01.000000000 +1000
@@ -159,7 +159,7 @@
 		if (iic_hosts[node] == NULL)
 			continue;
 		virq = irq_create_mapping(iic_hosts[node],
-					  iic_ipi_to_irq(ipi), 0);
+					  iic_ipi_to_irq(ipi));
 		if (virq == NO_IRQ) {
 			printk(KERN_ERR
 			       "iic: failed to map IPI %s on node %d\n",
@@ -197,7 +197,7 @@
 }
 
 static int iic_host_map(struct irq_host *h, unsigned int virq,
-			irq_hw_number_t hw, unsigned int flags)
+			irq_hw_number_t hw)
 {
 	if (hw < IIC_IRQ_IPI0)
 		set_irq_chip_and_handler(virq, &iic_chip, handle_fasteoi_irq);
Index: linux-irq-work/arch/powerpc/platforms/cell/spider-pic.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/cell/spider-pic.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/cell/spider-pic.c	2006-07-08 11:09:28.000000000 +1000
@@ -85,9 +85,6 @@
 	struct spider_pic *pic = spider_virq_to_pic(virq);
 	void __iomem *cfg = spider_get_irq_config(pic, irq_map[virq].hwirq);
 
-	/* We use no locking as we should be covered by the descriptor lock
-	 * for access to invidual source configuration registers
-	 */
 	out_be32(cfg, in_be32(cfg) | 0x30000000u);
 }
 
@@ -96,9 +93,6 @@
 	struct spider_pic *pic = spider_virq_to_pic(virq);
 	void __iomem *cfg = spider_get_irq_config(pic, irq_map[virq].hwirq);
 
-	/* We use no locking as we should be covered by the descriptor lock
-	 * for access to invidual source configuration registers
-	 */
 	out_be32(cfg, in_be32(cfg) & ~0x30000000u);
 }
 
@@ -120,26 +114,14 @@
 	out_be32(pic->regs + TIR_EDC, 0x100 | (src & 0xf));
 }
 
-static struct irq_chip spider_pic = {
-	.typename = " SPIDER   ",
-	.unmask = spider_unmask_irq,
-	.mask = spider_mask_irq,
-	.ack = spider_ack_irq,
-};
-
-static int spider_host_match(struct irq_host *h, struct device_node *node)
-{
-	struct spider_pic *pic = h->host_data;
-	return node == pic->of_node;
-}
-
-static int spider_host_map(struct irq_host *h, unsigned int virq,
-			irq_hw_number_t hw, unsigned int flags)
+static int spider_set_irq_type(unsigned int virq, unsigned int type)
 {
-	unsigned int sense = flags & IRQ_TYPE_SENSE_MASK;
-	struct spider_pic *pic = h->host_data;
+	unsigned int sense = type & IRQ_TYPE_SENSE_MASK;
+	struct spider_pic *pic = spider_virq_to_pic(virq);
+	unsigned int hw = irq_map[virq].hwirq;
 	void __iomem *cfg = spider_get_irq_config(pic, hw);
-	int level = 0;
+	struct irq_desc *desc = get_irq_desc(virq);
+	u32 old_mask;
 	u32 ic;
 
 	/* Note that only level high is supported for most interrupts */
@@ -157,29 +139,57 @@
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
 		ic = 0x0;
-		level = 1;
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
 	case IRQ_TYPE_NONE:
 		ic = 0x1;
-		level = 1;
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	/* Update irq_desc */
+	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
+	desc->status |= type & IRQ_TYPE_SENSE_MASK;
+	if (type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
+		desc->status |= IRQ_LEVEL;
+
 	/* Configure the source. One gross hack that was there before and
 	 * that I've kept around is the priority to the BE which I set to
 	 * be the same as the interrupt source number. I don't know wether
 	 * that's supposed to make any kind of sense however, we'll have to
 	 * decide that, but for now, I'm not changing the behaviour.
 	 */
-	out_be32(cfg, (ic << 24) | (0x7 << 16) | (pic->node_id << 4) | 0xe);
+	old_mask = in_be32(cfg) & 0x30000000u;
+	out_be32(cfg, old_mask | (ic << 24) | (0x7 << 16) |
+		 (pic->node_id << 4) | 0xe);
 	out_be32(cfg + 4, (0x2 << 16) | (hw & 0xff));
 
-	if (level)
-		get_irq_desc(virq)->status |= IRQ_LEVEL;
+	return 0;
+}
+
+static struct irq_chip spider_pic = {
+	.typename = " SPIDER   ",
+	.unmask = spider_unmask_irq,
+	.mask = spider_mask_irq,
+	.ack = spider_ack_irq,
+	.set_type = spider_set_irq_type,
+};
+
+static int spider_host_match(struct irq_host *h, struct device_node *node)
+{
+	struct spider_pic *pic = h->host_data;
+	return node == pic->of_node;
+}
+
+static int spider_host_map(struct irq_host *h, unsigned int virq,
+			irq_hw_number_t hw)
+{
 	set_irq_chip_and_handler(virq, &spider_pic, handle_level_irq);
+
+	/* Set default irq type */
+	set_irq_type(virq, IRQ_TYPE_NONE);
+
 	return 0;
 }
 
@@ -283,7 +293,7 @@
 	if (iic_host == NULL)
 		return NO_IRQ;
 	/* Manufacture an IIC interrupt number of class 2 */
-	virq = irq_create_mapping(iic_host, 0x20 | unit, 0);
+	virq = irq_create_mapping(iic_host, 0x20 | unit);
 	if (virq == NO_IRQ)
 		printk(KERN_ERR "spider_pic: failed to map cascade !");
 	return virq;
Index: linux-irq-work/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/cell/spu_base.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/cell/spu_base.c	2006-07-08 11:05:01.000000000 +1000
@@ -583,9 +583,9 @@
 	spu->isrc = isrc = tmp[0];
 
 	/* Now map interrupts of all 3 classes */
-	spu->irqs[0] = irq_create_mapping(host, 0x00 | isrc, 0);
-	spu->irqs[1] = irq_create_mapping(host, 0x10 | isrc, 0);
-	spu->irqs[2] = irq_create_mapping(host, 0x20 | isrc, 0);
+	spu->irqs[0] = irq_create_mapping(host, 0x00 | isrc);
+	spu->irqs[1] = irq_create_mapping(host, 0x10 | isrc);
+	spu->irqs[2] = irq_create_mapping(host, 0x20 | isrc);
 
 	/* Right now, we only fail if class 2 failed */
 	return spu->irqs[2] == NO_IRQ ? -EINVAL : 0;
Index: linux-irq-work/arch/powerpc/platforms/iseries/irq.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/iseries/irq.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/iseries/irq.c	2006-07-08 11:06:10.000000000 +1000
@@ -300,7 +300,7 @@
 	realirq = (((((sub_bus << 8) + (bus - 1)) << 3) + (idsel - 1)) << 3)
 		+ function;
 
-	return irq_create_mapping(NULL, realirq, IRQ_TYPE_NONE);
+	return irq_create_mapping(NULL, realirq);
 }
 
 #endif /* CONFIG_PCI */
@@ -341,7 +341,7 @@
 }
 
 static int iseries_irq_host_map(struct irq_host *h, unsigned int virq,
-				irq_hw_number_t hw, unsigned int flags)
+				irq_hw_number_t hw)
 {
 	set_irq_chip_and_handler(virq, &iseries_pic, handle_fasteoi_irq);
 
Index: linux-irq-work/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/pseries/ras.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/pseries/ras.c	2006-07-08 11:06:34.000000000 +1000
@@ -93,8 +93,7 @@
 		for (i = 0; i < opicplen; i++) {
 			if (count > 15)
 				break;
-			virqs[count] = irq_create_mapping(NULL, *(opicprop++),
-							 IRQ_TYPE_NONE);
+			virqs[count] = irq_create_mapping(NULL, *(opicprop++));
 			if (virqs[count] == NO_IRQ)
 				printk(KERN_ERR "Unable to allocate interrupt "
 				       "number for %s\n", np->full_name);
Index: linux-irq-work/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/pseries/xics.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/pseries/xics.c	2006-07-09 14:09:57.000000000 +1000
@@ -502,16 +502,9 @@
 }
 
 static int xics_host_map_direct(struct irq_host *h, unsigned int virq,
-				irq_hw_number_t hw, unsigned int flags)
+				irq_hw_number_t hw)
 {
-	unsigned int sense = flags & IRQ_TYPE_SENSE_MASK;
-
-	pr_debug("xics: map_direct virq %d, hwirq 0x%lx, flags: 0x%x\n",
-		 virq, hw, flags);
-
-	if (sense && sense != IRQ_TYPE_LEVEL_LOW)
-		printk(KERN_WARNING "xics: using unsupported sense 0x%x"
-		       " for irq %d (h: 0x%lx)\n", flags, virq, hw);
+	pr_debug("xics: map_direct virq %d, hwirq 0x%lx\n", virq, hw);
 
 	get_irq_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &xics_pic_direct, handle_fasteoi_irq);
@@ -519,16 +512,9 @@
 }
 
 static int xics_host_map_lpar(struct irq_host *h, unsigned int virq,
-			      irq_hw_number_t hw, unsigned int flags)
+			      irq_hw_number_t hw)
 {
-	unsigned int sense = flags & IRQ_TYPE_SENSE_MASK;
-
-	pr_debug("xics: map_lpar virq %d, hwirq 0x%lx, flags: 0x%x\n",
-		 virq, hw, flags);
-
-	if (sense && sense != IRQ_TYPE_LEVEL_LOW)
-		printk(KERN_WARNING "xics: using unsupported sense 0x%x"
-		       " for irq %d (h: 0x%lx)\n", flags, virq, hw);
+	pr_debug("xics: map_direct virq %d, hwirq 0x%lx\n", virq, hw);
 
 	get_irq_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &xics_pic_lpar, handle_fasteoi_irq);
@@ -757,7 +743,7 @@
 {
 	unsigned int ipi;
 
-	ipi = irq_create_mapping(xics_host, XICS_IPI, 0);
+	ipi = irq_create_mapping(xics_host, XICS_IPI);
 	BUG_ON(ipi == NO_IRQ);
 
 	/*
@@ -783,6 +769,14 @@
 	xics_set_cpu_priority(cpu, 0);
 
 	/*
+	 * Clear IPI
+	 */
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		lpar_qirr_info(cpu, 0xff);
+	else
+		direct_qirr_info(cpu, 0xff);
+
+	/*
 	 * we need to EOI the IPI if we got here from kexec down IPI
 	 *
 	 * probably need to check all the other interrupts too
@@ -795,7 +789,7 @@
 		return;
 	desc = get_irq_desc(ipi);
 	if (desc->chip && desc->chip->eoi)
-		desc->chip->eoi(XICS_IPI);
+		desc->chip->eoi(ipi);
 
 	/*
 	 * Some machines need to have at least one cpu in the GIQ,
Index: linux-irq-work/arch/powerpc/sysdev/i8259.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/sysdev/i8259.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-irq-work/arch/powerpc/sysdev/i8259.c	2006-07-08 09:39:38.000000000 +1000
@@ -169,7 +169,7 @@
 }
 
 static int i8259_host_map(struct irq_host *h, unsigned int virq,
-			  irq_hw_number_t hw, unsigned int flags)
+			  irq_hw_number_t hw)
 {
 	pr_debug("i8259_host_map(%d, 0x%lx)\n", virq, hw);
 
@@ -177,7 +177,7 @@
 	if (hw == 2)
 		get_irq_desc(virq)->status |= IRQ_NOREQUEST;
 
-	/* We use the level stuff only for now, we might want to
+	/* We use the level handler only for now, we might want to
 	 * be more cautious here but that works for now
 	 */
 	get_irq_desc(virq)->status |= IRQ_LEVEL;
Index: linux-irq-work/drivers/char/hvsi.c
===================================================================
--- linux-irq-work.orig/drivers/char/hvsi.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-irq-work/drivers/char/hvsi.c	2006-07-08 11:07:11.000000000 +1000
@@ -1299,7 +1299,7 @@
 		hp->inbuf_end = hp->inbuf;
 		hp->state = HVSI_CLOSED;
 		hp->vtermno = *vtermno;
-		hp->virq = irq_create_mapping(NULL, irq[0], 0);
+		hp->virq = irq_create_mapping(NULL, irq[0]);
 		if (hp->virq == NO_IRQ) {
 			printk(KERN_ERR "%s: couldn't create irq mapping for 0x%x\n",
 				__FUNCTION__, irq[0]);
Index: linux-irq-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/kernel/pci_64.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-irq-work/arch/powerpc/kernel/pci_64.c	2006-07-10 12:39:16.000000000 +1000
@@ -21,13 +21,13 @@
 #include <linux/mm.h>
 #include <linux/list.h>
 #include <linux/syscalls.h>
+#include <linux/irq.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include <asm/byteorder.h>
-#include <asm/irq.h>
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 
@@ -1289,15 +1289,37 @@
 
 	DBG("Try to map irq for %s...\n", pci_name(pci_dev));
 
+	/* Try to get a mapping from the device-tree */
 	if (of_irq_map_pci(pci_dev, &oirq)) {
-		DBG(" -> failed !\n");
-		return -1;
-	}
+		u8 line, pin;
 
-	DBG(" -> got one, spec %d cells (0x%08x...) on %s\n",
-	    oirq.size, oirq.specifier[0], oirq.controller->full_name);
+		/* If that fails, lets fallback to what is in the config
+		 * space and map that through the default controller. We
+		 * also set the type to level low since that's what PCI
+		 * interrupts are. If your platform does differently, then
+		 * either provide a proper interrupt tree or don't use this
+		 * function.
+		 */
+		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_PIN, &pin))
+			return -1;
+		if (pin == 0)
+			return -1;
+		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &line) ||
+		    line == 0xff) {
+			return -1;
+		}
+		DBG(" -> no map ! Using irq line %d from PCI config\n", line);
 
-	virq = irq_create_of_mapping(oirq.controller, oirq.specifier, oirq.size);
+		virq = irq_create_mapping(NULL, line);
+		if (virq != NO_IRQ)
+			set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
+	} else {
+		DBG(" -> got one, spec %d cells (0x%08x...) on %s\n",
+		    oirq.size, oirq.specifier[0], oirq.controller->full_name);
+
+		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
+					     oirq.size);
+	}
 	if(virq == NO_IRQ) {
 		DBG(" -> failed to map !\n");
 		return -1;
Index: linux-irq-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/kernel/pci_32.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-irq-work/arch/powerpc/kernel/pci_32.c	2006-07-10 12:40:09.000000000 +1000
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/bootmem.h>
+#include <linux/irq.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -18,7 +19,6 @@
 #include <asm/sections.h>
 #include <asm/pci-bridge.h>
 #include <asm/byteorder.h>
-#include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/machdep.h>
 
@@ -1420,15 +1420,37 @@
 
 	DBG("Try to map irq for %s...\n", pci_name(pci_dev));
 
+	/* Try to get a mapping from the device-tree */
 	if (of_irq_map_pci(pci_dev, &oirq)) {
-		DBG(" -> failed !\n");
-		return -1;
-	}
+		u8 line, pin;
+
+		/* If that fails, lets fallback to what is in the config
+		 * space and map that through the default controller. We
+		 * also set the type to level low since that's what PCI
+		 * interrupts are. If your platform does differently, then
+		 * either provide a proper interrupt tree or don't use this
+		 * function.
+		 */
+		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_PIN, &pin))
+			return -1;
+		if (pin == 0)
+			return -1;
+		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &line) ||
+		    line == 0xff) {
+			return -1;
+		}
+		DBG(" -> no map ! Using irq line %d from PCI config\n", line);
 
-	DBG(" -> got one, spec %d cells (0x%08x...) on %s\n",
-	    oirq.size, oirq.specifier[0], oirq.controller->full_name);
+		virq = irq_create_mapping(NULL, line);
+		if (virq != NO_IRQ)
+			set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
+	} else {
+		DBG(" -> got one, spec %d cells (0x%08x...) on %s\n",
+		    oirq.size, oirq.specifier[0], oirq.controller->full_name);
 
-	virq = irq_create_of_mapping(oirq.controller, oirq.specifier, oirq.size);
+		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
+					     oirq.size);
+	}
 	if(virq == NO_IRQ) {
 		DBG(" -> failed to map !\n");
 		return -1;
