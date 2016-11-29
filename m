Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSVZb0SlNzDwBh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:15:19 +1100 (AEDT)
Subject: [PATCH v4 3/7] PCI: Separate VF BAR updates from standard BAR updates
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: clsoto@us.ibm.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Date: Mon, 28 Nov 2016 22:15:06 -0600
Message-ID: <20161129041506.21453.18478.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously pci_update_resource() used the same code path for updating
standard BARs and VF BARs in SR-IOV capabilities.

Split the VF BAR update into a new pci_iov_update_resource() internal
interface, which makes it simpler to compute the BAR address (we can get
rid of pci_resource_bar() and pci_iov_resource_bar()).

This patch:

  - Renames pci_update_resource() to pci_std_update_resource(),
  - Adds pci_iov_update_resource(),
  - Makes pci_update_resource() a wrapper that calls the appropriate one,

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c       |   49 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h       |    1 +
 drivers/pci/setup-res.c |   13 +++++++++++-
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index d41ec29..d00ed5c 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -571,6 +571,55 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno)
 		4 * (resno - PCI_IOV_RESOURCES);
 }
 
+/**
+ * pci_iov_update_resource - update a VF BAR
+ * @dev: the PCI device
+ * @resno: the resource number
+ *
+ * Update a VF BAR in the SR-IOV capability of a PF.
+ */
+void pci_iov_update_resource(struct pci_dev *dev, int resno)
+{
+	struct pci_sriov *iov = dev->is_physfn ? dev->sriov : NULL;
+	struct resource *res = dev->resource + resno;
+	int vf_bar = resno - PCI_IOV_RESOURCES;
+	struct pci_bus_region region;
+	u32 new;
+	int reg;
+
+	/*
+	 * The generic pci_restore_bars() path calls this for all devices,
+	 * including VFs and non-SR-IOV devices.  If this is not a PF, we
+	 * have nothing to do.
+	 */
+	if (!iov)
+		return;
+
+	/*
+	 * Ignore unimplemented BARs, unused resource slots for 64-bit
+	 * BARs, and non-movable resources, e.g., those described via
+	 * Enhanced Allocation.
+	 */
+	if (!res->flags)
+		return;
+
+	if (res->flags & IORESOURCE_UNSET)
+		return;
+
+	if (res->flags & IORESOURCE_PCI_FIXED)
+		return;
+
+	pcibios_resource_to_bus(dev->bus, &region, res);
+	new = region.start;
+
+	reg = iov->pos + PCI_SRIOV_BAR + 4 * vf_bar;
+	pci_write_config_dword(dev, reg, new);
+	if (res->flags & IORESOURCE_MEM_64) {
+		new = region.start >> 16 >> 16;
+		pci_write_config_dword(dev, reg + 4, new);
+	}
+}
+
 resource_size_t __weak pcibios_iov_resource_alignment(struct pci_dev *dev,
 						      int resno)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4518562..5bfcb92 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -290,6 +290,7 @@ static inline void pci_restore_ats_state(struct pci_dev *dev)
 int pci_iov_init(struct pci_dev *dev);
 void pci_iov_release(struct pci_dev *dev);
 int pci_iov_resource_bar(struct pci_dev *dev, int resno);
+void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d2a32d8..ee0be34 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -25,8 +25,7 @@
 #include <linux/slab.h>
 #include "pci.h"
 
-
-void pci_update_resource(struct pci_dev *dev, int resno)
+static void pci_std_update_resource(struct pci_dev *dev, int resno)
 {
 	struct pci_bus_region region;
 	bool disable;
@@ -109,6 +108,16 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 }
 
+void pci_update_resource(struct pci_dev *dev, int resno)
+{
+	if (resno <= PCI_ROM_RESOURCE)
+		pci_std_update_resource(dev, resno);
+#ifdef CONFIG_PCI_IOV
+	else if (resno >= PCI_IOV_RESOURCES && resno < PCI_IOV_RESOURCE_END)
+		pci_iov_update_resource(dev, resno);
+#endif
+}
+
 int pci_claim_resource(struct pci_dev *dev, int resource)
 {
 	struct resource *res = &dev->resource[resource];
