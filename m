Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 86A782C007E
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jan 2014 14:36:34 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 12 Jan 2014 20:36:32 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BA3AC1FF001A
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Jan 2014 20:36:00 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0D3aUhJ4587798
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jan 2014 04:36:30 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0D3aUKm019125
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Jan 2014 20:36:30 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/iommu: Don't detach device without IOMMU group
Date: Mon, 13 Jan 2014 11:36:22 +0800
Message-Id: <1389584182-6349-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some devices, for example PCI root port, don't have IOMMU table and
group. We needn't detach them from their IOMMU group. Otherwise, it
potentially incurs kernel crash because of referring NULL IOMMU group
as following backtrace indicates:

  .iommu_group_remove_device+0x74/0x1b0
  .iommu_bus_notifier+0x94/0xb4
  .notifier_call_chain+0x78/0xe8
  .__blocking_notifier_call_chain+0x7c/0xbc
  .blocking_notifier_call_chain+0x38/0x48
  .device_del+0x50/0x234
  .pci_remove_bus_device+0x88/0x138
  .pci_stop_and_remove_bus_device+0x2c/0x40
  .pcibios_remove_pci_devices+0xcc/0xfc
  .pcibios_remove_pci_devices+0x3c/0xfc

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/iommu.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 572bb5b..8a49424 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1137,6 +1137,17 @@ static int iommu_add_device(struct device *dev)
 
 static void iommu_del_device(struct device *dev)
 {
+	/*
+	 * Some devices might not have IOMMU table and group
+	 * and we needn't detach them from the associated
+	 * IOMMU groups
+	 */
+	if (!dev->iommu_group) {
+		pr_debug("iommu_tce: skipping device %s with no tbl\n",
+			 dev_name(dev));
+		return;
+	}
+
 	iommu_group_remove_device(dev);
 }
 
-- 
1.7.10.4
