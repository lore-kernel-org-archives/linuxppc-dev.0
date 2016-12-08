Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tZ7Zx1RDyzDw4B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 19:20:08 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 0/9] powerpc/kvm/vfio: Enable in-kernel acceleration
Date: Thu,  8 Dec 2016 19:19:47 +1100
Message-Id: <20161208081956.26221-1-aik@ozlabs.ru>
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

This is based on the "next" branch of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git

I am not doing changelog here as it is 4 months since last respin
and I am sure everybody lost the context anyway, I tried to be
as detailed as I could in the very last patch, others are
pretty trivial anyway.

Please comment. Thanks.


Alexey Kardashevskiy (9):
  KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO capability number
  powerpc/iommu: Cleanup iommu_table disposal
  powerpc/vfio_spapr_tce: Add reference counting to iommu_table
  powerpc/mmu: Add real mode support for IOMMU preregistered memory
  KVM: PPC: Use preregistered memory API to access TCE list
  powerpc/powernv/iommu: Add real mode version of
    iommu_table_ops::exchange()
  KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64 permanently
  KVM: PPC: Pass kvm* to kvmppc_find_table()
  KVM: PPC: Add in-kernel acceleration for VFIO

 Documentation/virtual/kvm/devices/vfio.txt |  21 +-
 arch/powerpc/include/asm/iommu.h           |  12 +-
 arch/powerpc/include/asm/kvm_host.h        |   8 +
 arch/powerpc/include/asm/kvm_ppc.h         |   7 +-
 arch/powerpc/include/asm/mmu_context.h     |   4 +
 include/uapi/linux/kvm.h                   |   9 +
 arch/powerpc/kernel/iommu.c                |  49 ++++-
 arch/powerpc/kvm/book3s_64_vio.c           | 309 ++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c        | 256 ++++++++++++++++++++++--
 arch/powerpc/kvm/powerpc.c                 |   2 +
 arch/powerpc/mm/mmu_context_iommu.c        |  39 ++++
 arch/powerpc/platforms/powernv/pci-ioda.c  |  42 +++-
 arch/powerpc/platforms/powernv/pci.c       |   1 +
 arch/powerpc/platforms/pseries/iommu.c     |   3 +-
 arch/powerpc/platforms/pseries/vio.c       |   2 +-
 drivers/vfio/vfio_iommu_spapr_tce.c        |   2 +-
 virt/kvm/vfio.c                            | 108 ++++++++++
 arch/powerpc/kvm/Kconfig                   |   1 +
 18 files changed, 828 insertions(+), 47 deletions(-)

-- 
2.11.0
