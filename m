Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKxlH0xd3zDqcF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 16:14:34 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 00:14:33 -0600
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, alistair@popple.id.au, ruscur@russell.cc,
 kevin.tian@intel.com, David.Laight@ACULAB.COM
Subject: [RESEND PATCH v2 4/6] iommu: Set PCI_BUS_FLAGS_MSI_REMAP on iommu
 driver initialization
Date: Thu,  2 Jun 2016 14:10:01 +0800
Message-Id: <1464847803-22756-5-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1464847803-22756-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464847803-22756-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some iommu drivers would be initialized after PCI device
enumeration. So PCI_BUS_FLAGS_MSI_REMAP would not be set
when probing PCI devices although IOMMU enables capability
of IRQ remapping. This patch tests this capability and
set the flag when iommu driver is initialized.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/iommu/iommu.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b9df141..e6159ab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -872,6 +872,14 @@ static int add_iommu_group(struct device *dev, void *data)
 	const struct iommu_ops *ops = cb->ops;
 	int ret;
 
+	/*
+	 * Set PCI_BUS_FLAGS_MSI_REMAP for all PCI buses when IOMMU
+	 * have capability of IRQ remapping.
+	 */
+	if (dev_is_pci(dev) && ops->capable &&
+			ops->capable(IOMMU_CAP_INTR_REMAP))
+		to_pci_dev(dev)->bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
+
 	if (!ops->add_device)
 		return 0;
 
-- 
1.7.9.5
