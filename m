Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F027C1A1D92
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2015 22:43:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: linux-pci@vger.kernel.org, gpiccoli@linux.vnet.ibm.com,
 bhelgaas@google.com, mst@redhat.com
Subject: [PATCH 1/2] PCI: Make pci_msi_setup_pci_dev() non-static for use by
 arch code
Date: Mon, 24 Aug 2015 22:42:46 +1000
Message-Id: <1440420167-8879-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>

Commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel
doesn't support MSI") changed the location of the code that initialises
dev->msi_cap/msix_cap and then disables MSI/MSI-X interrupts at PCI
probe time in devices that have this flag set. It moved the code from
pci_msi_init_pci_dev() to a new function named pci_msi_setup_pci_dev(),
called by pci_setup_device().

The pseries PCI probing code does not call pci_setup_device(), so since
the aforementioned commit the function pci_msi_setup_pci_dev() is not
called and MSI/MSI-X interrupts are left enabled. Additionally because
dev->msi_cap/msix_cap are not initialised no driver can ever enable
MSI/MSI-X.

To fix this, the pseries PCI probe should manually call
pci_msi_setup_pci_dev(), so this patch makes it non-static.

Fixes: 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI")
[mpe: Update change log to mention dev->msi_cap/msix_cap]
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/pci/probe.c | 2 +-
 include/linux/pci.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)


Bjorn, I plan to put this series in my fixes branch and ask Linus to pull it
before the 4.2 release. Unless you want to take it.

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b978bbfe044c..f6ae0d0052eb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1108,7 +1108,7 @@ int pci_cfg_space_size(struct pci_dev *dev)
 
 #define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
 
-static void pci_msi_setup_pci_dev(struct pci_dev *dev)
+void pci_msi_setup_pci_dev(struct pci_dev *dev)
 {
 	/*
 	 * Disable the MSI hardware to avoid screaming interrupts
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a8fb59..860c751810fc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1202,6 +1202,7 @@ struct msix_entry {
 	u16	entry;	/* driver uses to specify entry, OS writes */
 };
 
+void pci_msi_setup_pci_dev(struct pci_dev *dev);
 
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
-- 
2.1.4
