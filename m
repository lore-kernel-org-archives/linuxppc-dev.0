Return-Path: <jiang.liu@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 69DB51A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 17:59:46 +1000 (AEST)
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Grant Likely <grant.likely@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Stuart Yoder <stuart.yoder@freescale.com>,
 Yijing Wang <wangyijing@huawei.com>, Borislav Petkov <bp@alien8.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, Daniel Axtens <dja@axtens.net>,
 Wei Yang <weiyang@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Alexander Gordeev <agordeev@redhat.com>,
 Jiang Liu <jiang.liu@linux.intel.com>,
 Scott Wood <scottwood@freescale.com>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 Tudor Laurentiu <b10716@freescale.com>,
 Hongtao Jia <hongtao.jia@freescale.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC Patch V1 03/12] PowerPC,
 PCI: Use for_pci_msi_entry() to access MSI device list
Date: Thu,  9 Jul 2015 16:00:38 +0800
Message-Id: <1436428847-8886-4-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use accessor for_pci_msi_entry() to access MSI device list, so we could
easily move msi_list from struct pci_dev into struct device later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/powerpc/platforms/cell/axon_msi.c |    6 +++---
 arch/powerpc/platforms/pasemi/msi.c    |    4 ++--
 arch/powerpc/platforms/powernv/pci.c   |    4 ++--
 arch/powerpc/platforms/pseries/msi.c   |    6 +++---
 arch/powerpc/sysdev/fsl_msi.c          |    4 ++--
 arch/powerpc/sysdev/mpic_u3msi.c       |    4 ++--
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c  |    4 ++--
 arch/powerpc/sysdev/ppc4xx_msi.c       |    4 ++--
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index fe51de4fcf13..306888acb737 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -213,7 +213,7 @@ static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 		return -ENODEV;
 	}
 
