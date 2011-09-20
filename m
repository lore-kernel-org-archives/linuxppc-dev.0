Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3244D100DC8
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 13:46:07 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/20] powerpc/powernv: Add OPAL ICS backend
Date: Tue, 20 Sep 2011 13:45:02 +1000
Message-Id: <1316490307-28030-15-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
References: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL handles HW access to the various ICS or equivalent chips
for us (with the exception of p5ioc2 based HEA which uses a
different backend) similarily to what RTAS does on pSeries.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/xics.h        |   19 +++
 arch/powerpc/sysdev/xics/Makefile      |    1 +
 arch/powerpc/sysdev/xics/ics-opal.c    |  244 ++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/xics/xics-common.c |    8 +-
 4 files changed, 266 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/sysdev/xics/ics-opal.c

diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index b183a40..bd6c401 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -27,10 +27,18 @@
 #define MAX_NUM_PRIORITIES	3
 
 /* Native ICP */
+#ifdef CONFIG_PPC_ICP_NATIVE
 extern int icp_native_init(void);
+#else
+static inline int icp_native_init(void) { return -ENODEV; }
+#endif
 
 /* PAPR ICP */
+#ifdef CONFIG_PPC_ICP_HV
 extern int icp_hv_init(void);
+#else
+static inline int icp_hv_init(void) { return -ENODEV; }
+#endif
 
 /* ICP ops */
 struct icp_ops {
@@ -51,7 +59,18 @@ extern const struct icp_ops *icp_ops;
 extern int ics_native_init(void);
 
 /* RTAS ICS */
+#ifdef CONFIG_PPC_ICS_RTAS
 extern int ics_rtas_init(void);
+#else
+static inline int ics_rtas_init(void) { return -ENODEV; }
+#endif
+
+/* HAL ICS */
+#ifdef CONFIG_PPC_POWERNV
+extern int ics_opal_init(void);
+#else
+static inline int ics_opal_init(void) { return -ENODEV; }
+#endif
 
 /* ICS instance, hooked up to chip_data of an irq */
 struct ics {
diff --git a/arch/powerpc/sysdev/xics/Makefile b/arch/powerpc/sysdev/xics/Makefile
index b75a605..c606aa8 100644
--- a/arch/powerpc/sysdev/xics/Makefile
+++ b/arch/powerpc/sysdev/xics/Makefile
@@ -4,3 +4,4 @@ obj-y				+= xics-common.o
 obj-$(CONFIG_PPC_ICP_NATIVE)	+= icp-native.o
 obj-$(CONFIG_PPC_ICP_HV)	+= icp-hv.o
 obj-$(CONFIG_PPC_ICS_RTAS)	+= ics-rtas.o
+obj-$(CONFIG_PPC_POWERNV)	+= ics-opal.o
diff --git a/arch/powerpc/sysdev/xics/ics-opal.c b/arch/powerpc/sysdev/xics/ics-opal.c
new file mode 100644
index 0000000..f7e8609
--- /dev/null
+++ b/arch/powerpc/sysdev/xics/ics-opal.c
@@ -0,0 +1,244 @@
+/*
+ * ICS backend for OPAL managed interrupts.
+ *
+ * Copyright 2011 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#undef DEBUG
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+#include <linux/spinlock.h>
+#include <linux/msi.h>
+
+#include <asm/prom.h>
+#include <asm/smp.h>
+#include <asm/machdep.h>
+#include <asm/irq.h>
+#include <asm/errno.h>
+#include <asm/xics.h>
+#include <asm/opal.h>
+#include <asm/firmware.h>
+
+static int ics_opal_mangle_server(int server)
+{
+	/* No link for now */
+	return server << 2;
+}
+
+static int ics_opal_unmangle_server(int server)
+{
+	/* No link for now */
+	return server >> 2;
+}
+
+static void ics_opal_unmask_irq(struct irq_data *d)
+{
+	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
+	int64_t rc;
+	int server;
+
+	pr_devel("ics-hal: unmask virq %d [hw 0x%x]\n", d->irq, hw_irq);
+
+	if (hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS)
+		return;
+
+	server = xics_get_irq_server(d->irq, d->affinity, 0);
+	server = ics_opal_mangle_server(server);
+
+	rc = opal_set_xive(hw_irq, server, DEFAULT_PRIORITY);
+	if (rc != OPAL_SUCCESS)
+		pr_err("%s: opal_set_xive(irq=%d [hw 0x%x] server=%x)"
+		       " error %lld\n",
+		       __func__, d->irq, hw_irq, server, rc);
+}
+
+static unsigned int ics_opal_startup(struct irq_data *d)
+{
+#ifdef CONFIG_PCI_MSI
+	/*
+	 * The generic MSI code returns with the interrupt disabled on the
+	 * card, using the MSI mask bits. Firmware doesn't appear to unmask
+	 * at that level, so we do it here by hand.
+	 */
+	if (d->msi_desc)
+		unmask_msi_irq(d);
+#endif
+
+	/* unmask it */
+	ics_opal_unmask_irq(d);
+	return 0;
+}
+
+static void ics_opal_mask_real_irq(unsigned int hw_irq)
+{
+	int server = ics_opal_mangle_server(xics_default_server);
+	int64_t rc;
+
+	if (hw_irq == XICS_IPI)
+		return;
+
+	/* Have to set XIVE to 0xff to be able to remove a slot */
+	rc = opal_set_xive(hw_irq, server, 0xff);
+	if (rc != OPAL_SUCCESS)
+		pr_err("%s: opal_set_xive(0xff) irq=%u returned %lld\n",
+		       __func__, hw_irq, rc);
+}
+
+static void ics_opal_mask_irq(struct irq_data *d)
+{
+	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
+
+	pr_devel("ics-hal: mask virq %d [hw 0x%x]\n", d->irq, hw_irq);
+
+	if (hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS)
+		return;
+	ics_opal_mask_real_irq(hw_irq);
+}
+
+static int ics_opal_set_affinity(struct irq_data *d,
+				 const struct cpumask *cpumask,
+				 bool force)
+{
+	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
+	int16_t server;
+	int8_t priority;
+	int64_t rc;
+	int wanted_server;
+
+	if (hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS)
+		return -1;
+
+	rc = opal_get_xive(hw_irq, &server, &priority);
+	if (rc != OPAL_SUCCESS) {
+		pr_err("%s: opal_set_xive(irq=%d [hw 0x%x] server=%x)"
+		       " error %lld\n",
+		       __func__, d->irq, hw_irq, server, rc);
+		return -1;
+	}
+
+	wanted_server = xics_get_irq_server(d->irq, cpumask, 1);
+	if (wanted_server < 0) {
+		char cpulist[128];
+		cpumask_scnprintf(cpulist, sizeof(cpulist), cpumask);
+		pr_warning("%s: No online cpus in the mask %s for irq %d\n",
+			   __func__, cpulist, d->irq);
+		return -1;
+	}
+	server = ics_opal_mangle_server(wanted_server);
+
+	pr_devel("ics-hal: set-affinity irq %d [hw 0x%x] server: 0x%x/0x%x\n",
+		 d->irq, hw_irq, wanted_server, server);
+
+	rc = opal_set_xive(hw_irq, server, priority);
+	if (rc != OPAL_SUCCESS) {
+		pr_err("%s: opal_set_xive(irq=%d [hw 0x%x] server=%x)"
+		       " error %lld\n",
+		       __func__, d->irq, hw_irq, server, rc);
+		return -1;
+	}
+	return 0;
+}
+
+static struct irq_chip ics_opal_irq_chip = {
+	.name = "OPAL ICS",
+	.irq_startup = ics_opal_startup,
+	.irq_mask = ics_opal_mask_irq,
+	.irq_unmask = ics_opal_unmask_irq,
+	.irq_eoi = NULL, /* Patched at init time */
+	.irq_set_affinity = ics_opal_set_affinity
+};
+
+static int ics_opal_map(struct ics *ics, unsigned int virq);
+static void ics_opal_mask_unknown(struct ics *ics, unsigned long vec);
+static long ics_opal_get_server(struct ics *ics, unsigned long vec);
+
+static int ics_opal_host_match(struct ics *ics, struct device_node *node)
+{
+	return 1;
+}
+
+/* Only one global & state struct ics */
+static struct ics ics_hal = {
+	.map		= ics_opal_map,
+	.mask_unknown	= ics_opal_mask_unknown,
+	.get_server	= ics_opal_get_server,
+	.host_match	= ics_opal_host_match,
+};
+
+static int ics_opal_map(struct ics *ics, unsigned int virq)
+{
+	unsigned int hw_irq = (unsigned int)virq_to_hw(virq);
+	int64_t rc;
+	int16_t server;
+	int8_t priority;
+
+	if (WARN_ON(hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS))
+		return -EINVAL;
+
+	/* Check if HAL knows about this interrupt */
+	rc = opal_get_xive(hw_irq, &server, &priority);
+	if (rc != OPAL_SUCCESS)
+		return -ENXIO;
+
+	irq_set_chip_and_handler(virq, &ics_opal_irq_chip, handle_fasteoi_irq);
+	irq_set_chip_data(virq, &ics_hal);
+
+	return 0;
+}
+
+static void ics_opal_mask_unknown(struct ics *ics, unsigned long vec)
+{
+	int64_t rc;
+	int16_t server;
+	int8_t priority;
+
+	/* Check if HAL knows about this interrupt */
+	rc = opal_get_xive(vec, &server, &priority);
+	if (rc != OPAL_SUCCESS)
+		return;
+
+	ics_opal_mask_real_irq(vec);
+}
+
+static long ics_opal_get_server(struct ics *ics, unsigned long vec)
+{
+	int64_t rc;
+	int16_t server;
+	int8_t priority;
+
+	/* Check if HAL knows about this interrupt */
+	rc = opal_get_xive(vec, &server, &priority);
+	if (rc != OPAL_SUCCESS)
+		return -1;
+	return ics_opal_unmangle_server(server);
+}
+
+int __init ics_opal_init(void)
+{
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
+		return -ENODEV;
+
+	/* We need to patch our irq chip's EOI to point to the
+	 * right ICP
+	 */
+	ics_opal_irq_chip.irq_eoi = icp_ops->eoi;
+
+	/* Register ourselves */
+	xics_register_ics(&ics_hal);
+
+	pr_info("ICS OPAL backend registered\n");
+
+	return 0;
+}
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 445c5a0..3d93a8d 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -409,14 +409,10 @@ void __init xics_init(void)
 	int rc = -1;
 
 	/* Fist locate ICP */
-#ifdef CONFIG_PPC_ICP_HV
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		rc = icp_hv_init();
-#endif
-#ifdef CONFIG_PPC_ICP_NATIVE
 	if (rc < 0)
 		rc = icp_native_init();
-#endif
 	if (rc < 0) {
 		pr_warning("XICS: Cannot find a Presentation Controller !\n");
 		return;
@@ -429,9 +425,9 @@ void __init xics_init(void)
 	xics_ipi_chip.irq_eoi = icp_ops->eoi;
 
 	/* Now locate ICS */
-#ifdef CONFIG_PPC_ICS_RTAS
 	rc = ics_rtas_init();
-#endif
+	if (rc < 0)
+		rc = ics_opal_init();
 	if (rc < 0)
 		pr_warning("XICS: Cannot find a Source Controller !\n");
 
-- 
1.7.4.1
