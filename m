Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [RFC] irq: Migrate powerpc virq subsystem into generic code
To: benh@kernel.crashing.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 22 Sep 2010 17:32:42 -0300
Message-ID: <20100922203117.10426.69278.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Being able to dynamically manage linux irq ranges is useful.  Migrate
the powerpc virq code into common code so that other architectures can
use it.

This patch also removes the unused irq_early_init() references.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
Only compile tested; but I wanted to get this out for comments.  I
think this is the right set of routines to generalize for virq on
other architectures.

g.

 arch/microblaze/kernel/setup.c |    2 
 arch/powerpc/Kconfig           |    3 
 arch/powerpc/include/asm/irq.h |  270 ----------------
 arch/powerpc/kernel/irq.c      |  659 --------------------------------------
 include/linux/virq.h           |  302 ++++++++++++++++++
 kernel/irq/Makefile            |    1 
 kernel/irq/virq.c              |  687 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 995 insertions(+), 929 deletions(-)
 create mode 100644 include/linux/virq.h
 create mode 100644 kernel/irq/virq.c

diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index f5f7688..39cf20d 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -51,8 +51,6 @@ void __init setup_arch(char **cmdline_p)
 
 	unflatten_device_tree();
 
-	/* NOTE I think that this function is not necessary to call */
-	/* irq_early_init(); */
 	setup_cpuinfo();
 
 	microblaze_cache_init();
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 631e5a0..cc06e59 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -146,6 +146,9 @@ config EARLY_PRINTK
 	bool
 	default y
 
+config VIRQ
+	def_bool y
+
 config COMPAT
 	bool
 	default y if PPC64
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 67ab5fb..6dea0cb 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -17,10 +17,6 @@
 #include <asm/atomic.h>
 
 
-/* Define a way to iterate across irqs. */
-#define for_each_irq(i) \
-	for ((i) = 0; (i) < NR_IRQS; ++(i))
-
 extern atomic_t ppc_n_lost_interrupts;
 
 /* This number is used when no interrupt has been assigned */
@@ -41,270 +37,6 @@ extern atomic_t ppc_n_lost_interrupts;
 /* Same thing, used by the generic IRQ code */
 #define NR_IRQS_LEGACY		NUM_ISA_INTERRUPTS
 
-/* This type is the placeholder for a hardware interrupt number. It has to
- * be big enough to enclose whatever representation is used by a given
- * platform.
- */
-typedef unsigned long irq_hw_number_t;
-
-/* Interrupt controller "host" data structure. This could be defined as a
- * irq domain controller. That is, it handles the mapping between hardware
- * and virtual interrupt numbers for a given interrupt domain. The host
- * structure is generally created by the PIC code for a given PIC instance
- * (though a host can cover more than one PIC if they have a flat number
- * model). It's the host callbacks that are responsible for setting the
- * irq_chip on a given irq_desc after it's been mapped.
- *
- * The host code and data structures are fairly agnostic to the fact that
- * we use an open firmware device-tree. We do have references to struct
- * device_node in two places: in irq_find_host() to find the host matching
- * a given interrupt controller node, and of course as an argument to its
- * counterpart host->ops->match() callback. However, those are treated as
- * generic pointers by the core and the fact that it's actually a device-node
- * pointer is purely a convention between callers and implementation. This
- * code could thus be used on other architectures by replacing those two
- * by some sort of arch-specific void * "token" used to identify interrupt
- * controllers.
- */
-struct irq_host;
-struct radix_tree_root;
-
-/* Functions below are provided by the host and called whenever a new mapping
- * is created or an old mapping is disposed. The host can then proceed to
- * whatever internal data structures management is required. It also needs
- * to setup the irq_desc when returning from map().
- */
-struct irq_host_ops {
-	/* Match an interrupt controller device node to a host, returns
-	 * 1 on a match
-	 */
-	int (*match)(struct irq_host *h, struct device_node *node);
-
-	/* Create or update a mapping between a virtual irq number and a hw
-	 * irq number. This is called only once for a given mapping.
-	 */
-	int (*map)(struct irq_host *h, unsigned int virq, irq_hw_number_t hw);
-
-	/* Dispose of such a mapping */
-	void (*unmap)(struct irq_host *h, unsigned int virq);
-
-	/* Update of such a mapping  */
-	void (*remap)(struct irq_host *h, unsigned int virq, irq_hw_number_t hw);
-
-	/* Translate device-tree interrupt specifier from raw format coming
-	 * from the firmware to a irq_hw_number_t (interrupt line number) and
-	 * type (sense) that can be passed to set_irq_type(). In the absence
-	 * of this callback, irq_create_of_mapping() and irq_of_parse_and_map()
-	 * will return the hw number in the first cell and IRQ_TYPE_NONE for
-	 * the type (which amount to keeping whatever default value the
-	 * interrupt controller has for that line)
-	 */
-	int (*xlate)(struct irq_host *h, struct device_node *ctrler,
-		     const u32 *intspec, unsigned int intsize,
-		     irq_hw_number_t *out_hwirq, unsigned int *out_type);
-};
-
-struct irq_host {
-	struct list_head	link;
-
-	/* type of reverse mapping technique */
-	unsigned int		revmap_type;
-#define IRQ_HOST_MAP_LEGACY     0 /* legacy 8259, gets irqs 1..15 */
-#define IRQ_HOST_MAP_NOMAP	1 /* no fast reverse mapping */
-#define IRQ_HOST_MAP_LINEAR	2 /* linear map of interrupts */
-#define IRQ_HOST_MAP_TREE	3 /* radix tree */
-	union {
-		struct {
-			unsigned int size;
-			unsigned int *revmap;
-		} linear;
-		struct radix_tree_root tree;
-	} revmap_data;
-	struct irq_host_ops	*ops;
-	void			*host_data;
-	irq_hw_number_t		inval_irq;
-
-	/* Optional device node pointer */
-	struct device_node	*of_node;
-};
-
-/* The main irq map itself is an array of NR_IRQ entries containing the
- * associate host and irq number. An entry with a host of NULL is free.
- * An entry can be allocated if it's free, the allocator always then sets
- * hwirq first to the host's invalid irq number and then fills ops.
- */
-struct irq_map_entry {
-	irq_hw_number_t	hwirq;
-	struct irq_host	*host;
-};
-
-extern struct irq_map_entry irq_map[NR_IRQS];
-
-extern irq_hw_number_t virq_to_hw(unsigned int virq);
-
-/**
- * irq_alloc_host - Allocate a new irq_host data structure
- * @of_node: optional device-tree node of the interrupt controller
- * @revmap_type: type of reverse mapping to use
- * @revmap_arg: for IRQ_HOST_MAP_LINEAR linear only: size of the map
- * @ops: map/unmap host callbacks
- * @inval_irq: provide a hw number in that host space that is always invalid
- *
- * Allocates and initialize and irq_host structure. Note that in the case of
- * IRQ_HOST_MAP_LEGACY, the map() callback will be called before this returns
- * for all legacy interrupts except 0 (which is always the invalid irq for
- * a legacy controller). For a IRQ_HOST_MAP_LINEAR, the map is allocated by
- * this call as well. For a IRQ_HOST_MAP_TREE, the radix tree will be allocated
- * later during boot automatically (the reverse mapping will use the slow path
- * until that happens).
- */
-extern struct irq_host *irq_alloc_host(struct device_node *of_node,
-				       unsigned int revmap_type,
-				       unsigned int revmap_arg,
-				       struct irq_host_ops *ops,
-				       irq_hw_number_t inval_irq);
-
-
-/**
- * irq_find_host - Locates a host for a given device node
- * @node: device-tree node of the interrupt controller
- */
-extern struct irq_host *irq_find_host(struct device_node *node);
-
-
-/**
- * irq_set_default_host - Set a "default" host
- * @host: default host pointer
- *
- * For convenience, it's possible to set a "default" host that will be used
- * whenever NULL is passed to irq_create_mapping(). It makes life easier for
- * platforms that want to manipulate a few hard coded interrupt numbers that
- * aren't properly represented in the device-tree.
- */
-extern void irq_set_default_host(struct irq_host *host);
-
-
-/**
- * irq_set_virq_count - Set the maximum number of virt irqs
- * @count: number of linux virtual irqs, capped with NR_IRQS
- *
- * This is mainly for use by platforms like iSeries who want to program
- * the virtual irq number in the controller to avoid the reverse mapping
- */
-extern void irq_set_virq_count(unsigned int count);
-
-
-/**
- * irq_create_mapping - Map a hardware interrupt into linux virq space
- * @host: host owning this hardware interrupt or NULL for default host
- * @hwirq: hardware irq number in that host space
- *
- * Only one mapping per hardware interrupt is permitted. Returns a linux
- * virq number.
- * If the sense/trigger is to be specified, set_irq_type() should be called
- * on the number returned from that call.
- */
-extern unsigned int irq_create_mapping(struct irq_host *host,
-				       irq_hw_number_t hwirq);
-
-
-/**
- * irq_dispose_mapping - Unmap an interrupt
- * @virq: linux virq number of the interrupt to unmap
- */
-extern void irq_dispose_mapping(unsigned int virq);
-
-/**
- * irq_find_mapping - Find a linux virq from an hw irq number.
- * @host: host owning this hardware interrupt
- * @hwirq: hardware irq number in that host space
- *
- * This is a slow path, for use by generic code. It's expected that an
- * irq controller implementation directly calls the appropriate low level
- * mapping function.
- */
-extern unsigned int irq_find_mapping(struct irq_host *host,
-				     irq_hw_number_t hwirq);
-
-/**
- * irq_create_direct_mapping - Allocate a virq for direct mapping
- * @host: host to allocate the virq for or NULL for default host
- *
- * This routine is used for irq controllers which can choose the hardware
- * interrupt numbers they generate. In such a case it's simplest to use
- * the linux virq as the hardware interrupt number.
- */
-extern unsigned int irq_create_direct_mapping(struct irq_host *host);
-
-/**
- * irq_radix_revmap_insert - Insert a hw irq to linux virq number mapping.
- * @host: host owning this hardware interrupt
- * @virq: linux irq number
- * @hwirq: hardware irq number in that host space
- *
- * This is for use by irq controllers that use a radix tree reverse
- * mapping for fast lookup.
- */
-extern void irq_radix_revmap_insert(struct irq_host *host, unsigned int virq,
-				    irq_hw_number_t hwirq);
-
-/**
- * irq_radix_revmap_lookup - Find a linux virq from a hw irq number.
- * @host: host owning this hardware interrupt
- * @hwirq: hardware irq number in that host space
- *
- * This is a fast path, for use by irq controller code that uses radix tree
- * revmaps
- */
-extern unsigned int irq_radix_revmap_lookup(struct irq_host *host,
-					    irq_hw_number_t hwirq);
-
-/**
- * irq_linear_revmap - Find a linux virq from a hw irq number.
- * @host: host owning this hardware interrupt
- * @hwirq: hardware irq number in that host space
- *
- * This is a fast path, for use by irq controller code that uses linear
- * revmaps. It does fallback to the slow path if the revmap doesn't exist
- * yet and will create the revmap entry with appropriate locking
- */
-
-extern unsigned int irq_linear_revmap(struct irq_host *host,
-				      irq_hw_number_t hwirq);
-
-
-
-/**
- * irq_alloc_virt - Allocate virtual irq numbers
- * @host: host owning these new virtual irqs
- * @count: number of consecutive numbers to allocate
- * @hint: pass a hint number, the allocator will try to use a 1:1 mapping
- *
- * This is a low level function that is used internally by irq_create_mapping()
- * and that can be used by some irq controllers implementations for things
- * like allocating ranges of numbers for MSIs. The revmaps are left untouched.
- */
-extern unsigned int irq_alloc_virt(struct irq_host *host,
-				   unsigned int count,
-				   unsigned int hint);
-
-/**
- * irq_free_virt - Free virtual irq numbers
- * @virq: virtual irq number of the first interrupt to free
- * @count: number of interrupts to free
- *
- * This function is the opposite of irq_alloc_virt. It will not clear reverse
- * maps, this should be done previously by unmap'ing the interrupt. In fact,
- * all interrupts covered by the range being freed should have been unmapped
- * prior to calling this.
- */
-extern void irq_free_virt(unsigned int virq, unsigned int count);
-
-/**
- * irq_early_init - Init irq remapping subsystem
- */
-extern void irq_early_init(void);
-
 static __inline__ int irq_canonicalize(int irq)
 {
 	return irq;
@@ -342,5 +74,7 @@ extern int call_handle_irq(int irq, void *p1,
 			   struct thread_info *tp, void *func);
 extern void do_IRQ(struct pt_regs *regs);
 
+#include <linux/virq.h>
+
 #endif /* _ASM_IRQ_H */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4a65386..86d8e42 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -523,553 +523,6 @@ void do_softirq(void)
 }
 
 
