Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 248ADB722A
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2011 00:21:03 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 20/21] powerpc/powernv: Implement MSI support for p5ioc2 PCIe
Date: Sat, 10 Sep 2011 11:20:07 -0300
Message-Id: <1315664408-16797-20-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
References: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This implements support for MSIs on p5ioc2 PHBs. We only support
MSIs on the PCIe PHBs, not the PCI-X ones as the later hasn't been
properly verified in HW.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |   49 ++++++++++++
 arch/powerpc/platforms/powernv/pci.c        |  108 +++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h        |   10 +++
 3 files changed, 167 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index afabc2b..fd1509a 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -19,6 +19,7 @@
 #include <linux/bootmem.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/msi.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -39,6 +40,51 @@
  */
 #define P5IOC2_TCE_MEMORY	0x01000000
 
+#ifdef CONFIG_PCI_MSI
+static int pnv_pci_p5ioc2_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
+				    unsigned int hwirq, unsigned int is_64,
+				    struct msi_msg *msg)
+{
+	if (WARN_ON(!is_64))
+		return -ENXIO;
+	msg->data = hwirq - phb->msi_base;
+	msg->address_hi = 0x10000000;
+	msg->address_lo = 0;
+
+	return 0;
+}
+
+static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb)
+{
+	unsigned int bmap_size;
+	const __be32 *prop = of_get_property(phb->hose->dn,
+					     "ibm,opal-msi-ranges", NULL);
+	if (!prop)
+		return;
+
+	/* Don't do MSI's on p5ioc2 PCI-X are they are not properly
+	 * verified in HW
+	 */
+	if (of_device_is_compatible(phb->hose->dn, "ibm,p5ioc2-pcix"))
+		return;
+	phb->msi_base = be32_to_cpup(prop);
+	phb->msi_count = be32_to_cpup(prop + 1);
+	bmap_size = BITS_TO_LONGS(phb->msi_count) * sizeof(unsigned long);
+	phb->msi_map = zalloc_maybe_bootmem(bmap_size, GFP_KERNEL);
+	if (!phb->msi_map) {
+		pr_err("PCI %d: Failed to allocate MSI bitmap !\n",
+		       phb->hose->global_number);
+		return;
+	}
+	phb->msi_setup = pnv_pci_p5ioc2_msi_setup;
+	phb->msi32_support = 0;
+	pr_info("  Allocated bitmap for %d MSIs (base IRQ 0x%x)\n",
+		phb->msi_count, phb->msi_base);
+}
+#else
+static void pnv_pci_setup_p5ioc2_msis(struct pnv_phb *phb) { }
+#endif /* CONFIG_PCI_MSI */
+
 static void __devinit pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 						   struct pci_dev *pdev)
 {
@@ -117,6 +163,9 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np,
 
 	phb->hose->ops = &pnv_pci_ops;
 
+	/* Setup MSI support */
+	pnv_pci_init_p5ioc2_msis(phb);
+
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_p5ioc2_dma_dev_setup;
 	pnv_pci_setup_iommu_table(&phb->p5ioc2.iommu_table,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b512489..f85fb13 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -19,6 +19,7 @@
 #include <linux/bootmem.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/msi.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -38,7 +39,108 @@
 #define cfg_dbg(fmt...)	do { } while(0)
 //#define cfg_dbg(fmt...)	printk(fmt)
 
+#ifdef CONFIG_PCI_MSI
+static int pnv_msi_check_device(struct pci_dev* pdev, int nvec, int type)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+
+	return (phb && phb->msi_map) ? 0 : -ENODEV;
+}
+
+static unsigned int pnv_get_one_msi(struct pnv_phb *phb)
+{
+	unsigned int id;
+
+	spin_lock(&phb->lock);
+	id = find_next_zero_bit(phb->msi_map, phb->msi_count, phb->msi_next);
+	if (id >= phb->msi_count && phb->msi_next)
+		id = find_next_zero_bit(phb->msi_map, phb->msi_count, 0);
+	if (id >= phb->msi_count) {
+		spin_unlock(&phb->lock);
+		return 0;
+	}
+	__set_bit(id, phb->msi_map);
+	spin_unlock(&phb->lock);
+	return id + phb->msi_base;
+}
+
+static void pnv_put_msi(struct pnv_phb *phb, unsigned int hwirq)
+{
+	unsigned int id;
+
+	if (WARN_ON(hwirq < phb->msi_base ||
+		    hwirq >= (phb->msi_base + phb->msi_count)))
+		return;
+	id = hwirq - phb->msi_base;
+	spin_lock(&phb->lock);
+	__clear_bit(id, phb->msi_map);
+	spin_unlock(&phb->lock);
+}
+
+static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct msi_desc *entry;
+	struct msi_msg msg;
+	unsigned int hwirq, virq;
+	int rc;
+
+	if (WARN_ON(!phb))
+		return -ENODEV;
+
+	list_for_each_entry(entry, &pdev->msi_list, list) {
+		if (!entry->msi_attrib.is_64 && !phb->msi32_support) {
+			pr_warn("%s: Supports only 64-bit MSIs\n",
+				pci_name(pdev));
+			return -ENXIO;
+		}
+		hwirq = pnv_get_one_msi(phb);
+		if (!hwirq) {
+			pr_warn("%s: Failed to find a free MSI\n",
+				pci_name(pdev));
+			return -ENOSPC;
+		}
+		virq = irq_create_mapping(NULL, hwirq);
+		if (virq == NO_IRQ) {
+			pr_warn("%s: Failed to map MSI to linux irq\n",
+				pci_name(pdev));
+			pnv_put_msi(phb, hwirq);
+			return -ENOMEM;
+		}
+		rc = phb->msi_setup(phb, pdev, hwirq, entry->msi_attrib.is_64,
+				    &msg);
+		if (rc) {
+			pr_warn("%s: Failed to setup MSI\n", pci_name(pdev));
+			irq_dispose_mapping(virq);
+			pnv_put_msi(phb, hwirq);
+			return rc;
+		}
+		irq_set_msi_desc(virq, entry);
+		write_msi_msg(virq, &msg);
+	}
+	return 0;
+}
 
