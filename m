Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 10FBB2C0381
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 07:53:26 +1100 (EST)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc: msi: fsl: add support for multiple MSI interrupts
Date: Thu, 20 Feb 2014 21:53:10 +0100
Message-Id: <1392929590-12888-3-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1392929590-12888-1-git-send-email-bigeasy@linutronix.de>
References: <1392929590-12888-1-git-send-email-bigeasy@linutronix.de>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Brian King <brking@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch pushes the check for nvec > 1 && MSI into the check function
of each MSI driver except for FSL's MSI where the functionality is
added.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alistair Popple <alistair@popple.id.au>
Cc: Brian King <brking@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/msi.c              |  4 ----
 arch/powerpc/platforms/cell/axon_msi.c |  3 +++
 arch/powerpc/platforms/powernv/pci.c   |  2 ++
 arch/powerpc/platforms/pseries/msi.c   |  3 +++
 arch/powerpc/platforms/wsp/msi.c       |  8 ++++++++
 arch/powerpc/sysdev/fsl_msi.c          | 29 +++++++++++++++++++++--------
 arch/powerpc/sysdev/mpic_pasemi_msi.c  |  3 ++-
 arch/powerpc/sysdev/mpic_u3msi.c       |  2 ++
 arch/powerpc/sysdev/ppc4xx_msi.c       |  2 ++
 9 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index 8bbc12d..46b1470 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -20,10 +20,6 @@ int arch_msi_check_device(struct pci_dev* dev, int nvec, int type)
 		return -ENOSYS;
 	}
 
-	/* PowerPC doesn't support multiple MSI yet */
-	if (type == PCI_CAP_ID_MSI && nvec > 1)
-		return 1;
-
 	if (ppc_md.msi_check_device) {
 		pr_debug("msi: Using platform check routine.\n");
 		return ppc_md.msi_check_device(dev, nvec, type);
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 85825b5..6e592ed 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -204,6 +204,9 @@ static int axon_msi_check_device(struct pci_dev *dev, int nvec, int type)
 	if (!find_msi_translator(dev))
 		return -ENODEV;
 
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 95633d7..1d08040 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -54,6 +54,8 @@ static int pnv_msi_check_device(struct pci_dev* pdev, int nvec, int type)
 
 	if (pdn && pdn->force_32bit_msi && !phb->msi32_support)
 		return -ENODEV;
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
 
 	return (phb && phb->msi_bmp.bitmap) ? 0 : -ENODEV;
 }
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 0c882e8..ad5e766 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -339,6 +339,9 @@ static int rtas_msi_check_device(struct pci_dev *pdev, int nvec, int type)
 {
 	int quota, rc;
 
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+
 	if (type == PCI_CAP_ID_MSIX)
 		rc = check_req_msix(pdev, nvec);
 	else
diff --git a/arch/powerpc/platforms/wsp/msi.c b/arch/powerpc/platforms/wsp/msi.c
index 380882f..0cabd46 100644
--- a/arch/powerpc/platforms/wsp/msi.c
+++ b/arch/powerpc/platforms/wsp/msi.c
@@ -21,6 +21,13 @@
 #define MSI_ADDR_32		0xFFFF0000ul
 #define MSI_ADDR_64		0x1000000000000000ul
 
+static int wsp_msi_check_device(struct pci_dev *dev, int nvec, int type)
+{
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+	return 0;
+}
+
 int wsp_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct pci_controller *phb;
@@ -98,5 +105,6 @@ void wsp_setup_phb_msi(struct pci_controller *phb)
 	out_be64(phb->cfg_data + PCIE_REG_IODA_DATA0, 1ull << 63);
 
 	ppc_md.setup_msi_irqs = wsp_setup_msi_irqs;
+	ppc_md.msi_check_device = wsp_msi_check_device;
 	ppc_md.teardown_msi_irqs = wsp_teardown_msi_irqs;
 }
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 77efbae..f07840f 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -123,13 +123,19 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 	struct fsl_msi *msi_data;
 
 	list_for_each_entry(entry, &pdev->msi_list, list) {
+		int num;
+		int i;
+
 		if (entry->irq == NO_IRQ)
 			continue;
 		msi_data = irq_get_chip_data(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
+		num = 1 << entry->msi_attrib.multiple;
 		msi_bitmap_free_hwirqs(&msi_data->bitmap,
-				       virq_to_hw(entry->irq), 1);
-		irq_dispose_mapping(entry->irq);
+				       virq_to_hw(entry->irq), num);
+
+		for (i = 0; i < num; i++)
+			irq_dispose_mapping(entry->irq + i);
 	}
 
 	return;
@@ -172,6 +178,7 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	struct msi_desc *entry;
 	struct msi_msg msg;
 	struct fsl_msi *msi_data;
+	int i;
 
 	/*
 	 * If the PCI node has an fsl,msi property, then we need to use it
@@ -207,7 +214,8 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			if (phandle && (phandle != msi_data->phandle))
 				continue;
 
-			hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
+			hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap,
+					nvec);
 			if (hwirq >= 0)
 				break;
 		}
@@ -218,17 +226,22 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			goto out_free;
 		}
 
-		virq = irq_create_mapping(msi_data->irqhost, hwirq);
-
+		virq = irq_create_mapping_block(msi_data->irqhost, hwirq, nvec);
 		if (virq == NO_IRQ) {
 			dev_err(&pdev->dev, "fail mapping hwirq %i\n", hwirq);
-			msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
+			msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, nvec);
 			rc = -ENOSPC;
 			goto out_free;
 		}
+		entry->msi_attrib.multiple = get_count_order(nvec);
 		/* chip_data is msi_data via host->hostdata in host->map() */
-		irq_set_msi_desc(virq, entry);
-
+		for (i = nvec - 1; i >= 0; i--) {
+			/*
+			 * write the virq mapping last so entry->irq will point
+			 * to first virq
+			 */
+			irq_set_msi_desc(virq + i, entry);
+		}
 		fsl_compose_msi_msg(pdev, hwirq, &msg, msi_data);
 		write_msi_msg(virq, &msg);
 	}
diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/sysdev/mpic_pasemi_msi.c
index 38e6238..3d36f7e 100644
--- a/arch/powerpc/sysdev/mpic_pasemi_msi.c
+++ b/arch/powerpc/sysdev/mpic_pasemi_msi.c
@@ -67,7 +67,8 @@ static int pasemi_msi_check_device(struct pci_dev *pdev, int nvec, int type)
 {
 	if (type == PCI_CAP_ID_MSIX)
 		pr_debug("pasemi_msi: MSI-X untested, trying anyway\n");
-
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
 	return 0;
 }
 
diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index 9a7aa0e..f6f86ac 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -109,6 +109,8 @@ static int u3msi_msi_check_device(struct pci_dev *pdev, int nvec, int type)
 {
 	if (type == PCI_CAP_ID_MSIX)
 		pr_debug("u3msi: MSI-X untested, trying anyway.\n");
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
 
 	/* If we can't find a magic address then MSI ain't gonna work */
 	if (find_ht_magic_addr(pdev, 0) == 0 &&
diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
index 43948da..af1efeb 100644
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -140,6 +140,8 @@ static int ppc4xx_msi_check_device(struct pci_dev *pdev, int nvec, int type)
 		__func__, nvec, type);
 	if (type == PCI_CAP_ID_MSIX)
 		pr_debug("ppc4xx msi: MSI-X untested, trying anyway.\n");
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
 
 	return 0;
 }
-- 
1.9.0.rc3
