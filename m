Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3L5L74jbzDqdc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 12:39:50 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u722dhTZ029163
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 21:39:45 -0500
Message-ID: <1470105583.12584.5.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/xics: Properly set Edge/Level type and enable resend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 02 Aug 2016 12:39:43 +1000
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

This sets the type of the interrupt appropriately. We set it as follow:

 - If not mapped from the device-tree, we use edge. This is the case
of the virtual interrupts and PCI MSIs for example.

 - If mapped from the device-tree and #interrupt-cells is 2 (PAPR
compliant), we use the second cell to set the appropriate type

 - If mapped from the device-tree and #interrupt-cells is 1 (current
OPAL on P8 does that), we assume level sensitive since those are
typically going to be the PSI LSIs which are level sensitive.

Additionally, we mark the interrupts requested via the opal_interrupts
property all level. This is a bit fishy but the best we can do until we
fix OPAL to properly expose them with a complete descriptor. It is also
correct for the current HW anyway as OPAL interrupts are currently PCI
error and PSI interrupts which are level.

Finally now that edge interrupts are properly identified, we can enable
CONFIG_HARDIRQS_SW_RESEND which will make the core re-send them if
they occur while masked, which some drivers rely upon.

This fixes issues with lost interrupts on some Mellanox adapters.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/xics.h               |  2 +
 arch/powerpc/platforms/powernv/opal-irqchip.c |  3 +-
 arch/powerpc/sysdev/xics/Kconfig              |  1 +
 arch/powerpc/sysdev/xics/ics-opal.c           |  4 +-
 arch/powerpc/sysdev/xics/ics-rtas.c           |  4 +-
 arch/powerpc/sysdev/xics/xics-common.c        | 57 +++++++++++++++++++++++----
 6 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index f5f729c..f0b2385 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -159,6 +159,8 @@ extern void xics_teardown_cpu(void);
 extern void xics_kexec_teardown_cpu(int secondary);
 extern void xics_migrate_irqs_away(void);
 extern void icp_native_eoi(struct irq_data *d);
+extern int xics_set_irq_type(struct irq_data *d, unsigned int flow_type);
+extern int xics_retrigger(struct irq_data *data);
 #ifdef CONFIG_SMP
 extern int xics_get_irq_server(unsigned int virq, const struct cpumask *cpumask,
 			       unsigned int strict_check);
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index e505223b..ed8bba6 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -228,7 +228,8 @@ int __init opal_event_init(void)
 		}
 
 		/* Install interrupt handler */
