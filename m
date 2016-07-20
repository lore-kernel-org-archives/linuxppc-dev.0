Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rvPGR3H6PzDqTX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 14:35:11 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Balbir Singh <bsingharora@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH kernel v2 0/2] powerpc/mm/iommu: Put pages on process exit
Date: Wed, 20 Jul 2016 14:34:29 +1000
Message-Id: <1468989271-753-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a fix to a bug when guest memory stays Active
after QEMU process exited. This happened because the QEMU memory context
was not released in a short period of time after QEMU process exited.
More details are in the commit logs.

Please comment. Thanks.

Alexey Kardashevskiy (2):
  powerpc/iommu: Stop using @current in mm_iommu_xxx
  powerpc/mm/iommu: Put pages on process exit

 arch/powerpc/include/asm/mmu_context.h | 16 +++---
 arch/powerpc/mm/mmu_context_book3s64.c |  4 --
 arch/powerpc/mm/mmu_context_iommu.c    | 55 +++++++--------------
 drivers/vfio/vfio_iommu_spapr_tce.c    | 89 ++++++++++++++++++++++++++++------
 4 files changed, 100 insertions(+), 64 deletions(-)

-- 
2.5.0.rc3
