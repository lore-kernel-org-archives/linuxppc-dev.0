Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6F0CE2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 18:23:19 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 00:13:11 -0700
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C2560C90025
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 02:13:08 -0500 (EST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r267D8XS320542
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 02:13:08 -0500
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r267D7wA025304
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 00:13:08 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Use MSI bitmap to manage IRQs
Date: Wed,  6 Mar 2013 15:12:37 +0800
Message-Id: <1362553957-12110-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Michael Ellerman mentioned, arch/powerpc/sysdev/msi_bitmap.c
already implemented bitmap to manage (alloc/free) MSI interrupts.
The patch intends to use that mechanism to manage MSI interrupts
for PowerNV platform.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c   |   12 +++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |   11 ++---
 arch/powerpc/platforms/powernv/pci.c        |   59 ++++++---------------------
 arch/powerpc/platforms/powernv/pci.h        |    4 +-
 4 files changed, 25 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8e90e89..a5c5f15 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -26,6 +26,7 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
+#include <asm/msi_bitmap.h>
 #include <asm/ppc-pci.h>
 #include <asm/opal.h>
 #include <asm/iommu.h>
@@ -647,7 +648,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 
 static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
 {
-	unsigned int bmap_size;
+	unsigned int count;
 	const __be32 *prop = of_get_property(phb->hose->dn,
 					     "ibm,opal-msi-ranges", NULL);
 	if (!prop) {
@@ -658,18 +659,17 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
 		return;
 
 	phb->msi_base = be32_to_cpup(prop);
-	phb->msi_count = be32_to_cpup(prop + 1);
-	bmap_size = BITS_TO_LONGS(phb->msi_count) * sizeof(unsigned long);
-	phb->msi_map = zalloc_maybe_bootmem(bmap_size, GFP_KERNEL);
-	if (!phb->msi_map) {
+	count = be32_to_cpup(prop + 1);
+	if (msi_bitmap_alloc(&phb->msi_bmp, count, phb->hose->dn)) {
 		pr_err("PCI %d: Failed to allocate MSI bitmap !\n",
 		       phb->hose->global_number);
 		return;
 	}
+
 	phb->msi_setup = pnv_pci_ioda_msi_setup;
 	phb->msi32_support = 1;
 	pr_info("  Allocated bitmap for %d MSIs (base IRQ 0x%x)\n",
-		phb->msi_count, phb->msi_base);
+		count, phb->msi_base);
 }
 #else
 static void pnv_pci_init_ioda_msis(struct pnv_phb *phb) { }
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 7db8771..d5c066e 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -26,6 +26,7 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
+#include <asm/msi_bitmap.h>
 #include <asm/ppc-pci.h>
 #include <asm/opal.h>
 #include <asm/iommu.h>
@@ -55,7 +56,7 @@ static int pnv_pci_p5ioc2_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 
 static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb)
 {
-	unsigned int bmap_size;
+	unsigned int count;
 	const __be32 *prop = of_get_property(phb->hose->dn,
 					     "ibm,opal-msi-ranges", NULL);
 	if (!prop)
@@ -67,10 +68,8 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb)
 	if (of_device_is_compatible(phb->hose->dn, "ibm,p5ioc2-pcix"))
 		return;
 	phb->msi_base = be32_to_cpup(prop);
-	phb->msi_count = be32_to_cpup(prop + 1);
-	bmap_size = BITS_TO_LONGS(phb->msi_count) * sizeof(unsigned long);
-	phb->msi_map = zalloc_maybe_bootmem(bmap_size, GFP_KERNEL);
-	if (!phb->msi_map) {
+	count = be32_to_cpup(prop + 1);
+	if (msi_bitmap_alloc(&phb->msi_bmp, count, phb->hose->dn)) {
 		pr_err("PCI %d: Failed to allocate MSI bitmap !\n",
 		       phb->hose->global_number);
 		return;
@@ -78,7 +77,7 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb)
 	phb->msi_setup = pnv_pci_p5ioc2_msi_setup;
 	phb->msi32_support = 0;
 	pr_info(" Allocated bitmap for %d MSIs (base IRQ 0x%x)\n",
-		phb->msi_count, phb->msi_base);
+		count, phb->msi_base);
 }
 #else
 static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb) { }
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b8b8e0b..42eee93 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -26,6 +26,7 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
+#include <asm/msi_bitmap.h>
 #include <asm/ppc-pci.h>
 #include <asm/opal.h>
 #include <asm/iommu.h>
