Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5CC3BDDF69
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 19:28:58 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m3I9SoPL012153
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 02:28:51 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3I9SmEQ027869
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 04:28:49 -0500 (CDT)
From: Jason Jin <Jason.jin@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] MSI driver for Freescale 83xx/85xx/86xx cpu
Date: Sat, 19 Apr 2008 17:27:45 +0800
Message-Id: <1208597267-30960-1-git-send-email-Jason.jin@freescale.com>
Cc: kumar.gala@freescale.com, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This MSI driver can be used on 83xx/85xx/86xx board.
In this driver, virtual interrupt host and chip were
setup. There are 256 MSI interrupts in this host, Every 32
MSI interrupts cascaded to one IPIC/MPIC interrupt.
The chip was treated as edge sensitive and some necessary
functions were setup for this chip.

Before using the MSI interrupt, PCI/PCIE device need to
ask for a MSI interrupt in the 256 MSI interrupts. A 256bit
bitmap show which MSI interrupt was used, reserve bit in
the bitmap can be used to force the device use some designate
MSI interrupt in the 256 MSI interrupts. Sometimes this is useful
for testing the all the MSI interrupts. The msi-available-ranges
property in the dts file was used for this purpose.

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
---
 arch/powerpc/sysdev/Makefile  |    1 +
 arch/powerpc/sysdev/fsl_msi.c |  457 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_msi.h |   40 ++++
 arch/powerpc/sysdev/fsl_pci.c |   14 ++
 4 files changed, 512 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_msi.c
 create mode 100644 arch/powerpc/sysdev/fsl_msi.h

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 6d386d0..bfd3fe4 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -4,6 +4,7 @@ endif
 
 mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o mpic_pasemi_msi.o
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
+obj-$(CONFIG_PCI_MSI)		+= fsl_msi.o
 
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
 obj-$(CONFIG_PPC_DCR_NATIVE)	+= dcr-low.o
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
new file mode 100644
index 0000000..e8132cf
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -0,0 +1,457 @@
+/*
+ * Copyright (C) 2007-2008 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: Tony Li <tony.li@freescale.com>
+ *	   Jason Jin <Jason.jin@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#include <linux/irq.h>
+#include <linux/bootmem.h>
+#include <linux/bitmap.h>
+#include <linux/msi.h>
+#include <asm/prom.h>
+#include <asm/hw_irq.h>
+#include <linux/pci.h>
+#include <asm/ppc-pci.h>
+#include <linux/of_platform.h>
+
+#include <sysdev/fsl_soc.h>
+#include "fsl_msi.h"
+
+#ifdef DEBUG
+#define pr_debug(fmt...) printk(fmt)
+#else
+#define pr_debug(fmt...)
+#endif
+
+/* A bit ugly, can we get this from the pci_dev somehow? */
+static struct fsl_msi *fsl_msi;
+
+static inline u32 fsl_msi_read(u32 __iomem *base,
+				unsigned int reg)
+{
+	return in_be32(base + (reg >> 2));
+}
+
+static inline void fsl_msi_write(u32 __iomem *base,
+				unsigned int reg, u32 value)
+{
+	out_be32(base + (reg >> 2), value);
+}
+
+#define	fsl_msi_irq_to_hw(virq)	 ((unsigned int)irq_map[virq].hwirq)
+
+/*
+ * We do not need this actually. The MSIR register has been read once
+ * in the cascade interrupt. So, this MSI interrupt has been acked
+*/
+static void fsl_msi_end_irq(unsigned int virq)
+{
+}
+
+static struct irq_chip fsl_msi_chip = {
+	.mask		= mask_msi_irq,
+	.unmask		= unmask_msi_irq,
+	.ack		= fsl_msi_end_irq,
+	.typename	= " FSL-MSI  ",
+};
+
+static int fsl_msi_host_match(struct irq_host *h, struct device_node *node)
+{
+	struct fsl_msi *msi = h->host_data;
+
+	/* Exact match, unless node is NULL */
+	return msi->of_node == NULL || msi->of_node == node;
+}
+
+
+static int fsl_msi_host_map(struct irq_host *h, unsigned int virq,
+				irq_hw_number_t hw)
+{
+	struct fsl_msi *msi = h->host_data;
+	struct irq_chip *chip = msi->hc_irq;
+
+	set_irq_chip_data(virq, msi);
+	get_irq_desc(virq)->status |= IRQ_TYPE_EDGE_FALLING;
+
+	set_irq_chip_and_handler(virq, chip,  handle_edge_irq);
+
+	return 0;
+}
+
+static struct irq_host_ops fsl_msi_host_ops = {
+	.match = fsl_msi_host_match,
+	.map = fsl_msi_host_map,
+};
+
+irq_hw_number_t fsl_msi_alloc_hwirqs(struct fsl_msi *msi, int num)
+{
+	unsigned long flags;
+	int offset, order = get_count_order(num);
+
+	spin_lock_irqsave(&msi->bitmap_lock, flags);
+
+	offset = bitmap_find_free_region(msi->fsl_msi_bitmap,
+					NR_MSI_IRQS, order);
+
+	spin_unlock_irqrestore(&msi->bitmap_lock, flags);
+
+	pr_debug("%s: allocated 0x%x (2^%d) at offset 0x%x\n",
+		__func__, num, order, offset);
+
+	return offset;
+}
+
+void fsl_msi_free_hwirqs(struct fsl_msi *msi, int offset, int num)
+{
+	unsigned long flags;
+	int order = get_count_order(num);
+
+	pr_debug("%s: freeing 0x%x (2^%d) at offset 0x%x\n",
+		__func__, num, order, offset);
+
+	spin_lock_irqsave(&msi->bitmap_lock, flags);
+	bitmap_release_region(msi->fsl_msi_bitmap, offset, order);
+	spin_unlock_irqrestore(&msi->bitmap_lock, flags);
+}
+
+static int fsl_msi_reserve_dt_hwirqs(struct fsl_msi *msi)
+{
+	int i, len;
+	const u32 *p;
+
+	p = of_get_property(msi->of_node, "msi-available-ranges", &len);
+	if (!p) {
+		pr_debug("fsl_msi: no msi-available-ranges property found \
+				on %s\n", msi->of_node->full_name);
+		return -ENODEV;
+	}
+
+	if (len & 0x8 != 0) {
+		printk(KERN_WARNING "fsl_msi: Malformed msi-available-ranges "
+		       "property on %s\n", msi->of_node->full_name);
+		return -EINVAL;
+	}
+
+	bitmap_allocate_region(msi->fsl_msi_bitmap, 0,
+			       get_count_order(msi->irq_count));
+
+	/* Format is: (<u32 start> <u32 count>)+ */
+	len /= sizeof(u32);
+	len /= 2;
+	for (i = 0; i < len; i++, p += 2)
+		fsl_msi_free_hwirqs(msi, *p, *(p + 1));
+
+	return 0;
+}
+
+static int fsl_msi_init_allocator(struct fsl_msi *msi)
+{
+	int rc, size;
+
+	size = BITS_TO_LONGS(NR_MSI_IRQS) * sizeof(long);
+
+	msi->fsl_msi_bitmap = kmalloc(size, GFP_KERNEL);
+
+	if (msi->fsl_msi_bitmap == NULL) {
+		pr_debug("%s: ENOMEM allocating allocator bitmap!\n",
+				__func__);
+		return -ENOMEM;
+	}
+	memset(msi->fsl_msi_bitmap, 0, size);
+
+	rc = fsl_msi_reserve_dt_hwirqs(msi);
+	if (rc)
+		goto out_free;
+
+	return 0;
+out_free:
+	if (mem_init_done)
+		kfree(msi->fsl_msi_bitmap);
+
+	msi->fsl_msi_bitmap = NULL;
+	return rc;
+
+}
+
+static int fsl_msi_check_device(struct pci_dev *pdev, int nvec, int type)
+{
+	if (type == PCI_CAP_ID_MSIX)
+		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");
+
+	return 0;
+}
+
+static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
+{
+	struct msi_desc *entry;
+	struct fsl_msi *msi = fsl_msi;
+
+	list_for_each_entry(entry, &pdev->msi_list, list) {
+		if (entry->irq == NO_IRQ)
+			continue;
+		set_irq_msi(entry->irq, NULL);
+		fsl_msi_free_hwirqs(msi, virq_to_hw(entry->irq), 1);
+		irq_dispose_mapping(entry->irq);
+	}
+
+	return;
+}
+
+static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
+				  struct msi_msg *msg)
+{
+	unsigned int srs;
+	unsigned int ibs;
+	struct fsl_msi *msi = fsl_msi;
+
+	srs = hwirq / INT_PER_MSIR;
+	ibs = hwirq % INT_PER_MSIR;
+
+	msg->address_lo = msi->msi_addr_lo;
+	msg->address_hi = msi->msi_addr_hi;
+	msg->data = (srs << 5) | (ibs & 0x1F);
+
+	pr_debug("%s: allocated srs: %d, ibs: %d\n",
+		__func__, srs, ibs);
+}
+
+static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+{
+	irq_hw_number_t hwirq;
+	int rc;
+	unsigned int virq;
+	struct msi_desc *entry;
+	struct msi_msg msg;
+	struct fsl_msi *msi = fsl_msi;
+
+	list_for_each_entry(entry, &pdev->msi_list, list) {
+		hwirq = fsl_msi_alloc_hwirqs(msi, 1);
+		if (hwirq < 0) {
+			rc = hwirq;
+			pr_debug("%s: fail allocating msi interrupt\n",
+					__func__);
+			goto out_free;
+		}
+
+		virq = irq_create_mapping(msi->irqhost, hwirq);
+
+		if (virq == NO_IRQ) {
+			pr_debug("%s: fail mapping hwirq 0x%lx\n",
+					__func__, hwirq);
+			fsl_msi_free_hwirqs(msi, hwirq, 1);
+			rc = -ENOSPC;
+			goto out_free;
+		}
+		set_irq_msi(virq, entry);
+
+		fsl_compose_msi_msg(pdev, hwirq, &msg);
+		write_msi_msg(virq, &msg);
+	}
+	return 0;
+
+out_free:
+	fsl_teardown_msi_irqs(pdev);
+	return rc;
+}
+
+void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int cascade_irq;
+	struct fsl_msi *msi = fsl_msi;
+	int msir_index = -1;
+	int i;
+	u32 msir_value = 0;
+	u32 intr_index;
+	u32 have_shift = 0;
+
+	spin_lock(&desc->lock);
+	if ((msi->feature &  FSL_PIC_IP_MASK) == FSL_PIC_IP_IPIC) {
+		if (desc->chip->mask_ack)
+			desc->chip->mask_ack(irq);
+		else {
+			desc->chip->mask(irq);
+			desc->chip->ack(irq);
+		}
+	}
+
+	if (unlikely(desc->status & IRQ_INPROGRESS))
+		goto unlock;
+
+	for (i = 0; i < NR_MSIR; i++)
+		if (irq == msi->msir[i]) {
+			msir_index = i;
+			break;
+		}
+
+	if (i >= NR_MSIR)
+		cascade_irq = NO_IRQ;
+
+	desc->status |= IRQ_INPROGRESS;
+	switch (fsl_msi->feature & FSL_PIC_IP_MASK) {
+	case FSL_PIC_IP_MPIC:
+		msir_value = fsl_msi_read(msi->msi_regs, msir_index * 0x10);
+		break;
+	case FSL_PIC_IP_IPIC:
+		msir_value = fsl_msi_read(msi->msi_regs, msir_index * 0x4);
+		break;
+	}
+
+	while (msir_value) {
+		intr_index = ffs(msir_value) - 1;
+
+		cascade_irq = irq_linear_revmap(msi->irqhost,
+			(msir_index * INT_PER_MSIR + intr_index + have_shift));
+
+		if (cascade_irq != NO_IRQ)
+			generic_handle_irq(cascade_irq);
+		have_shift += (intr_index + 1);
+		msir_value = (msir_value >> (intr_index + 1));
+	}
+	desc->status &= ~IRQ_INPROGRESS;
+
+	switch (fsl_msi->feature & FSL_PIC_IP_MASK) {
+	case FSL_PIC_IP_MPIC:
+		desc->chip->eoi(irq);
+		break;
+	case FSL_PIC_IP_IPIC:
+		if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
+		desc->chip->unmask(irq);
+		break;
+	}
+unlock:
+	spin_unlock(&desc->lock);
+}
+
+static int __devinit fsl_of_msi_probe(struct of_device *dev,
+				const struct of_device_id *match)
+{
+	struct fsl_msi *msi;
+	struct resource res;
+	int err, i, count;
+	int rc;
+	int virt_msir;
+	const u32 *p;
+	struct fsl_msi_data *tmp_data;
+
+	printk(KERN_INFO "Setting up fsl msi support\n");
+
+	msi = kzalloc(sizeof(struct fsl_msi), GFP_KERNEL);
+	if (!msi) {
+		dev_err(&dev->dev, "No memory for MSI structure\n");
+		err = -ENOMEM;
+		goto error_out;
+	}
+
+	msi->of_node = dev->node;
+
+	msi->irqhost = irq_alloc_host(of_node_get(dev->node),
+				IRQ_HOST_MAP_LINEAR,
+				NR_MSI_IRQS, &fsl_msi_host_ops, 0);
+	if (msi->irqhost == NULL) {
+		dev_err(&dev->dev, "No memory for MSI irqhost\n");
+		err = -ENOMEM;
+		goto error_out;
+	}
+
+	/*Get the MSI reg base */
+	err = of_address_to_resource(dev->node, 0, &res);
+	if (err) {
+		dev_err(&dev->dev, "Can't get %s property 'reg'\n",
+				dev->node->full_name);
+		goto error_out;
+	}
+
+	msi->msi_regs = ioremap(res.start, res.end - res.start + 1);
+
+	tmp_data = (struct fsl_msi_data *)match->data;
+
+	msi->feature = tmp_data->fsl_pic_ip;
+
+	msi->irqhost->host_data = msi;
+	msi->hc_irq = &fsl_msi_chip;
+
+	msi->msi_addr_hi = 0x0;
+	msi->msi_addr_lo = res.start + tmp_data->msiir_offset;
+
+	msi->irq_count = NR_MSI_IRQS;
+
+	p = of_get_property(dev->node, "interrupts", &count);
+	if (!p) {
+		dev_err(&dev->dev, "no msi-interrupts property found on %s\n",
+				dev->node->full_name);
+		err = -ENODEV;
+		goto error_out;
+	}
+	if (count % 8 != 0) {
+		dev_err(&dev->dev, "Malformed msi-interrupts property on %s\n",
+				dev->node->full_name);
+		err = -EINVAL;
+		goto error_out;
+	}
+
+	count /= sizeof(u32);
+	for (i = 0; i < count / 2; i++) {
+		if (i > NR_MSIR)
+			break;
+		virt_msir = irq_of_parse_and_map(dev->node, i);
+		if (virt_msir != NO_IRQ) {
+			set_irq_data(virt_msir, msi);
+			set_irq_chained_handler(virt_msir, fsl_msi_cascade);
+			msi->msir[i] = virt_msir;
+		} else
+			msi->msir[i] = NO_IRQ;
+	}
+
+	rc = fsl_msi_init_allocator(msi);
+	if (rc) {
+		dev_err(&dev->dev, "Error allocating MSI bitmap\n");
+		goto error_out;
+	}
+
+	fsl_msi = msi;
+
+	WARN_ON(ppc_md.setup_msi_irqs);
+	ppc_md.setup_msi_irqs = fsl_setup_msi_irqs;
+	ppc_md.teardown_msi_irqs = fsl_teardown_msi_irqs;
+	ppc_md.msi_check_device = fsl_msi_check_device;
+	return 0;
+error_out:
+	if (msi)
+		kfree(msi);
+	return err;
+}
+
+static const struct fsl_msi_data mpic_msi_feature = {FSL_PIC_IP_MPIC, 0x140};
+static const struct fsl_msi_data ipic_msi_feature = {FSL_PIC_IP_IPIC, 0x38};
+
+static const struct of_device_id fsl_of_msi_ids[] = {
+	{
+		.compatible = "fsl,MPIC-MSI",
+		.data = (void *)&mpic_msi_feature,
+	},
+	{
+		.compatible = "fsl,IPIC-MSI",
+		.data = (void *)&ipic_msi_feature,
+	},
+	{}
+};
+
+static struct of_platform_driver fsl_of_msi_driver = {
+	.name = "fsl-of-msi",
+	.match_table = fsl_of_msi_ids,
+	.probe = fsl_of_msi_probe,
+};
+
+static __init int fsl_of_msi_init(void)
+{
+	return of_register_platform_driver(&fsl_of_msi_driver);
+}
+
+subsys_initcall(fsl_of_msi_init);
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
new file mode 100644
index 0000000..7eef9ec
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -0,0 +1,40 @@
+#ifndef _ASM_POWERPC_MSI_H
+#define _ASM_POWERPC_MSI_H
+
+#define NR_MSIR	8
+#define INT_PER_MSIR	32
+#define NR_MSI_IRQS	(NR_MSIR * INT_PER_MSIR)
+
+#define FSL_PIC_IP_MASK	0x0000000F
+#define FSL_PIC_IP_MPIC	0x00000001
+#define FSL_PIC_IP_IPIC	0x00000002
+
+struct fsl_msi {
+	/* Device node of the MSI interrupt*/
+	struct device_node *of_node;
+
+	struct irq_host *irqhost;
+	struct irq_chip *hc_irq;
+
+	unsigned long cascade_irq;
+	unsigned int msir[NR_MSIR];
+
+	u32 msi_addr_lo;
+	u32 msi_addr_hi;
+	void __iomem *msi_regs;
+	u32 irq_count;
+	u32 feature;
+
+	spinlock_t fsl_msi_lock;
+	unsigned long *fsl_msi_bitmap;
+	spinlock_t bitmap_lock;
+	const char *name;
+};
+
+struct fsl_msi_data {
+	u32 fsl_pic_ip;
+	u32 msiir_offset;
+};
+
+#endif /* _ASM_POWERPC_MSI_H */
+
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index bf13c21..fede767 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -106,6 +106,16 @@ void __init setup_pci_cmd(struct pci_controller *hose)
 	}
 }
 
+#ifdef CONFIG_PCI_MSI
+void __init setup_pci_pcsrbar(struct pci_controller *hose)
+{
+	phys_addr_t immr_base;
+
+	immr_base = get_immrbase();
+	early_write_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, immr_base);
+}
+#endif
+
 static int fsl_pcie_bus_fixup;
 
 static void __init quirk_fsl_pcie_header(struct pci_dev *dev)
@@ -211,6 +221,10 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	/* Setup PEX window registers */
 	setup_pci_atmu(hose, &rsrc);
 
+	/*Setup PEXCSRBAR */
+#ifdef CONFIG_PCI_MSI
+	setup_pci_pcsrbar(hose);
+#endif
 	return 0;
 }
 
-- 
1.5.4
