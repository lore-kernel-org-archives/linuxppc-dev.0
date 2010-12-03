Return-Path: <r58472@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 61D15B725C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 22:41:27 +1100 (EST)
Received: from mail9-db3 (localhost.localdomain [127.0.0.1])	by
	mail9-db3-R.bigfish.com (Postfix) with ESMTP id DA16C11A0067	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  3 Dec 2010 11:41:25 +0000 (UTC)
Received: from DB3EHSMHS010.bigfish.com (unknown [10.3.81.245])	by
	mail9-db3.bigfish.com (Postfix) with ESMTP id C6DC9A8804C	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  3 Dec 2010 11:41:19 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB3BfGiL023345	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 04:41:16 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oB3BxAdh018881	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 3 Dec 2010 05:59:19 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 5/7] powerpc: add the mpic timer support
Date: Fri, 3 Dec 2010 20:34:09 +0800
Message-ID: <1291379651-8822-5-git-send-email-leoli@freescale.com>
In-Reply-To: <1291379651-8822-4-git-send-email-leoli@freescale.com>
References: <1291379651-8822-1-git-send-email-leoli@freescale.com>
	<1291379651-8822-2-git-send-email-leoli@freescale.com>
	<1291379651-8822-3-git-send-email-leoli@freescale.com>
	<1291379651-8822-4-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are global timers in the MPIC interrupt controller.  The patch
adds support to the timers.

The timer can generate interrupt which can be used as a wakeup event.

Signed-off-by: Dave Liu <daveliu@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/include/asm/mpic.h  |    1 +
 arch/powerpc/sysdev/Makefile     |    2 +-
 arch/powerpc/sysdev/mpic.c       |   88 +++++++++++++-
 arch/powerpc/sysdev/mpic_timer.c |  258 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 346 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/sysdev/mpic_timer.c

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index e000cce..4272111 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -263,6 +263,7 @@ struct mpic
 #ifdef CONFIG_SMP
 	struct irq_chip		hc_ipi;
 #endif
+	struct irq_chip         hc_tm;
 	const char		*name;
 	/* Flags */
 	unsigned int		flags;
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 0bef9da..d95a417 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -3,7 +3,7 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 ccflags-$(CONFIG_PPC64)		:= -mno-minimal-toc
 
 mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o mpic_pasemi_msi.o
-obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
+obj-$(CONFIG_MPIC)		+= mpic.o mpic_timer.o $(mpic-msi-obj-y)
 fsl-msi-obj-$(CONFIG_PCI_MSI)	+= fsl_msi.o
 obj-$(CONFIG_PPC_MSI_BITMAP)	+= msi_bitmap.o
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 7c13426..107549d 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -6,6 +6,7 @@
  *  with various broken implementations of this HW.
  *
  *  Copyright (C) 2004 Benjamin Herrenschmidt, IBM Corp.
+ *  Copyright (C) 2006, 2008-2010 Freescale Semiconductor Inc.
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License.  See the file COPYING in the main directory of this archive
@@ -36,6 +37,7 @@
 #include <asm/machdep.h>
 #include <asm/mpic.h>
 #include <asm/smp.h>
+#include <asm/prom.h>
 
 #include "mpic.h"
 
@@ -208,6 +210,22 @@ static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi, u32 valu
 	_mpic_write(mpic->reg_type, &mpic->gregs, offset, value);
 }
 
+static inline u32 _mpic_tm_read(struct mpic *mpic, unsigned int tm)
+{
+	unsigned int offset = MPIC_INFO(TIMER_VECTOR_PRI) +
+			      (tm * MPIC_INFO(TIMER_STRIDE));
+
+	return _mpic_read(mpic->reg_type, &mpic->tmregs, offset);
+}
+
+static inline void _mpic_tm_write(struct mpic *mpic, unsigned int tm, u32 value)
+{
+	unsigned int offset = MPIC_INFO(TIMER_VECTOR_PRI) +
+			      (tm * MPIC_INFO(TIMER_STRIDE));
+
+	_mpic_write(mpic->reg_type, &mpic->tmregs, offset, value);
+}
+
 static inline u32 _mpic_cpu_read(struct mpic *mpic, unsigned int reg)
 {
 	unsigned int cpu = 0;
@@ -263,6 +281,8 @@ static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
 #define mpic_write(b,r,v)	_mpic_write(mpic->reg_type,&(b),(r),(v))
 #define mpic_ipi_read(i)	_mpic_ipi_read(mpic,(i))
 #define mpic_ipi_write(i,v)	_mpic_ipi_write(mpic,(i),(v))
+#define mpic_tm_read(i)		_mpic_tm_read(mpic,(i))
+#define mpic_tm_write(i,v)	_mpic_tm_write(mpic,(i),(v))
 #define mpic_cpu_read(i)	_mpic_cpu_read(mpic,(i))
 #define mpic_cpu_write(i,v)	_mpic_cpu_write(mpic,(i),(v))
 #define mpic_irq_read(s,r)	_mpic_irq_read(mpic,(s),(r))
@@ -622,6 +642,13 @@ static unsigned int mpic_is_ipi(struct mpic *mpic, unsigned int irq)
 	return (src >= mpic->ipi_vecs[0] && src <= mpic->ipi_vecs[3]);
 }
 