-/*
- * IRQ controller and virtual interrupts
- */
-
-static LIST_HEAD(irq_hosts);
-static DEFINE_RAW_SPINLOCK(irq_big_lock);
-static unsigned int revmap_trees_allocated;
-static DEFINE_MUTEX(revmap_trees_mutex);
-struct irq_map_entry irq_map[NR_IRQS];
-static unsigned int irq_virq_count = NR_IRQS;
-static struct irq_host *irq_default_host;
-
-irq_hw_number_t virq_to_hw(unsigned int virq)
-{
-	return irq_map[virq].hwirq;
-}
-EXPORT_SYMBOL_GPL(virq_to_hw);
-
-static int default_irq_host_match(struct irq_host *h, struct device_node *np)
-{
-	return h->of_node != NULL && h->of_node == np;
-}
-
-struct irq_host *irq_alloc_host(struct device_node *of_node,
-				unsigned int revmap_type,
-				unsigned int revmap_arg,
-				struct irq_host_ops *ops,
-				irq_hw_number_t inval_irq)
-{
-	struct irq_host *host;
-	unsigned int size = sizeof(struct irq_host);
-	unsigned int i;
-	unsigned int *rmap;
-	unsigned long flags;
-
-	/* Allocate structure and revmap table if using linear mapping */
-	if (revmap_type == IRQ_HOST_MAP_LINEAR)
-		size += revmap_arg * sizeof(unsigned int);
-	host = zalloc_maybe_bootmem(size, GFP_KERNEL);
-	if (host == NULL)
-		return NULL;
-
-	/* Fill structure */
-	host->revmap_type = revmap_type;
-	host->inval_irq = inval_irq;
-	host->ops = ops;
-	host->of_node = of_node_get(of_node);
-
-	if (host->ops->match == NULL)
-		host->ops->match = default_irq_host_match;
-
-	raw_spin_lock_irqsave(&irq_big_lock, flags);
-
-	/* If it's a legacy controller, check for duplicates and
-	 * mark it as allocated (we use irq 0 host pointer for that
-	 */
-	if (revmap_type == IRQ_HOST_MAP_LEGACY) {
-		if (irq_map[0].host != NULL) {
-			raw_spin_unlock_irqrestore(&irq_big_lock, flags);
-			/* If we are early boot, we can't free the structure,
-			 * too bad...
-			 * this will be fixed once slab is made available early
-			 * instead of the current cruft
-			 */
-			if (mem_init_done)
-				kfree(host);
-			return NULL;
-		}
-		irq_map[0].host = host;
-	}
-
-	list_add(&host->link, &irq_hosts);
-	raw_spin_unlock_irqrestore(&irq_big_lock, flags);
-
-	/* Additional setups per revmap type */
-	switch(revmap_type) {
-	case IRQ_HOST_MAP_LEGACY:
-		/* 0 is always the invalid number for legacy */
-		host->inval_irq = 0;
-		/* setup us as the host for all legacy interrupts */
-		for (i = 1; i < NUM_ISA_INTERRUPTS; i++) {
-			irq_map[i].hwirq = i;
-			smp_wmb();
-			irq_map[i].host = host;
-			smp_wmb();
-
-			/* Clear norequest flags */
-			irq_to_desc(i)->status &= ~IRQ_NOREQUEST;
-
-			/* Legacy flags are left to default at this point,
-			 * one can then use irq_create_mapping() to
-			 * explicitly change them
-			 */
-			ops->map(host, i, i);
-		}
-		break;
-	case IRQ_HOST_MAP_LINEAR:
-		rmap = (unsigned int *)(host + 1);
-		for (i = 0; i < revmap_arg; i++)
-			rmap[i] = NO_IRQ;
-		host->revmap_data.linear.size = revmap_arg;
-		smp_wmb();
-		host->revmap_data.linear.revmap = rmap;
-		break;
-	default:
-		break;
-	}
-
-	pr_debug("irq: Allocated host of type %d @0x%p\n", revmap_type, host);
-
-	return host;
-}
-
-struct irq_host *irq_find_host(struct device_node *node)
-{
-	struct irq_host *h, *found = NULL;
-	unsigned long flags;
-
-	/* We might want to match the legacy controller last since
-	 * it might potentially be set to match all interrupts in
-	 * the absence of a device node. This isn't a problem so far
-	 * yet though...
-	 */
-	raw_spin_lock_irqsave(&irq_big_lock, flags);
-	list_for_each_entry(h, &irq_hosts, link)
-		if (h->ops->match(h, node)) {
-			found = h;
-			break;
-		}
-	raw_spin_unlock_irqrestore(&irq_big_lock, flags);
-	return found;
-}
-EXPORT_SYMBOL_GPL(irq_find_host);
-
-void irq_set_default_host(struct irq_host *host)
-{
-	pr_debug("irq: Default host set to @0x%p\n", host);
-
-	irq_default_host = host;
-}
-
-void irq_set_virq_count(unsigned int count)
-{
-	pr_debug("irq: Trying to set virq count to %d\n", count);
-
-	BUG_ON(count < NUM_ISA_INTERRUPTS);
-	if (count < NR_IRQS)
-		irq_virq_count = count;
-}
-
-static int irq_setup_virq(struct irq_host *host, unsigned int virq,
-			    irq_hw_number_t hwirq)
-{
-	struct irq_desc *desc;
-
-	desc = irq_to_desc_alloc_node(virq, 0);
-	if (!desc) {
-		pr_debug("irq: -> allocating desc failed\n");
-		goto error;
-	}
-
-	/* Clear IRQ_NOREQUEST flag */
-	desc->status &= ~IRQ_NOREQUEST;
-
-	/* map it */
-	smp_wmb();
-	irq_map[virq].hwirq = hwirq;
-	smp_mb();
-
-	if (host->ops->map(host, virq, hwirq)) {
-		pr_debug("irq: -> mapping failed, freeing\n");
-		goto error;
-	}
-
-	return 0;
-
-error:
-	irq_free_virt(virq, 1);
-	return -1;
-}
-
-unsigned int irq_create_direct_mapping(struct irq_host *host)
-{
-	unsigned int virq;
-
-	if (host == NULL)
-		host = irq_default_host;
-
-	BUG_ON(host == NULL);
-	WARN_ON(host->revmap_type != IRQ_HOST_MAP_NOMAP);
-
-	virq = irq_alloc_virt(host, 1, 0);
-	if (virq == NO_IRQ) {
-		pr_debug("irq: create_direct virq allocation failed\n");
-		return NO_IRQ;
-	}
-
-	pr_debug("irq: create_direct obtained virq %d\n", virq);
-
-	if (irq_setup_virq(host, virq, virq))
-		return NO_IRQ;
-
-	return virq;
-}
-
-unsigned int irq_create_mapping(struct irq_host *host,
-				irq_hw_number_t hwirq)
-{
-	unsigned int virq, hint;
-
-	pr_debug("irq: irq_create_mapping(0x%p, 0x%lx)\n", host, hwirq);
-
-	/* Look for default host if nececssary */
-	if (host == NULL)
-		host = irq_default_host;
-	if (host == NULL) {
-		printk(KERN_WARNING "irq_create_mapping called for"
-		       " NULL host, hwirq=%lx\n", hwirq);
-		WARN_ON(1);
-		return NO_IRQ;
-	}
-	pr_debug("irq: -> using host @%p\n", host);
-
-	/* Check if mapping already exist, if it does, call
-	 * host->ops->map() to update the flags
-	 */
-	virq = irq_find_mapping(host, hwirq);
-	if (virq != NO_IRQ) {
-		if (host->ops->remap)
-			host->ops->remap(host, virq, hwirq);
-		pr_debug("irq: -> existing mapping on virq %d\n", virq);
-		return virq;
-	}
-
-	/* Get a virtual interrupt number */
-	if (host->revmap_type == IRQ_HOST_MAP_LEGACY) {
-		/* Handle legacy */
-		virq = (unsigned int)hwirq;
-		if (virq == 0 || virq >= NUM_ISA_INTERRUPTS)
-			return NO_IRQ;
-		return virq;
-	} else {
-		/* Allocate a virtual interrupt number */
-		hint = hwirq % irq_virq_count;
-		virq = irq_alloc_virt(host, 1, hint);
-		if (virq == NO_IRQ) {
-			pr_debug("irq: -> virq allocation failed\n");
-			return NO_IRQ;
-		}
-	}
-
-	if (irq_setup_virq(host, virq, hwirq))
-		return NO_IRQ;
-
-	printk(KERN_DEBUG "irq: irq %lu on host %s mapped to virtual irq %u\n",
-		hwirq, host->of_node ? host->of_node->full_name : "null", virq);
-
-	return virq;
-}
-EXPORT_SYMBOL_GPL(irq_create_mapping);
-
-unsigned int irq_create_of_mapping(struct device_node *controller,
-				   const u32 *intspec, unsigned int intsize)
-{
-	struct irq_host *host;
-	irq_hw_number_t hwirq;
-	unsigned int type = IRQ_TYPE_NONE;
-	unsigned int virq;
-
-	if (controller == NULL)
-		host = irq_default_host;
-	else
-		host = irq_find_host(controller);
-	if (host == NULL) {
-		printk(KERN_WARNING "irq: no irq host found for %s !\n",
-		       controller->full_name);
-		return NO_IRQ;
-	}
-
-	/* If host has no translation, then we assume interrupt line */
-	if (host->ops->xlate == NULL)
-		hwirq = intspec[0];
-	else {
-		if (host->ops->xlate(host, controller, intspec, intsize,
-				     &hwirq, &type))
-			return NO_IRQ;
-	}
-
-	/* Create mapping */
-	virq = irq_create_mapping(host, hwirq);
-	if (virq == NO_IRQ)
-		return virq;
-
-	/* Set type if specified and different than the current one */
-	if (type != IRQ_TYPE_NONE &&
-	    type != (irq_to_desc(virq)->status & IRQF_TRIGGER_MASK))
-		set_irq_type(virq, type);
-	return virq;
-}
-EXPORT_SYMBOL_GPL(irq_create_of_mapping);
-
-void irq_dispose_mapping(unsigned int virq)
-{
-	struct irq_host *host;
-	irq_hw_number_t hwirq;
-
-	if (virq == NO_IRQ)
-		return;
-
-	host = irq_map[virq].host;
-	WARN_ON (host == NULL);
-	if (host == NULL)
-		return;
-
-	/* Never unmap legacy interrupts */
-	if (host->revmap_type == IRQ_HOST_MAP_LEGACY)
-		return;
-
-	/* remove chip and handler */
-	set_irq_chip_and_handler(virq, NULL, NULL);
-
-	/* Make sure it's completed */
-	synchronize_irq(virq);
-
-	/* Tell the PIC about it */
-	if (host->ops->unmap)
-		host->ops->unmap(host, virq);
-	smp_mb();
-
-	/* Clear reverse map */
-	hwirq = irq_map[virq].hwirq;
-	switch(host->revmap_type) {
-	case IRQ_HOST_MAP_LINEAR:
-		if (hwirq < host->revmap_data.linear.size)
-			host->revmap_data.linear.revmap[hwirq] = NO_IRQ;
-		break;
-	case IRQ_HOST_MAP_TREE:
-		/*
-		 * Check if radix tree allocated yet, if not then nothing to
-		 * remove.
-		 */
-		smp_rmb();
-		if (revmap_trees_allocated < 1)
-			break;
-		mutex_lock(&revmap_trees_mutex);
-		radix_tree_delete(&host->revmap_data.tree, hwirq);
-		mutex_unlock(&revmap_trees_mutex);
-		break;
-	}
-
-	/* Destroy map */
-	smp_mb();
-	irq_map[virq].hwirq = host->inval_irq;
-
-	/* Set some flags */
-	irq_to_desc(virq)->status |= IRQ_NOREQUEST;
-
-	/* Free it */
-	irq_free_virt(virq, 1);
-}
-EXPORT_SYMBOL_GPL(irq_dispose_mapping);
-
-unsigned int irq_find_mapping(struct irq_host *host,
-			      irq_hw_number_t hwirq)
-{
-	unsigned int i;
-	unsigned int hint = hwirq % irq_virq_count;
-
-	/* Look for default host if nececssary */
-	if (host == NULL)
-		host = irq_default_host;
-	if (host == NULL)
-		return NO_IRQ;
-
-	/* legacy -> bail early */
-	if (host->revmap_type == IRQ_HOST_MAP_LEGACY)
-		return hwirq;
-
-	/* Slow path does a linear search of the map */
-	if (hint < NUM_ISA_INTERRUPTS)
-		hint = NUM_ISA_INTERRUPTS;
-	i = hint;
-	do  {
-		if (irq_map[i].host == host &&
-		    irq_map[i].hwirq == hwirq)
-			return i;
-		i++;
-		if (i >= irq_virq_count)
-			i = NUM_ISA_INTERRUPTS;
-	} while(i != hint);
-	return NO_IRQ;
-}
-EXPORT_SYMBOL_GPL(irq_find_mapping);
-
-
-unsigned int irq_radix_revmap_lookup(struct irq_host *host,
-				     irq_hw_number_t hwirq)
-{
-	struct irq_map_entry *ptr;
-	unsigned int virq;
-
-	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
-
-	/*
-	 * Check if the radix tree exists and has bee initialized.
-	 * If not, we fallback to slow mode
-	 */
-	if (revmap_trees_allocated < 2)
-		return irq_find_mapping(host, hwirq);
-
-	/* Now try to resolve */
-	/*
-	 * No rcu_read_lock(ing) needed, the ptr returned can't go under us
-	 * as it's referencing an entry in the static irq_map table.
-	 */
-	ptr = radix_tree_lookup(&host->revmap_data.tree, hwirq);
-
-	/*
-	 * If found in radix tree, then fine.
-	 * Else fallback to linear lookup - this should not happen in practice
-	 * as it means that we failed to insert the node in the radix tree.
-	 */
-	if (ptr)
-		virq = ptr - irq_map;
-	else
-		virq = irq_find_mapping(host, hwirq);
-
-	return virq;
-}
-
-void irq_radix_revmap_insert(struct irq_host *host, unsigned int virq,
-			     irq_hw_number_t hwirq)
-{
-
-	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
-
-	/*
-	 * Check if the radix tree exists yet.
-	 * If not, then the irq will be inserted into the tree when it gets
-	 * initialized.
-	 */
-	smp_rmb();
-	if (revmap_trees_allocated < 1)
-		return;
-
-	if (virq != NO_IRQ) {
-		mutex_lock(&revmap_trees_mutex);
-		radix_tree_insert(&host->revmap_data.tree, hwirq,
-				  &irq_map[virq]);
-		mutex_unlock(&revmap_trees_mutex);
-	}
-}
-
-unsigned int irq_linear_revmap(struct irq_host *host,
-			       irq_hw_number_t hwirq)
-{
-	unsigned int *revmap;
-
-	WARN_ON(host->revmap_type != IRQ_HOST_MAP_LINEAR);
-
-	/* Check revmap bounds */
-	if (unlikely(hwirq >= host->revmap_data.linear.size))
-		return irq_find_mapping(host, hwirq);
-
-	/* Check if revmap was allocated */
-	revmap = host->revmap_data.linear.revmap;
-	if (unlikely(revmap == NULL))
-		return irq_find_mapping(host, hwirq);
-
-	/* Fill up revmap with slow path if no mapping found */
-	if (unlikely(revmap[hwirq] == NO_IRQ))
-		revmap[hwirq] = irq_find_mapping(host, hwirq);
-
-	return revmap[hwirq];
-}
-
-unsigned int irq_alloc_virt(struct irq_host *host,
-			    unsigned int count,
-			    unsigned int hint)
-{
-	unsigned long flags;
-	unsigned int i, j, found = NO_IRQ;
-
-	if (count == 0 || count > (irq_virq_count - NUM_ISA_INTERRUPTS))
-		return NO_IRQ;
-
-	raw_spin_lock_irqsave(&irq_big_lock, flags);
-
-	/* Use hint for 1 interrupt if any */
-	if (count == 1 && hint >= NUM_ISA_INTERRUPTS &&
-	    hint < irq_virq_count && irq_map[hint].host == NULL) {
-		found = hint;
-		goto hint_found;
-	}
-
-	/* Look for count consecutive numbers in the allocatable
-	 * (non-legacy) space
-	 */
-	for (i = NUM_ISA_INTERRUPTS, j = 0; i < irq_virq_count; i++) {
-		if (irq_map[i].host != NULL)
-			j = 0;
-		else
-			j++;
-
-		if (j == count) {
-			found = i - count + 1;
-			break;
-		}
-	}
-	if (found == NO_IRQ) {
-		raw_spin_unlock_irqrestore(&irq_big_lock, flags);
-		return NO_IRQ;
-	}
- hint_found:
-	for (i = found; i < (found + count); i++) {
-		irq_map[i].hwirq = host->inval_irq;
-		smp_wmb();
-		irq_map[i].host = host;
-	}
-	raw_spin_unlock_irqrestore(&irq_big_lock, flags);
-	return found;
-}
-
-void irq_free_virt(unsigned int virq, unsigned int count)
-{
-	unsigned long flags;
-	unsigned int i;
-
-	WARN_ON (virq < NUM_ISA_INTERRUPTS);
-	WARN_ON (count == 0 || (virq + count) > irq_virq_count);
-
-	raw_spin_lock_irqsave(&irq_big_lock, flags);
-	for (i = virq; i < (virq + count); i++) {
-		struct irq_host *host;
-
-		if (i < NUM_ISA_INTERRUPTS ||
-		    (virq + count) > irq_virq_count)
-			continue;
-
-		host = irq_map[i].host;
-		irq_map[i].hwirq = host->inval_irq;
-		smp_wmb();
-		irq_map[i].host = NULL;
-	}
-	raw_spin_unlock_irqrestore(&irq_big_lock, flags);
-}
-
 int arch_early_irq_init(void)
 {
 	struct irq_desc *desc;
@@ -1090,118 +543,6 @@ int arch_init_chip_data(struct irq_desc *desc, int node)
 	return 0;
 }
 
