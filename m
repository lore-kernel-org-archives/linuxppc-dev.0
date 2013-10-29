Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0A462C009A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:34:27 +1100 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <alex.williamson@redhat.com>, <joro@8bytes.org>,
 <galak@kernel.crashing.org>, <scottwood@freescale.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-pci@vger.kernel.org>, <agraf@suse.de>, <stuart.yoder@freescale.com>
Subject: [PATCH 4/5 RFC] pci: msi: expose msi region information functions
Date: Tue, 29 Oct 2013 16:57:38 +0530
Message-ID: <1383046062-16520-2-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1383046062-16520-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1383046062-16520-1-git-send-email-Bharat.Bhushan@freescale.com>
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

So by now we have defined all the interfaces for getting the msi region,
this patch expose the interface to linux subsystem. These will be used by
vfio subsystem for setting up iommu for MSI interrupt of direct assignment
devices.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 include/linux/pci.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index da172f9..c587034 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1142,6 +1142,7 @@ struct msix_entry {
 	u16	entry;	/* driver uses to specify entry, OS writes */
 };
 
+struct msi_region;
 
 #ifndef CONFIG_PCI_MSI
 static inline int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
@@ -1184,6 +1185,16 @@ static inline int pci_msi_enabled(void)
 {
 	return 0;
 }
+
+static inline int msi_get_region_count(void)
+{
+	return 0;
+}
+
+static inline int msi_get_region(int region_num, struct msi_region *region)
+{
+	return 0;
+}
 #else
 int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec);
 int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec);
@@ -1196,6 +1207,8 @@ void pci_disable_msix(struct pci_dev *dev);
 void msi_remove_pci_irq_vectors(struct pci_dev *dev);
 void pci_restore_msi_state(struct pci_dev *dev);
 int pci_msi_enabled(void);
+int msi_get_region_count(void);
+int msi_get_region(int region_num, struct msi_region *region);
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
-- 
1.7.0.4
