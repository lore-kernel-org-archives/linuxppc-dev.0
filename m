Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 678A62C0135
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 17:37:07 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <alex.williamson@redhat.com>, <joro@8bytes.org>,
 <benh@kernel.crashing.org>, <galak@kernel.crashing.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-pci@vger.kernel.org>, <agraf@suse.de>, <scottwood@freescale.com>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH 2/7] iommu: add api to get iommu_domain of a device
Date: Thu, 19 Sep 2013 12:59:18 +0530
Message-ID: <1379575763-2091-3-git-send-email-Bharat.Bhushan@freescale.com>
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

This api return the iommu domain to which the device is attached.
The iommu_domain is required for making API calls related to iommu.
Follow up patches which use this API to know iommu maping.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 drivers/iommu/iommu.c |   10 ++++++++++
 include/linux/iommu.h |    7 +++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fbe9ca7..6ac5f50 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -696,6 +696,16 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device);
 
+struct iommu_domain *iommu_get_dev_domain(struct device *dev)
+{
+	struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (unlikely(ops == NULL || ops->get_dev_iommu_domain == NULL))
+		return NULL;
+
+	return ops->get_dev_iommu_domain(dev);
+}
+EXPORT_SYMBOL_GPL(iommu_get_dev_domain);
 /*
  * IOMMU groups are really the natrual working unit of the IOMMU, but
  * the IOMMU API works on domains and devices.  Bridge that gap by
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7ea319e..fa046bd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -127,6 +127,7 @@ struct iommu_ops {
 	int (*domain_set_windows)(struct iommu_domain *domain, u32 w_count);
 	/* Get the numer of window per domain */
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
+	struct iommu_domain *(*get_dev_iommu_domain)(struct device *dev);
 
 	unsigned long pgsize_bitmap;
 };
@@ -190,6 +191,7 @@ extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 				      phys_addr_t offset, u64 size,
 				      int prot);
 extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr);
+extern struct iommu_domain *iommu_get_dev_domain(struct device *dev);
 /**
  * report_iommu_fault() - report about an IOMMU fault to the IOMMU framework
  * @domain: the iommu domain where the fault has happened
@@ -284,6 +286,11 @@ static inline void iommu_domain_window_disable(struct iommu_domain *domain,
 {
 }
 
+static inline struct iommu_domain *iommu_get_dev_domain(struct device *dev)
+{
+	return NULL;
+}
+
 static inline phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
 	return 0;
-- 
1.7.0.4
