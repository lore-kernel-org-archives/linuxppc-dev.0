Return-Path: <hughd@google.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 86F842C024B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jul 2012 12:47:57 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so8488670pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jul 2012 19:47:55 -0700 (PDT)
Date: Sat, 21 Jul 2012 19:47:13 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: next/mmotm unbootable on G5: irqdomain
Message-ID: <alpine.LSU.2.00.1207211911160.1585@eggly.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Paul Mundt <lethal@linux-sh.org>,
 Rob Herring <rob.herring@calxeda.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have to revert the patch below from mmotm 2012-07-20-16-30 or
next-20120720 in order to boot on the PowerPC G5: otherwise it
freezes before switching to the framebuffer console - but I'm
not certain where because that initial console doesn't scroll
(there are mpic messages at bottom and at top of screen, probably
later messages at the top but I don't know the sequence).

Hugh

commit 94f036a1f242f98cc30700b7676c07270a9c5c27
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Sun Jun 3 22:04:39 2012 -0700

irqdomain: eliminate slow-path revmap lookups

With the current state of irq_domain, the reverse map is always updated
when new IRQs get mapped.  This means that the irq_find_mapping() function
can be simplified to execute the revmap lookup functions unconditionally

This patch adds lookup functions for the revmaps that don't yet have one
and removes the slow path lookup code path.

v8: Broke out unrelated changes into separate patches.  Rebased on Paul's irq
    association patches.
v7: Rebased to irqdomain/next for v3.4 and applied before the removal of 'hint'
v6: Remove the slow path entirely.  The only place where the slow path
    could get called is for a linear mapping if the hwirq number is larger
    than the linear revmap size.  There shouldn't be any interrupt
    controllers that do that.
v5: rewrite to not use a ->revmap() callback.  It is simpler, smaller,
    safer and faster to open code each of the revmap lookups directly into
    irq_find_mapping() via a switch statement.
v4: Fix build failure on incorrect variable reference.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Milton Miller <miltonm@bga.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Rob Herring <rob.herring@calxeda.com>

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index c0e638b..a9b810e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -686,16 +686,11 @@ EXPORT_SYMBOL_GPL(irq_dispose_mapping);
  * irq_find_mapping() - Find a linux irq from an hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
- *
- * This is a slow path, for use by generic code. It's expected that an
- * irq controller implementation directly calls the appropriate low level
- * mapping function.
  */
 unsigned int irq_find_mapping(struct irq_domain *domain,
 			      irq_hw_number_t hwirq)
 {
-	unsigned int i;
-	unsigned int hint = hwirq % nr_irqs;
+	struct irq_data *data;
 
 	/* Look for default domain if nececssary */
 	if (domain == NULL)
@@ -703,22 +698,27 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
 	if (domain == NULL)
 		return 0;
 
-	/* legacy -> bail early */
-	if (domain->revmap_type == IRQ_DOMAIN_MAP_LEGACY)
+	switch (domain->revmap_type) {
+	case IRQ_DOMAIN_MAP_LEGACY:
 		return irq_domain_legacy_revmap(domain, hwirq);
-
-	/* Slow path does a linear search of the map */
-	if (hint == 0)
-		hint = 1;
-	i = hint;
-	do {
-		struct irq_data *data = irq_get_irq_data(i);
+	case IRQ_DOMAIN_MAP_LINEAR:
+		return irq_linear_revmap(domain, hwirq);
+	case IRQ_DOMAIN_MAP_TREE:
+		rcu_read_lock();
+		data = radix_tree_lookup(&domain->revmap_data.tree, hwirq);
+		rcu_read_unlock();
+		if (data)
+			return data->irq;
+		break;
+	case IRQ_DOMAIN_MAP_NOMAP:
+		data = irq_get_irq_data(hwirq);
 		if (data && (data->domain == domain) && (data->hwirq == hwirq))
-			return i;
-		i++;
-		if (i >= nr_irqs)
-			i = 1;
-	} while(i != hint);
+			return hwirq;
+		break;
+	}
+
+	WARN(1, "ERROR: irq revmap went horribly wrong. revmap_type=%i\n",
+		domain->revmap_type);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_find_mapping);
@@ -728,32 +728,19 @@ EXPORT_SYMBOL_GPL(irq_find_mapping);
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
  *
- * This is a fast path, for use by irq controller code that uses linear
- * revmaps. It does fallback to the slow path if the revmap doesn't exist
- * yet and will create the revmap entry with appropriate locking
+ * This is a fast path that can be called directly by irq controller code to
+ * save a handful of instructions.
  */
 unsigned int irq_linear_revmap(struct irq_domain *domain,
 			       irq_hw_number_t hwirq)
 {
-	unsigned int *revmap;
+	BUG_ON(domain->revmap_type != IRQ_DOMAIN_MAP_LINEAR);
 
-	if (WARN_ON_ONCE(domain->revmap_type != IRQ_DOMAIN_MAP_LINEAR))
-		return irq_find_mapping(domain, hwirq);
-
-	/* Check revmap bounds */
-	if (unlikely(hwirq >= domain->revmap_data.linear.size))
-		return irq_find_mapping(domain, hwirq);
-
-	/* Check if revmap was allocated */
-	revmap = domain->revmap_data.linear.revmap;
-	if (unlikely(revmap == NULL))
-		return irq_find_mapping(domain, hwirq);
-
-	/* Fill up revmap with slow path if no mapping found */
-	if (unlikely(!revmap[hwirq]))
-		revmap[hwirq] = irq_find_mapping(domain, hwirq);
+	/* Check revmap bounds; complain if exceeded */
+	if (WARN_ON(hwirq >= domain->revmap_data.linear.size))
+		return 0;
 
-	return revmap[hwirq];
+	return domain->revmap_data.linear.revmap[hwirq];
 }
 EXPORT_SYMBOL_GPL(irq_linear_revmap);
 
