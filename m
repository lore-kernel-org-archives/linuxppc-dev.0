Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3y26qZ6wsSzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 16:10:00 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Yongji Xie <elohimes@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Russell Currey <ruscur@russell.cc>, linux-pci@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH kernel] powerpc/powernv: Reserve a hole which appears after
 enabling IOV
Date: Wed, 27 Sep 2017 16:09:49 +1000
Message-Id: <20170927060949.10284-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to make generic IOV code work, the physical function IOV BAR
should start from offset of the first VF. Since M64 segments share
PE number space across PHB, and some PEs may be in use at the time
when IOV is enabled, the existing code shifts the IOV BAR to the index
of the first PE/VF. This creates a hole in IOMEM space which can be
potentially taken by some other device.

This reserves a temporary hole on a parent and releases it when IOV is
disabled; the temporary resources are stored in pci_dn to avoid
kmalloc/free.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I assume this goes to powerpc next branch but before this I'd like to
get Bjorn's opinion as he continously commented on this bit.
---
 arch/powerpc/include/asm/pci-bridge.h     |  1 +
 arch/powerpc/platforms/powernv/pci-ioda.c | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 0b8aa1fe2d5f..62ed83db04ae 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -218,6 +218,7 @@ struct pci_dn {
 #endif
 	struct list_head child_list;
 	struct list_head list;
+	struct resource holes[PCI_SRIOV_NUM_BARS];
 };
 
 /* Get the pointer to a device_node's pci_dn */
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 57f9e55f4352..d01c1ac02ea4 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1002,9 +1002,12 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 	}
 
 	/*
-	 * After doing so, there would be a "hole" in the /proc/iomem when
-	 * offset is a positive value. It looks like the device return some
-	 * mmio back to the system, which actually no one could use it.
+	 * Since M64 BAR shares segments among all possible 256 PEs,
+	 * we have to shift the beginning of PF IOV BAR to make it start from
+	 * the segment which belongs to the PE number assigned to the first VF.
+	 * This creates a "hole" in the /proc/iomem which could be used for
+	 * allocating other resources so we reserve this area below and
+	 * release when IOV is released.
 	 */
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
@@ -1019,6 +1022,18 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 			 i, &res2, res, (offset > 0) ? "En" : "Dis",
 			 num_vfs, offset);
 		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
+
+		if (offset > 0) {
+			pdn->holes[i].start = res2.start;
+			pdn->holes[i].end = res2.start + size * offset - 1;
+			pdn->holes[i].flags = IORESOURCE_BUS;
+			pdn->holes[i].name = "pnv_iov_reserved";
+			devm_request_resource(&dev->dev, res->parent,
+					&pdn->holes[i]);
+		} else {
+			devm_release_resource(&dev->dev, &pdn->holes[i]);
+			memset(&pdn->holes[i], 0, sizeof(pdn->holes[i]));
+		}
 	}
 	return 0;
 }
-- 
2.11.0
