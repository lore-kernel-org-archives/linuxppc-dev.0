Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3t2Rnb2WNMzDvQB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 17:53:23 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel v4 0/4] powerpc/spapr/vfio: Put pages on VFIO container
 shutdown
Date: Mon, 24 Oct 2016 17:53:06 +1100
Message-Id: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
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

Please comment. Thanks.

Alexey Kardashevskiy (4):
  powerpc/iommu: Pass mm_struct to init/cleanup helpers
  powerpc/iommu: Stop using @current in mm_iommu_xxx
  vfio/spapr: Reference mm in tce_container
  powerpc/mm/iommu, vfio/spapr: Put pages on VFIO container shutdown

 arch/powerpc/include/asm/mmu_context.h |  20 ++--
 arch/powerpc/kernel/setup-common.c     |   2 +-
 arch/powerpc/mm/mmu_context_book3s64.c |   6 +-
 arch/powerpc/mm/mmu_context_iommu.c    |  60 ++++-------
 drivers/vfio/vfio_iommu_spapr_tce.c    | 181 ++++++++++++++++++++++-----------
 5 files changed, 154 insertions(+), 115 deletions(-)

-- 
2.5.0.rc3