@@ -47,43 +48,7 @@ static int pnv_msi_check_device(struct pci_dev* pdev, int nvec, int type)
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
 
-	return (phb && phb->msi_map) ? 0 : -ENODEV;
-}
-
-static unsigned int pnv_get_one_msi(struct pnv_phb *phb)
-{
-	unsigned long flags;
-	unsigned int id, rc;
-
-	spin_lock_irqsave(&phb->lock, flags);
-
-	id = find_next_zero_bit(phb->msi_map, phb->msi_count, phb->msi_next);
-	if (id >= phb->msi_count && phb->msi_next)
-		id = find_next_zero_bit(phb->msi_map, phb->msi_count, 0);
-	if (id >= phb->msi_count) {
-		rc = 0;
-		goto out;
-	}
-	__set_bit(id, phb->msi_map);
-	rc = id + phb->msi_base;
-out:
-	spin_unlock_irqrestore(&phb->lock, flags);
-	return rc;
-}
-
-static void pnv_put_msi(struct pnv_phb *phb, unsigned int hwirq)
-{
-	unsigned long flags;
-	unsigned int id;
-
-	if (WARN_ON(hwirq < phb->msi_base ||
-		    hwirq >= (phb->msi_base + phb->msi_count)))
-		return;
-	id = hwirq - phb->msi_base;
-
-	spin_lock_irqsave(&phb->lock, flags);
-	__clear_bit(id, phb->msi_map);
-	spin_unlock_irqrestore(&phb->lock, flags);
+	return (phb && phb->msi_bmp.bitmap) ? 0 : -ENODEV;
 }
 
 static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
@@ -92,7 +57,8 @@ static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	struct pnv_phb *phb = hose->private_data;
 	struct msi_desc *entry;
 	struct msi_msg msg;
-	unsigned int hwirq, virq;
+	int hwirq;
+	unsigned int virq;
 	int rc;
 
 	if (WARN_ON(!phb))
@@ -104,25 +70,25 @@ static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 				pci_name(pdev));
 			return -ENXIO;
 		}
-		hwirq = pnv_get_one_msi(phb);
-		if (!hwirq) {
+		hwirq = msi_bitmap_alloc_hwirqs(&phb->msi_bmp, 1);
+		if (hwirq < 0) {
 			pr_warn("%s: Failed to find a free MSI\n",
 				pci_name(pdev));
 			return -ENOSPC;
 		}
-		virq = irq_create_mapping(NULL, hwirq);
+		virq = irq_create_mapping(NULL, phb->msi_base + hwirq);
 		if (virq == NO_IRQ) {
 			pr_warn("%s: Failed to map MSI to linux irq\n",
 				pci_name(pdev));
-			pnv_put_msi(phb, hwirq);
+			msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq, 1);
 			return -ENOMEM;
 		}
-		rc = phb->msi_setup(phb, pdev, hwirq, entry->msi_attrib.is_64,
-				    &msg);
+		rc = phb->msi_setup(phb, pdev, phb->msi_base + hwirq,
+				    entry->msi_attrib.is_64, &msg);
 		if (rc) {
 			pr_warn("%s: Failed to setup MSI\n", pci_name(pdev));
 			irq_dispose_mapping(virq);
-			pnv_put_msi(phb, hwirq);
+			msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq, 1);
 			return rc;
 		}
 		irq_set_msi_desc(virq, entry);
@@ -144,7 +110,8 @@ static void pnv_teardown_msi_irqs(struct pci_dev *pdev)
 		if (entry->irq == NO_IRQ)
 			continue;
 		irq_set_msi_desc(entry->irq, NULL);
-		pnv_put_msi(phb, virq_to_hw(entry->irq));
+		msi_bitmap_free_hwirqs(&phb->msi_bmp,
+			virq_to_hw(entry->irq) - phb->msi_base, 1);
 		irq_dispose_mapping(entry->irq);
 	}
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 7cfb7c8..42ddfba 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -73,11 +73,9 @@ struct pnv_phb {
 	spinlock_t		lock;
 
 #ifdef CONFIG_PCI_MSI
-	unsigned long		*msi_map;
 	unsigned int		msi_base;
-	unsigned int		msi_count;
-	unsigned int		msi_next;
 	unsigned int		msi32_support;
+	struct msi_bitmap	msi_bmp;
 #endif
 	int (*msi_setup)(struct pnv_phb *phb, struct pci_dev *dev,
 			 unsigned int hwirq, unsigned int is_64,
-- 
1.7.5.4
