Return-Path: <glikely@secretlab.ca>
Received: from mail-ea0-x231.google.com (mail-ea0-x231.google.com
 [IPv6:2a00:1450:4013:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F7412C02B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 10:49:36 +1000 (EST)
Received: by mail-ea0-f177.google.com with SMTP id j14so4974802eak.36
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jun 2013 17:49:33 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC 02/10] irqdomain: Replace LEGACY mapping with LINEAR
Date: Mon, 10 Jun 2013 01:49:14 +0100
Message-Id: <1370825362-11145-3-git-send-email-grant.likely@linaro.org>
In-Reply-To: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
References: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>,
 Paul Mundt <lethal@linux-sh.org>, Grant Likely <grant.likely@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The LEGACY mapping unnecessarily complicates the irqdomain code and
can easily be implemented with a linear mapping.  By ripping it out
and replacing it with the LINEAR mapping the object size of
irqdomain.c shrinks by about 330 bytes (ARMv7) which offsets the
additional allocation required by the linear map.  It also makes it
possible for current LEGACY map users to pre-allocate irq_descs for a
subset of the hwirqs and dynamically allocate the rest as needed.

Signed-off-by: Grant Likely <grant.likely@linaro.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 include/linux/irqdomain.h |  7 ----
 kernel/irq/irqdomain.c    | 84 ++++-------------------------------------------
 2 files changed, 6 insertions(+), 85 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index ba2c708..6f06241 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -95,11 +95,6 @@ struct irq_domain {
 	union {
 		struct {
 			unsigned int size;
-			unsigned int first_irq;
-			irq_hw_number_t first_hwirq;
-		} legacy;
-		struct {
-			unsigned int size;
 			unsigned int *revmap;
 		} linear;
 		struct {
@@ -117,8 +112,6 @@ struct irq_domain {
 	struct irq_domain_chip_generic *gc;
 };
 
-#define IRQ_DOMAIN_MAP_LEGACY 0 /* driver allocated fixed range of irqs.
-				 * ie. legacy 8259, gets irqs 1..15 */
 #define IRQ_DOMAIN_MAP_NOMAP 1 /* no fast reverse mapping */
 #define IRQ_DOMAIN_MAP_LINEAR 2 /* linear map of interrupts */
 #define IRQ_DOMAIN_MAP_TREE 3 /* radix tree */
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 61d6d3c..1ac8cf4 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -82,13 +82,6 @@ void irq_domain_remove(struct irq_domain *domain)
 	mutex_lock(&irq_domain_mutex);
 
 	switch (domain->revmap_type) {
-	case IRQ_DOMAIN_MAP_LEGACY:
-		/*
-		 * Legacy domains don't manage their own irq_desc
-		 * allocations, we expect the caller to handle irq_desc
-		 * freeing on their own.
-		 */
-		break;
 	case IRQ_DOMAIN_MAP_TREE:
 		/*
 		 * radix_tree_delete() takes care of destroying the root
@@ -122,17 +115,6 @@ void irq_domain_remove(struct irq_domain *domain)
 }
 EXPORT_SYMBOL_GPL(irq_domain_remove);
 
-static unsigned int irq_domain_legacy_revmap(struct irq_domain *domain,
-					     irq_hw_number_t hwirq)
-{
-	irq_hw_number_t first_hwirq = domain->revmap_data.legacy.first_hwirq;
-	int size = domain->revmap_data.legacy.size;
-
-	if (WARN_ON(hwirq < first_hwirq || hwirq >= first_hwirq + size))
-		return 0;
-	return hwirq - first_hwirq + domain->revmap_data.legacy.first_irq;
-}
-
 /**
  * irq_domain_add_simple() - Allocate and register a simple irq_domain.
  * @of_node: pointer to interrupt controller's device tree node.
@@ -213,57 +195,17 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 void *host_data)
 {
 	struct irq_domain *domain;
-	unsigned int i;
 
-	domain = irq_domain_alloc(of_node, IRQ_DOMAIN_MAP_LEGACY, ops, host_data);
+	pr_debug("Setting up legacy domain virq[%i:%i] ==> hwirq[%i:%i]\n",
+		 first_irq, first_irq + size - 1,
+		 (int)first_hwirq, (int)first_hwirq + size -1);
+
+	domain = irq_domain_add_linear(of_node, first_hwirq + size, ops, host_data);
 	if (!domain)
 		return NULL;
 
-	domain->revmap_data.legacy.first_irq = first_irq;
-	domain->revmap_data.legacy.first_hwirq = first_hwirq;
-	domain->revmap_data.legacy.size = size;
-
-	mutex_lock(&irq_domain_mutex);
-	/* Verify that all the irqs are available */
-	for (i = 0; i < size; i++) {
-		int irq = first_irq + i;
-		struct irq_data *irq_data = irq_get_irq_data(irq);
-
-		if (WARN_ON(!irq_data || irq_data->domain)) {
-			mutex_unlock(&irq_domain_mutex);
-			irq_domain_free(domain);
-			return NULL;
-		}
-	}
+	WARN_ON(irq_domain_associate_many(domain, first_irq, first_hwirq, size));
 
-	/* Claim all of the irqs before registering a legacy domain */
-	for (i = 0; i < size; i++) {
-		struct irq_data *irq_data = irq_get_irq_data(first_irq + i);
-		irq_data->hwirq = first_hwirq + i;
-		irq_data->domain = domain;
-	}
-	mutex_unlock(&irq_domain_mutex);
-
-	for (i = 0; i < size; i++) {
-		int irq = first_irq + i;
-		int hwirq = first_hwirq + i;
-
-		/* IRQ0 gets ignored */
-		if (!irq)
-			continue;
-
-		/* Legacy flags are left to default at this point,
-		 * one can then use irq_create_mapping() to
-		 * explicitly change them
-		 */
-		if (ops->map)
-			ops->map(domain, irq, hwirq);
-
-		/* Clear norequest flags */
-		irq_clear_status_flags(irq, IRQ_NOREQUEST);
-	}
-
-	irq_domain_add(domain);
 	return domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
@@ -492,10 +434,6 @@ int irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_base,
 	}
 
 	return 0;
-
- err_unmap:
-	irq_domain_disassociate_many(domain, irq_base, i);
-	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(irq_domain_associate_many);
 
@@ -575,10 +513,6 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 		return virq;
 	}
 
-	/* Get a virtual interrupt number */
-	if (domain->revmap_type == IRQ_DOMAIN_MAP_LEGACY)
-		return irq_domain_legacy_revmap(domain, hwirq);
-
 	/* Allocate a virtual interrupt number */
 	hint = hwirq % nr_irqs;
 	if (hint == 0)
@@ -706,10 +640,6 @@ void irq_dispose_mapping(unsigned int virq)
 	if (WARN_ON(domain == NULL))
 		return;
 
-	/* Never unmap legacy interrupts */
-	if (domain->revmap_type == IRQ_DOMAIN_MAP_LEGACY)
-		return;
-
 	irq_domain_disassociate_many(domain, virq, 1);
 	irq_free_desc(virq);
 }
@@ -732,8 +662,6 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
 		return 0;
 
 	switch (domain->revmap_type) {
-	case IRQ_DOMAIN_MAP_LEGACY:
-		return irq_domain_legacy_revmap(domain, hwirq);
 	case IRQ_DOMAIN_MAP_LINEAR:
 		return irq_linear_revmap(domain, hwirq);
 	case IRQ_DOMAIN_MAP_TREE:
-- 
1.8.1.2
