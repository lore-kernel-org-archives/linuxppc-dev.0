Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC551DDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 17:26:24 +1100 (EST)
Date: Tue, 20 Nov 2007 07:26:19 +0100
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] powerpc: hash lock use lock bitops
Message-ID: <20071120062618.GB31514@wotan.suse.de>
References: <20071120050826.GA18332@wotan.suse.de>
	<20071120050950.GB18332@wotan.suse.de>
	<1195538904.6970.37.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1195538904.6970.37.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 20, 2007 at 05:08:24PM +1100, Benjamin Herrenschmidt wrote:
> 
> On Tue, 2007-11-20 at 06:09 +0100, Nick Piggin wrote:
> > This isn't a bugfix, but may help performance slightly...
> > 
> > --
> > powerpc 64-bit hash pte lock bit is an actual lock, so it can take advantage
> > of lock bitops for slightly more optimal memory barriers (can avoid an lwsync
> > in the trylock).
> > 
> > Signed-off-by: Nick Piggin <npiggin@suse.de>
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> 
> Looks nice, I'll try it out on a G5 and let you know.

Cool, thanks (I don't have mine handy ATM...).

BTW, here is another thing which you might want to think about. Again
untested for temporary lack of hardware.

--

The radix-tree is now RCU safe, so powerpc can avoid the games it was playing
in order to have a lockless readside. Saves an irq disable/enable, a couple of
__get_cpu_var()s, a cacheline, and a memory barrier, in the fastpath. Should
save a cycle or two...

---
Index: linux-2.6/arch/powerpc/kernel/irq.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/irq.c
+++ linux-2.6/arch/powerpc/kernel/irq.c
@@ -406,8 +406,6 @@ void do_softirq(void)
 
 static LIST_HEAD(irq_hosts);
 static DEFINE_SPINLOCK(irq_big_lock);
-static DEFINE_PER_CPU(unsigned int, irq_radix_reader);
-static unsigned int irq_radix_writer;
 struct irq_map_entry irq_map[NR_IRQS];
 static unsigned int irq_virq_count = NR_IRQS;
 static struct irq_host *irq_default_host;
@@ -550,57 +548,6 @@ void irq_set_virq_count(unsigned int cou
 		irq_virq_count = count;
 }
 
-/* radix tree not lockless safe ! we use a brlock-type mecanism
- * for now, until we can use a lockless radix tree
- */
-static void irq_radix_wrlock(unsigned long *flags)
-{
-	unsigned int cpu, ok;
-
-	spin_lock_irqsave(&irq_big_lock, *flags);
-	irq_radix_writer = 1;
-	smp_mb();
-	do {
-		barrier();
-		ok = 1;
-		for_each_possible_cpu(cpu) {
-			if (per_cpu(irq_radix_reader, cpu)) {
-				ok = 0;
-				break;
-			}
-		}
-		if (!ok)
-			cpu_relax();
-	} while(!ok);
-}
-
-static void irq_radix_wrunlock(unsigned long flags)
-{
-	smp_wmb();
-	irq_radix_writer = 0;
-	spin_unlock_irqrestore(&irq_big_lock, flags);
-}
-
-static void irq_radix_rdlock(unsigned long *flags)
-{
-	local_irq_save(*flags);
-	__get_cpu_var(irq_radix_reader) = 1;
-	smp_mb();
-	if (likely(irq_radix_writer == 0))
-		return;
-	__get_cpu_var(irq_radix_reader) = 0;
-	smp_wmb();
-	spin_lock(&irq_big_lock);
-	__get_cpu_var(irq_radix_reader) = 1;
-	spin_unlock(&irq_big_lock);
-}
-
-static void irq_radix_rdunlock(unsigned long flags)
-{
-	__get_cpu_var(irq_radix_reader) = 0;
-	local_irq_restore(flags);
-}
-
 static int irq_setup_virq(struct irq_host *host, unsigned int virq,
 			    irq_hw_number_t hwirq)
 {
@@ -791,9 +738,9 @@ void irq_dispose_mapping(unsigned int vi
 		/* Check if radix tree allocated yet */
 		if (host->revmap_data.tree.gfp_mask == 0)
 			break;
-		irq_radix_wrlock(&flags);
+		spin_lock_irqsave(&irq_big_lock, flags);
 		radix_tree_delete(&host->revmap_data.tree, hwirq);
-		irq_radix_wrunlock(flags);
+		spin_unlock_irqrestore(&irq_big_lock, flags);
 		break;
 	}
 
@@ -861,9 +808,9 @@ unsigned int irq_radix_revmap(struct irq
 		return irq_find_mapping(host, hwirq);
 
 	/* Now try to resolve */
-	irq_radix_rdlock(&flags);
+	rcu_read_lock();
 	ptr = radix_tree_lookup(tree, hwirq);
-	irq_radix_rdunlock(flags);
+	rcu_read_unlock();
 
 	/* Found it, return */
 	if (ptr) {
@@ -874,9 +821,9 @@ unsigned int irq_radix_revmap(struct irq
 	/* If not there, try to insert it */
 	virq = irq_find_mapping(host, hwirq);
 	if (virq != NO_IRQ) {
-		irq_radix_wrlock(&flags);
+		spin_lock_irqsave(&irq_big_lock, flags);
 		radix_tree_insert(tree, hwirq, &irq_map[virq]);
-		irq_radix_wrunlock(flags);
+		spin_unlock_irqrestore(&irq_big_lock, flags);
 	}
 	return virq;
 }
@@ -989,12 +936,12 @@ static int irq_late_init(void)
 	struct irq_host *h;
 	unsigned long flags;
 
-	irq_radix_wrlock(&flags);
+	spin_lock_irqsave(&irq_big_lock, flags);
 	list_for_each_entry(h, &irq_hosts, link) {
 		if (h->revmap_type == IRQ_HOST_MAP_TREE)
 			INIT_RADIX_TREE(&h->revmap_data.tree, GFP_ATOMIC);
 	}
-	irq_radix_wrunlock(flags);
+	spin_unlock_irqrestore(&irq_big_lock, flags);
 
 	return 0;
 }