-/* We need to create the radix trees late */
-static int irq_late_init(void)
-{
-	struct irq_host *h;
-	unsigned int i;
-
-	/*
-	 * No mutual exclusion with respect to accessors of the tree is needed
-	 * here as the synchronization is done via the state variable
-	 * revmap_trees_allocated.
-	 */
-	list_for_each_entry(h, &irq_hosts, link) {
-		if (h->revmap_type == IRQ_HOST_MAP_TREE)
-			INIT_RADIX_TREE(&h->revmap_data.tree, GFP_KERNEL);
-	}
-
-	/*
-	 * Make sure the radix trees inits are visible before setting
-	 * the flag
-	 */
-	smp_wmb();
-	revmap_trees_allocated = 1;
-
-	/*
-	 * Insert the reverse mapping for those interrupts already present
-	 * in irq_map[].
-	 */
-	mutex_lock(&revmap_trees_mutex);
-	for (i = 0; i < irq_virq_count; i++) {
-		if (irq_map[i].host &&
-		    (irq_map[i].host->revmap_type == IRQ_HOST_MAP_TREE))
-			radix_tree_insert(&irq_map[i].host->revmap_data.tree,
-					  irq_map[i].hwirq, &irq_map[i]);
-	}
-	mutex_unlock(&revmap_trees_mutex);
-
-	/*
-	 * Make sure the radix trees insertions are visible before setting
-	 * the flag
-	 */
-	smp_wmb();
-	revmap_trees_allocated = 2;
-
-	return 0;
-}
-arch_initcall(irq_late_init);
-
-#ifdef CONFIG_VIRQ_DEBUG
-static int virq_debug_show(struct seq_file *m, void *private)
-{
-	unsigned long flags;
-	struct irq_desc *desc;
-	const char *p;
-	char none[] = "none";
-	int i;
-
-	seq_printf(m, "%-5s  %-7s  %-15s  %s\n", "virq", "hwirq",
-		      "chip name", "host name");
-
-	for (i = 1; i < nr_irqs; i++) {
-		desc = irq_to_desc(i);
-		if (!desc)
-			continue;
-
-		raw_spin_lock_irqsave(&desc->lock, flags);
-
-		if (desc->action && desc->action->handler) {
-			seq_printf(m, "%5d  ", i);
-			seq_printf(m, "0x%05lx  ", virq_to_hw(i));
-
-			if (desc->chip && desc->chip->name)
-				p = desc->chip->name;
-			else
-				p = none;
-			seq_printf(m, "%-15s  ", p);
-
-			if (irq_map[i].host && irq_map[i].host->of_node)
-				p = irq_map[i].host->of_node->full_name;
-			else
-				p = none;
-			seq_printf(m, "%s\n", p);
-		}
-
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-
-	return 0;
-}
-
-static int virq_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, virq_debug_show, inode->i_private);
-}
-
-static const struct file_operations virq_debug_fops = {
-	.open = virq_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int __init irq_debugfs_init(void)
-{
-	if (debugfs_create_file("virq_mapping", S_IRUGO, powerpc_debugfs_root,
-				 NULL, &virq_debug_fops) == NULL)
-		return -ENOMEM;
-
-	return 0;
-}
-__initcall(irq_debugfs_init);
-#endif /* CONFIG_VIRQ_DEBUG */
-
 #ifdef CONFIG_PPC64
 static int __init setup_noirqdistrib(char *str)
 {
diff --git a/include/linux/virq.h b/include/linux/virq.h
new file mode 100644
index 0000000..06035ef
--- /dev/null
+++ b/include/linux/virq.h
@@ -0,0 +1,302 @@
+/*
+ * Virtual IRQ infrastructure
+ *
+ * Virtual IRQs provides support for dynamically allocating ranges of IRQ
+ * numbers for use by interrupt controllers.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ */
+
+
+#ifdef __KERNEL__
+#ifndef _LINUX_VIRQ_H
+#define _LINUX_VIRQ_H
+
+#include <asm/irq.h>
+
+#ifdef CONFIG_VIRQ
+
+/* Define a way to iterate across irqs. */
+#define for_each_irq(i) \
+	for ((i) = 0; (i) < NR_IRQS; ++(i))
+
+/* This type is the placeholder for a hardware interrupt number. It has to
+ * be big enough to enclose whatever representation is used by a given
+ * platform.
+ */
+typedef unsigned long irq_hw_number_t;
+
+/* Interrupt controller "host" data structure. This could be defined as a
+ * irq domain controller. That is, it handles the mapping between hardware
+ * and virtual interrupt numbers for a given interrupt domain. The host
+ * structure is generally created by the PIC code for a given PIC instance
+ * (though a host can cover more than one PIC if they have a flat number
+ * model). It's the host callbacks that are responsible for setting the
+ * irq_chip on a given irq_desc after it's been mapped.
+ *
+ * The host code and data structures are fairly agnostic to the fact that
+ * we use an open firmware device-tree. We do have references to struct
+ * device_node in two places: in irq_find_host() to find the host matching
+ * a given interrupt controller node, and of course as an argument to its
+ * counterpart host->ops->match() callback. However, those are treated as
+ * generic pointers by the core and the fact that it's actually a device-node
+ * pointer is purely a convention between callers and implementation. This
+ * code could thus be used on other architectures by replacing those two
+ * by some sort of arch-specific void * "token" used to identify interrupt
+ * controllers.
+ */
+struct irq_host;
+struct radix_tree_root;
+struct device_node;
+
+/**
+ * struct irq_host_ops - operations for managing per-domain hw irq numbers
+ *
+ * Functions below are provided by the host and called whenever a new mapping
+ * is created or an old mapping is disposed. The host can then proceed to
+ * whatever internal data structures management is required. It also needs
+ * to setup the irq_desc when returning from map().
+ */
+struct irq_host_ops {
+	/* Match an interrupt controller device node to a host, returns
+	 * 1 on a match
+	 */
+	int (*match)(struct irq_host *h, struct device_node *node);
+
+	/* Create or update a mapping between a virtual irq number and a hw
+	 * irq number. This is called only once for a given mapping.
+	 */
+	int (*map)(struct irq_host *h, unsigned int virq, irq_hw_number_t hw);
+
+	/* Dispose of such a mapping */
+	void (*unmap)(struct irq_host *h, unsigned int virq);
+
+	/* Update of such a mapping  */
+	void (*remap)(struct irq_host *h, unsigned int virq, irq_hw_number_t hw);
+
+	/* Translate device-tree interrupt specifier from raw format coming
+	 * from the firmware to a irq_hw_number_t (interrupt line number) and
+	 * type (sense) that can be passed to set_irq_type(). In the absence
+	 * of this callback, irq_create_of_mapping() and irq_of_parse_and_map()
+	 * will return the hw number in the first cell and IRQ_TYPE_NONE for
+	 * the type (which amount to keeping whatever default value the
+	 * interrupt controller has for that line)
+	 */
+	int (*xlate)(struct irq_host *h, struct device_node *ctrler,
+		     const u32 *intspec, unsigned int intsize,
+		     irq_hw_number_t *out_hwirq, unsigned int *out_type);
+};
+
+/**
+ * struct irq_host - a single irq domain. maps hw irq numbers to Linux irq.
+ * @link: entry in global irq_host list
+ * @revmap_type: Method of reverse mapping hwirq to Linux irq number
+ * @revmap_data: reverse map data
+ * @ops: irq domain operations (documented above)
+ * @host_data: irq controller driver data; core does not touch this pointer
+ * @inval_irq: hw irq number used for unassigned virqs
+ * @of_node: Optional pointer to the irq controllers device tree node.
+ *
+ * One irq_host is allocated for each range (domain) of Linux irq numbers
+ * allocated.  Typically, one irq_host is allocated per controller, but it
+ * is perfectly valid to manage multiple controllers with a single irq_host
+ * instance if need be.
+ */
+struct irq_host {
+	struct list_head	link;
+
+	/* type of reverse mapping technique */
+	unsigned int		revmap_type;
+#define IRQ_HOST_MAP_LEGACY     0 /* legacy 8259, gets irqs 1..15 */
+#define IRQ_HOST_MAP_NOMAP	1 /* no fast reverse mapping */
+#define IRQ_HOST_MAP_LINEAR	2 /* linear map of interrupts */
+#define IRQ_HOST_MAP_TREE	3 /* radix tree */
+	union {
+		struct {
+			unsigned int size;
+			unsigned int *revmap;
+		} linear;
+		struct radix_tree_root tree;
+	} revmap_data;
+	struct irq_host_ops	*ops;
+	void			*host_data;
+	irq_hw_number_t		inval_irq;
+
+	/* Optional device node pointer */
+	struct device_node	*of_node;
+};
+
+/**
+ * irq_alloc_host() - Allocate a new irq_host data structure
+ * @of_node: optional device-tree node of the interrupt controller
+ * @revmap_type: type of reverse mapping to use
+ * @revmap_arg: for IRQ_HOST_MAP_LINEAR linear only: size of the map
+ * @ops: map/unmap host callbacks
+ * @inval_irq: provide a hw number in that host space that is always invalid
+ *
+ * Allocates and initialize and irq_host structure. Note that in the case of
+ * IRQ_HOST_MAP_LEGACY, the map() callback will be called before this returns
+ * for all legacy interrupts except 0 (which is always the invalid irq for
+ * a legacy controller). For a IRQ_HOST_MAP_LINEAR, the map is allocated by
+ * this call as well. For a IRQ_HOST_MAP_TREE, the radix tree will be allocated
+ * later during boot automatically (the reverse mapping will use the slow path
+ * until that happens).
+ */
+extern struct irq_host *irq_alloc_host(struct device_node *of_node,
+				       unsigned int revmap_type,
+				       unsigned int revmap_arg,
+				       struct irq_host_ops *ops,
+				       irq_hw_number_t inval_irq);
+
+/* The main irq map itself is an array of NR_IRQ entries containing the
+ * associate host and irq number. An entry with a host of NULL is free.
+ * An entry can be allocated if it's free, the allocator always then sets
+ * hwirq first to the host's invalid irq number and then fills ops.
+ */
+struct irq_map_entry {
+	irq_hw_number_t	hwirq;
+	struct irq_host	*host;
+};
+extern struct irq_map_entry irq_map[NR_IRQS];
+
+extern irq_hw_number_t virq_to_hw(unsigned int virq);
+
+/**
+ * irq_find_host - Locates a host for a given device node
+ * @node: device-tree node of the interrupt controller
+ */
+extern struct irq_host *irq_find_host(struct device_node *node);
+
+/**
+ * irq_set_default_host - Set a "default" host
+ * @host: default host pointer
+ *
+ * For convenience, it's possible to set a "default" host that will be used
+ * whenever NULL is passed to irq_create_mapping(). It makes life easier for
+ * platforms that want to manipulate a few hard coded interrupt numbers that
+ * aren't properly represented in the device-tree.
+ */
+extern void irq_set_default_host(struct irq_host *host);
+
+/**
+ * irq_set_virq_count - Set the maximum number of virt irqs
+ * @count: number of linux virtual irqs, capped with NR_IRQS
+ *
+ * This is mainly for use by platforms like iSeries who want to program
+ * the virtual irq number in the controller to avoid the reverse mapping
+ */
+extern void irq_set_virq_count(unsigned int count);
+
+/**
+ * irq_create_mapping - Map a hardware interrupt into linux virq space
+ * @host: host owning this hardware interrupt or NULL for default host
+ * @hwirq: hardware irq number in that host space
+ *
+ * Only one mapping per hardware interrupt is permitted. Returns a linux
+ * virq number.
+ * If the sense/trigger is to be specified, set_irq_type() should be called
+ * on the number returned from that call.
+ */
+extern unsigned int irq_create_mapping(struct irq_host *host,
+				       irq_hw_number_t hwirq);
+
+/**
+ * irq_dispose_mapping - Unmap an interrupt
+ * @virq: linux virq number of the interrupt to unmap
+ */
+extern void irq_dispose_mapping(unsigned int virq);
+
+/**
+ * irq_find_mapping - Find a linux virq from an hw irq number.
+ * @host: host owning this hardware interrupt
+ * @hwirq: hardware irq number in that host space
+ *
+ * This is a slow path, for use by generic code. It's expected that an
+ * irq controller implementation directly calls the appropriate low level
+ * mapping function.
+ */
+extern unsigned int irq_find_mapping(struct irq_host *host,
+				     irq_hw_number_t hwirq);
+
+/**
+ * irq_create_direct_mapping - Allocate a virq for direct mapping
+ * @host: host to allocate the virq for or NULL for default host
+ *
+ * This routine is used for irq controllers which can choose the hardware
+ * interrupt numbers they generate. In such a case it's simplest to use
+ * the linux virq as the hardware interrupt number.
+ */
+extern unsigned int irq_create_direct_mapping(struct irq_host *host);
+
+/**
+ * irq_radix_revmap_insert - Insert a hw irq to linux virq number mapping.
+ * @host: host owning this hardware interrupt
+ * @virq: linux irq number
+ * @hwirq: hardware irq number in that host space
+ *
+ * This is for use by irq controllers that use a radix tree reverse
+ * mapping for fast lookup.
+ */
+extern void irq_radix_revmap_insert(struct irq_host *host, unsigned int virq,
+				    irq_hw_number_t hwirq);
+
+/**
+ * irq_radix_revmap_lookup - Find a linux virq from a hw irq number.
+ * @host: host owning this hardware interrupt
+ * @hwirq: hardware irq number in that host space
+ *
+ * This is a fast path, for use by irq controller code that uses radix tree
+ * revmaps
+ */
+extern unsigned int irq_radix_revmap_lookup(struct irq_host *host,
+					    irq_hw_number_t hwirq);
+
+/**
+ * irq_linear_revmap - Find a linux virq from a hw irq number.
+ * @host: host owning this hardware interrupt
+ * @hwirq: hardware irq number in that host space
+ *
+ * This is a fast path, for use by irq controller code that uses linear
+ * revmaps. It does fallback to the slow path if the revmap doesn't exist
+ * yet and will create the revmap entry with appropriate locking
+ */
+
+extern unsigned int irq_linear_revmap(struct irq_host *host,
+				      irq_hw_number_t hwirq);
+
+
+
+/**
+ * irq_alloc_virt - Allocate virtual irq numbers
+ * @host: host owning these new virtual irqs
+ * @count: number of consecutive numbers to allocate
+ * @hint: pass a hint number, the allocator will try to use a 1:1 mapping
+ *
+ * This is a low level function that is used internally by irq_create_mapping()
+ * and that can be used by some irq controllers implementations for things
+ * like allocating ranges of numbers for MSIs. The revmaps are left untouched.
+ */
+extern unsigned int irq_alloc_virt(struct irq_host *host,
+				   unsigned int count,
+				   unsigned int hint);
+
+/**
+ * irq_free_virt - Free virtual irq numbers
+ * @virq: virtual irq number of the first interrupt to free
+ * @count: number of interrupts to free
+ *
+ * This function is the opposite of irq_alloc_virt. It will not clear reverse
+ * maps, this should be done previously by unmap'ing the interrupt. In fact,
+ * all interrupts covered by the range being freed should have been unmapped
+ * prior to calling this.
+ */
+extern void irq_free_virt(unsigned int virq, unsigned int count);
+
+
+#endif /* CONFIG_VIRQ */
+
+#endif /* _LINUX_VIRQ_H */
+#endif /* __KERNEL__ */
+
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index 7d04780..f5207dc 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -1,5 +1,6 @@
 
 obj-y := handle.o manage.o spurious.o resend.o chip.o devres.o
+obj-$(CONFIG_VIRQ) += virq.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
diff --git a/kernel/irq/virq.c b/kernel/irq/virq.c
new file mode 100644
index 0000000..b3c0db3
--- /dev/null
+++ b/kernel/irq/virq.c
@@ -0,0 +1,687 @@
+/*
+ * Mapping support from per-controller hw irq numbers to linux irqs
+ *
+ *  Derived from arch/i386/kernel/irq.c
+ *    Copyright (C) 1992 Linus Torvalds
+ *  Adapted from arch/i386 by Gary Thomas
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *  Updated and modified by Cort Dougan <cort@fsmlabs.com>
+ *    Copyright (C) 1996-2001 Cort Dougan
+ *  Adapted for Power Macintosh by Paul Mackerras
+ *    Copyright (C) 1996 Paul Mackerras (paulus@cs.anu.edu.au)
+ *  Generalized for virtual irq mapping on all platformes by Grant Likely
+ *    Copyright (C) 2010 Secret Lab Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/radix-tree.h>
+#include <linux/virq.h>
+#include <linux/of_irq.h>
+
+/*
+ * IRQ controller and virtual interrupts
+ */
+static LIST_HEAD(irq_hosts);
+static DEFINE_RAW_SPINLOCK(irq_big_lock);
+static unsigned int revmap_trees_allocated;
+static DEFINE_MUTEX(revmap_trees_mutex);
+struct irq_map_entry irq_map[NR_IRQS];
+static unsigned int irq_virq_count = NR_IRQS;
+static struct irq_host *irq_default_host;
+
+irq_hw_number_t virq_to_hw(unsigned int virq)
+{
+	return irq_map[virq].hwirq;
+}
+EXPORT_SYMBOL_GPL(virq_to_hw);
+
+static int default_irq_host_match(struct irq_host *h, struct device_node *np)
+{
+	return h->of_node != NULL && h->of_node == np;
+}
+
+struct irq_host *irq_alloc_host(struct device_node *of_node,
+				unsigned int revmap_type,
+				unsigned int revmap_arg,
+				struct irq_host_ops *ops,
+				irq_hw_number_t inval_irq)
+{
+	struct irq_host *host;
+	unsigned int size = sizeof(struct irq_host);
+	unsigned int i;
+	unsigned int *rmap;
+	unsigned long flags;
+
+	/* Allocate structure and revmap table if using linear mapping */
+	if (revmap_type == IRQ_HOST_MAP_LINEAR)
+		size += revmap_arg * sizeof(unsigned int);
+	host = zalloc_maybe_bootmem(size, GFP_KERNEL);
+	if (host == NULL)
+		return NULL;
+
+	/* Fill structure */
+	host->revmap_type = revmap_type;
+	host->inval_irq = inval_irq;
+	host->ops = ops;
+	host->of_node = of_node_get(of_node);
+
+	if (host->ops->match == NULL)
+		host->ops->match = default_irq_host_match;
+
+	raw_spin_lock_irqsave(&irq_big_lock, flags);
+
+	/* If it's a legacy controller, check for duplicates and
+	 * mark it as allocated (we use irq 0 host pointer for that
+	 */
+	if (revmap_type == IRQ_HOST_MAP_LEGACY) {
+		if (irq_map[0].host != NULL) {
+			raw_spin_unlock_irqrestore(&irq_big_lock, flags);
+			/* If we are early boot, we can't free the structure,
+			 * too bad...
+			 * this will be fixed once slab is made available early
+			 * instead of the current cruft
+			 */
+			if (mem_init_done)
+				kfree(host);
+			return NULL;
+		}
+		irq_map[0].host = host;
+	}
+
+	list_add(&host->link, &irq_hosts);
+	raw_spin_unlock_irqrestore(&irq_big_lock, flags);
+
+	/* Additional setups per revmap type */
+	switch(revmap_type) {
+	case IRQ_HOST_MAP_LEGACY:
+		/* 0 is always the invalid number for legacy */
+		host->inval_irq = 0;
+		/* setup us as the host for all legacy interrupts */
+		for (i = 1; i < NUM_ISA_INTERRUPTS; i++) {
+			irq_map[i].hwirq = i;
+			smp_wmb();
+			irq_map[i].host = host;
+			smp_wmb();
+
+			/* Clear norequest flags */
+			irq_to_desc(i)->status &= ~IRQ_NOREQUEST;
+
+			/* Legacy flags are left to default at this point,
+			 * one can then use irq_create_mapping() to
+			 * explicitly change them
+			 */
+			ops->map(host, i, i);
+		}
+		break;
+	case IRQ_HOST_MAP_LINEAR:
+		rmap = (unsigned int *)(host + 1);
+		for (i = 0; i < revmap_arg; i++)
+			rmap[i] = NO_IRQ;
+		host->revmap_data.linear.size = revmap_arg;
+		smp_wmb();
+		host->revmap_data.linear.revmap = rmap;
+		break;
+	default:
+		break;
+	}
+
+	pr_debug("irq: Allocated host of type %d @0x%p\n", revmap_type, host);
+
+	return host;
+}
+
+struct irq_host *irq_find_host(struct device_node *node)
+{
+	struct irq_host *h, *found = NULL;
+	unsigned long flags;
+
+	/* We might want to match the legacy controller last since
+	 * it might potentially be set to match all interrupts in
+	 * the absence of a device node. This isn't a problem so far
+	 * yet though...
+	 */
+	raw_spin_lock_irqsave(&irq_big_lock, flags);
+	list_for_each_entry(h, &irq_hosts, link)
+		if (h->ops->match(h, node)) {
+			found = h;
+			break;
+		}
+	raw_spin_unlock_irqrestore(&irq_big_lock, flags);
+	return found;
+}
+EXPORT_SYMBOL_GPL(irq_find_host);
+
+void irq_set_default_host(struct irq_host *host)
+{
+	pr_debug("irq: Default host set to @0x%p\n", host);
+
+	irq_default_host = host;
+}
+
+void irq_set_virq_count(unsigned int count)
+{
+	pr_debug("irq: Trying to set virq count to %d\n", count);
+
+	BUG_ON(count < NUM_ISA_INTERRUPTS);
+	if (count < NR_IRQS)
+		irq_virq_count = count;
+}
+
+static int irq_setup_virq(struct irq_host *host, unsigned int virq,
+			    irq_hw_number_t hwirq)
+{
+	struct irq_desc *desc;
+
+	desc = irq_to_desc_alloc_node(virq, 0);
+	if (!desc) {
+		pr_debug("irq: -> allocating desc failed\n");
+		goto error;
+	}
+
+	/* Clear IRQ_NOREQUEST flag */
+	desc->status &= ~IRQ_NOREQUEST;
+
+	/* map it */
+	smp_wmb();
+	irq_map[virq].hwirq = hwirq;
+	smp_mb();
+
+	if (host->ops->map(host, virq, hwirq)) {
+		pr_debug("irq: -> mapping failed, freeing\n");
+		goto error;
+	}
+
+	return 0;
+
+error:
+	irq_free_virt(virq, 1);
+	return -1;
+}
+
+unsigned int irq_create_direct_mapping(struct irq_host *host)
+{
+	unsigned int virq;
+
+	if (host == NULL)
+		host = irq_default_host;
+
+	BUG_ON(host == NULL);
+	WARN_ON(host->revmap_type != IRQ_HOST_MAP_NOMAP);
+
+	virq = irq_alloc_virt(host, 1, 0);
+	if (virq == NO_IRQ) {
+		pr_debug("irq: create_direct virq allocation failed\n");
+		return NO_IRQ;
+	}
+
+	pr_debug("irq: create_direct obtained virq %d\n", virq);
+
+	if (irq_setup_virq(host, virq, virq))
+		return NO_IRQ;
+
+	return virq;
+}
+
+unsigned int irq_create_mapping(struct irq_host *host,
+				irq_hw_number_t hwirq)
+{
+	unsigned int virq, hint;
+
+	pr_debug("irq: irq_create_mapping(0x%p, 0x%lx)\n", host, hwirq);
+
+	/* Look for default host if nececssary */
+	if (host == NULL)
+		host = irq_default_host;
+	if (host == NULL) {
+		printk(KERN_WARNING "irq_create_mapping called for"
+		       " NULL host, hwirq=%lx\n", hwirq);
+		WARN_ON(1);
+		return NO_IRQ;
+	}
+	pr_debug("irq: -> using host @%p\n", host);
+
+	/* Check if mapping already exist, if it does, call
+	 * host->ops->map() to update the flags
+	 */
+	virq = irq_find_mapping(host, hwirq);
+	if (virq != NO_IRQ) {
+		if (host->ops->remap)
+			host->ops->remap(host, virq, hwirq);
+		pr_debug("irq: -> existing mapping on virq %d\n", virq);
+		return virq;
+	}
+
+	/* Get a virtual interrupt number */
+	if (host->revmap_type == IRQ_HOST_MAP_LEGACY) {
+		/* Handle legacy */
+		virq = (unsigned int)hwirq;
+		if (virq == 0 || virq >= NUM_ISA_INTERRUPTS)
+			return NO_IRQ;
+		return virq;
+	} else {
+		/* Allocate a virtual interrupt number */
+		hint = hwirq % irq_virq_count;
+		virq = irq_alloc_virt(host, 1, hint);
+		if (virq == NO_IRQ) {
+			pr_debug("irq: -> virq allocation failed\n");
+			return NO_IRQ;
+		}
+	}
+
+	if (irq_setup_virq(host, virq, hwirq))
+		return NO_IRQ;
+
+	printk(KERN_DEBUG "irq: irq %lu on host %s mapped to virtual irq %u\n",
+		hwirq, host->of_node ? host->of_node->full_name : "null", virq);
+
+	return virq;
+}
+EXPORT_SYMBOL_GPL(irq_create_mapping);
+
+unsigned int irq_create_of_mapping(struct device_node *controller,
+				   const u32 *intspec, unsigned int intsize)
+{
+	struct irq_host *host;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	unsigned int virq;
+
+	if (controller == NULL)
+		host = irq_default_host;
+	else
+		host = irq_find_host(controller);
+	if (host == NULL) {
+		printk(KERN_WARNING "irq: no irq host found for %s !\n",
+		       controller->full_name);
+		return NO_IRQ;
+	}
+
+	/* If host has no translation, then we assume interrupt line */
+	if (host->ops->xlate == NULL)
+		hwirq = intspec[0];
+	else {
+		if (host->ops->xlate(host, controller, intspec, intsize,
+				     &hwirq, &type))
+			return NO_IRQ;
+	}
+
+	/* Create mapping */
+	virq = irq_create_mapping(host, hwirq);
+	if (virq == NO_IRQ)
+		return virq;
+
+	/* Set type if specified and different than the current one */
+	if (type != IRQ_TYPE_NONE &&
+	    type != (irq_to_desc(virq)->status & IRQF_TRIGGER_MASK))
+		set_irq_type(virq, type);
+	return virq;
+}
+EXPORT_SYMBOL_GPL(irq_create_of_mapping);
+
+void irq_dispose_mapping(unsigned int virq)
+{
+	struct irq_host *host;
+	irq_hw_number_t hwirq;
+
+	if (virq == NO_IRQ)
+		return;
+
+	host = irq_map[virq].host;
+	WARN_ON (host == NULL);
+	if (host == NULL)
+		return;
+
+	/* Never unmap legacy interrupts */
+	if (host->revmap_type == IRQ_HOST_MAP_LEGACY)
+		return;
+
+	/* remove chip and handler */
+	set_irq_chip_and_handler(virq, NULL, NULL);
+
+	/* Make sure it's completed */
+	synchronize_irq(virq);
+
+	/* Tell the PIC about it */
+	if (host->ops->unmap)
+		host->ops->unmap(host, virq);
+	smp_mb();
+
+	/* Clear reverse map */
+	hwirq = irq_map[virq].hwirq;
+	switch(host->revmap_type) {
+	case IRQ_HOST_MAP_LINEAR:
+		if (hwirq < host->revmap_data.linear.size)
+			host->revmap_data.linear.revmap[hwirq] = NO_IRQ;
+		break;
+	case IRQ_HOST_MAP_TREE:
+		/*
+		 * Check if radix tree allocated yet, if not then nothing to
+		 * remove.
+		 */
+		smp_rmb();
+		if (revmap_trees_allocated < 1)
+			break;
+		mutex_lock(&revmap_trees_mutex);
+		radix_tree_delete(&host->revmap_data.tree, hwirq);
+		mutex_unlock(&revmap_trees_mutex);
+		break;
+	}
+
+	/* Destroy map */
+	smp_mb();
+	irq_map[virq].hwirq = host->inval_irq;
+
+	/* Set some flags */
+	irq_to_desc(virq)->status |= IRQ_NOREQUEST;
+
+	/* Free it */
+	irq_free_virt(virq, 1);
+}
+EXPORT_SYMBOL_GPL(irq_dispose_mapping);
+
+unsigned int irq_find_mapping(struct irq_host *host,
+			      irq_hw_number_t hwirq)
+{
+	unsigned int i;
+	unsigned int hint = hwirq % irq_virq_count;
+
+	/* Look for default host if nececssary */
+	if (host == NULL)
+		host = irq_default_host;
+	if (host == NULL)
+		return NO_IRQ;
+
+	/* legacy -> bail early */
+	if (host->revmap_type == IRQ_HOST_MAP_LEGACY)
+		return hwirq;
+
+	/* Slow path does a linear search of the map */
+	if (hint < NUM_ISA_INTERRUPTS)
+		hint = NUM_ISA_INTERRUPTS;
+	i = hint;
+	do  {
+		if (irq_map[i].host == host &&
+		    irq_map[i].hwirq == hwirq)
+			return i;
+		i++;
+		if (i >= irq_virq_count)
+			i = NUM_ISA_INTERRUPTS;
+	} while(i != hint);
+	return NO_IRQ;
+}
+EXPORT_SYMBOL_GPL(irq_find_mapping);
+
+
+unsigned int irq_radix_revmap_lookup(struct irq_host *host,
+				     irq_hw_number_t hwirq)
+{
+	struct irq_map_entry *ptr;
+	unsigned int virq;
+
+	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
+
+	/*
+	 * Check if the radix tree exists and has bee initialized.
+	 * If not, we fallback to slow mode
+	 */
+	if (revmap_trees_allocated < 2)
+		return irq_find_mapping(host, hwirq);
+
+	/* Now try to resolve */
+	/*
+	 * No rcu_read_lock(ing) needed, the ptr returned can't go under us
+	 * as it's referencing an entry in the static irq_map table.
+	 */
+	ptr = radix_tree_lookup(&host->revmap_data.tree, hwirq);
+
+	/*
+	 * If found in radix tree, then fine.
+	 * Else fallback to linear lookup - this should not happen in practice
+	 * as it means that we failed to insert the node in the radix tree.
+	 */
+	if (ptr)
+		virq = ptr - irq_map;
+	else
+		virq = irq_find_mapping(host, hwirq);
+
+	return virq;
+}
+
+void irq_radix_revmap_insert(struct irq_host *host, unsigned int virq,
+			     irq_hw_number_t hwirq)
+{
+
+	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
+
+	/*
+	 * Check if the radix tree exists yet.
+	 * If not, then the irq will be inserted into the tree when it gets
+	 * initialized.
+	 */
+	smp_rmb();
+	if (revmap_trees_allocated < 1)
+		return;
+
+	if (virq != NO_IRQ) {
+		mutex_lock(&revmap_trees_mutex);
+		radix_tree_insert(&host->revmap_data.tree, hwirq,
+				  &irq_map[virq]);
+		mutex_unlock(&revmap_trees_mutex);
+	}
+}
+
+unsigned int irq_linear_revmap(struct irq_host *host,
+			       irq_hw_number_t hwirq)
+{
+	unsigned int *revmap;
+
+	WARN_ON(host->revmap_type != IRQ_HOST_MAP_LINEAR);
+
+	/* Check revmap bounds */
+	if (unlikely(hwirq >= host->revmap_data.linear.size))
+		return irq_find_mapping(host, hwirq);
+
+	/* Check if revmap was allocated */
+	revmap = host->revmap_data.linear.revmap;
+	if (unlikely(revmap == NULL))
+		return irq_find_mapping(host, hwirq);
+
+	/* Fill up revmap with slow path if no mapping found */
+	if (unlikely(revmap[hwirq] == NO_IRQ))
+		revmap[hwirq] = irq_find_mapping(host, hwirq);
+
+	return revmap[hwirq];
+}
+
+unsigned int irq_alloc_virt(struct irq_host *host,
+			    unsigned int count,
+			    unsigned int hint)
+{
+	unsigned long flags;
+	unsigned int i, j, found = NO_IRQ;
+
+	if (count == 0 || count > (irq_virq_count - NUM_ISA_INTERRUPTS))
+		return NO_IRQ;
+
+	raw_spin_lock_irqsave(&irq_big_lock, flags);
+
+	/* Use hint for 1 interrupt if any */
+	if (count == 1 && hint >= NUM_ISA_INTERRUPTS &&
+	    hint < irq_virq_count && irq_map[hint].host == NULL) {
+		found = hint;
+		goto hint_found;
+	}
+
+	/* Look for count consecutive numbers in the allocatable
+	 * (non-legacy) space
+	 */
+	for (i = NUM_ISA_INTERRUPTS, j = 0; i < irq_virq_count; i++) {
+		if (irq_map[i].host != NULL)
+			j = 0;
+		else
+			j++;
+
+		if (j == count) {
+			found = i - count + 1;
+			break;
+		}
+	}
+	if (found == NO_IRQ) {
+		raw_spin_unlock_irqrestore(&irq_big_lock, flags);
+		return NO_IRQ;
+	}
+ hint_found:
+	for (i = found; i < (found + count); i++) {
+		irq_map[i].hwirq = host->inval_irq;
+		smp_wmb();
+		irq_map[i].host = host;
+	}
+	raw_spin_unlock_irqrestore(&irq_big_lock, flags);
+	return found;
+}
+
+void irq_free_virt(unsigned int virq, unsigned int count)
+{
+	unsigned long flags;
+	unsigned int i;
+
+	WARN_ON (virq < NUM_ISA_INTERRUPTS);
+	WARN_ON (count == 0 || (virq + count) > irq_virq_count);
+
+	raw_spin_lock_irqsave(&irq_big_lock, flags);
+	for (i = virq; i < (virq + count); i++) {
+		struct irq_host *host;
+
+		if (i < NUM_ISA_INTERRUPTS ||
+		    (virq + count) > irq_virq_count)
+			continue;
+
+		host = irq_map[i].host;
+		irq_map[i].hwirq = host->inval_irq;
+		smp_wmb();
+		irq_map[i].host = NULL;
+	}
+	raw_spin_unlock_irqrestore(&irq_big_lock, flags);
+}
+
+/* We need to create the radix trees late */
+static int irq_late_init(void)
+{
+	struct irq_host *h;
+	unsigned int i;
+
+	/*
+	 * No mutual exclusion with respect to accessors of the tree is needed
+	 * here as the synchronization is done via the state variable
+	 * revmap_trees_allocated.
+	 */
+	list_for_each_entry(h, &irq_hosts, link) {
+		if (h->revmap_type == IRQ_HOST_MAP_TREE)
+			INIT_RADIX_TREE(&h->revmap_data.tree, GFP_KERNEL);
+	}
+
+	/*
+	 * Make sure the radix trees inits are visible before setting
+	 * the flag
+	 */
+	smp_wmb();
+	revmap_trees_allocated = 1;
+
+	/*
+	 * Insert the reverse mapping for those interrupts already present
+	 * in irq_map[].
+	 */
+	mutex_lock(&revmap_trees_mutex);
+	for (i = 0; i < irq_virq_count; i++) {
+		if (irq_map[i].host &&
+		    (irq_map[i].host->revmap_type == IRQ_HOST_MAP_TREE))
+			radix_tree_insert(&irq_map[i].host->revmap_data.tree,
+					  irq_map[i].hwirq, &irq_map[i]);
+	}
+	mutex_unlock(&revmap_trees_mutex);
+
+	/*
+	 * Make sure the radix trees insertions are visible before setting
+	 * the flag
+	 */
+	smp_wmb();
+	revmap_trees_allocated = 2;
+
+	return 0;
+}
+arch_initcall(irq_late_init);
+
+#ifdef CONFIG_VIRQ_DEBUG
+static int virq_debug_show(struct seq_file *m, void *private)
+{
+	unsigned long flags;
+	struct irq_desc *desc;
+	const char *p;
+	char none[] = "none";
+	int i;
+
+	seq_printf(m, "%-5s  %-7s  %-15s  %s\n", "virq", "hwirq",
+		      "chip name", "host name");
+
+	for (i = 1; i < nr_irqs; i++) {
+		desc = irq_to_desc(i);
+		if (!desc)
+			continue;
+
+		raw_spin_lock_irqsave(&desc->lock, flags);
+
+		if (desc->action && desc->action->handler) {
+			seq_printf(m, "%5d  ", i);
+			seq_printf(m, "0x%05lx  ", virq_to_hw(i));
+
+			if (desc->chip && desc->chip->name)
+				p = desc->chip->name;
+			else
+				p = none;
+			seq_printf(m, "%-15s  ", p);
+
+			if (irq_map[i].host && irq_map[i].host->of_node)
+				p = irq_map[i].host->of_node->full_name;
+			else
+				p = none;
+			seq_printf(m, "%s\n", p);
+		}
+
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+	}
+
+	return 0;
+}
+
+static int virq_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, virq_debug_show, inode->i_private);
+}
+
+static const struct file_operations virq_debug_fops = {
+	.open = virq_debug_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int __init irq_debugfs_init(void)
+{
+	if (debugfs_create_file("virq_mapping", S_IRUGO, powerpc_debugfs_root,
+				 NULL, &virq_debug_fops) == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+__initcall(irq_debugfs_init);
+#endif /* CONFIG_VIRQ_DEBUG */
+
