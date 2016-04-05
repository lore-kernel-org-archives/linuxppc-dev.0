Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfVYj5V4szDqgC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 23:48:25 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Tue, 5 Apr 2016 23:48:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 14C692BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 23:48:00 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u35DlkJO15401026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 23:48:00 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u35DlLV6013219
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 23:47:22 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 alex.williamson@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 eric.auger@linaro.org, will.deacon@arm.com, gwshan@linux.vnet.ibm.com,
 alistair@popple.id.au, ruscur@russell.cc,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC v5 6/7] PCI: Add a new bit to pci_bus_flags to indicate
 interrupt remapping
Date: Tue,  5 Apr 2016 21:46:43 +0800
Message-Id: <1459864004-2869-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm trying to find a proper way to indicate
the capability of interrupt remapping on PPC64
because we need this to determine whether it is
safe to mmap MSI-X table in VFIO driver.

There is a existing flag for this in the IOMMU
space:

enum iommu_cap {
	IOMMU_CAP_CACHE_COHERENCY,
--->    IOMMU_CAP_INTR_REMAP,
	IOMMU_CAP_NOEXEC,
};

But it seems to be not a good idea to use
bus_set_iommu() to add this flag on PPC64 which
never set/use iommu_ops.

Eric also posted a patchset [1] to abstract
this capability on MSI controller side for ARM.
But I found we also never use msi_domain_info
on PPC64. We have to rework the MSI code on
PPC64 to support msi_domain_ops if we want to
use msi_domain_info.

Then I noticed that interrupt remapping is
abstracted on PCI host bridge side on PPC64.
So I'm thinking whether we could add a new
bit to pci_bus_flags to indicate this
capability, like this patch does.

Compared with IOMMU_CAP_INTR_REMAP, this
flag is more common. Any arch can set/use this
easily. And it can provide a better granularity
(pci_bus_type -> pci_bus).

[1] http://www.spinics.net/lists/kvm/msg130262.html

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    8 ++++++++
 include/linux/pci.h                       |    1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f90dc04..9557638 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3080,6 +3080,12 @@ static void pnv_pci_ioda_fixup(void)
 	pnv_npu_ioda_fixup();
 }
 
+int pnv_pci_ioda_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
+	return 0;
+}
+
 /*
  * Returns the alignment for I/O or memory windows for P2P
  * bridges. That actually depends on how PEs are segmented.
@@ -3364,6 +3370,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 
+	ppc_md.pcibios_root_bridge_prepare = pnv_pci_ioda_root_bridge_prepare;
+
 	if (phb->type == PNV_PHB_NPU)
 		hose->controller_ops = pnv_npu_ioda_controller_ops;
 	else
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27df4a6..741dcaf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -193,6 +193,7 @@ typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MSI   = (__force pci_bus_flags_t) 1,
 	PCI_BUS_FLAGS_NO_MMRBC = (__force pci_bus_flags_t) 2,
+	PCI_BUS_FLAGS_MSI_REMAP = (__force pci_bus_flags_t) 3,
 };
 
 /* These values come from the PCI Express Spec */
-- 
1.7.9.5
