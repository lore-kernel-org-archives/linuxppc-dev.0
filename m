Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE6841A0796
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 14:36:29 +1000 (AEST)
Date: Thu, 10 Sep 2015 14:36:21 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH] powerpc: MSI: Fix race condition in tearing down MSI
 interrupts
Message-ID: <20150910043621.GA21735@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a race which can result in the same virtual IRQ number
being assigned to two different MSI interrupts.  The most visible
consequence of that is usually a warning and stack trace from the
sysfs code about an attempt to create a duplicate entry in sysfs.

The race happens when one CPU (say CPU 0) is disposing of an MSI
while another CPU (say CPU 1) is setting up an MSI.  CPU 0 calls
(for example) pnv_teardown_msi_irqs(), which calls
msi_bitmap_free_hwirqs() to indicate that the MSI (i.e. its
hardware IRQ number) is no longer in use.  Then, before CPU 0 gets
to calling irq_dispose_mapping() to free up the virtal IRQ number,
CPU 1 comes in and calls msi_bitmap_alloc_hwirqs() to allocate an
MSI, and gets the same hardware IRQ number that CPU 0 just freed.
CPU 1 then calls irq_create_mapping() to get a virtual IRQ number,
which sees that there is currently a mapping for that hardware IRQ
number and returns the corresponding virtual IRQ number (which is
the same virtual IRQ number that CPU 0 was using).  CPU 0 then
calls irq_dispose_mapping() and frees that virtual IRQ number.
Now, if another CPU comes along and calls irq_create_mapping(), it
is likely to get the virtual IRQ number that was just freed,
resulting in the same virtual IRQ number apparently being used for
two different hardware interrupts.

To fix this race, we just move the call to msi_bitmap_free_hwirqs()
to after the call to irq_dispose_mapping().  Since virq_to_hw()
doesn't work for the virtual IRQ number after irq_dispose_mapping()
has been called, we need to call it before irq_dispose_mapping() and
remember the result for the msi_bitmap_free_hwirqs() call.

The pattern of calling msi_bitmap_free_hwirqs() before
irq_dispose_mapping() appears in 5 places under arch/powerpc, and
appears to have originated in commit 05af7bd2d75e ("[POWERPC] MPIC
U3/U4 MSI backend") from 2007.

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/platforms/pasemi/msi.c  | 5 +++--
 arch/powerpc/platforms/powernv/pci.c | 5 +++--
 arch/powerpc/sysdev/fsl_msi.c        | 5 +++--
 arch/powerpc/sysdev/mpic_u3msi.c     | 5 +++--
 arch/powerpc/sysdev/ppc4xx_msi.c     | 5 +++--
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/msi.c b/arch/powerpc/platforms/pasemi/msi.c
index e66ef19..b304a9f 100644
--- a/arch/powerpc/platforms/pasemi/msi.c
+++ b/arch/powerpc/platforms/pasemi/msi.c
@@ -63,6 +63,7 @@ static struct irq_chip mpic_pasemi_msi_chip = {
 static void pasemi_msi_teardown_msi_irqs(struct pci_dev *pdev)
 {
 	struct msi_desc *entry;
+	irq_hw_number_t hwirq;
 
 	pr_debug("pasemi_msi_teardown_msi_irqs, pdev %p\n", pdev);
 
@@ -70,10 +71,10 @@ static void pasemi_msi_teardown_msi_irqs(struct pci_dev *pdev)
 		if (entry->irq == NO_IRQ)
 			continue;
 
+		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
-		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap,
-				       virq_to_hw(entry->irq), ALLOC_CHUNK);
 		irq_dispose_mapping(entry->irq);
+		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, ALLOC_CHUNK);
 	}
 
 	return;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 9b2480b..f2dd772 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -99,6 +99,7 @@ void pnv_teardown_msi_irqs(struct pci_dev *pdev)
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
 	struct msi_desc *entry;
+	irq_hw_number_t hwirq;
 
 	if (WARN_ON(!phb))
 		return;
@@ -106,10 +107,10 @@ void pnv_teardown_msi_irqs(struct pci_dev *pdev)
 	for_each_pci_msi_entry(entry, pdev) {
 		if (entry->irq == NO_IRQ)
 			continue;
+		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
-		msi_bitmap_free_hwirqs(&phb->msi_bmp,
-			virq_to_hw(entry->irq) - phb->msi_base, 1);
 		irq_dispose_mapping(entry->irq);
+		msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq - phb->msi_base, 1);
 	}
 }
 #endif /* CONFIG_PCI_MSI */
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 5916da1..48a576a 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -128,15 +128,16 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 {
 	struct msi_desc *entry;
 	struct fsl_msi *msi_data;
+	irq_hw_number_t hwirq;
 
 	for_each_pci_msi_entry(entry, pdev) {
 		if (entry->irq == NO_IRQ)
 			continue;
+		hwirq = virq_to_hw(entry->irq);
 		msi_data = irq_get_chip_data(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
-		msi_bitmap_free_hwirqs(&msi_data->bitmap,
-				       virq_to_hw(entry->irq), 1);
 		irq_dispose_mapping(entry->irq);
+		msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
 	}
 
 	return;
diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index 70fbd56..2cbc7e2 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -107,15 +107,16 @@ static u64 find_u4_magic_addr(struct pci_dev *pdev, unsigned int hwirq)
 static void u3msi_teardown_msi_irqs(struct pci_dev *pdev)
 {
 	struct msi_desc *entry;
+	irq_hw_number_t hwirq;
 
 	for_each_pci_msi_entry(entry, pdev) {
 		if (entry->irq == NO_IRQ)
 			continue;
 
+		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
-		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap,
-				       virq_to_hw(entry->irq), 1);
 		irq_dispose_mapping(entry->irq);
+		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, 1);
 	}
 
 	return;
diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
index 24d0470..8fb8061 100644
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -124,16 +124,17 @@ void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 	struct ppc4xx_msi *msi_data = &ppc4xx_msi;
+	irq_hw_number_t hwirq;
 
 	dev_dbg(&dev->dev, "PCIE-MSI: tearing down msi irqs\n");
 
 	for_each_pci_msi_entry(entry, dev) {
 		if (entry->irq == NO_IRQ)
 			continue;
+		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
-		msi_bitmap_free_hwirqs(&msi_data->bitmap,
-				virq_to_hw(entry->irq), 1);
 		irq_dispose_mapping(entry->irq);
+		msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
 	}
 }
 
-- 
2.5.1
