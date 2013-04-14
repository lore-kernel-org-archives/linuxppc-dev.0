Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2AE5B2C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 05:20:37 +1000 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joro@8bytes.org>, <stuart.yoder@freescale.com>,
 <scottwood@freescale.com>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <galak@kernel.crashing.org>, <benh@kernel.crashing.org>
Subject: [PATCH 1/3] iommu: Move swap_pci_ref function to pci.h.
Date: Mon, 15 Apr 2013 00:42:00 +0530
Message-ID: <1365966722-1804-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

swap_pci_ref function is used by the IOMMU API code for swapping pci device
pointers, while determining the iommu group for the device.
Currently this function was being implemented for different IOMMU drivers.
This patch moves the function to pci.h so that the implementation can be
shared across various IOMMU drivers.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 drivers/iommu/amd_iommu.c   |    6 ------
 drivers/iommu/intel-iommu.c |    6 ------
 include/linux/pci.h         |    8 ++++++++
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a7f6b04..c36c046 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -263,12 +263,6 @@ static bool check_device(struct device *dev)
 	return true;
 }
 
-static void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
-{
-	pci_dev_put(*from);
-	*from = to;
-}
-
 static struct pci_bus *find_hosted_bus(struct pci_bus *bus)
 {
 	while (!bus->self) {
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6e0b9ff..8d7c979 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4137,12 +4137,6 @@ static int intel_iommu_domain_has_cap(struct iommu_domain *domain,
 	return 0;
 }
 
-static void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
-{
-	pci_dev_put(*from);
-	*from = to;
-}
-
 #define REQ_ACS_FLAGS	(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
 
 static int intel_iommu_add_device(struct device *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2461033a..41511de 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1850,6 +1850,14 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 }
 #endif
 
+#ifdef CONFIG_IOMMU_API
+static inline void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
+{
+	pci_dev_put(*from);
+	*from = to;
+}
+#endif
+
 /**
  * pci_find_upstream_pcie_bridge - find upstream PCIe-to-PCI bridge of a device
  * @pdev: the PCI device
-- 
1.7.4.1
