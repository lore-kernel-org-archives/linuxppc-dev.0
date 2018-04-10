Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Kz480GgVzDrLm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 17:16:23 +1000 (AEST)
Message-ID: <1523344570.11062.65.camel@kernel.crashing.org>
Subject: [PATCH]  powerpc/powernv/opal: Use standard interrupts property
 when available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 17:16:10 +1000
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

For (bad) historical reasons, OPAL used to create a non-standard pair of
properties "opal-interrupts" and "opal-interrupts-names" for representing
the list of interrupts it wants Linux to request on its behalf.

Among other issues, the opal-interrupts doesn't have a way to carry the
type of interrupts, and they were assumed to be all level sensitive.

This is wrong on some recent systems where some of them are edge sensitive
causing warnings in the XIVE code and possible misbehaviours if they need
to be retriggered (typically the NPU2 TCE error interrupts).

This makes Linux switch to using the standard "interrupts" and
"interrupt-names" properties instead when they are available, using standard
of_irq helpers, which can carry all the desired type information.

Newer versions of OPAL will generate those properties in addition to the
legacy ones.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index 9d1b8c0aaf93..46785eaf625d 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/irq_work.h>
+#include <linux/of_irq.h>
 
 #include <asm/machdep.h>
 #include <asm/opal.h>
@@ -39,8 +40,8 @@ struct opal_event_irqchip {
 };
 static struct opal_event_irqchip opal_event_irqchip;
 
-static unsigned int opal_irq_count;
-static unsigned int *opal_irqs;
+static int opal_irq_count;
+static struct resource *opal_irqs;
 
 static void opal_handle_irq_work(struct irq_work *work);
 static u64 last_outstanding_events;
