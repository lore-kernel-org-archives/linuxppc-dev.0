Return-Path: <R65777@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0DB9E2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:34:23 +1100 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <alex.williamson@redhat.com>, <joro@8bytes.org>,
 <galak@kernel.crashing.org>, <scottwood@freescale.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-pci@vger.kernel.org>, <agraf@suse.de>, <stuart.yoder@freescale.com>
Subject: [PATCH 1/5 RFC] pci:msi: add weak function for returning msi region
 info
Date: Tue, 29 Oct 2013 16:57:37 +0530
Message-ID: <1383046062-16520-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In Aperture type of IOMMU (like FSL PAMU), VFIO-iommu system need to know
the MSI region to map its window in h/w. This patch just defines the
required weak functions only and will be used by followup patches.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 drivers/pci/msi.c   |   22 ++++++++++++++++++++++
 include/linux/msi.h |   14 ++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d5f90d6..2643a29 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -67,6 +67,28 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
 	return chip->check_device(chip, dev, nvec, type);
 }
 
+int __weak arch_msi_get_region_count(void)
+{
+	return 0;
+}
+
+int __weak arch_msi_get_region(int region_num, struct msi_region *region)
+{
+	return 0;
+}
+
+int msi_get_region_count(void)
+{
+	return arch_msi_get_region_count();
+}
+EXPORT_SYMBOL(msi_get_region_count);
+
+int msi_get_region(int region_num, struct msi_region *region)
+{
+	return arch_msi_get_region(region_num, region);
+}
+EXPORT_SYMBOL(msi_get_region);
+
 int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct msi_desc *entry;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b17ead8..0deedb4 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -51,6 +51,18 @@ struct msi_desc {
 };
 
 /*
+ * This structure is used to get
+ * 	- physical address
+ * 	- size
+ * of a msi region
+ */
+struct msi_region {
+	int region_num; /* MSI region number */
+	dma_addr_t addr; /* Address of MSI region */
+	size_t size; /* Size of MSI region */
+};
+
+/*
  * The arch hooks to setup up msi irqs. Those functions are
  * implemented as weak symbols so that they /can/ be overriden by
  * architecture specific code if needed.
@@ -64,6 +76,8 @@ void arch_restore_msi_irqs(struct pci_dev *dev, int irq);
 
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev, int irq);
+int arch_msi_get_region_count(void);
+int arch_msi_get_region(int region_num, struct msi_region *region);
 
 struct msi_chip {
 	struct module *owner;
-- 
1.7.0.4
