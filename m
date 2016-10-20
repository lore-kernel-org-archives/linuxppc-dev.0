Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3szttr5HPbzDt1D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 14:04:04 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH kernel v3 0/4] powerpc/spapr/vfio: Put pages on VFIO container
 shutdown
Date: Thu, 20 Oct 2016 14:03:46 +1100
Message-Id: <1476932630-45323-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches are to fix a bug when pages stay pinned hours
after QEMU which requested pinning exited. This time 4 patches
for easier reviewing.

Please comment. Thanks.


Alexey Kardashevskiy (4):
  powerpc/iommu: Pass mm_struct to init/cleanup helpers
  powerpc/iommu: Stop using @current in mm_iommu_xxx
  vfio/spapr: Cache mm in tce_container
  powerpc/mm/iommu, vfio/spapr: Put pages on VFIO container shutdown

 arch/powerpc/include/asm/mmu_context.h |  20 ++--
 arch/powerpc/kernel/setup-common.c     |   2 +-
 arch/powerpc/mm/mmu_context_book3s64.c |   6 +-
 arch/powerpc/mm/mmu_context_iommu.c    |  60 ++++-------
 drivers/vfio/vfio_iommu_spapr_tce.c    | 180 +++++++++++++++++++++++----------
 5 files changed, 156 insertions(+), 112 deletions(-)

-- 
2.5.0.rc3
