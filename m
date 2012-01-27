Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Thomas Gleixner <tglx@linutronix.de>, Milton Miller <miltonm@bga.com>,
 Rob Herring <rob.herring@calxeda.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v3 24/25] irq_domain: remove "hint" when allocating irq numbers
Date: Fri, 27 Jan 2012 14:36:18 -0700
Message-Id: <1327700179-17454-25-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 'hint' used to try and line up irq numbers with hw irq numbers is
rather a hack and not very useful.  Now that /proc/interrupts also outputs
the hwirq number, it is even less useful to keep around the 'hint' heuristic.

This patch removes it.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Milton Miller <miltonm@bga.com>
---
 kernel/irq/irqdomain.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index bf181ef..5b4fc4d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -339,7 +339,7 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 unsigned int irq_create_mapping(struct irq_domain *domain,
 				irq_hw_number_t hwirq)
 {
-	unsigned int virq, hint;
+	unsigned int virq;
 
 	pr_debug("irq: irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
 
@@ -366,10 +366,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 		return irq_domain_legacy_revmap(domain, hwirq);
 
 	/* Allocate a virtual interrupt number */
-	hint = hwirq % irq_virq_count;
-	virq = irq_alloc_desc_from(hint, 0);
-	if (!virq)
-		virq = irq_alloc_desc(0);
+	virq = irq_alloc_desc(0);
 	if (!virq) {
 		pr_debug("irq: -> virq allocation failed\n");
 		return 0;
@@ -490,7 +487,6 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
 			      irq_hw_number_t hwirq)
 {
 	unsigned int i;
-	unsigned int hint = hwirq % irq_virq_count;
 
 	/* Look for default domain if nececssary */
 	if (domain == NULL)
@@ -503,17 +499,11 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
 		return irq_domain_legacy_revmap(domain, hwirq);
 
 	/* Slow path does a linear search of the map */
-	if (hint < NUM_ISA_INTERRUPTS)
-		hint = NUM_ISA_INTERRUPTS;
-	i = hint;
-	do {
+	for (i = 0; i < irq_virq_count; i++)  {
 		struct irq_data *data = irq_get_irq_data(i);
 		if (data && (data->domain == domain) && (data->hwirq == hwirq))
 			return i;
-		i++;
-		if (i >= irq_virq_count)
-			i = NUM_ISA_INTERRUPTS;
-	} while(i != hint);
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_find_mapping);
-- 
1.7.5.4
