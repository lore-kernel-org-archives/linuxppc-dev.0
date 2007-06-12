Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f6b7628924d804d7f0ffcf0fcf3bc9f4670e09ef.1181640735.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/1] Add support for MSI on Axon-based Cell systems
Date: Tue, 12 Jun 2007 19:33:43 +1000 (EST)
Cc: Milton Miller <miltonm@bga.com>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for the setup and decoding of MSIs
on Axon-based Cell systems.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

Updated to address everyone's comments I think.

 arch/powerpc/platforms/cell/Makefile   |    2 +
 arch/powerpc/platforms/cell/axon_msi.c |  491 ++++++++++++++++++++++++++++++++
 2 files changed, 493 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
index 869af89..6615d40 100644
--- a/arch/powerpc/platforms/cell/Makefile
+++ b/arch/powerpc/platforms/cell/Makefile
@@ -23,3 +23,5 @@ obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
 					   $(spu-priv1-y) \
 					   $(spu-manage-y) \
 					   spufs/
+
+obj-$(CONFIG_PCI_MSI)			+= axon_msi.o
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
new file mode 100644
index 0000000..63a32b4
--- /dev/null
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -0,0 +1,491 @@
+/*
+ * Copyright 2007, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/msi.h>
+#include <linux/reboot.h>
+
+#include <asm/dcr.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+
+
+/*
+ * MSIC registers, specified as offsets from dcr_base
+ */
+#define MSIC_CTRL_REG	0x0
+
+/* Base Address registers specify FIFO location in BE memory */
+#define MSIC_BASE_ADDR_HI_REG	0x3
+#define MSIC_BASE_ADDR_LO_REG	0x4
+
+/* Hold the read/write offsets into the FIFO */
+#define MSIC_READ_OFFSET_REG	0x5
+#define MSIC_WRITE_OFFSET_REG	0x6
+
+
+/* Flags */
+#define MSIC_ENABLE		0x0001
+#define MSIC_FIFO_FULL_ENABLE	0x0002
+#define MSIC_IRQ_ENABLE		0x0008
+#define MSIC_FULL_STOP_ENABLE	0x0010
+
+/* Size configuration constants */
+#define MSIC_SIZE_MASK		0x0180
+#define MSIC_SIZE_SHIFT		(7)
+#define	MSIC_SIZE_32K		0x0
+#define	MSIC_SIZE_64K		0x1
+#define	MSIC_SIZE_128K		0x2
+#define	MSIC_SIZE_256K		0x3
+
+#define MSIC_FIFO_ENTRY_SIZE	0x10
+
+/* The size we're actually using */
+#define MSIC_FIFO_SIZE		MSIC_SIZE_32K
+
+/* Different representations of the fifo size */
+#define MSIC_FIFO_SHIFT		(MSIC_FIFO_SIZE + 15)
+#define MSIC_FIFO_BYTES		(1 << MSIC_FIFO_SHIFT)
+#define MSIC_FIFO_ORDER		max(MSIC_FIFO_SHIFT - PAGE_SHIFT, 0)
+
+/* FIFO locations should always be 16-byte aligned */
+#define MSIC_FIFO_MASK		((MSIC_FIFO_BYTES - 1) & ~0xFu)
+
+
+struct axon_msic {
+	struct device_node *dn;
+	struct irq_host *irq_host;
+	__le32 *fifo;
+	dcr_host_t dcr_host;
+	struct list_head list;
+	u32 read_offset;
+	u32 dcr_base;
+#ifdef DEBUG
+	u32 __iomem *trigger;
+#endif
+};
+
+void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic);
+
+static LIST_HEAD(axon_msic_list);
+
+static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
+{
+	dcr_write(msic->dcr_host, msic->dcr_base + dcr_n, val);
+}
+
+static u32 msic_dcr_read(struct axon_msic *msic, unsigned int dcr_n)
+{
+	return dcr_read(msic->dcr_host, msic->dcr_base + dcr_n);
+}
+
+static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	struct axon_msic *msic = get_irq_data(irq);
+	u32 write_offset, msi;
+	int idx;
+
+	write_offset = msic_dcr_read(msic, MSIC_WRITE_OFFSET_REG);
+	pr_debug("axon_msi: original write_offset 0x%x\n", write_offset);
+
+	/* write_offset doesn't wrap properly, so we have to mask it */
+	write_offset &= MSIC_FIFO_MASK;
+
+	while (msic->read_offset != write_offset) {
+		idx  = msic->read_offset / sizeof(__le32);
+		msi  = le32_to_cpu(msic->fifo[idx]);
+		msi &= 0xFFFF;
+
+		pr_debug("axon_msi: woff %x roff %x msi %x\n",
+			  write_offset, msic->read_offset, msi);
+
+		msic->read_offset += MSIC_FIFO_ENTRY_SIZE;
+		msic->read_offset &= MSIC_FIFO_MASK;
+
+		if (msi < NR_IRQS && irq_map[msi].host == msic->irq_host)
+			generic_handle_irq(msi);
+		else
+			pr_debug("axon_msi: invalid irq 0x%x!\n", msi);
+	}
+
+	msic_dcr_write(msic, MSIC_READ_OFFSET_REG, msic->read_offset);
+
+	desc->chip->eoi(irq);
+}
+
+static struct axon_msic *find_msi_translator(struct pci_dev *dev)
+{
+	struct irq_host *irq_host;
+	struct device_node *dn, *tmp;
+	const phandle *ph;
+	struct axon_msic *msic = NULL;
+
+	dn = pci_device_to_OF_node(dev);
+	if (!dn) {
+		dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
+		return NULL;
+	}
+
+	for (; dn; tmp = of_get_parent(dn), of_node_put(dn), dn = tmp) {
+		ph = of_get_property(dn, "msi-translator", NULL);
+		if (ph)
+			break;
+	}
+
+	if (!ph) {
+		dev_dbg(&dev->dev,
+			"axon_msi: no msi-translator property found\n");
+		goto out_error;
+	}
+
+	tmp = dn;
+	dn = of_find_node_by_phandle(*ph);
+	if (!dn) {
+		dev_dbg(&dev->dev,
+			"axon_msi: msi-translator doesn't point to a node\n");
+		goto out_error;
+	}
+
+	irq_host = irq_find_host(dn);
+	if (!irq_host) {
+		dev_dbg(&dev->dev, "axon_msi: no irq_host found for node %s\n",
+			dn->full_name);
+		goto out_error;
+	}
+
+	msic = irq_host->host_data;
+
+out_error:
+	of_node_put(dn);
+	of_node_put(tmp);
+
+	return msic;
+}
+
+static int axon_msi_check_device(struct pci_dev *dev, int nvec, int type)
+{
+	if (!find_msi_translator(dev))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
+{
+	struct device_node *dn, *tmp;
+	struct msi_desc *entry;
+	int len;
+	const u32 *prop;
+
+	dn = pci_device_to_OF_node(dev);
+	if (!dn) {
+		dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
+		return -ENODEV;
+	}
+
+	entry = list_first_entry(&dev->msi_list, struct msi_desc, list);
+
+	for (; dn; tmp = of_get_parent(dn), of_node_put(dn), dn = tmp) {
+		if (entry->msi_attrib.is_64) {
+			prop = of_get_property(dn, "msi-address-64", &len);
+			if (prop)
+				break;
+		}
+
+		prop = of_get_property(dn, "msi-address-32", &len);
+		if (prop)
+			break;
+	}
+
+	if (!prop) {
+		dev_dbg(&dev->dev,
+			"axon_msi: no msi-address-(32|64) properties found\n");
+		return -ENOENT;
+	}
+
+	switch (len) {
+	case 8:
+		msg->address_hi = prop[0];
+		msg->address_lo = prop[1];
+		break;
+	case 4:
+		msg->address_hi = 0;
+		msg->address_lo = prop[0];
+		break;
+	default:
+		dev_dbg(&dev->dev,
+			"axon_msi: malformed msi-address-(32|64) property\n");
+		of_node_put(dn);
+		return -EINVAL;
+	}
+
+	of_node_put(dn);
+
+	return 0;
+}
+
+static int axon_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	unsigned int virq, rc;
+	struct msi_desc *entry;
+	struct msi_msg msg;
+	struct axon_msic *msic;
+
+	msic = find_msi_translator(dev);
+	if (!msic)
+		return -ENODEV;
+
+	rc = setup_msi_msg_address(dev, &msg);
+	if (rc)
+		return rc;
+
+	/* We rely on being able to stash a virq in a u16 */
+	BUILD_BUG_ON(NR_IRQS > 65536);
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		virq = irq_create_direct_mapping(msic->irq_host);
+		if (virq == NO_IRQ) {
+			dev_warn(&dev->dev,
+				 "axon_msi: virq allocation failed!\n");
+			return -1;
+		}
+		dev_dbg(&dev->dev, "axon_msi: allocated virq 0x%x\n", virq);
+
+		set_irq_msi(virq, entry);
+		msg.data = virq;
+		write_msi_msg(virq, &msg);
+	}
+
+	return 0;
+}
+
+static void axon_msi_teardown_msi_irqs(struct pci_dev *dev)
+{
+	struct msi_desc *entry;
+
+	dev_dbg(&dev->dev, "axon_msi: tearing down msi irqs");
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		if (entry->irq == NO_IRQ)
+			continue;
+
+		set_irq_msi(entry->irq, NULL);
+		irq_dispose_mapping(entry->irq);
+	}
+}
+
+static struct irq_chip msic_irq_chip = {
+	.mask		= mask_msi_irq,
+	.unmask		= unmask_msi_irq,
+	.shutdown	= unmask_msi_irq,
+	.typename	= "AXON-MSI",
+};
+
+static int msic_host_map(struct irq_host *h, unsigned int virq,
+			 irq_hw_number_t hw)
+{
+	set_irq_chip_and_handler(virq, &msic_irq_chip, handle_simple_irq);
+
+	return 0;
+}
+
+static int msic_host_match(struct irq_host *host, struct device_node *dn)
+{
+	struct axon_msic *msic = host->host_data;
+
+	return msic->dn == dn;
+}
+
+static struct irq_host_ops msic_host_ops = {
+	.match	= msic_host_match,
+	.map	= msic_host_map,
+};
+
+static int axon_msi_notify_reboot(struct notifier_block *nb,
+				  unsigned long code, void *data)
+{
+	struct axon_msic *msic;
+	u32 tmp;
+
+	list_for_each_entry(msic, &axon_msic_list, list) {
+		tmp  = msic_dcr_read(msic, MSIC_CTRL_REG);
+		tmp &= ~MSIC_ENABLE;
+		pr_debug("axon_msi: disabling %s\n", msic->dn->full_name);
+		msic_dcr_write(msic, MSIC_CTRL_REG, tmp);
+	}
+
+	return 0;
+}
+
+static struct notifier_block axon_msi_reboot_notifier = {
+	.notifier_call = axon_msi_notify_reboot
+};
+
+static int axon_msi_setup_one(struct device_node *dn)
+{
+	struct page *page;
+	struct axon_msic *msic;
+	unsigned int virq;
+	int dcr_len;
+
+	pr_debug("axon_msi: setting up dn %s\n", dn->full_name);
+
+	msic = kzalloc(sizeof(struct axon_msic), GFP_KERNEL);
+	if (!msic) {
+		printk(KERN_ERR "axon_msi: couldn't allocate msic for %s\n",
+		       dn->full_name);
+		goto out;
+	}
+
+	msic->dcr_base = dcr_resource_start(dn, 0);
+	dcr_len = dcr_resource_len(dn, 0);
+
+	if (msic->dcr_base == 0 || dcr_len == 0) {
+		printk(KERN_ERR
+		       "axon_msi: couldn't parse dcr properties on %s\n",
+			dn->full_name);
+		goto out;
+	}
+
+	msic->dcr_host = dcr_map(dn, msic->dcr_base, dcr_len);
+	if (!DCR_MAP_OK(msic->dcr_host)) {
+		printk(KERN_ERR "axon_msi: dcr_map failed for %s\n",
+		       dn->full_name);
+		goto out_free_msic;
+	}
+
+	page = alloc_pages_node(of_node_to_nid(dn),
+				GFP_KERNEL, MSIC_FIFO_ORDER);
+	if (!page) {
+		printk(KERN_ERR "axon_msi: couldn't allocate fifo for %s\n",
+		       dn->full_name);
+		goto out_free_msic;
+	}
+
+	msic->fifo = page_address(page);
+
+	msic->irq_host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, NR_IRQS,
+					&msic_host_ops, 0);
+	if (!msic->irq_host) {
+		printk(KERN_ERR "axon_msi: couldn't allocate irq_host for %s\n",
+		       dn->full_name);
+		goto out_free_fifo;
+	}
+
+	msic->irq_host->host_data = msic;
+
+	virq = irq_of_parse_and_map(dn, 0);
+	if (virq == NO_IRQ) {
+		printk(KERN_ERR "axon_msi: irq parse and map failed for %s\n",
+		       dn->full_name);
+		goto out_free_host;
+	}
+
+	msic->dn = of_node_get(dn);
+
+	set_irq_data(virq, msic);
+	set_irq_chained_handler(virq, axon_msi_cascade);
+	pr_debug("axon_msi: irq 0x%x setup for axon_msi\n", virq);
+
+	/* Enable the MSIC hardware */
+	msic_dcr_write(msic, MSIC_BASE_ADDR_HI_REG, (u64)msic->fifo >> 32);
+	msic_dcr_write(msic, MSIC_BASE_ADDR_LO_REG,
+				  (u64)msic->fifo & 0xFFFFFFFF);
+	msic_dcr_write(msic, MSIC_CTRL_REG, MSIC_IRQ_ENABLE | MSIC_ENABLE |
+				  (MSIC_FIFO_SIZE << MSIC_SIZE_SHIFT));
+#ifdef DEBUG
+	axon_msi_debug_setup(dn, msic);
+#endif
+	list_add(&msic->list, &axon_msic_list);
+
+	printk(KERN_DEBUG "axon_msi: setup MSIC on %s\n", dn->full_name);
+
+	return 0;
+
+out_free_host:
+	kfree(msic->irq_host);
+out_free_fifo:
+	__free_pages(virt_to_page(msic->fifo), MSIC_FIFO_ORDER);
+out_free_msic:
+	kfree(msic);
+out:
+
+	return -1;
+}
+
+static int axon_msi_init(void)
+{
+	struct device_node *dn;
+	int found = 0;
+
+	pr_debug("axon_msi: initialising ...\n");
+
+	for_each_compatible_node(dn, NULL, "ibm,axon-msic") {
+		if (axon_msi_setup_one(dn) == 0)
+			found++;
+	}
+
+	if (found) {
+		ppc_md.setup_msi_irqs = axon_msi_setup_msi_irqs;
+		ppc_md.teardown_msi_irqs = axon_msi_teardown_msi_irqs;
+		ppc_md.msi_check_device = axon_msi_check_device;
+
+		register_reboot_notifier(&axon_msi_reboot_notifier);
+
+		pr_debug("axon_msi: registered callbacks!\n");
+	}
+
+	return 0;
+}
+arch_initcall(axon_msi_init);
+
+#ifdef DEBUG
+static void msic_set(void *data, u64 val)
+{
+	struct axon_msic *msic = data;
+
+	out_le32(msic->trigger, val);
+}
+
+static u64 msic_get(void *data)
+{
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_msic, msic_get, msic_set, "%llu\n");
+
+void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic)
+{
+	char name[8];
+	u64 addr;
+
+	addr = of_translate_address(dn, of_get_property(dn, "reg", NULL));
+	if (addr == OF_BAD_ADDR) {
+		pr_debug("axon_msi: couldn't translate reg property\n");
+		return;
+	}
+
+	msic->trigger = ioremap(addr, 0x4);
+	if (!msic->trigger) {
+		pr_debug("axon_msi: ioremap failed\n");
+		return;
+	}
+
+	snprintf(name, sizeof(name), "msic_%d", of_node_to_nid(dn));
+
+	if (!debugfs_create_file(name, 0600, NULL, msic, &fops_msic)) {
+		pr_debug("axon_msi: debugfs_create_file failed!\n");
+		return;
+	}
+}
+#endif
-- 
1.5.1.3.g7a33b
