Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ8yD4v32zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 16:33:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/opal-irqchip: Use interrupt names if present
Date: Wed,  8 Feb 2017 16:33:32 +1100
Message-Id: <1486532012-3094-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Recent versions of OPAL can provide names for the various OPAL interrupts,
so let's use them. This also modernises the code that fetches the
interrupt array to use the helpers provided by the generic code instead
of hand-parsing the property.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/opal-irqchip.c | 55 ++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 13 deletions(-)

v2: Free irqs array in the error path.
    Check the allocation of names succeeded, and consolidate that with the
    check of irqs and opal_irqs.
    We don't need to initialise rc.
    Add a comment about the lack of error handling for "opal-interrupt-names".

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index 998316bf2dad..ecdcba9d1220 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -183,8 +183,9 @@ void opal_event_shutdown(void)
 int __init opal_event_init(void)
 {
 	struct device_node *dn, *opal_node;
-	const __be32 *irqs;
-	int i, irqlen, rc = 0;
+	const char **names;
+	u32 *irqs;
+	int i, rc;
 
 	opal_node = of_find_node_by_path("/ibm,opal");
 	if (!opal_node) {
@@ -209,31 +210,56 @@ int __init opal_event_init(void)
 		goto out;
 	}
 
-	/* Get interrupt property */
-	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
-	opal_irq_count = irqs ? (irqlen / 4) : 0;
+	/* Get opal-interrupts property and names if present */
+	rc = of_property_count_u32_elems(opal_node, "opal-interrupts");
+	if (rc < 0)
+		goto out;
+
+	opal_irq_count = rc;
 	pr_debug("Found %d interrupts reserved for OPAL\n", opal_irq_count);
 
-	/* Install interrupt handlers */
+	irqs = kcalloc(opal_irq_count, sizeof(*irqs), GFP_KERNEL);
+	names = kcalloc(opal_irq_count, sizeof(*names), GFP_KERNEL);
 	opal_irqs = kcalloc(opal_irq_count, sizeof(*opal_irqs), GFP_KERNEL);
-	for (i = 0; irqs && i < opal_irq_count; i++, irqs++) {
-		unsigned int irq, virq;
+
+	if (WARN_ON(!irqs || !names || !opal_irqs))
+		goto out_free;
+
+	rc = of_property_read_u32_array(opal_node, "opal-interrupts",
+					irqs, opal_irq_count);
+	if (rc < 0) {
+		pr_err("Error %d reading opal-interrupts array\n", rc);
+		goto out_free;
+	}
+
+	/* It's not an error for the names to be missing */
+	of_property_read_string_array(opal_node, "opal-interrupts-names",
+				      names, opal_irq_count);
+
+	/* Install interrupt handlers */
+	for (i = 0; i < opal_irq_count; i++) {
+		unsigned int virq;
+		char *name;
 
 		/* Get hardware and virtual IRQ */
-		irq = be32_to_cpup(irqs);
-		virq = irq_create_mapping(NULL, irq);
+		virq = irq_create_mapping(NULL, irqs[i]);
 		if (!virq) {
-			pr_warn("Failed to map irq 0x%x\n", irq);
+			pr_warn("Failed to map irq 0x%x\n", irqs[i]);
 			continue;
 		}
 
+		if (names[i] && strlen(names[i]))
+			name = kasprintf(GFP_KERNEL, "opal-%s", names[i]);
+		else
+			name = kasprintf(GFP_KERNEL, "opal");
+
 		/* Install interrupt handler */
 		rc = request_irq(virq, opal_interrupt, IRQF_TRIGGER_LOW,
-				 "opal", NULL);
+				 name, NULL);
 		if (rc) {
 			irq_dispose_mapping(virq);
 			pr_warn("Error %d requesting irq %d (0x%x)\n",
-				 rc, virq, irq);
+				 rc, virq, irqs[i]);
 			continue;
 		}
 
@@ -241,6 +267,9 @@ int __init opal_event_init(void)
 		opal_irqs[i] = virq;
 	}
 
+out_free:
+	kfree(irqs);
+	kfree(names);
 out:
 	of_node_put(opal_node);
 	return rc;
-- 
2.7.4
