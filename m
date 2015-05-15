Return-Path: <apopple@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96AE31A0484
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:49 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <apopple@au1.ibm.com>;
 Fri, 15 May 2015 14:07:48 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 598AD357804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4F47bwv28508308
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:46 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4F47Dki024785
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:13 +1000
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v4 2/9] powerpc/powernv: Add a virtual irqchip for opal events
Date: Fri, 15 May 2015 14:06:37 +1000
Message-Id: <1431662804-16851-3-git-send-email-alistair@popple.id.au>
In-Reply-To: <1431662804-16851-1-git-send-email-alistair@popple.id.au>
References: <1431662804-16851-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, linux-kernel@vger.kernel.org
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
 arch/powerpc/include/asm/opal.h               |   3 +
 arch/powerpc/platforms/powernv/Makefile       |   2 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c | 253 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c         |  78 ++------
 arch/powerpc/platforms/powernv/powernv.h      |   4 +
 5 files changed, 273 insertions(+), 67 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-irqchip.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 518a22e..520dfb2 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -242,6 +242,7 @@ extern void opal_msglog_init(void);
 extern int opal_async_comp_init(void);
 extern int opal_sensor_init(void);
 extern int opal_hmi_handler_init(void);
+extern int opal_event_init(void);
 
 extern int opal_machine_check(struct pt_regs *regs);
 extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
@@ -253,6 +254,8 @@ extern int opal_resync_timebase(void);
 
 extern void opal_lpc_init(void);
 
