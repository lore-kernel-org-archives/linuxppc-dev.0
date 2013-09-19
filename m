Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E57B2C014E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 17:37:14 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <alex.williamson@redhat.com>, <joro@8bytes.org>,
 <benh@kernel.crashing.org>, <galak@kernel.crashing.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-pci@vger.kernel.org>, <agraf@suse.de>, <scottwood@freescale.com>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH 3/7] fsl iommu: add get_dev_iommu_domain
Date: Thu, 19 Sep 2013 12:59:19 +0530
Message-ID: <1379575763-2091-4-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
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

From: Bharat Bhushan <bharat.bhushan@freescale.com>

returns the iommu_domain of the requested device for fsl pamu.

Use PCI controller dev struct for pci devices as current LIODN schema
assign LIODN to PCI controller not PCI device. This will be corrected
with proper LIODN schema.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 drivers/iommu/fsl_pamu_domain.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 14d803a..1d0dfe3 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -1140,6 +1140,35 @@ static u32 fsl_pamu_get_windows(struct iommu_domain *domain)
 	return dma_domain->win_cnt;
 }
 
+static struct iommu_domain *fsl_get_dev_domain(struct device *dev)
+{
+	struct pci_controller *pci_ctl;
+	struct device_domain_info *info;
+	struct pci_dev *pdev;
+
+	/*
+	 * Use PCI controller dev struct for pci devices as current
+	 * LIODN schema assign LIODN to PCI controller not PCI device
+	 * This should get corrected with proper LIODN schema.
+	 */
+	if (dev->bus == &pci_bus_type) {
+		pdev = to_pci_dev(dev);
+		pci_ctl = pci_bus_to_host(pdev->bus);
+		/*
+		 * make dev point to pci controller device
+		 * so we can get the LIODN programmed by
+		 * u-boot.
+		 */
+		dev = pci_ctl->parent;
+	}
+
+	info = dev->archdata.iommu_domain;
+	if (info && info->domain)
+		return info->domain->iommu_domain;
+
+	return NULL;
+}
+
 static struct iommu_ops fsl_pamu_ops = {
 	.domain_init	= fsl_pamu_domain_init,
 	.domain_destroy = fsl_pamu_domain_destroy,
@@ -1155,6 +1184,7 @@ static struct iommu_ops fsl_pamu_ops = {
 	.domain_get_attr = fsl_pamu_get_domain_attr,
 	.add_device	= fsl_pamu_add_device,
 	.remove_device	= fsl_pamu_remove_device,
+	.get_dev_iommu_domain = fsl_get_dev_domain,
 };
 
 int pamu_domain_init()
-- 
1.7.0.4
