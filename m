Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qw07q52JbzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:46:15 +1000 (AEST)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 18:16:13 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3RCkBfO25952276
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 18:16:11 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3RCk0gA014665
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 18:16:10 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
 alistair@popple.id.au, ruscur@russell.cc,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH 2/5] iommu: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have
 capability of IRQ remapping
Date: Wed, 27 Apr 2016 20:43:27 +0800
Message-Id: <1461761010-5452-3-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The capability of IRQ remapping is abstracted on IOMMU side on
some archs. There is a existing flag IOMMU_CAP_INTR_REMAP for this.

To have a universal flag to test this capability for different
archs on PCI side, we set PCI_BUS_FLAGS_MSI_REMAP for PCI buses
when IOMMU_CAP_INTR_REMAP is set.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/iommu/iommu.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0e3b009..5d2b6f6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -813,6 +813,16 @@ struct iommu_group *pci_device_group(struct device *dev)
 	return group;
 }
 
+static void pci_check_msi_remapping(struct pci_dev *pdev,
+					const struct iommu_ops *ops)
+{
+	struct pci_bus *bus = pdev->bus;
+
+	if (ops->capable(IOMMU_CAP_INTR_REMAP) &&
+		!(bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP))
+		bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
@@ -871,6 +881,9 @@ static int add_iommu_group(struct device *dev, void *data)
 	const struct iommu_ops *ops = cb->ops;
 	int ret;
 
+	if (dev_is_pci(dev) && ops->capable)
+		pci_check_msi_remapping(to_pci_dev(dev), ops);
+
 	if (!ops->add_device)
 		return 0;
 
@@ -913,6 +926,8 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 	 * result in ADD/DEL notifiers to group->notifier
 	 */
 	if (action == BUS_NOTIFY_ADD_DEVICE) {
+		if (dev_is_pci(dev) && ops->capable)
+			pci_check_msi_remapping(to_pci_dev(dev), ops);
 		if (ops->add_device)
 			return ops->add_device(dev);
 	} else if (action == BUS_NOTIFY_REMOVED_DEVICE) {
-- 
1.7.9.5