+static void pnv_teardown_msi_irqs(struct pci_dev *pdev)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct msi_desc *entry;
+
+	if (WARN_ON(!phb))
+		return;
+
+	list_for_each_entry(entry, &pdev->msi_list, list) {
+		if (entry->irq == NO_IRQ)
+			continue;
+		irq_set_msi_desc(entry->irq, NULL);
+		pnv_put_msi(phb, virq_to_hw(entry->irq));
+		irq_dispose_mapping(entry->irq);
+	}
+}
+#endif /* CONFIG_PCI_MSI */
 static void pnv_pci_config_check_eeh(struct pnv_phb *phb, struct pci_bus *bus,
 				     u32 bdfn)
 {
@@ -283,4 +385,10 @@ void __init pnv_pci_init(void)
 	ppc_md.tce_free = pnv_tce_free;
 	set_pci_dma_ops(&dma_iommu_ops);
 
+	/* Configure MSIs */
+#ifdef CONFIG_PCI_MSI
+	ppc_md.msi_check_device = pnv_msi_check_device;
+	ppc_md.setup_msi_irqs = pnv_setup_msi_irqs;
+	ppc_md.teardown_msi_irqs = pnv_teardown_msi_irqs;
+#endif
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index b8be721..a468c9b 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -16,6 +16,16 @@ struct pnv_phb {
 	void __iomem		*regs;
 	spinlock_t		lock;
 
+#ifdef CONFIG_PCI_MSI
+	unsigned long		*msi_map;
+	unsigned int		msi_base;
+	unsigned int		msi_count;
+	unsigned int		msi_next;
+	unsigned int		msi32_support;
+#endif
+	int (*msi_setup)(struct pnv_phb *phb, struct pci_dev *dev,
+			 unsigned int hwirq, unsigned int is_64,
+			 struct msi_msg *msg);
 	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
 	void (*fixup_phb)(struct pci_controller *hose);
 	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
-- 
1.7.4.1
