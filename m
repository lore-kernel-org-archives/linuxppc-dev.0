Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 36F9267D19
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 20:34:35 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k8TAYYYI000807
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 03:34:34 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8TAYUbx011928
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 05:34:31 -0500 (CDT)
Message-ID: <451CF6DD.70902@freescale.com>
Date: Fri, 29 Sep 2006 18:35:09 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 2/9] qe_lib: Add QE interrupt controller driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The QEIC is updated to use genirq and Ben's interrupt mapping.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Shlomi Gridish <gridish@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com> 

---
 arch/powerpc/sysdev/qe_lib/qe_ic.c |  554 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/qe_ic.h |  105 +++++++
 include/asm-powerpc/qe_ic.h        |   89 ++++++
 3 files changed, 748 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
new file mode 100644
index 0000000..9fb95e9
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -0,0 +1,554 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc.  All rights reserved.
+ *
+ * Author: Li Yang <leoli@freescale.com>
+ * Based on code from Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * QUICC ENGINE Interrupt Controller
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/sysdev.h>
+#include <linux/device.h>
+#include <linux/bootmem.h>
+#include <linux/spinlock.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/qe_ic.h>
+
+#include "qe_ic.h"
+
+static DEFINE_SPINLOCK(qe_ic_lock);
+
+static struct qe_ic_info qe_ic_info[] = {
+	[1] = {
+	       .mask = 0x00008000,
+	       .mask_reg = QEIC_CIMR,
+	       .pri_code = 0,
+	       .pri_reg = QEIC_CIPWCC,
+	       },
+	[2] = {
+	       .mask = 0x00004000,
+	       .mask_reg = QEIC_CIMR,
+	       .pri_code = 1,
+	       .pri_reg = QEIC_CIPWCC,
+	       },
+	[3] = {
+	       .mask = 0x00002000,
+	       .mask_reg = QEIC_CIMR,
+	       .pri_code = 2,
+	       .pri_reg = QEIC_CIPWCC,
+	       },
+	[10] = {
+		.mask = 0x00000040,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 1,
+		.pri_reg = QEIC_CIPZCC,
+		},
+	[11] = {
+		.mask = 0x00000020,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 2,
+		.pri_reg = QEIC_CIPZCC,
+		},
+	[12] = {
+		.mask = 0x00000010,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 3,
+		.pri_reg = QEIC_CIPZCC,
+		},
+	[13] = {
+		.mask = 0x00000008,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 4,
+		.pri_reg = QEIC_CIPZCC,
+		},
+	[14] = {
+		.mask = 0x00000004,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 5,
+		.pri_reg = QEIC_CIPZCC,
+		},
+	[15] = {
+		.mask = 0x00000002,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 6,
+		.pri_reg = QEIC_CIPZCC,
+		},
+	[20] = {
+		.mask = 0x10000000,
+		.mask_reg = QEIC_CRIMR,
+		.pri_code = 3,
+		.pri_reg = QEIC_CIPRTA,
+		},
+	[25] = {
+		.mask = 0x00800000,
+		.mask_reg = QEIC_CRIMR,
+		.pri_code = 0,
+		.pri_reg = QEIC_CIPRTB,
+		},
+	[26] = {
+		.mask = 0x00400000,
+		.mask_reg = QEIC_CRIMR,
+		.pri_code = 1,
+		.pri_reg = QEIC_CIPRTB,
+		},
+	[27] = {
+		.mask = 0x00200000,
+		.mask_reg = QEIC_CRIMR,
+		.pri_code = 2,
+		.pri_reg = QEIC_CIPRTB,
+		},
+	[28] = {
+		.mask = 0x00100000,
+		.mask_reg = QEIC_CRIMR,
+		.pri_code = 3,
+		.pri_reg = QEIC_CIPRTB,
+		},
+	[32] = {
+		.mask = 0x80000000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 0,
+		.pri_reg = QEIC_CIPXCC,
+		},
+	[33] = {
+		.mask = 0x40000000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 1,
+		.pri_reg = QEIC_CIPXCC,
+		},
+	[34] = {
+		.mask = 0x20000000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 2,
+		.pri_reg = QEIC_CIPXCC,
+		},
+	[35] = {
+		.mask = 0x10000000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 3,
+		.pri_reg = QEIC_CIPXCC,
+		},
+	[36] = {
+		.mask = 0x08000000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 4,
+		.pri_reg = QEIC_CIPXCC,
+		},
+	[40] = {
+		.mask = 0x00800000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 0,
+		.pri_reg = QEIC_CIPYCC,
+		},
+	[41] = {
+		.mask = 0x00400000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 1,
+		.pri_reg = QEIC_CIPYCC,
+		},
+	[42] = {
+		.mask = 0x00200000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 2,
+		.pri_reg = QEIC_CIPYCC,
+		},
+	[43] = {
+		.mask = 0x00100000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 3,
+		.pri_reg = QEIC_CIPYCC,
+		},
+};
+
+static inline u32 qe_ic_read(volatile u32 __iomem * base, unsigned int reg)
+{
+	return in_be32(base + (reg >> 2));
+}
+
+static inline void qe_ic_write(volatile u32 __iomem * base, unsigned int reg,
+			       u32 value)
+{
+	out_be32(base + (reg >> 2), value);
+}
+
+static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
+{
+	return irq_desc[virq].chip_data;
+}
+
+#define virq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
+
+static void qe_ic_unmask_irq(unsigned int virq)
+{
+	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
+	unsigned int src = virq_to_hw(virq);
+	unsigned long flags;
+	u32 temp;
+
+	spin_lock_irqsave(&qe_ic_lock, flags);
+
+	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
+	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
+		    temp | qe_ic_info[src].mask);
+
+	spin_unlock_irqrestore(&qe_ic_lock, flags);
+}
+
+static void qe_ic_mask_irq(unsigned int virq)
+{
+	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
+	unsigned int src = virq_to_hw(virq);
+	unsigned long flags;
+	u32 temp;
+
+	spin_lock_irqsave(&qe_ic_lock, flags);
+
+	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
+	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
+		    temp & ~qe_ic_info[src].mask);
+
+	spin_unlock_irqrestore(&qe_ic_lock, flags);
+}
+
+static void qe_ic_mask_irq_and_ack(unsigned int virq)
+{
+	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
+	unsigned int src = virq_to_hw(virq);
+	unsigned long flags;
+	u32 temp;
+
+	spin_lock_irqsave(&qe_ic_lock, flags);
+
+	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
+	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
+		    temp & ~qe_ic_info[src].mask);
+
+	/* There is nothing to do for ack here, ack is handled in ISR */
+
+	spin_unlock_irqrestore(&qe_ic_lock, flags);
+}
+
+static struct irq_chip qe_ic_irq_chip = {
+	.typename = " QEIC  ",
+	.unmask = qe_ic_unmask_irq,
+	.mask = qe_ic_mask_irq,
+	.mask_ack = qe_ic_mask_irq_and_ack,
+};
+
+static int qe_ic_host_match(struct irq_host *h, struct device_node *node)
+{
+	struct qe_ic *qe_ic = h->host_data;
+
+	/* Exact match, unless qe_ic node is NULL */
+	return qe_ic->of_node == NULL || qe_ic->of_node == node;
+}
+
+static int qe_ic_host_map(struct irq_host *h, unsigned int virq,
+			  irq_hw_number_t hw)
+{
+	struct qe_ic *qe_ic = h->host_data;
+	struct irq_chip *chip;
+
+	if (qe_ic_info[hw].mask == 0) {
+		printk(KERN_ERR "Can't map reserved IRQ \n");
+		return -EINVAL;
+	}
+	/* Default chip */
+	chip = &qe_ic->hc_irq;
+
+	set_irq_chip_data(virq, qe_ic);
+	get_irq_desc(virq)->status |= IRQ_LEVEL;
+
+	set_irq_chip_and_handler(virq, chip, handle_level_irq);
+
+	return 0;
+}
+
+static int qe_ic_host_xlate(struct irq_host *h, struct device_node *ct,
+			    u32 * intspec, unsigned int intsize,
+			    irq_hw_number_t * out_hwirq,
+			    unsigned int *out_flags)
+{
+	*out_hwirq = intspec[0];
+	if (intsize > 1)
+		*out_flags = intspec[1];
+	else
+		*out_flags = IRQ_TYPE_NONE;
+	return 0;
+}
+
+static struct irq_host_ops qe_ic_host_ops = {
+	.match = qe_ic_host_match,
+	.map = qe_ic_host_map,
+	.xlate = qe_ic_host_xlate,
+};
+
+/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic, struct pt_regs *regs)
+{
+	int irq;
+
+	BUG_ON(qe_ic == NULL);
+
+	/* get the interrupt source vector. */
+	irq = qe_ic_read(qe_ic->regs, QEIC_CIVEC) >> 26;
+
+	if (irq == 0)
+		return NO_IRQ;
+
+	return irq_linear_revmap(qe_ic->irqhost, irq);
+}
+
+/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic, struct pt_regs *regs)
+{
+	int irq;
+
+	BUG_ON(qe_ic == NULL);
+
+	/* get the interrupt source vector. */
+	irq = qe_ic_read(qe_ic->regs, QEIC_CHIVEC) >> 26;
+
+	if (irq == 0)
+		return NO_IRQ;
+
+	return irq_linear_revmap(qe_ic->irqhost, irq);
+}
+
+/* FIXME: We mask all the QE Low interrupts while handling.  We should
+ * let other interrupt come in, but BAD interrupts are generated */
+void fastcall qe_ic_cascade_low(unsigned int irq, struct irq_desc *desc,
+				struct pt_regs *regs)
+{
+	struct qe_ic *qe_ic = desc->handler_data;
+	struct irq_chip *chip = irq_desc[irq].chip;
+
+	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic, regs);
+
+	chip->mask_ack(irq);
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq, regs);
+	chip->unmask(irq);
+}
+
+/* FIXME: We mask all the QE High interrupts while handling.  We should
+ * let other interrupt come in, but BAD interrupts are generated */
+void fastcall qe_ic_cascade_high(unsigned int irq, struct irq_desc *desc,
+				 struct pt_regs *regs)
+{
+	struct qe_ic *qe_ic = desc->handler_data;
+	struct irq_chip *chip = irq_desc[irq].chip;
+
+	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic, regs);
+
+	chip->mask_ack(irq);
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq, regs);
+	chip->unmask(irq);
+}
+
+void __init qe_ic_init(struct device_node *node, unsigned int flags)
+{
+	struct qe_ic *qe_ic;
+	struct resource res;
+	u32 temp = 0, ret, high_active = 0;
+
+	qe_ic = alloc_bootmem(sizeof(struct qe_ic));
+	if (qe_ic == NULL)
+		return;
+
+	memset(qe_ic, 0, sizeof(struct qe_ic));
+	qe_ic->of_node = node ? of_node_get(node) : NULL;
+
+	qe_ic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
+					NR_QE_IC_INTS, &qe_ic_host_ops, 0);
+	if (qe_ic->irqhost == NULL) {
+		of_node_put(node);
+		return;
+	}
+
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret)
+		return;
+
+	qe_ic->regs = ioremap(res.start, res.end - res.start + 1);
+
+	qe_ic->irqhost->host_data = qe_ic;
+	qe_ic->hc_irq = qe_ic_irq_chip;
+
+	qe_ic->virq_high = irq_of_parse_and_map(node, 0);
+	qe_ic->virq_low = irq_of_parse_and_map(node, 1);
+
+	if (qe_ic->virq_low == NO_IRQ) {
+		printk(KERN_ERR "Failed to map QE_IC low IRQ\n");
+		return;
+	}
+
+	/* default priority scheme is grouped. If spread mode is    */
+	/* required, configure cicr accordingly.                    */
+	if (flags & QE_IC_SPREADMODE_GRP_W)
+		temp |= CICR_GWCC;
+	if (flags & QE_IC_SPREADMODE_GRP_X)
+		temp |= CICR_GXCC;
+	if (flags & QE_IC_SPREADMODE_GRP_Y)
+		temp |= CICR_GYCC;
+	if (flags & QE_IC_SPREADMODE_GRP_Z)
+		temp |= CICR_GZCC;
+	if (flags & QE_IC_SPREADMODE_GRP_RISCA)
+		temp |= CICR_GRTA;
+	if (flags & QE_IC_SPREADMODE_GRP_RISCB)
+		temp |= CICR_GRTB;
+
+	/* choose destination signal for highest priority interrupt */
+	if (flags & QE_IC_HIGH_SIGNAL) {
+		temp |= (SIGNAL_HIGH << CICR_HPIT_SHIFT);
+		high_active = 1;
+	}
+
+	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
+
+	set_irq_data(qe_ic->virq_low, qe_ic);
+	set_irq_chained_handler(qe_ic->virq_low, qe_ic_cascade_low);
+
+	if (qe_ic->virq_high != NO_IRQ) {
+		set_irq_data(qe_ic->virq_high, qe_ic);
+		set_irq_chained_handler(qe_ic->virq_high, qe_ic_cascade_high);
+	}
+
+	printk("QEIC (%d IRQ sources) at %p\n", NR_QE_IC_INTS, qe_ic->regs);
+}
+
+void qe_ic_set_highest_priority(unsigned int virq, int high)
+{
+	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
+	unsigned int src = virq_to_hw(virq);
+	u32 temp = 0;
+
+	temp = qe_ic_read(qe_ic->regs, QEIC_CICR);
+
+	temp &= ~CICR_HP_MASK;
+	temp |= src << CICR_HP_SHIFT;
+
+	temp &= ~CICR_HPIT_MASK;
+	temp |= (high ? SIGNAL_HIGH : SIGNAL_LOW) << CICR_HPIT_SHIFT;
+
+	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
+}
+
+/* Set Priority level within its group, from 1 to 8 */
+int qe_ic_set_priority(unsigned int virq, unsigned int priority)
+{
+	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
+	unsigned int src = virq_to_hw(virq);
+	u32 temp;
+
+	if (priority > 8 || priority == 0)
+		return -EINVAL;
+	if (src > 127)
+		return -EINVAL;
+	if (qe_ic_info[src].pri_reg == 0)
+		return -EINVAL;
+
+	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].pri_reg);
+
+	if (priority < 4) {
+		temp &= ~(0x7 << (32 - priority * 3));
+		temp |= qe_ic_info[src].pri_code << (32 - priority * 3);
+	} else {
+		temp &= ~(0x7 << (24 - priority * 3));
+		temp |= qe_ic_info[src].pri_code << (24 - priority * 3);
+	}
+
+	qe_ic_write(qe_ic->regs, qe_ic_info[src].pri_reg, temp);
+
+	return 0;
+}
+
+/* Set a QE priority to use high irq, only priority 1~2 can use high irq */
+int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
+{
+	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
+	unsigned int src = virq_to_hw(virq);
+	u32 temp, control_reg = QEIC_CICNR, shift = 0;
+
+	if (priority > 2 || priority == 0)
+		return -EINVAL;
+
+	switch (qe_ic_info[src].pri_reg) {
+	case (QEIC_CIPZCC):
+		shift = CICNR_ZCC1T_SHIFT;
+		break;
+	case (QEIC_CIPWCC):
+		shift = CICNR_WCC1T_SHIFT;
+		break;
+	case (QEIC_CIPYCC):
+		shift = CICNR_YCC1T_SHIFT;
+		break;
+	case (QEIC_CIPXCC):
+		shift = CICNR_XCC1T_SHIFT;
+		break;
+	case (QEIC_CIPRTA):
+		shift = CRICR_RTA1T_SHIFT;
+		control_reg = QEIC_CRICR;
+		break;
+	case (QEIC_CIPRTB):
+		shift = CRICR_RTB1T_SHIFT;
+		control_reg = QEIC_CRICR;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	shift += (2 - priority) * 2;
+	temp = qe_ic_read(qe_ic->regs, control_reg);
+	temp &= ~(SIGNAL_MASK << shift);
+	temp |= (high ? SIGNAL_HIGH : SIGNAL_LOW) << shift;
+	qe_ic_write(qe_ic->regs, control_reg, temp);
+
+	return 0;
+}
+
+static struct sysdev_class qe_ic_sysclass = {
+	set_kset_name("qe_ic"),
+};
+
+static struct sys_device device_qe_ic = {
+	.id = 0,
+	.cls = &qe_ic_sysclass,
+};
+
+static int __init init_qe_ic_sysfs(void)
+{
+	int rc;
+
+	printk(KERN_DEBUG "Registering qe_ic with sysfs...\n");
+
+	rc = sysdev_class_register(&qe_ic_sysclass);
+	if (rc) {
+		printk(KERN_ERR "Failed registering qe_ic sys class\n");
+		return -ENODEV;
+	}
+	rc = sysdev_register(&device_qe_ic);
+	if (rc) {
+		printk(KERN_ERR "Failed registering qe_ic sys device\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+subsys_initcall(init_qe_ic_sysfs);
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.h b/arch/powerpc/sysdev/qe_lib/qe_ic.h
new file mode 100644
index 0000000..33612c8
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.h
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Author: Li Yang <leoli@freescale.com>
+ * Based on code from Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * QUICC ENGINE Interrupt Controller Header
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __QE_IC_H__
+#define __QE_IC_H__
+
+#include <asm/qe_ic.h>
+
+#define NR_QE_IC_INTS		128
+
+/* QE IC registers offset */
+#define QEIC_CICR		0x00
+#define QEIC_CIVEC		0x04
+#define QEIC_CRIPNR		0x08
+#define QEIC_CIPNR		0x0c
+#define QEIC_CIPXCC		0x10
+#define QEIC_CIPYCC		0x14
+#define QEIC_CIPWCC		0x18
+#define QEIC_CIPZCC		0x1c
+#define QEIC_CIMR		0x20
+#define QEIC_CRIMR		0x24
+#define QEIC_CICNR		0x28
+#define QEIC_CIPRTA		0x30
+#define QEIC_CIPRTB		0x34
+#define QEIC_CRICR		0x3c
+#define QEIC_CHIVEC		0x60
+
+/* Interrupt priority registers */
+#define CIPCC_SHIFT_PRI0	29
+#define CIPCC_SHIFT_PRI1	26
+#define CIPCC_SHIFT_PRI2	23
+#define CIPCC_SHIFT_PRI3	20
+#define CIPCC_SHIFT_PRI4	13
+#define CIPCC_SHIFT_PRI5	10
+#define CIPCC_SHIFT_PRI6	7
+#define CIPCC_SHIFT_PRI7	4
+
+/* CICR priority modes */
+#define CICR_GWCC		0x00040000
+#define CICR_GXCC		0x00020000
+#define CICR_GYCC		0x00010000
+#define CICR_GZCC		0x00080000
+#define CICR_GRTA		0x00200000
+#define CICR_GRTB		0x00400000
+#define CICR_HPIT_SHIFT		8
+#define CICR_HPIT_MASK		0x00000300
+#define CICR_HP_SHIFT		24
+#define CICR_HP_MASK		0x3f000000
+
+/* CICNR */
+#define CICNR_WCC1T_SHIFT	20
+#define CICNR_ZCC1T_SHIFT	28
+#define CICNR_YCC1T_SHIFT	12
+#define CICNR_XCC1T_SHIFT	4
+
+/* CRICR */
+#define CRICR_RTA1T_SHIFT	20
+#define CRICR_RTB1T_SHIFT	28
+
+/* Signal indicator */
+#define SIGNAL_MASK		3
+#define SIGNAL_HIGH		2
+#define SIGNAL_LOW		0
+
+struct qe_ic {
+	/* Control registers offset */
+	volatile u32 __iomem *regs;
+
+	/* The remapper for this QEIC */
+	struct irq_host *irqhost;
+
+	/* The "linux" controller struct */
+	struct irq_chip hc_irq;
+
+	/* The device node of the interrupt controller */
+	struct device_node *of_node;
+
+	/* VIRQ numbers of QE high/low irqs */
+	unsigned int virq_high;
+	unsigned int virq_low;
+};
+
+/*
+ * QE interrupt controller internal structure
+ */
+struct qe_ic_info {
+	u32 mask;	/* location of this source at the QIMR register. */
+	u32 mask_reg;	/* Mask register offset */
+	u8 pri_code;	/* for grouped interrupts sources - the interrupt
+			   code as appears at the group priority register. */
+	u32 pri_reg;		/* Group priority register offset */
+};
+
+#endif				/* __QE_IC_H__ */
diff --git a/include/asm-powerpc/qe_ic.h b/include/asm-powerpc/qe_ic.h
new file mode 100644
index 0000000..26199c1
--- /dev/null
+++ b/include/asm-powerpc/qe_ic.h
@@ -0,0 +1,89 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * Description:
+ * QE IC external definitions and structure.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifdef CONFIG_QUICC_ENGINE
+#ifdef __KERNEL__
+#ifndef __ASM_QE_IC_H__
+#define __ASM_QE_IC_H__
+
+#include <linux/irq.h>
+
+#define _IO_BASE        isa_io_base
+#define _ISA_MEM_BASE   isa_mem_base
+#ifdef CONFIG_PCI
+#define PCI_DRAM_OFFSET pci_dram_offset
+#else
+#define PCI_DRAM_OFFSET 0
+#endif
+
+#define NUM_OF_QE_IC_GROUPS    6
+
+/* Flags when we init the QE IC */
+#define QE_IC_SPREADMODE_GRP_W                   0x00000001
+#define QE_IC_SPREADMODE_GRP_X                   0x00000002
+#define QE_IC_SPREADMODE_GRP_Y                   0x00000004
+#define QE_IC_SPREADMODE_GRP_Z                   0x00000008
+#define QE_IC_SPREADMODE_GRP_RISCA               0x00000010
+#define QE_IC_SPREADMODE_GRP_RISCB               0x00000020
+
+#define QE_IC_LOW_SIGNAL                         0x00000100
+#define QE_IC_HIGH_SIGNAL                        0x00000200
+
+#define QE_IC_GRP_W_PRI0_DEST_SIGNAL_HIGH        0x00001000
+#define QE_IC_GRP_W_PRI1_DEST_SIGNAL_HIGH        0x00002000
+#define QE_IC_GRP_X_PRI0_DEST_SIGNAL_HIGH        0x00004000
+#define QE_IC_GRP_X_PRI1_DEST_SIGNAL_HIGH        0x00008000
+#define QE_IC_GRP_Y_PRI0_DEST_SIGNAL_HIGH        0x00010000
+#define QE_IC_GRP_Y_PRI1_DEST_SIGNAL_HIGH        0x00020000
+#define QE_IC_GRP_Z_PRI0_DEST_SIGNAL_HIGH        0x00040000
+#define QE_IC_GRP_Z_PRI1_DEST_SIGNAL_HIGH        0x00080000
+#define QE_IC_GRP_RISCA_PRI0_DEST_SIGNAL_HIGH    0x00100000
+#define QE_IC_GRP_RISCA_PRI1_DEST_SIGNAL_HIGH    0x00200000
+#define QE_IC_GRP_RISCB_PRI0_DEST_SIGNAL_HIGH    0x00400000
+#define QE_IC_GRP_RISCB_PRI1_DEST_SIGNAL_HIGH    0x00800000
+#define QE_IC_GRP_W_DEST_SIGNAL_SHIFT            (12)
+
+/*
+ * QE interrupt sources groups
+ */
+enum qe_ic_grp_id {
+	QE_IC_GRP_W = 0,	/* QE interrupt controller group W      */
+	QE_IC_GRP_X,		/* QE interrupt controller group X      */
+	QE_IC_GRP_Y,		/* QE interrupt controller group Y      */
+	QE_IC_GRP_Z,		/* QE interrupt controller group Z      */
+	QE_IC_GRP_RISCA,	/* QE interrupt controller RISC group A */
+	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
+};
+
+/*********************************************/
+/******   QE IC API routines             *****/
+/*********************************************/
+void qe_ic_init(struct device_node *node, unsigned int flags);
+
+/* qe_ic_modify_highest_priority
+ * Optional, used to change default. This routine defines a single interrupt
+ * source to be highest priority. It may be called at any stage, thus enabling
+ * dynamic change of the highest priority interrupt.
+ * In default, Highest priority is XCC1 highest priority interrupt source.
+ *
+ *     virq: Interrupt source number
+ *     high: Use high signal?
+ */
+void qe_ic_set_highest_priority(unsigned int virq, int high);
+int qe_ic_set_priority(unsigned int virq, unsigned int priority);
+int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
+
+#endif				/* __ASM_QE_IC_H__ */
+#endif				/* __KERNEL__ */
+#endif				/* CONFIG_QUICC_ENGINE */