-		rc = request_irq(virq, opal_interrupt, 0, "opal", NULL);
+		rc = request_irq(virq, opal_interrupt, IRQF_TRIGGER_LOW,
+				 "opal", NULL);
 		if (rc) {
 			irq_dispose_mapping(virq);
 			pr_warn("Error %d requesting irq %d (0x%x)\n",
diff --git a/arch/powerpc/sysdev/xics/Kconfig b/arch/powerpc/sysdev/xics/Kconfig
index 0031eda..385e7aa 100644
--- a/arch/powerpc/sysdev/xics/Kconfig
+++ b/arch/powerpc/sysdev/xics/Kconfig
@@ -1,6 +1,7 @@
 config PPC_XICS
        def_bool n
        select PPC_SMP_MUXED_IPI
+       select HARDIRQS_SW_RESEND
 
 config PPC_ICP_NATIVE
        def_bool n
diff --git a/arch/powerpc/sysdev/xics/ics-opal.c b/arch/powerpc/sysdev/xics/ics-opal.c
index 27c936c..1c6bf4b 100644
--- a/arch/powerpc/sysdev/xics/ics-opal.c
+++ b/arch/powerpc/sysdev/xics/ics-opal.c
@@ -156,7 +156,9 @@ static struct irq_chip ics_opal_irq_chip = {
 	.irq_mask = ics_opal_mask_irq,
 	.irq_unmask = ics_opal_unmask_irq,
 	.irq_eoi = NULL, /* Patched at init time */
-	.irq_set_affinity = ics_opal_set_affinity
+	.irq_set_affinity = ics_opal_set_affinity,
+	.irq_set_type = xics_set_irq_type,
+	.irq_retrigger = xics_retrigger,
 };
 
 static int ics_opal_map(struct ics *ics, unsigned int virq);
diff --git a/arch/powerpc/sysdev/xics/ics-rtas.c b/arch/powerpc/sysdev/xics/ics-rtas.c
index 3854dd4..78ee5c7 100644
--- a/arch/powerpc/sysdev/xics/ics-rtas.c
+++ b/arch/powerpc/sysdev/xics/ics-rtas.c
@@ -163,7 +163,9 @@ static struct irq_chip ics_rtas_irq_chip = {
 	.irq_mask = ics_rtas_mask_irq,
 	.irq_unmask = ics_rtas_unmask_irq,
 	.irq_eoi = NULL, /* Patched at init time */
-	.irq_set_affinity = ics_rtas_set_affinity
+	.irq_set_affinity = ics_rtas_set_affinity,
+	.irq_set_type = xics_set_irq_type,
+	.irq_retrigger = xics_retrigger,
 };
 
 static int ics_rtas_map(struct ics *ics, unsigned int virq)
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index a795a5f..79db666 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -328,8 +328,12 @@ static int xics_host_map(struct irq_domain *h, unsigned int virq,
 
 	pr_devel("xics: map virq %d, hwirq 0x%lx\n", virq, hw);
 
-	/* They aren't all level sensitive but we just don't really know */
-	irq_set_status_flags(virq, IRQ_LEVEL);
+	/*
+	 * Mark interrupts as edge sensitive by default so that resend
+	 * actually works. The device-tree parsing will turn the LSIs
+	 * back to level.
+	 */
+	irq_clear_status_flags(virq, IRQ_LEVEL);
 
 	/* Don't call into ICS for IPIs */
 	if (hw == XICS_IPI) {
@@ -351,13 +355,52 @@ static int xics_host_xlate(struct irq_domain *h, struct device_node *ct,
 			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
 
 {
-	/* Current xics implementation translates everything
-	 * to level. It is not technically right for MSIs but this
-	 * is irrelevant at this point. We might get smarter in the future
-	 */
 	*out_hwirq = intspec[0];
-	*out_flags = IRQ_TYPE_LEVEL_LOW;
 
+	/* If intsize is at least 2, we look for the type in the second cell,
+	 * we assume the LSB indicates a level interrupt
+	 */
+	if (intsize > 1) {
+		if (intspec[1] & 1)
+			*out_flags = IRQ_TYPE_LEVEL_LOW;
+		else
+			*out_flags = IRQ_TYPE_EDGE_RISING;
+	} else
+		*out_flags = IRQ_TYPE_LEVEL_LOW;
+
+	return 0;
+}
+
+int xics_set_irq_type(struct irq_data *d, unsigned int flow_type)
+{
+	/* We only support these. This has really no effect other
+	 * than setting the corresponding descriptor bits mind you
+	 * but those will in turn affect the resend function when
+	 * re-enabling an edge interrupt.
+	 *
+	 * Set set the default to edge as explained in map()
+	 */
+	if (flow_type == IRQ_TYPE_DEFAULT || flow_type == IRQ_TYPE_NONE)
+		flow_type = IRQ_TYPE_EDGE_RISING;
+
+	if (flow_type != IRQ_TYPE_EDGE_RISING &&
+	    flow_type != IRQ_TYPE_LEVEL_LOW)
+		return -EINVAL;
+
+	irqd_set_trigger_type(d, flow_type);
+
+	return IRQ_SET_MASK_OK_NOCOPY;
+}
+
+int xics_retrigger(struct irq_data *data)
+{
+	/* We need to push a dummy CPPR when retriggering, since
+	 * the subsequent EOI will try to pop it. Passing 0 works,
+	 * as the function hard codes the priority value anyway.
+	 */
+	xics_push_cppr(0);
+
+	/* Tell the core to do a soft retrigger */
 	return 0;
 }
 
