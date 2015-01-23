Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D106F1A0D99
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:26:09 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 23 Jan 2015 13:26:08 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A7CEF2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:26:05 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0N3Pvw929950170
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:26:05 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0N3PVgC000473
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:25:31 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] powerpc/powernv: Separate function for OPAL IRQ setup
Date: Fri, 23 Jan 2015 14:25:05 +1100
Message-Id: <1421983506-17034-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch put the OPAL interrupt setup logic in opal_init() into
seperate function opal_irq_init() for easier code maintaining. The
patch doesn't introduce logic changes except:

   * Rename variable names.
   * Release virtual IRQ upon error from request_irq().
   * Don't cache the virtual IRQ to opal_irqs[] upon error from
     request_irq().

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c | 61 +++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f10b9ec..411975c 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -695,11 +695,49 @@ static void opal_i2c_create_devs(void)
 		of_platform_device_create(np, NULL, NULL);
 }
 
+static void __init opal_irq_init(struct device_node *dn)
+{
+	const __be32 *irqs;
+	int i, irqlen;
+
+	/* Get interrupt property */
+	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
+	pr_debug("opal: Found %d interrupts reserved for OPAL\n",
+		 irqs ? (irqlen / 4) : 0);
+
+	/* Install interrupt handlers */
+	opal_irq_count = irqlen / 4;
+	opal_irqs = kzalloc(opal_irq_count * sizeof(unsigned int), GFP_KERNEL);
+	for (i = 0; irqs && i < opal_irq_count; i++, irqs++) {
+		unsigned int irq, virq;
+		int rc;
+
+		/* Get hardware and virtual IRQ */
+		irq = be32_to_cpup(irqs);
+		virq = irq_create_mapping(NULL, irq);
+		if (virq == NO_IRQ) {
+			pr_warn("opal: Failed to map irq 0x%x\n", irq);
+			continue;
+		}
+
+		/* Install interrupt handler */
+		rc = request_irq(virq, opal_interrupt, 0, "opal", NULL);
+		if (rc) {
+			irq_dispose_mapping(virq);
+			pr_warn("opal: Error %d requesting irq %d"
+				" (0x%x)\n", rc, virq, irq);
+			continue;
+		}
+
+		/* Cache IRQ */
+		opal_irqs[i] = virq;
+	}
+}
+
 static int __init opal_init(void)
 {
 	struct device_node *np, *consoles;
-	const __be32 *irqs;
-	int rc, i, irqlen;
+	int rc;
 
 	opal_node = of_find_node_by_path("/ibm,opal");
 	if (!opal_node) {
@@ -725,24 +763,7 @@ static int __init opal_init(void)
 	opal_i2c_create_devs();
 
 	/* Find all OPAL interrupts and request them */
-	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
-	pr_debug("opal: Found %d interrupts reserved for OPAL\n",
-		 irqs ? (irqlen / 4) : 0);
-	opal_irq_count = irqlen / 4;
-	opal_irqs = kzalloc(opal_irq_count * sizeof(unsigned int), GFP_KERNEL);
-	for (i = 0; irqs && i < (irqlen / 4); i++, irqs++) {
-		unsigned int hwirq = be32_to_cpup(irqs);
-		unsigned int irq = irq_create_mapping(NULL, hwirq);
-		if (irq == NO_IRQ) {
-			pr_warning("opal: Failed to map irq 0x%x\n", hwirq);
-			continue;
-		}
-		rc = request_irq(irq, opal_interrupt, 0, "opal", NULL);
-		if (rc)
-			pr_warning("opal: Error %d requesting irq %d"
-				   " (0x%x)\n", rc, irq, hwirq);
-		opal_irqs[i] = irq;
-	}
+	opal_irq_init(opal_node);
 
 	/* Create "opal" kobject under /sys/firmware */
 	rc = opal_sysfs_init();
-- 
1.8.3.2
