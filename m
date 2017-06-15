Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wpBMF3yjrzDqMG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 15:07:21 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongji Xie <elohimes@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel 1/3] PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
Date: Thu, 15 Jun 2017 15:06:40 +1000
Message-Id: <20170615050642.8197-2-aik@ozlabs.ru>
In-Reply-To: <20170615050642.8197-1-aik@ozlabs.ru>
References: <20170615050642.8197-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yongji Xie <xyjxie@linux.vnet.ibm.com>

We introduce a new pci_bus_flags, PCI_BUS_FLAGS_MSI_REMAP
which indicates interrupts of all devices on the bus are
managed by the hardware enabling IRQ remapping(intel naming).
When the capability is enabled, a given PCI device can only
shoot the MSIs assigned for it. In other words, the hardware
can protect system from invalid MSIs of the device by checking
the target address and data when there is something wrong
with MSI part in device or device driver.

There is a existing flag for this capability in the IOMMU space:

enum iommu_cap {
	IOMMU_CAP_CACHE_COHERENCY,
--->	IOMMU_CAP_INTR_REMAP,
	IOMMU_CAP_NOEXEC,
};

and Eric also posted a patchset [1] to abstract it on MSI
controller side for ARM. But it would make sense to have a
more common flag like PCI_BUS_FLAGS_MSI_REMAP so that we can
use a universal flag to test this capability on PCI side for
different archs.

With this flag enabled, we can easily know whether it's safe
to expose MSI-X tables of PCI BARs to userspace. Some usespace
drivers such as VFIO may benefit from this.

[1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8039f9f0ca05..2c6dbb3dd0da 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -200,6 +200,7 @@ enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MSI	= (__force pci_bus_flags_t) 1,
 	PCI_BUS_FLAGS_NO_MMRBC	= (__force pci_bus_flags_t) 2,
 	PCI_BUS_FLAGS_NO_AERSID	= (__force pci_bus_flags_t) 4,
+	PCI_BUS_FLAGS_MSI_REMAP = (__force pci_bus_flags_t) 8,
 };
 
 /* These values come from the PCI Express Spec */
-- 
2.11.0
