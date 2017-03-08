Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vdJDv63xvzDqY5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 14:00:47 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v7 00/10] powerpc/kvm/vfio: Enable in-kernel
 acceleration
Date: Wed,  8 Mar 2017 14:00:01 +1100
Message-Id: <20170308030011.26780-1-aik@ozlabs.ru>
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

This is based on Linus'es tree sha1 c1ae3cfa0e89 v4.11-rc1.

Please comment. Thanks.

Changes:
v7:
* added realmode's WARN_ON_ONCE_RM in arch/powerpc/kvm/book3s_64_vio_hv.c

v6:
* reworked the last patch in terms of error handling and parameters checking

v5:
* replaced "KVM: PPC: Separate TCE validation from update" with
"KVM: PPC: iommu: Unify TCE checking"
* changed already reviewed "powerpc/iommu/vfio_spapr_tce: Cleanup iommu_table disposal"
* reworked "KVM: PPC: VFIO: Add in-kernel acceleration for VFIO"
* more details in individual commit logs

v4:
* addressed comments from v3
* updated subject lines with correct component names
* regrouped the patchset in order:
	- powerpc fixes;
	- vfio_spapr_tce driver fixes;
	- KVM/PPC fixes;
	- KVM+PPC+VFIO;
* everything except last 2 patches have "Reviewed-By: David"

v3:
* there was no full repost, only last patch was posted

v2:
* 11/11 reworked to use new notifiers, it is rather RFC as it still has
a issue;
* got 09/11, 10/11 to use notifiers in 11/11;
* added rb: David to most of patches and added a comment in 05/11.


Alexey Kardashevskiy (10):
  powerpc/mmu: Add real mode support for IOMMU preregistered memory
  powerpc/powernv/iommu: Add real mode version of
    iommu_table_ops::exchange()
  powerpc/iommu/vfio_spapr_tce: Cleanup iommu_table disposal
  powerpc/vfio_spapr_tce: Add reference counting to iommu_table
  KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO capability number
  KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64 permanently
  KVM: PPC: Pass kvm* to kvmppc_find_table()
  KVM: PPC: Use preregistered memory API to access TCE list
  KVM: PPC: iommu: Unify TCE checking
  KVM: PPC: VFIO: Add in-kernel acceleration for VFIO

 Documentation/virtual/kvm/devices/vfio.txt |  22 +-
 arch/powerpc/include/asm/iommu.h           |  32 ++-
 arch/powerpc/include/asm/kvm_host.h        |   8 +
 arch/powerpc/include/asm/kvm_ppc.h         |  12 +-
 arch/powerpc/include/asm/mmu_context.h     |   4 +
 include/uapi/linux/kvm.h                   |   9 +
 arch/powerpc/kernel/iommu.c                |  86 +++++---
 arch/powerpc/kvm/book3s_64_vio.c           | 329 ++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c        | 292 ++++++++++++++++++++-----
 arch/powerpc/kvm/powerpc.c                 |   2 +
 arch/powerpc/mm/mmu_context_iommu.c        |  39 ++++
 arch/powerpc/platforms/powernv/pci-ioda.c  |  46 ++--
 arch/powerpc/platforms/powernv/pci.c       |   1 +
 arch/powerpc/platforms/pseries/iommu.c     |   3 +-
 arch/powerpc/platforms/pseries/vio.c       |   2 +-
 drivers/vfio/vfio_iommu_spapr_tce.c        |   2 +-
 virt/kvm/vfio.c                            |  60 ++++++
 arch/powerpc/kvm/Kconfig                   |   1 +
 18 files changed, 843 insertions(+), 107 deletions(-)

-- 
2.11.0
