Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm4YH6mqgzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 16:37:39 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rm4YG6Ss8z9s5Q
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2016 16:37:38 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/14] powerpc/xics: Add ICP OPAL backend
Date: Fri,  8 Jul 2016 16:37:08 +1000
Message-Id: <1467959838-6900-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
References: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a new XICS backend that uses OPAL calls, which can be
used when we don't have native support for the platform interrupt
controller.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/xics.h        |   8 +-
 arch/powerpc/sysdev/xics/Makefile      |   2 +-
 arch/powerpc/sysdev/xics/icp-opal.c    | 144 +++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/xics/xics-common.c |   5 +-
 4 files changed, 156 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/sysdev/xics/icp-opal.c

diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index 04ef3ae..a30d845 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -42,6 +42,12 @@ extern int icp_hv_init(void);
 static inline int icp_hv_init(void) { return -ENODEV; }
 #endif
 
+#ifdef CONFIG_PPC_POWERNV
+extern int icp_opal_init(void);
+#else
+static inline int icp_opal_init(void) { return -ENODEV; }
+#endif
+
 /* ICP ops */
 struct icp_ops {
 	unsigned int (*get_irq)(void);
@@ -135,7 +141,7 @@ static inline void xics_set_base_cppr(unsigned char cppr)
 static inline unsigned char xics_cppr_top(void)
 {
 	struct xics_cppr *os_cppr = this_cpu_ptr(&xics_cppr);
-	
+
 	return os_cppr->stack[os_cppr->index];
 }
 
diff --git a/arch/powerpc/sysdev/xics/Makefile b/arch/powerpc/sysdev/xics/Makefile
index c606aa8..5d7f5a6 100644
--- a/arch/powerpc/sysdev/xics/Makefile
+++ b/arch/powerpc/sysdev/xics/Makefile
@@ -4,4 +4,4 @@ obj-y				+= xics-common.o
 obj-$(CONFIG_PPC_ICP_NATIVE)	+= icp-native.o
 obj-$(CONFIG_PPC_ICP_HV)	+= icp-hv.o
 obj-$(CONFIG_PPC_ICS_RTAS)	+= ics-rtas.o
-obj-$(CONFIG_PPC_POWERNV)	+= ics-opal.o
+obj-$(CONFIG_PPC_POWERNV)	+= ics-opal.o icp-opal.o
diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
new file mode 100644
index 0000000..eb484e9
--- /dev/null
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -0,0 +1,144 @@
+/*
+ * Copyright 2011 IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+
+#include <asm/smp.h>
+#include <asm/irq.h>
+#include <asm/errno.h>
+#include <asm/xics.h>
+#include <asm/io.h>
+#include <asm/opal.h>
+
+static void icp_opal_teardown_cpu(void)
+{
+	int cpu = smp_processor_id();
+
+	/* Clear any pending IPI */
+	opal_int_set_mfrr(cpu, 0xff);
+}
+
+static void icp_opal_flush_ipi(void)
+{
+	/* We take the ipi irq but and never return so we
+	 * need to EOI the IPI, but want to leave our priority 0
+	 *
+	 * should we check all the other interrupts too?
+	 * should we be flagging idle loop instead?
+	 * or creating some task to be scheduled?
+	 */
+
+	opal_int_eoi((0x00 << 24) | XICS_IPI);
+}
+
+static unsigned int icp_opal_get_irq(void)
+{
+	unsigned int xirr;
+	unsigned int vec;
+	unsigned int irq;
+	int64_t rc;
+
+	rc = opal_int_get_xirr(&xirr, false);
+	if (rc < 0)
+		return NO_IRQ;
+	xirr = be32_to_cpu(xirr);
+	vec = xirr & 0x00ffffff;
+	if (vec == XICS_IRQ_SPURIOUS)
+		return NO_IRQ;
+
+	irq = irq_find_mapping(xics_host, vec);
+	if (likely(irq != NO_IRQ)) {
+		xics_push_cppr(vec);
+		return irq;
+	}
+
+	/* We don't have a linux mapping, so have rtas mask it. */
+	xics_mask_unknown_vec(vec);
+
+	/* We might learn about it later, so EOI it */
+	opal_int_eoi(xirr);
+
+	return NO_IRQ;
+}
+
+static void icp_opal_set_cpu_priority(unsigned char cppr)
+{
+	xics_set_base_cppr(cppr);
+	opal_int_set_cppr(cppr);
+	iosync();
+}
+
+static void icp_opal_eoi(struct irq_data *d)
+{
+	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
+	int64_t rc;
+
+	iosync();
+	rc = opal_int_eoi((xics_pop_cppr() << 24) | hw_irq);
+
+	/* EOI tells us whether there are more interrupts to fetch.
+	 *
+	 * Some HW implementations might not be able to send us another
+	 * external interrupt in that case, so we force a replay.
+	 */
+	if (rc > 0)
+		force_external_irq_replay();
+}
+
+#ifdef CONFIG_SMP
+
+static void icp_opal_cause_ipi(int cpu, unsigned long data)
+{
+	opal_int_set_mfrr(cpu, IPI_PRIORITY);
+}
+
+static irqreturn_t icp_opal_ipi_action(int irq, void *dev_id)
+{
+	int cpu = smp_processor_id();
+
+	opal_int_set_mfrr(cpu, 0xff);
+
+	return smp_ipi_demux();
+}
+
+#endif /* CONFIG_SMP */
+
+static const struct icp_ops icp_opal_ops = {
+	.get_irq	= icp_opal_get_irq,
+	.eoi		= icp_opal_eoi,
+	.set_priority	= icp_opal_set_cpu_priority,
+	.teardown_cpu	= icp_opal_teardown_cpu,
+	.flush_ipi	= icp_opal_flush_ipi,
+#ifdef CONFIG_SMP
+	.ipi_action	= icp_opal_ipi_action,
+	.cause_ipi	= icp_opal_cause_ipi,
+#endif
+};
+
+int icp_opal_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "ibm,opal-intc");
+	if (!np)
+		return -ENODEV;
+
+	icp_ops = &icp_opal_ops;
+
+	printk("XICS: Using OPAL ICP fallbacks\n");
+
+	return 0;
+}
+
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 47e43b7..a795a5f 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -404,8 +404,11 @@ void __init xics_init(void)
 	/* Fist locate ICP */
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		rc = icp_hv_init();
-	if (rc < 0)
+	if (rc < 0) {
 		rc = icp_native_init();
+		if (rc == -ENODEV)
+		    rc = icp_opal_init();
+	}
 	if (rc < 0) {
 		pr_warning("XICS: Cannot find a Presentation Controller !\n");
 		return;
-- 
2.7.4
