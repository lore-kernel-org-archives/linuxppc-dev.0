Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xQqCF4XY1zDqnn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 17:38:31 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jike Song <jike.song@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Neo Jia <cjia@nvidia.com>, Paul Mackerras <paulus@samba.org>,
 Vlad Tsyrklevich <vlad@tsyrklevich.net>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 2/5] iommu: Set IOMMU_GROUP_CAP_ISOLATE_MSIX if MSI
 controller enables IRQ remapping
Date: Mon,  7 Aug 2017 17:25:45 +1000
Message-Id: <20170807072548.3023-3-aik@ozlabs.ru>
In-Reply-To: <20170807072548.3023-1-aik@ozlabs.ru>
References: <20170807072548.3023-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This sets IOMMU_GROUP_CAP_ISOLATE_MSIX to a group if MSI remapping is
enabled on an IRQ domain; this is expected to set the capability
on ARM.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/iommu/iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6b2c34fe2c3d..e720e90fa93c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -32,6 +32,7 @@
 #include <linux/pci.h>
 #include <linux/bitops.h>
 #include <linux/property.h>
+#include <linux/irqdomain.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -1028,6 +1029,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct iommu_group *group;
 	int ret;
+	struct irq_domain *d = dev_get_msi_domain(dev);
 
 	group = iommu_group_get(dev);
 	if (group)
@@ -1070,6 +1072,11 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 		return ERR_PTR(ret);
 	}
 
+	if (d && irq_domain_is_msi(d) &&
+			irq_domain_hierarchical_is_msi_remap(d))
+		iommu_group_set_caps(group, 0,
+				IOMMU_GROUP_CAP_ISOLATE_MSIX);
+
 	return group;
 }
 
-- 
2.11.0
