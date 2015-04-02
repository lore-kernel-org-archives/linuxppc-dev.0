Return-Path: <alistair.popple@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5D791A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:23:59 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair.popple@au1.ibm.com>;
 Thu, 2 Apr 2015 13:23:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2FA5A3578047
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:23:54 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t323NkBu45547772
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:23:54 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t323NKeu029855
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:23:20 +1100
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] powerpc/powernv: Add a virtual irqchip for opal events
Date: Thu,  2 Apr 2015 14:22:25 +1100
Message-Id: <1427944952-17452-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Whenever an interrupt is received for opal the linux kernel gets a
bitfield indicating certain events that have occurred and need handling
by the various device drivers. Currently this is handled using a
notifier interface where we call every device driver that has
registered to receive opal events.

This approach has several drawbacks. For example each driver has to do
its own checking to see if the event is relevant as well as event
masking. There is also no easy method of recording the number of times
we receive particular events.

This patch solves these issues by exposing opal events via the
standard interrupt APIs by adding a new interrupt chip and
domain. Drivers can then register for the appropriate events using
standard kernel calls such as irq_of_parse_and_map().

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/include/asm/opal.h               |   2 +
 arch/powerpc/platforms/powernv/Makefile       |   2 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c | 259 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c         |  70 +------
 arch/powerpc/platforms/powernv/powernv.h      |   4 +
 5 files changed, 271 insertions(+), 66 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-irqchip.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9ee0a30..4d969f7 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -979,6 +979,8 @@ extern int opal_resync_timebase(void);
 
 extern void opal_lpc_init(void);
 
+extern int opal_event_request(unsigned int opal_event_nr);
+
 struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
 					     unsigned long vmalloc_size);
 void opal_free_sg_list(struct opal_sg_list *sg);
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 6f3c5d3..911154f 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,7 +1,7 @@
 obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
