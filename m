Return-Path: <Johannes.Thumshirn@men.de>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.140])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5FE01A02B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 03:18:53 +1100 (AEDT)
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Scott Wood
 <scottwood@freescale.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/2] powerpc: msi: fsl: add support for multiple MSI interrupts
Date: Mon, 3 Nov 2014 17:18:34 +0100
Message-ID: <1415031514-27284-3-git-send-email-johannes.thumshirn@men.de>
In-Reply-To: <1415031514-27284-1-git-send-email-johannes.thumshirn@men.de>
References: <1415031514-27284-1-git-send-email-johannes.thumshirn@men.de>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Johannes Thumshirn <johannes.thumshirn@men.de>,
 linuxppc-dev@lists.ozlabs.org
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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>
---
 arch/powerpc/kernel/msi.c              |  4 ----
 arch/powerpc/platforms/cell/axon_msi.c |  3 +++
 arch/powerpc/platforms/powernv/pci.c   |  3 +++
 arch/powerpc/platforms/pseries/msi.c   |  3 +++
 arch/powerpc/sysdev/fsl_msi.c          | 22 ++++++++++++++++------
 arch/powerpc/sysdev/mpic_pasemi_msi.c  |  3 +++
 arch/powerpc/sysdev/mpic_u3msi.c       |  3 +++
 arch/powerpc/sysdev/ppc4xx_msi.c       |  2 ++
 8 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index 71bd161..80ee2f4 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -20,10 +20,6 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		return -ENOSYS;
 	}
 
-	/* PowerPC doesn't support multiple MSI yet */
-	if (type == PCI_CAP_ID_MSI && nvec > 1)
-		return 1;
-
 	return ppc_md.setup_msi_irqs(dev, nvec, type);
 }
 
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 862b327..537a70e 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -250,6 +250,9 @@ static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 
 	of_node_put(dn);
 
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b2187d0..de33ec0 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -63,6 +63,9 @@ static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	if (pdn && pdn->force_32bit_msi && !phb->msi32_support)
 		return -ENODEV;
 
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+
 	list_for_each_entry(entry, &pdev->msi_list, list) {
 		if (!entry->msi_attrib.is_64 && !phb->msi32_support) {
 			pr_warn("%s: Supports only 64-bit MSIs\n",
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 8ab5add..544e924 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -383,6 +383,9 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
 	int nvec = nvec_in;
 	int use_32bit_msi_hack = 0;
 
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+
 	if (type == PCI_CAP_ID_MSIX)
 		rc = check_req_msix(pdev, nvec);
 	else
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index de40b48..454e8b1 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -131,13 +131,19 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
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
@@ -180,6 +186,7 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	struct msi_desc *entry;
 	struct msi_msg msg;
 	struct fsl_msi *msi_data;
+	int i;
 
 	if (type == PCI_CAP_ID_MSIX)
 		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");
@@ -219,7 +226,8 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			if (phandle && (phandle != msi_data->phandle))
 				continue;
 
-			hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
+			hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap,
+							nvec);
 			if (hwirq >= 0)
 				break;
 		}
@@ -230,16 +238,18 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			goto out_free;
 		}
 
-		virq = irq_create_mapping(msi_data->irqhost, hwirq);
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
+		for (i = nvec - 1; i >= 0; i--)
+			irq_set_msi_desc(virq + i, entry);
 
 		fsl_compose_msi_msg(pdev, hwirq, &msg, msi_data);
 		write_msi_msg(virq, &msg);
diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/sysdev/mpic_pasemi_msi.c
index 15dccd3..03bace0 100644
--- a/arch/powerpc/sysdev/mpic_pasemi_msi.c
+++ b/arch/powerpc/sysdev/mpic_pasemi_msi.c
@@ -139,6 +139,9 @@ static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		write_msi_msg(virq, &msg);
 	}
 
+	if (typpe == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+
 	return 0;
 }
 
diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index 623d7fb..5024629 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -133,6 +133,9 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	if (type == PCI_CAP_ID_MSIX)
 		pr_debug("u3msi: MSI-X untested, trying anyway.\n");
 
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+
 	/* If we can't find a magic address then MSI ain't gonna work */
 	if (find_ht_magic_addr(pdev, 0) == 0 &&
 	    find_u4_magic_addr(pdev, 0) == 0) {
diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
index 22b5200..8bbb228 100644
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -89,6 +89,8 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		__func__, nvec, type);
 	if (type == PCI_CAP_ID_MSIX)
 		pr_debug("ppc4xx msi: MSI-X untested, trying anyway.\n");
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
 
 	msi_data->msi_virqs = kmalloc((msi_irqs) * sizeof(int), GFP_KERNEL);
 	if (!msi_data->msi_virqs)
-- 
1.9.1