@@ -174,24 +175,21 @@ void opal_event_shutdown(void)
 
 	/* First free interrupts, which will also mask them */
 	for (i = 0; i < opal_irq_count; i++) {
-		if (!opal_irqs[i])
+		if (!opal_irqs || !opal_irqs[i].start)
 			continue;
 
 		if (in_interrupt())
-			disable_irq_nosync(opal_irqs[i]);
+			disable_irq_nosync(opal_irqs[i].start);
 		else
-			free_irq(opal_irqs[i], NULL);
-
-		opal_irqs[i] = 0;
+			free_irq(opal_irqs[i].start, NULL);
 	}
 }
 
 int __init opal_event_init(void)
 {
 	struct device_node *dn, *opal_node;
-	const char **names;
-	u32 *irqs;
-	int i, rc;
+	bool old_style = false;
+	int i, rc = 0;
 
 	opal_node = of_find_node_by_path("/ibm,opal");
 	if (!opal_node) {
@@ -216,67 +214,91 @@ int __init opal_event_init(void)
 		goto out;
 	}
 
-	/* Get opal-interrupts property and names if present */
-	rc = of_property_count_u32_elems(opal_node, "opal-interrupts");
-	if (rc < 0)
-		goto out;
+	/* Look for new-style (standard) "interrupts" property */
+	opal_irq_count = of_irq_count(opal_node);
 
-	opal_irq_count = rc;
-	pr_debug("Found %d interrupts reserved for OPAL\n", opal_irq_count);
+	/* Absent ? Look for the old one */
+	if (opal_irq_count < 1) {
+		/* Get opal-interrupts property and names if present */
+		rc = of_property_count_u32_elems(opal_node, "opal-interrupts");
+		if (rc > 0)
+			opal_irq_count = rc;
+		old_style = true;
+	}
 
-	irqs = kcalloc(opal_irq_count, sizeof(*irqs), GFP_KERNEL);
-	names = kcalloc(opal_irq_count, sizeof(*names), GFP_KERNEL);
-	opal_irqs = kcalloc(opal_irq_count, sizeof(*opal_irqs), GFP_KERNEL);
+	/* No interrupts ? Bail out */
+	if (!opal_irq_count)
+		goto out;
 
-	if (WARN_ON(!irqs || !names || !opal_irqs))
-		goto out_free;
+	pr_debug("OPAL: Found %d interrupts reserved for OPAL using %s scheme\n",
+		 opal_irq_count, old_style ? "old" : "new");
 
-	rc = of_property_read_u32_array(opal_node, "opal-interrupts",
-					irqs, opal_irq_count);
-	if (rc < 0) {
-		pr_err("Error %d reading opal-interrupts array\n", rc);
-		goto out_free;
+	/* Allocate an IRQ resources array */
+	opal_irqs = kcalloc(opal_irq_count, sizeof(struct resource), GFP_KERNEL);
+	if (WARN_ON(!opal_irqs)) {
+		rc = -ENOMEM;
+		goto out;
 	}
 
-	/* It's not an error for the names to be missing */
-	of_property_read_string_array(opal_node, "opal-interrupts-names",
-				      names, opal_irq_count);
+	/* Build the resources array */
+	if (old_style) {
+		/* Old style "opal-interrupts" property */
+		for (i = 0; i < opal_irq_count; i++) {
+			struct resource *r = &opal_irqs[i];
+			const char *name = NULL;
+			u32 hw_irq;
+			int virq;
+
+			rc = of_property_read_u32_index(opal_node, "opal-interrupts",
+							i, &hw_irq);
+			if (WARN_ON(rc < 0)) {
+				opal_irq_count = i;
+				break;
+			}
+			of_property_read_string_index(opal_node, "opal-interrupts-names",
+						      i, &name);
+			virq = irq_create_mapping(NULL, hw_irq);
+			if (!virq) {
+				pr_warn("Failed to map OPAL irq 0x%x\n", hw_irq);
+				continue;
+			}
+			r->start = r->end = virq;
+			r->flags = IORESOURCE_IRQ | IRQ_TYPE_LEVEL_LOW;
+			r->name = name;
+		}
+	} else {
+		/* new style standard "interrupts" property */
+		rc = of_irq_to_resource_table(opal_node, opal_irqs, opal_irq_count);
+		if (WARN_ON(rc < 0)) {
+			opal_irq_count = 0;
+			kfree(opal_irqs);
+			goto out;
+		}
+		if (WARN_ON(rc < opal_irq_count))
+			opal_irq_count = rc;
+	}
 
 	/* Install interrupt handlers */
 	for (i = 0; i < opal_irq_count; i++) {
-		unsigned int virq;
-		char *name;
+		struct resource *r = &opal_irqs[i];
+		const char *name;
 
-		/* Get hardware and virtual IRQ */
-		virq = irq_create_mapping(NULL, irqs[i]);
-		if (!virq) {
-			pr_warn("Failed to map irq 0x%x\n", irqs[i]);
-			continue;
-		}
-
-		if (names[i] && strlen(names[i]))
-			name = kasprintf(GFP_KERNEL, "opal-%s", names[i]);
+		/* Prefix name */
+		if (r->name)
+			name = kasprintf(GFP_KERNEL, "opal-%s", r->name);
 		else
 			name = kasprintf(GFP_KERNEL, "opal");
 
 		/* Install interrupt handler */
-		rc = request_irq(virq, opal_interrupt, IRQF_TRIGGER_LOW,
+		rc = request_irq(r->start, opal_interrupt, r->flags & IRQD_TRIGGER_MASK,
 				 name, NULL);
 		if (rc) {
-			irq_dispose_mapping(virq);
-			pr_warn("Error %d requesting irq %d (0x%x)\n",
-				 rc, virq, irqs[i]);
+			pr_warn("Error %d requesting OPAL irq %d\n", rc, (int)r->start);
 			continue;
 		}
-
-		/* Cache IRQ */
-		opal_irqs[i] = virq;
 	}
-
-out_free:
-	kfree(irqs);
-	kfree(names);
-out:
+	rc = 0;
+ out:
 	of_node_put(opal_node);
 	return rc;
 }