+extern int opal_event_request(unsigned int opal_event_nr);
+
 struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
 					     unsigned long vmalloc_size);
 void opal_free_sg_list(struct opal_sg_list *sg);
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 33e44f3..f1d7de2 100644
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
index 0000000..bd5125d
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -0,0 +1,253 @@
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
+#include <linux/irq_work.h>
+
+#include <asm/machdep.h>
+#include <asm/opal.h>
+
+#include "powernv.h"
+
+/* Maximum number of events supported by OPAL firmware */
+#define MAX_NUM_EVENTS 64
+
+struct opal_event_irqchip {
+	struct irq_chip irqchip;
+	struct irq_domain *domain;
+	unsigned long mask;
+};
+static struct opal_event_irqchip opal_event_irqchip;
+
+static unsigned int opal_irq_count;
+static unsigned int *opal_irqs;
+
+static void opal_handle_irq_work(struct irq_work *work);
+static __be64 last_outstanding_events;
+static struct irq_work opal_event_irq_work = {
+	.func = opal_handle_irq_work,
+};
+
+static void opal_event_mask(struct irq_data *d)
+{
+	clear_bit(d->hwirq, &opal_event_irqchip.mask);
+}
+
+static void opal_event_unmask(struct irq_data *d)
+{
+	set_bit(d->hwirq, &opal_event_irqchip.mask);
+
+	opal_poll_events(&last_outstanding_events);
+	if (last_outstanding_events & opal_event_irqchip.mask)
+		/* Need to retrigger the interrupt */
+		irq_work_queue(&opal_event_irq_work);
+}
+
+static int opal_event_set_type(struct irq_data *d, unsigned int flow_type)
+{
+	/*
+	 * For now we only support level triggered events. The irq
+	 * handler will be called continuously until the event has
+	 * been cleared in OPAL.
+	 */
+	if (flow_type != IRQ_TYPE_LEVEL_HIGH)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct opal_event_irqchip opal_event_irqchip = {
+	.irqchip = {
+		.name = "OPAL EVT",
+		.irq_mask = opal_event_mask,
+		.irq_unmask = opal_event_unmask,
+		.irq_set_type = opal_event_set_type,
+	},
+	.mask = 0,
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
+	u64 mask = opal_event_irqchip.mask;
+	u64 notifier_mask = 0;
+
+	if (!in_irq() && (events & mask)) {
+		last_outstanding_events = events;
+		irq_work_queue(&opal_event_irq_work);
+		return;
+	}
+
+	while (events) {
+		hwirq = fls64(events) - 1;
+		virq = irq_find_mapping(opal_event_irqchip.domain,
+					hwirq);
+		if (virq) {
+			if (BIT_ULL(hwirq) & mask)
+				generic_handle_irq(virq);
+		} else
+			notifier_mask |= BIT_ULL(hwirq);
+		events &= ~BIT_ULL(hwirq);
+	}
+
+	opal_do_notifier(notifier_mask);
+}
+
+static irqreturn_t opal_interrupt(int irq, void *data)
+{
+	__be64 events;
+
+	opal_handle_interrupt(virq_to_hw(irq), &events);
+	opal_handle_events(be64_to_cpu(events));
+
+	return IRQ_HANDLED;
+}
+
+static void opal_handle_irq_work(struct irq_work *work)
+{
+	opal_handle_events(be64_to_cpu(last_outstanding_events));
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
+int __init opal_event_init(void)
+{
+	struct device_node *dn, *opal_node;
+	const __be32 *irqs;
+	int i, irqlen, rc = 0;
+
+	opal_node = of_find_node_by_path("/ibm,opal");
+	if (!opal_node) {
+		pr_warn("opal: Node not found\n");
+		return -ENODEV;
+	}
+
+	/* If dn is NULL it means the domain won't be linked to a DT
+	 * node so therefore irq_of_parse_and_map(...) wont work. But
+	 * that shouldn't be problem because if we're running a
+	 * version of skiboot that doesn't have the dn then the
+	 * devices won't have the correct properties and will have to
+	 * fall back to the legacy method (opal_event_request(...))
+	 * anyway. */
+	dn = of_find_compatible_node(NULL, NULL, "ibm,opal-event");
+	opal_event_irqchip.domain = irq_domain_add_linear(dn, MAX_NUM_EVENTS,
+				&opal_event_domain_ops, &opal_event_irqchip);
+	of_node_put(dn);
+	if (!opal_event_irqchip.domain) {
+		pr_warn("opal: Unable to create irq domain\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	/* Get interrupt property */
+	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
+	opal_irq_count = irqs ? (irqlen / 4) : 0;
+	pr_debug("Found %d interrupts reserved for OPAL\n", opal_irq_count);
+
+	/* Install interrupt handlers */
+	opal_irqs = kcalloc(opal_irq_count, sizeof(*opal_irqs), GFP_KERNEL);
+	for (i = 0; irqs && i < opal_irq_count; i++, irqs++) {
+		unsigned int irq, virq;
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
+out:
+	of_node_put(opal_node);
+	return rc;
+}
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
index eb3decc..3baca71 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -53,8 +53,6 @@ static int mc_recoverable_range_len;
 
 struct device_node *opal_node;
 static DEFINE_SPINLOCK(opal_write_lock);
-static unsigned int *opal_irqs;
-static unsigned int opal_irq_count;
 static ATOMIC_NOTIFIER_HEAD(opal_notifier_head);
 static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
 static DEFINE_SPINLOCK(opal_notifier_lock);
@@ -251,7 +249,7 @@ int opal_notifier_unregister(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(opal_notifier_unregister);
 
-static void opal_do_notifier(uint64_t events)
+void opal_do_notifier(uint64_t events)
 {
 	unsigned long flags;
 	uint64_t changed_mask;
@@ -571,8 +569,10 @@ int opal_handle_hmi_exception(struct pt_regs *regs)
 
 	local_paca->hmi_event_available = 0;
 	rc = opal_poll_events(&evt);
-	if (rc == OPAL_SUCCESS && evt)
+	if (rc == OPAL_SUCCESS && evt) {
 		opal_do_notifier(be64_to_cpu(evt));
+		opal_handle_events(be64_to_cpu(evt));
+	}
 
 	return 1;
 }
@@ -609,17 +609,6 @@ out:
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
@@ -718,52 +707,15 @@ static void opal_i2c_create_devs(void)
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
 static int kopald(void *unused)
 {
+	__be64 events;
+
 	set_freezable();
 	do {
 		try_to_freeze();
-		opal_poll_events(NULL);
+		opal_poll_events(&events);
+		opal_handle_events(be64_to_cpu(events));
 		msleep_interruptible(opal_heartbeat);
 	} while (!kthread_should_stop());
 
@@ -792,6 +744,9 @@ static int __init opal_init(void)
 		return -ENODEV;
 	}
 
+	/* Initialise OPAL events */
+	opal_event_init();
+
 	/* Register OPAL consoles if any ports */
 	if (firmware_has_feature(FW_FEATURE_OPALv2))
 		consoles = of_find_node_by_path("/ibm,opal/consoles");
@@ -824,9 +779,6 @@ static int __init opal_init(void)
 	/* Setup a heatbeat thread if requested by OPAL */
 	opal_init_heartbeat();
 
-	/* Find all OPAL interrupts and request them */
-	opal_irq_init(opal_node);
-
 	/* Create "opal" kobject under /sys/firmware */
 	rc = opal_sysfs_init();
 	if (rc == 0) {
@@ -857,15 +809,9 @@ machine_subsys_initcall(powernv, opal_init);
 
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
index 826d2c9..221d4c8 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -35,6 +35,10 @@ extern u32 pnv_get_supported_cpuidle_states(void);
 
 extern void pnv_lpc_init(void);
 
+extern void opal_do_notifier(uint64_t events);
+extern void opal_handle_events(uint64_t events);
+extern void opal_event_shutdown(void);
+
 bool cpu_core_split_required(void);
 
 #endif /* _POWERNV_H */
-- 
1.8.3.2
