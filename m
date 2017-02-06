Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGwTD27Z8zDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 16:07:44 +1100 (AEDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id v1657bSp016234
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Feb 2017 23:07:39 -0600
Message-ID: <1486357656.4850.88.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/opal-irqchip: Use interrupt names if present
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 06 Feb 2017 16:07:36 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent versions of OPAL can provide names for the various OPAL interrupts,
so let's use them. This also modernises the code that fetches the
interrupt array to use the helpers provided by the generic code instead
of hand-parsing the property.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal-irqchip.c | 45 ++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index 998316b..fe9b029 100644
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
+	int i, rc = 0;
 
 	opal_node = of_find_node_by_path("/ibm,opal");
 	if (!opal_node) {
@@ -209,37 +210,57 @@ int __init opal_event_init(void)
 		goto out;
 	}
 
-	/* Get interrupt property */
-	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
-	opal_irq_count = irqs ? (irqlen / 4) : 0;
+	/* Get opal-interrupts property and names if present */
+	rc = of_property_count_u32_elems(opal_node, "opal-interrupts");
+	if (rc < 0)
+		goto out;
+	opal_irq_count = rc;
 	pr_debug("Found %d interrupts reserved for OPAL\n", opal_irq_count);
+	irqs = kzalloc(rc * sizeof(u32), GFP_KERNEL);
+	if (WARN_ON(!irqs))
+		goto out;
+	rc = of_property_read_u32_array(opal_node, "opal-interrupts",
+					irqs, opal_irq_count);
+	if (rc < 0) {
+		pr_err("Error %d reading opal-interrupts array\n", rc);
+		goto out;
+	}
+	names = kzalloc(opal_irq_count * sizeof(char *), GFP_KERNEL);
+	of_property_read_string_array(opal_node, "opal-interrupts-names",
+				      names, opal_irq_count);
 
 	/* Install interrupt handlers */
 	opal_irqs = kcalloc(opal_irq_count, sizeof(*opal_irqs), GFP_KERNEL);
-	for (i = 0; irqs && i < opal_irq_count; i++, irqs++) {
-		unsigned int irq, virq;
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
+		if (names && names[i] && strlen(names[i]))
+			name = kasprintf(GFP_KERNEL, "opal-%s", names[i]);
+		else
+			name = kasprintf(GFP_KERNEL, "opal");
 
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
 
 		/* Cache IRQ */
 		opal_irqs[i] = virq;
 	}
+	kfree(irqs);
+	kfree(names);
 
 out:
 	of_node_put(opal_node);
