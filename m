Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s464F4L47zDqTk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:41:33 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 00/15] powerpc/kvm/vfio: Enable in-kernel acceleration
Date: Wed,  3 Aug 2016 18:40:41 +1000
Message-Id: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is my current queue of patches to add acceleration of TCE
updates in KVM. This has a long history and was rewritten pretty
much completely again, this time I am teaching KVM about VFIO
containers. Some patches (such as 01/15) could be posted
separately but I keep all of them here to make review easier
(if the concept turns out be wrong - then I might still want
to have 01/15).

Please comment. Thanks.


Alexey Kardashevskiy (15):
  Revert "iommu: Add a function to find an iommu group by id"
  KVM: PPC: Finish enabling VFIO KVM device on POWER
  KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO capability number
  powerpc/powernv/ioda: Fix TCE invalidate to work in real mode again
  powerpc/iommu: Stop using @current in mm_iommu_xxx
  powerpc/mm/iommu: Put pages on process exit
  powerpc/iommu: Cleanup iommu_table disposal
  powerpc/vfio_spapr_tce: Add reference counting to iommu_table
  powerpc/mmu: Add real mode support for IOMMU preregistered memory
  KVM: PPC: Use preregistered memory API to access TCE list
  powerpc/powernv/iommu: Add real mode version of
    iommu_table_ops::exchange()
  KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64 permanently
  KVM: PPC: Pass kvm* to kvmppc_find_table()
  vfio/spapr_tce: Export container API for external users
  KVM: PPC: Add in-kernel acceleration for VFIO

 arch/powerpc/include/asm/iommu.h          |  12 +-
 arch/powerpc/include/asm/kvm_host.h       |   8 +
 arch/powerpc/include/asm/kvm_ppc.h        |   2 +-
 arch/powerpc/include/asm/mmu_context.h    |  23 +-
 arch/powerpc/include/uapi/asm/kvm.h       |  12 +
 arch/powerpc/kernel/iommu.c               |  49 +++-
 arch/powerpc/kernel/setup-common.c        |   2 +-
 arch/powerpc/kernel/vio.c                 |   2 +-
 arch/powerpc/kvm/Kconfig                  |   2 +
 arch/powerpc/kvm/Makefile                 |   3 +
 arch/powerpc/kvm/book3s_64_vio.c          | 410 +++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c       | 251 ++++++++++++++++--
 arch/powerpc/kvm/powerpc.c                |   2 +
 arch/powerpc/mm/mmu_context_book3s64.c    |   6 +-
 arch/powerpc/mm/mmu_context_iommu.c       |  96 ++++---
 arch/powerpc/platforms/powernv/pci-ioda.c |  46 +++-
 arch/powerpc/platforms/powernv/pci.c      |   1 +
 arch/powerpc/platforms/pseries/iommu.c    |   3 +-
 drivers/iommu/iommu.c                     |  29 ---
 drivers/vfio/vfio.c                       |  30 +++
 drivers/vfio/vfio_iommu_spapr_tce.c       | 107 ++++++--
 include/linux/iommu.h                     |   1 -
 include/linux/vfio.h                      |   6 +
 include/uapi/linux/kvm.h                  |   1 +
 24 files changed, 959 insertions(+), 145 deletions(-)

-- 
2.5.0.rc3
