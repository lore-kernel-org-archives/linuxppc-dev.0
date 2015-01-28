Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 131FE1A074A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 15:23:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/powernv: Remove "opal" prefix from pr_xxx()s
Date: Wed, 28 Jan 2015 15:23:01 +1100
Message-Id: <1422418981-32110-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit c8742f85125d "powerpc/powernv: Expose OPAL firmware symbol
map" I added pr_fmt() to opal.c. This left some existing pr_xxx()s with
duplicate "opal" prefixes, eg:

    opal: opal: Found 0 interrupts reserved for OPAL

Fix them all up. Also make the "Not not found" message a bit more
verbose.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/opal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 1db119f0f4ee..8f5bbfae9c32 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -208,7 +208,7 @@ static int __init opal_register_exception_handlers(void)
 	 * start catching/handling HMI directly in Linux.
 	 */
 	if (!opal_check_token(OPAL_HANDLE_HMI)) {
-		pr_info("opal: Old firmware detected, OPAL handles HMIs.\n");
+		pr_info("Old firmware detected, OPAL handles HMIs.\n");
 		opal_register_exception_handler(
 				OPAL_HYPERVISOR_MAINTENANCE_HANDLER,
 				0, glue);
@@ -709,7 +709,7 @@ static int __init opal_init(void)
 
 	opal_node = of_find_node_by_path("/ibm,opal");
 	if (!opal_node) {
-		pr_warn("opal: Node not found\n");
+		pr_warn("Device node not found\n");
 		return -ENODEV;
 	}
 
@@ -732,7 +732,7 @@ static int __init opal_init(void)
 
 	/* Find all OPAL interrupts and request them */
 	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
-	pr_debug("opal: Found %d interrupts reserved for OPAL\n",
+	pr_debug("Found %d interrupts reserved for OPAL\n",
 		 irqs ? (irqlen / 4) : 0);
 	opal_irq_count = irqlen / 4;
 	opal_irqs = kzalloc(opal_irq_count * sizeof(unsigned int), GFP_KERNEL);
@@ -740,13 +740,13 @@ static int __init opal_init(void)
 		unsigned int hwirq = be32_to_cpup(irqs);
 		unsigned int irq = irq_create_mapping(NULL, hwirq);
 		if (irq == NO_IRQ) {
-			pr_warning("opal: Failed to map irq 0x%x\n", hwirq);
+			pr_warning("Failed to map irq 0x%x\n", hwirq);
 			continue;
 		}
 		rc = request_irq(irq, opal_interrupt, 0, "opal", NULL);
 		if (rc)
-			pr_warning("opal: Error %d requesting irq %d"
-				   " (0x%x)\n", rc, irq, hwirq);
+			pr_warning("Error %d requesting irq %d (0x%x)\n",
+				    rc, irq, hwirq);
 		opal_irqs[i] = irq;
 	}
 
-- 
2.1.0