-	entry = list_first_entry(&dev->msi_list, struct msi_desc, list);
+	entry = first_pci_msi_entry(dev);
 
 	for (; dn; dn = of_get_next_parent(dn)) {
 		if (entry->msi_attrib.is_64) {
@@ -269,7 +269,7 @@ static int axon_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (rc)
 		return rc;
 
-	list_for_each_entry(entry, &dev->msi_list, list) {
+	for_each_pci_msi_entry(entry, dev) {
 		virq = irq_create_direct_mapping(msic->irq_domain);
 		if (virq == NO_IRQ) {
 			dev_warn(&dev->dev,
@@ -292,7 +292,7 @@ static void axon_msi_teardown_msi_irqs(struct pci_dev *dev)
 
 	dev_dbg(&dev->dev, "axon_msi: tearing down msi irqs\n");
 
-	list_for_each_entry(entry, &dev->msi_list, list) {
+	for_each_pci_msi_entry(entry, dev) {
 		if (entry->irq == NO_IRQ)
 			continue;
 
diff --git a/arch/powerpc/platforms/pasemi/msi.c b/arch/powerpc/platforms/pasemi/msi.c
index 27f2b187a91b..e66ef1943338 100644
--- a/arch/powerpc/platforms/pasemi/msi.c
+++ b/arch/powerpc/platforms/pasemi/msi.c
@@ -66,7 +66,7 @@ static void pasemi_msi_teardown_msi_irqs(struct pci_dev *pdev)
 
 	pr_debug("pasemi_msi_teardown_msi_irqs, pdev %p\n", pdev);
 
-	list_for_each_entry(entry, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(entry, pdev) {
 		if (entry->irq == NO_IRQ)
 			continue;
 
@@ -94,7 +94,7 @@ static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	msg.address_hi = 0;
 	msg.address_lo = PASEMI_MSI_ADDR;
 
-	list_for_each_entry(entry, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(entry, pdev) {
 		/* Allocate 16 interrupts for now, since that's the grouping for
 		 * affinity. This can be changed later if it turns out 32 is too
 		 * few MSIs for someone, but restrictions will apply to how the
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 765d8ed558d0..bc6d4e02e29c 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -61,7 +61,7 @@ int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	if (pdev->no_64bit_msi && !phb->msi32_support)
 		return -ENODEV;
 
-	list_for_each_entry(entry, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(entry, pdev) {
 		if (!entry->msi_attrib.is_64 && !phb->msi32_support) {
 			pr_warn("%s: Supports only 64-bit MSIs\n",
 				pci_name(pdev));
@@ -103,7 +103,7 @@ void pnv_teardown_msi_irqs(struct pci_dev *pdev)
 	if (WARN_ON(!phb))
 		return;
 
-	list_for_each_entry(entry, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(entry, pdev) {
 		if (entry->irq == NO_IRQ)
 			continue;
 		irq_set_msi_desc(entry->irq, NULL);
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index c22bb647cce6..272e9ec1ab54 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -118,7 +118,7 @@ static void rtas_teardown_msi_irqs(struct pci_dev *pdev)
 {
 	struct msi_desc *entry;
 
-	list_for_each_entry(entry, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(entry, pdev) {
 		if (entry->irq == NO_IRQ)
 			continue;
 
@@ -350,7 +350,7 @@ static int check_msix_entries(struct pci_dev *pdev)
 	 * So we must reject such requests. */
 
 	expected = 0;
-	list_for_each_entry(entry, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(entry, pdev) {
 		if (entry->msi_attrib.entry_nr != expected) {
 			pr_debug("rtas_msi: bad MSI-X entries.\n");
 			return -EINVAL;
@@ -462,7 +462,7 @@ again:
 	}
 
 	i = 0;
-	list_for_each_entry(entry, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(entry, pdev) {
 		hwirq = rtas_query_irq_number(pdn, i++);
 		if (hwirq < 0) {
 			pr_debug("rtas_msi: error (%d) getting hwirq\n", rc);
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 5236e5427c38..5916da1856a7 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -129,7 +129,7 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 	struct msi_desc *entry;
 	struct fsl_msi *msi_data;
 
-	list_for_each_entry(entry, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(entry, pdev) {
 		if (entry->irq == NO_IRQ)
 			continue;
 		msi_data = irq_get_chip_data(entry->irq);
@@ -219,7 +219,7 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		}
 	}
 
-	list_for_each_entry(entry, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(entry, pdev) {
 		/*
 		 * Loop over all the MSI devices until we find one that has an
 		 * available interrupt.
diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index fc46ef3b816e..70fbd5694a8b 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -108,7 +108,7 @@ static void u3msi_teardown_msi_irqs(struct pci_dev *pdev)
 {
 	struct msi_desc *entry;
 
-        list_for_each_entry(entry, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(entry, pdev) {
 		if (entry->irq == NO_IRQ)
 			continue;
 
@@ -140,7 +140,7 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		return -ENXIO;
 	}
 
-	list_for_each_entry(entry, &pdev->msi_list, list) {
+	for_each_pci_msi_entry(entry, pdev) {
 		hwirq = msi_bitmap_alloc_hwirqs(&msi_mpic->msi_bitmap, 1);
 		if (hwirq < 0) {
 			pr_debug("u3msi: failed allocating hwirq\n");
diff --git a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
index 2bc33674ebfc..0d88ba242754 100644
--- a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
@@ -50,7 +50,7 @@ static int hsta_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		return -EINVAL;
 	}
 
-	list_for_each_entry(entry, &dev->msi_list, list) {
+	for_each_pci_msi_entry(entry, dev) {
 		irq = msi_bitmap_alloc_hwirqs(&ppc4xx_hsta_msi.bmp, 1);
 		if (irq < 0) {
 			pr_debug("%s: Failed to allocate msi interrupt\n",
@@ -108,7 +108,7 @@ static void hsta_teardown_msi_irqs(struct pci_dev *dev)
 	struct msi_desc *entry;
 	int irq;
 
-	list_for_each_entry(entry, &dev->msi_list, list) {
+	for_each_pci_msi_entry(entry, dev) {
 		if (entry->irq == NO_IRQ)
 			continue;
 
diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
index 6eb21f2ea585..24d0470c1698 100644
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -93,7 +93,7 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (!msi_data->msi_virqs)
 		return -ENOMEM;
 
-	list_for_each_entry(entry, &dev->msi_list, list) {
+	for_each_pci_msi_entry(entry, dev) {
 		int_no = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
 		if (int_no >= 0)
 			break;
@@ -127,7 +127,7 @@ void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
 
 	dev_dbg(&dev->dev, "PCIE-MSI: tearing down msi irqs\n");
 
-	list_for_each_entry(entry, &dev->msi_list, list) {
+	for_each_pci_msi_entry(entry, dev) {
 		if (entry->irq == NO_IRQ)
 			continue;
 		irq_set_msi_desc(entry->irq, NULL);
-- 
1.7.10.4
