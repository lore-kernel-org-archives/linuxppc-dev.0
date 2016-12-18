Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3th60h0lBRzDwGV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Dec 2016 12:29:39 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v2 00/11] powerpc/kvm/vfio: Enable in-kernel
 acceleration
Date: Sun, 18 Dec 2016 12:28:49 +1100
Message-Id: <20161218012900.18142-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is my current queue of patches to add acceleration of TCE
updates in KVM.

This is based on a merge of the "next" branch of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
and the "next" of https://github.com/awilliam/linux-vfio.git
and pushed to https://github.com/aik/linux.git , vfio-kvm-next branch.

Changes:
v2:
* 11/11 reworked to use new notifiers, it is rather RFC as it still has
a issue;
* got 09/11, 10/11 to use notifiers in 11/11;
* added rb: David to most of patches and added a comment in 05/11.

Please comment. Thanks.

Alexey Kardashevskiy (11):
  KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO capability number
  powerpc/iommu: Cleanup iommu_table disposal
  powerpc/vfio_spapr_tce: Add reference counting to iommu_table
  powerpc/mmu: Add real mode support for IOMMU preregistered memory
  KVM: PPC: Use preregistered memory API to access TCE list
  powerpc/powernv/iommu: Add real mode version of
    iommu_table_ops::exchange()
  KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64 permanently
  KVM: PPC: Pass kvm* to kvmppc_find_table()
  vfio iommu: Add helpers to (un)register blocking notifiers per group
  vfio: Check for unregistered notifiers when group is actually released
  KVM: PPC: Add in-kernel acceleration for VFIO

 Documentation/virtual/kvm/devices/vfio.txt |  22 +-
 arch/powerpc/include/asm/iommu.h           |  12 +-
 arch/powerpc/include/asm/kvm_host.h        |  11 +
 arch/powerpc/include/asm/kvm_ppc.h         |   6 +-
 arch/powerpc/include/asm/mmu_context.h     |   4 +
 include/linux/vfio.h                       |   6 +
 include/uapi/linux/kvm.h                   |   9 +
 arch/powerpc/kernel/iommu.c                |  49 +++-
 arch/powerpc/kvm/book3s_64_vio.c           | 359 ++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c        | 256 ++++++++++++++++++--
 arch/powerpc/kvm/powerpc.c                 |   2 +
 arch/powerpc/mm/mmu_context_iommu.c        |  39 ++++
 arch/powerpc/platforms/powernv/pci-ioda.c  |  42 +++-
 arch/powerpc/platforms/powernv/pci.c       |   1 +
 arch/powerpc/platforms/pseries/iommu.c     |   3 +-
 arch/powerpc/platforms/pseries/vio.c       |   2 +-
 drivers/vfio/vfio.c                        |  81 ++++++-
 drivers/vfio/vfio_iommu_spapr_tce.c        |   2 +-
 virt/kvm/vfio.c                            |  82 +++++++
 arch/powerpc/kvm/Kconfig                   |   1 +
 20 files changed, 939 insertions(+), 50 deletions(-)

-- 
2.11.0
