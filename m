Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tFfSV3qxgzDt0N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 23:32:26 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: [PATCH kernel v5 0/6] powerpc/spapr/vfio: Put pages on VFIO container
 shutdown
Date: Fri, 11 Nov 2016 23:32:11 +1100
Message-Id: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches are to fix a bug when pages stay pinned hours
after QEMU which requested pinning exited.

The only change to v4 is it is now 6 patches and mm is
referenced rather later than sooner.

Please comment. Thanks.

Alexey Kardashevskiy (6):
  powerpc/iommu: Pass mm_struct to init/cleanup helpers
  powerpc/iommu: Stop using @current in mm_iommu_xxx
  vfio/spapr: Postpone allocation of userspace version of TCE table
  vfio/spapr: Postpone default window creation
  vfio/spapr: Reference mm in tce_container
  powerpc/mm/iommu, vfio/spapr: Put pages on VFIO container shutdown

 arch/powerpc/include/asm/mmu_context.h |  20 ++-
 arch/powerpc/kernel/setup-common.c     |   2 +-
 arch/powerpc/mm/mmu_context_book3s64.c |   6 +-
 arch/powerpc/mm/mmu_context_iommu.c    |  60 ++-----
 drivers/vfio/vfio_iommu_spapr_tce.c    | 316 ++++++++++++++++++++++-----------
 5 files changed, 240 insertions(+), 164 deletions(-)

-- 
2.5.0.rc3
