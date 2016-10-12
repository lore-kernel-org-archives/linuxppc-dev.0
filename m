Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sv1qF31gfzDsrc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 15:59:05 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel v2 0/2] powerpc/spapr/vfio: Put pages on VFIO container
 shutdown
Date: Wed, 12 Oct 2016 15:58:26 +1100
Message-Id: <1476248308-41754-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These 2 patches are to fix a bug when pages stay pinned hours
after QEMU which requested pinning exited.

Please comment. Thanks.

Alexey Kardashevskiy (2):
  powerpc/iommu: Stop using @current in mm_iommu_xxx
  powerpc/mm/iommu, vfio/spapr: Put pages on VFIO container shutdown

 arch/powerpc/include/asm/mmu_context.h | 19 +++----
 arch/powerpc/kernel/setup-common.c     |  2 +-
 arch/powerpc/mm/mmu_context_book3s64.c |  6 +--
 arch/powerpc/mm/mmu_context_iommu.c    | 60 +++++++----------------
 drivers/vfio/vfio_iommu_spapr_tce.c    | 90 ++++++++++++++++++++++++++++------
 5 files changed, 107 insertions(+), 70 deletions(-)

-- 
2.5.0.rc3
