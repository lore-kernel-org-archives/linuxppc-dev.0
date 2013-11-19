Return-Path: <Bharat.Bhushan@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6BAE92C0493
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 16:23:55 +1100 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <alex.williamson@redhat.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
 <agraf@suse.de>, <scottwood@freescale.com>, <stuart.yoder@freescale.com>,
 <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/9 v2] pci/msi: interface to set an iova for a msi region
Date: Tue, 19 Nov 2013 10:47:09 +0530
Message-ID: <1384838233-24847-6-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
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

This patch defines an interface by which a msi page
can be mapped to a specific iova page.

This is a requirement in aperture type of IOMMUs (like Freescale PAMU),
where we map msi iova page just after guest memory iova address.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v2
 - new patch

 drivers/pci/msi.c   |   13 +++++++++++++
 include/linux/pci.h |    8 ++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 2643a29..040609f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -77,6 +77,19 @@ int __weak arch_msi_get_region(int region_num, struct msi_region *region)
 	return 0;
 }
 
+int __weak arch_msi_set_iova(struct pci_dev *pdev, int region_num,
+			     dma_addr_t iova, bool set)
+{
+	return 0;
+}
+
+int msi_set_iova(struct pci_dev *pdev, int region_num,
+		 dma_addr_t iova, bool set)
+{
+	return arch_msi_set_iova(pdev, region_num, iova, set);
+}
+EXPORT_SYMBOL(msi_set_iova);
+
 int msi_get_region_count(void)
 {
 	return arch_msi_get_region_count();
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c587034..c6d3e58 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1195,6 +1195,12 @@ static inline int msi_get_region(int region_num, struct msi_region *region)
 {
 	return 0;
 }
+
+static inline int msi_set_iova(struct pci_dev *pdev, int region_num,
+			       dma_addr_t iova, bool set)
+{
+	return 0;
+}
 #else
 int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec);
 int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec);
@@ -1209,6 +1215,8 @@ void pci_restore_msi_state(struct pci_dev *dev);
 int pci_msi_enabled(void);
 int msi_get_region_count(void);
 int msi_get_region(int region_num, struct msi_region *region);
+int msi_set_iova(struct pci_dev *pdev, int region_num,
+		 dma_addr_t iova, bool set);
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
-- 
1.7.0.4