-obj-y			+= opal-msglog.o opal-hmi.o opal-power.o
+obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
new file mode 100644
index 0000000..acc12e3
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -0,0 +1,259 @@
+/*
+ * This file implements an irqchip for OPAL events. Whenever there is
+ * an interrupt that is handled by OPAL we get passed a list of events
+ * that Linux needs to do something about. These basically look like
+ * interrupts to Linux so we implement an irqchip to handle them.
+ *
+ * Copyright Alistair Popple, IBM Corporation 2014.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+
+#include <asm/machdep.h>
+#include <asm/opal.h>
+
+#include "powernv.h"
+
+struct opal_event_irqchip {
+	struct irq_chip irqchip;
+	struct irq_domain *domain;
+	unsigned long mask;
+	unsigned long ack;
+	unsigned long edge;
+};
+static struct opal_event_irqchip opal_event_irqchip;
+
+static unsigned int opal_irq_count;
+static unsigned int *opal_irqs;
+
+static void opal_event_ack(struct irq_data *d)
+{
+	/* Set the ack bit so that we don't get any more interrupts
+	 * until the event is cleared. */
+	if (opal_event_irqchip.edge & BIT_ULL(d->hwirq))
+		set_bit(d->hwirq, &opal_event_irqchip.ack);
+}
+
+static void opal_event_mask(struct irq_data *d)
+{
+	clear_bit(d->hwirq, &opal_event_irqchip.mask);
+}
+
+static void opal_event_unmask(struct irq_data *d)
+{
+	set_bit(d->hwirq, &opal_event_irqchip.mask);
+}
+
+static int opal_event_set_type(struct irq_data *d, unsigned int flow_type)
+{
+	/* We support two flow types - level and edge. These
+	 * correspond to the two possible ways events are used. When
+	 * flow_type is set to LEVEL_HIGH the irq handler will be
+	 * called continuously until the event has been cleared.
+	 *
+	 * When flow_type is set to EDGE_RISING we call the irq
+	 * handler once each time the event is set. The handler will
+	 * not be called again until Linux has seen the event cleared
+	 * in OPAL. */
+
+	switch (flow_type) {
+	case IRQ_TYPE_EDGE_RISING:
+		set_bit(d->hwirq, &opal_event_irqchip.edge);
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		clear_bit(d->hwirq, &opal_event_irqchip.edge);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct opal_event_irqchip opal_event_irqchip = {
+	.irqchip = {
+		.name = "OPAL EVT",
+		.irq_ack = opal_event_ack,
+		.irq_mask = opal_event_mask,
+		.irq_unmask = opal_event_unmask,
+		.irq_set_type = opal_event_set_type,
+	},
+	.mask = 0,
+	.ack  = 0,
+};
+
+static int opal_event_map(struct irq_domain *d, unsigned int irq,
+			irq_hw_number_t hwirq)
+{
+	irq_set_chip_data(irq, &opal_event_irqchip);
+	irq_set_chip_and_handler(irq, &opal_event_irqchip.irqchip,
+				handle_level_irq);
+
+	return 0;
+}
+
+void opal_handle_events(uint64_t events)
+{
+	int virq, hwirq = 0;
+	u64 mask = opal_event_irqchip.mask & ~(opal_event_irqchip.ack &
+					opal_event_irqchip.edge);
+
+	while (events & mask) {
+		hwirq = fls64(events) - 1;
+		if (BIT_ULL(hwirq) & mask) {
+			virq = irq_find_mapping(opal_event_irqchip.domain,
+						hwirq);
+			if (virq)
+				handle_edge_irq(virq, irq_to_desc(virq));
+		}
+		events &= ~BIT_ULL(hwirq);
+	}
+}
+
+static irqreturn_t opal_interrupt(int irq, void *data)
+{
+	__be64 events;
+
+	opal_handle_interrupt(virq_to_hw(irq), &events);
+
+	/* Continue to call the notifiers until we have converted
+	 * existing users over. */
+	opal_do_notifier(be64_to_cpu(events));
+
+	/* Clear the ack bit once an event is set to zero */
+	opal_event_irqchip.ack &= events;
+
+	opal_handle_events(be64_to_cpu(events));
+
+	return IRQ_HANDLED;
+}
+
+static int opal_event_match(struct irq_domain *h, struct device_node *node)
+{
+	return h->of_node == node;
+}
+
+static int opal_event_xlate(struct irq_domain *h, struct device_node *np,
+			   const u32 *intspec, unsigned int intsize,
+			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
+{
+	*out_hwirq = intspec[0];
+	*out_flags = IRQ_TYPE_LEVEL_HIGH;
+
+	return 0;
+}
+
+static const struct irq_domain_ops opal_event_domain_ops = {
+	.match	= opal_event_match,
+	.map	= opal_event_map,
+	.xlate	= opal_event_xlate,
+};
+
+void opal_event_shutdown(void)
+{
+	unsigned int i;
+
+	/* First free interrupts, which will also mask them */
+	for (i = 0; i < opal_irq_count; i++) {
+		if (opal_irqs[i])
+			free_irq(opal_irqs[i], NULL);
+		opal_irqs[i] = 0;
+	}
+}
+
+static int __init opal_event_init(void)
+{
+	struct device_node *dn, *opal_node;
+	const __be32 *irqs;
+	int i, irqlen;
+
+	opal_node = of_find_node_by_path("/ibm,opal");
+	if (!opal_node) {
+		pr_warn("opal: Node not found\n");
+		return -ENODEV;
+	}
+
+	dn = of_find_compatible_node(NULL, NULL, "ibm,opal-event");
+
+	/* If dn is NULL it means the domain won't be linked to a DT
+	 * node so therefore irq_of_parse_and_map(...) wont work. But
+	 * that shouldn't be problem because if we're running a
+	 * version of skiboot that doesn't have the dn then the
+	 * devices won't have the correct properties and will have to
+	 * fall back to the legacy method (opal_event_request(...))
+	 * anyway. */
+	opal_event_irqchip.domain =
+		irq_domain_add_linear(dn, 64, &opal_event_domain_ops,
+				      &opal_event_irqchip);
+	if (IS_ERR(opal_event_irqchip.domain)) {
+		pr_warn("opal: Unable to create irq domain\n");
+		return PTR_ERR(opal_event_irqchip.domain);
+	}
+
+	/* Get interrupt property */
+	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
+	opal_irq_count = irqs ? (irqlen / 4) : 0;
+	pr_debug("Found %d interrupts reserved for OPAL\n", opal_irq_count);
+
+	/* Install interrupt handlers */
+	opal_irqs = kcalloc(opal_irq_count * sizeof(unsigned int), GFP_KERNEL);
+	for (i = 0; irqs && i < opal_irq_count; i++, irqs++) {
+		unsigned int irq, virq;
+		int rc;
+
+		/* Get hardware and virtual IRQ */
+		irq = be32_to_cpup(irqs);
+		virq = irq_create_mapping(NULL, irq);
+		if (virq == NO_IRQ) {
+			pr_warn("Failed to map irq 0x%x\n", irq);
+			continue;
+		}
+
+		/* Install interrupt handler */
+		rc = request_irq(virq, opal_interrupt, 0, "opal", NULL);
+		if (rc) {
+			irq_dispose_mapping(virq);
+			pr_warn("Error %d requesting irq %d (0x%x)\n",
+				 rc, virq, irq);
+			continue;
+		}
+
+		/* Cache IRQ */
+		opal_irqs[i] = virq;
+	}
+
+	return 0;
+}
+machine_core_initcall(powernv, opal_event_init);
+
+/**
+ * opal_event_request(unsigned int opal_event_nr) - Request an event
+ * @opal_event_nr: the opal event number to request
+ *
+ * This routine can be used to find the linux virq number which can
+ * then be passed to request_irq to assign a handler for a particular
+ * opal event. This should only be used by legacy devices which don't
+ * have proper device tree bindings. Most devices should use
+ * irq_of_parse_and_map() instead.
+ */
+int opal_event_request(unsigned int opal_event_nr)
+{
+	return irq_create_mapping(opal_event_irqchip.domain, opal_event_nr);
+}
+EXPORT_SYMBOL(opal_event_request);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 18fd4e7..1d73b85 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -51,8 +51,6 @@ static int mc_recoverable_range_len;
 
 struct device_node *opal_node;
 static DEFINE_SPINLOCK(opal_write_lock);
-static unsigned int *opal_irqs;
-static unsigned int opal_irq_count;
 static ATOMIC_NOTIFIER_HEAD(opal_notifier_head);
 static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
 static DEFINE_SPINLOCK(opal_notifier_lock);
@@ -248,7 +246,7 @@ int opal_notifier_unregister(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(opal_notifier_unregister);
 
-static void opal_do_notifier(uint64_t events)
+void opal_do_notifier(uint64_t events)
 {
 	unsigned long flags;
 	uint64_t changed_mask;
@@ -566,8 +564,10 @@ int opal_handle_hmi_exception(struct pt_regs *regs)
 
 	local_paca->hmi_event_available = 0;
 	rc = opal_poll_events(&evt);
-	if (rc == OPAL_SUCCESS && evt)
+	if (rc == OPAL_SUCCESS && evt) {
 		opal_do_notifier(be64_to_cpu(evt));
+		opal_handle_events(be64_to_cpu(evt));
+	}
 
 	return 1;
 }
@@ -604,17 +604,6 @@ out:
 	return !!recover_addr;
 }
 
-static irqreturn_t opal_interrupt(int irq, void *data)
-{
-	__be64 events;
-
-	opal_handle_interrupt(virq_to_hw(irq), &events);
-
-	opal_do_notifier(be64_to_cpu(events));
-
-	return IRQ_HANDLED;
-}
-
 static int opal_sysfs_init(void)
 {
 	opal_kobj = kobject_create_and_add("opal", firmware_kobj);
@@ -701,46 +690,6 @@ static void opal_i2c_create_devs(void)
 		of_platform_device_create(np, NULL, NULL);
 }
 
-static void __init opal_irq_init(struct device_node *dn)
-{
-	const __be32 *irqs;
-	int i, irqlen;
-
-	/* Get interrupt property */
-	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
-	opal_irq_count = irqs ? (irqlen / 4) : 0;
-	pr_debug("Found %d interrupts reserved for OPAL\n", opal_irq_count);
-	if (!opal_irq_count)
-		return;
-
-	/* Install interrupt handlers */
-	opal_irqs = kzalloc(opal_irq_count * sizeof(unsigned int), GFP_KERNEL);
-	for (i = 0; irqs && i < opal_irq_count; i++, irqs++) {
-		unsigned int irq, virq;
-		int rc;
-
-		/* Get hardware and virtual IRQ */
-		irq = be32_to_cpup(irqs);
-		virq = irq_create_mapping(NULL, irq);
-		if (virq == NO_IRQ) {
-			pr_warn("Failed to map irq 0x%x\n", irq);
-			continue;
-		}
-
-		/* Install interrupt handler */
-		rc = request_irq(virq, opal_interrupt, 0, "opal", NULL);
-		if (rc) {
-			irq_dispose_mapping(virq);
-			pr_warn("Error %d requesting irq %d (0x%x)\n",
-				 rc, virq, irq);
-			continue;
-		}
-
-		/* Cache IRQ */
-		opal_irqs[i] = virq;
-	}
-}
-
 static int __init opal_init(void)
 {
 	struct device_node *np, *consoles;
@@ -769,9 +718,6 @@ static int __init opal_init(void)
 	/* Create i2c platform devices */
 	opal_i2c_create_devs();
 
-	/* Find all OPAL interrupts and request them */
-	opal_irq_init(opal_node);
-
 	/* Create "opal" kobject under /sys/firmware */
 	rc = opal_sysfs_init();
 	if (rc == 0) {
@@ -799,15 +745,9 @@ machine_subsys_initcall(powernv, opal_init);
 
 void opal_shutdown(void)
 {
-	unsigned int i;
 	long rc = OPAL_BUSY;
 
-	/* First free interrupts, which will also mask them */
-	for (i = 0; i < opal_irq_count; i++) {
-		if (opal_irqs[i])
-			free_irq(opal_irqs[i], NULL);
-		opal_irqs[i] = 0;
-	}
+	opal_event_shutdown();
 
 	/*
 	 * Then sync with OPAL which ensure anything that can
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 604c48e..41edf6c 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -33,6 +33,10 @@ extern u32 pnv_get_supported_cpuidle_states(void);
 
 extern void pnv_lpc_init(void);
 
+extern void opal_do_notifier(uint64_t events);
+extern void opal_handle_events(uint64_t events);
+extern void opal_event_shutdown(void);
+
 bool cpu_core_split_required(void);
 
 #endif /* _POWERNV_H */
-- 
1.8.3.2