+/* Determine if the linux irq is an timer IPI */
+static unsigned int mpic_is_tm(struct mpic *mpic, unsigned int irq)
+{
+	unsigned int src = mpic_irq_to_hw(irq);
+
+	return (src >= mpic->timer_vecs[0] && src <= mpic->timer_vecs[3]);
+}
 
 /* Convert a cpu mask from logical to physical cpu numbers. */
 static inline u32 mpic_physmask(u32 cpumask)
@@ -642,6 +669,12 @@ static inline struct mpic * mpic_from_ipi(unsigned int ipi)
 }
 #endif
 
+/* Get the mpic structure from the tm number */
+static inline struct mpic * mpic_from_tm(unsigned int tm)
+{
+	return irq_to_desc(tm)->chip_data;
+}
+
 /* Get the mpic structure from the irq number */
 static inline struct mpic * mpic_from_irq(unsigned int irq)
 {
@@ -800,6 +833,32 @@ static void mpic_end_ipi(unsigned int irq)
 
 #endif /* CONFIG_SMP */
 
+static void mpic_unmask_tm(unsigned int irq)
+{
+	struct mpic *mpic = mpic_from_tm(irq);
+	unsigned int src = mpic_irq_to_hw(irq) - mpic->timer_vecs[0];
+
+	DBG("%s: enable_tm: %d (tm %d)\n", mpic->name, irq, src);
+	mpic_tm_write(src, mpic_tm_read(src) & ~MPIC_VECPRI_MASK);
+	mpic_tm_read(src);
+}
+
+static void mpic_mask_tm(unsigned int irq)
+{
+	struct mpic *mpic = mpic_from_tm(irq);
+	unsigned int src = mpic_irq_to_hw(irq) - mpic->timer_vecs[0];
+
+	mpic_tm_write(src, mpic_tm_read(src) | MPIC_VECPRI_MASK);
+	mpic_tm_read(src);
+}
+
+static void mpic_end_tm(unsigned int irq)
+{
+	struct mpic *mpic = mpic_from_tm(irq);
+
+	mpic_eoi(mpic);
+}
+
 int mpic_set_affinity(unsigned int irq, const struct cpumask *cpumask)
 {
 	struct mpic *mpic = mpic_from_irq(irq);
@@ -919,6 +978,12 @@ static struct irq_chip mpic_ipi_chip = {
 };
 #endif /* CONFIG_SMP */
 
+static struct irq_chip mpic_tm_chip = {
+	.mask		= mpic_mask_tm,
+	.unmask		= mpic_unmask_tm,
+	.eoi		= mpic_end_tm,
+};
+
 #ifdef CONFIG_MPIC_U3_HT_IRQS
 static struct irq_chip mpic_irq_ht_chip = {
 	.startup	= mpic_startup_ht_irq,
@@ -950,6 +1015,15 @@ static int mpic_host_map(struct irq_host *h, unsigned int virq,
 	if (mpic->protected && test_bit(hw, mpic->protected))
 		return -EINVAL;
 
+	else if (hw >= mpic->timer_vecs[0] && hw <= mpic->timer_vecs[3]) {
+		WARN_ON(!(mpic->flags & MPIC_PRIMARY));
+
+		DBG("mpic: mapping as timer\n");
+		set_irq_chip_data(virq, mpic);
+		set_irq_chip_and_handler(virq, &mpic->hc_tm,
+					 handle_fasteoi_irq);
+		return 0;
+	}
 #ifdef CONFIG_SMP
 	else if (hw >= mpic->ipi_vecs[0]) {
 		WARN_ON(!(mpic->flags & MPIC_PRIMARY));
@@ -1071,6 +1145,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->hc_ipi.name = name;
 #endif /* CONFIG_SMP */
 
+	mpic->hc_tm = mpic_tm_chip;
+	mpic->hc_tm.name = name;
+
 	mpic->flags = flags;
 	mpic->isu_size = isu_size;
 	mpic->irq_count = irq_count;
@@ -1277,15 +1354,17 @@ void __init mpic_init(struct mpic *mpic)
 	/* Set current processor priority to max */
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
 
-	/* Initialize timers: just disable them all */
+	/* Initialize timers to our reserved vectors and mask them for now */
 	for (i = 0; i < 4; i++) {
 		mpic_write(mpic->tmregs,
 			   i * MPIC_INFO(TIMER_STRIDE) +
-			   MPIC_INFO(TIMER_DESTINATION), 0);
+			   MPIC_INFO(TIMER_DESTINATION),
+			   1 << hard_smp_processor_id());
 		mpic_write(mpic->tmregs,
 			   i * MPIC_INFO(TIMER_STRIDE) +
 			   MPIC_INFO(TIMER_VECTOR_PRI),
 			   MPIC_VECPRI_MASK |
+			   (9 << MPIC_VECPRI_PRIORITY_SHIFT) |
 			   (mpic->timer_vecs[0] + i));
 	}
 
@@ -1395,6 +1474,11 @@ void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
 			~MPIC_VECPRI_PRIORITY_MASK;
 		mpic_ipi_write(src - mpic->ipi_vecs[0],
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
+	} else if (mpic_is_tm(mpic, irq)) {
+		reg = mpic_tm_read(src - mpic->timer_vecs[0]) &
+			~MPIC_VECPRI_PRIORITY_MASK;
+		mpic_tm_write(src - mpic->timer_vecs[0],
+			      reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
 	} else {
 		reg = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI))
 			& ~MPIC_VECPRI_PRIORITY_MASK;
diff --git a/arch/powerpc/sysdev/mpic_timer.c b/arch/powerpc/sysdev/mpic_timer.c
new file mode 100644
index 0000000..cdc2438
--- /dev/null
+++ b/arch/powerpc/sysdev/mpic_timer.c
@@ -0,0 +1,258 @@
+/*
+ * Copyright (c) 2008-2010 Freescale Semiconductor, Inc. All rights reserved.
+ * Dave Liu <daveliu@freescale.com>
+ * copy from the 83xx GTM driver and modify for MPIC global timer,
+ * implement the global timer 0 function.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/interrupt.h>
+#include <linux/sysfs.h>
+#include <linux/slab.h>
+#include <linux/of_platform.h>
+
+#include <linux/io.h>
+#include <linux/irq.h>
+
+#include <sysdev/fsl_soc.h>
+
+#define MPIC_TIMER_TCR_OFFSET		0x200
+#define MPIC_TIMER_TCR_CLKDIV_64	0x00000300
+#define MPIC_TIMER_STOP			0x80000000
+
+struct mpic_tm_regs {
+	u32	gtccr;
+	u32	res0[3];
+	u32	gtbcr;
+	u32	res1[3];
+	u32	gtvpr;
+	u32	res2[3];
+	u32	gtdr;
+	u32	res3[3];
+};
+
+struct mpic_tm_priv {
+	struct mpic_tm_regs __iomem *regs;
+	int irq;
+	int ticks_per_sec;
+	spinlock_t lock;
+};
+
+struct mpic_type {
+	int has_tcr;
+};
+
+static irqreturn_t mpic_tm_isr(int irq, void *dev_id)
+{
+	struct mpic_tm_priv *priv = dev_id;
+	unsigned long flags;
+	unsigned long temp;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	temp = in_be32(&priv->regs->gtbcr);
+	temp |= MPIC_TIMER_STOP; /* counting inhibited */
+	out_be32(&priv->regs->gtbcr, temp);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t mpic_tm_timeout_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct mpic_tm_priv *priv = dev_get_drvdata(dev);
+	unsigned long interval = simple_strtoul(buf, NULL, 0);
+	unsigned long temp;
+
+	if (interval > 0x7fffffff) {
+		dev_dbg(dev, "mpic_tm: interval %lu (in s) too long\n", interval);
+		return -EINVAL;
+	}
+
+	temp = interval;
+	interval *= priv->ticks_per_sec;
+
+	if (interval > 0x7fffffff || (interval / priv->ticks_per_sec) != temp) {
+		dev_dbg(dev, "mpic_tm: interval %lu (in ticks) too long\n",
+			interval);
+		return -EINVAL;
+	}
+
+	spin_lock_irq(&priv->lock);
+
+	/* stop timer 0 */
+	temp = in_be32(&priv->regs->gtbcr);
+	temp |= MPIC_TIMER_STOP; /* counting inhibited */
+	out_be32(&priv->regs->gtbcr, temp);
+
+	if (interval != 0) {
+		/* start timer */
+		out_be32(&priv->regs->gtbcr, interval | MPIC_TIMER_STOP);
+		out_be32(&priv->regs->gtbcr, interval);
+	}
+
+	spin_unlock_irq(&priv->lock);
+	return count;
+}
+
+static ssize_t mpic_tm_timeout_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct mpic_tm_priv *priv = dev_get_drvdata(dev);
+	int timeout = 0;
+
+	spin_lock_irq(&priv->lock);
+
+	if (!(in_be32(&priv->regs->gtbcr) & MPIC_TIMER_STOP)) {
+		timeout = in_be32(&priv->regs->gtccr);
+		timeout += priv->ticks_per_sec - 1;
+		timeout /= priv->ticks_per_sec;
+	}
+
+	spin_unlock_irq(&priv->lock);
+	return sprintf(buf, "%u\n", timeout);
+}
+
+static DEVICE_ATTR(timeout, 0660, mpic_tm_timeout_show, mpic_tm_timeout_store);
+
+static int __devinit mpic_tm_probe(struct platform_device *dev,
+				const struct of_device_id *match)
+{
+	struct device_node *np = dev->dev.of_node;
+	struct resource res;
+	struct mpic_tm_priv *priv;
+	struct mpic_type *type = match->data;
+	int has_tcr = type->has_tcr;
+	u32 busfreq = fsl_get_sys_freq();
+	int ret = 0;
+
+	if (busfreq == 0) {
+		dev_err(&dev->dev, "mpic_tm: No bus frequency in device tree.\n");
+		return -ENODEV;
+	}
+
+	priv = kmalloc(sizeof(struct mpic_tm_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->lock);
+	dev_set_drvdata(&dev->dev, priv);
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		goto out;
+
+	priv->irq = irq_of_parse_and_map(np, 0);
+	if (priv->irq == NO_IRQ) {
+		dev_err(&dev->dev, "MPIC global timer0 exists in device tree "
+				"without an IRQ.\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = request_irq(priv->irq, mpic_tm_isr, 0, "mpic timer 0", priv);
+	if (ret)
+		goto out;
+
+	priv->regs = ioremap(res.start, res.end - res.start + 1);
+	if (!priv->regs) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * MPIC implementation from Freescale has the TCR register,
+	 * the MPIC_TIMER_TCR_OFFSET is 0x200 from global timer base
+	 * the default clock source to the MPIC timer 0 is CCB freq / 8.
+	 * to extend the timer period, we divide the timer clock source
+	 * as CCB freq / 64, so the max timer period is 336 seconds
+	 * when the CCB frequence is 400MHz.
+	 */
+	if (!has_tcr) {
+		priv->ticks_per_sec = busfreq / 8;
+	} else {
+		u32 __iomem *tcr;
+		tcr = (u32 __iomem *)((u32)priv->regs + MPIC_TIMER_TCR_OFFSET);
+		out_be32(tcr, in_be32(tcr) | MPIC_TIMER_TCR_CLKDIV_64);
+		priv->ticks_per_sec = busfreq / 64;
+	}
+
+	ret = device_create_file(&dev->dev, &dev_attr_timeout);
+	if (ret)
+		goto out;
+
+	printk("MPIC global timer init done.\n");
+
+	return 0;
+
+out:
+	kfree(priv);
+	return ret;
+}
+
+static int __devexit mpic_tm_remove(struct platform_device *dev)
+{
+	struct mpic_tm_priv *priv = dev_get_drvdata(&dev->dev);
+
+	device_remove_file(&dev->dev, &dev_attr_timeout);
+	free_irq(priv->irq, priv);
+	iounmap(priv->regs);
+
+	dev_set_drvdata(&dev->dev, NULL);
+	kfree(priv);
+	return 0;
+}
+
+static struct mpic_type mpic_types[] = {
+	{
+		.has_tcr = 0,
+	},
+	{
+		.has_tcr = 1,
+	}
+};
+
+static struct of_device_id mpic_tm_match[] = {
+	{
+		.compatible = "fsl,mpic-global-timer",
+		.data = &mpic_types[1],
+	},
+	{},
+};
+
+static struct of_platform_driver mpic_tm_driver = {
+	.driver = {
+		.name = "mpic-global-timer",
+		.owner = THIS_MODULE,
+		.of_match_table = mpic_tm_match,
+	},
+	.probe = mpic_tm_probe,
+	.remove = __devexit_p(mpic_tm_remove)
+};
+
+static int __init mpic_tm_init(void)
+{
+	return of_register_platform_driver(&mpic_tm_driver);
+}
+
+static void __exit mpic_tm_exit(void)
+{
+	of_unregister_platform_driver(&mpic_tm_driver);
+}
+
+module_init(mpic_tm_init);
+module_exit(mpic_tm_exit);
-- 
1.6.6-rc1.GIT
