Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 41L83J2m1tzF1Rp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 15:01:32 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel v3 0/2] KVM: PPC: Check if IOMMU page is contained in
 the pinned physical page
Date: Wed,  4 Jul 2018 15:00:50 +1000
Message-Id: <20180704050052.20045-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is to improve page boundaries checking and should probably
be cc:stable. I came accross this while debugging nvlink2 passthrough
but the lack of checking might be exploited by the existing userspace.

Changes:
v3:
* enforced huge pages not to cross preregistered chunk boundaries

v2:
* 2/2: explicitly check for compound pages before calling compound_order()


This is based on sha1
021c917 Linus Torvalds "Linux 4.18-rc3".

Please comment. Thanks.



Alexey Kardashevskiy (2):
  vfio/spapr: Use IOMMU pageshift rather than pagesize
  KVM: PPC: Check if IOMMU page is contained in the pinned physical page

 arch/powerpc/include/asm/mmu_context.h |  4 ++--
 arch/powerpc/kvm/book3s_64_vio.c       |  2 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c    |  6 +++--
 arch/powerpc/mm/mmu_context_iommu.c    | 41 +++++++++++++++++++++++++++++++---
 drivers/vfio/vfio_iommu_spapr_tce.c    | 10 ++++-----
 5 files changed, 50 insertions(+), 13 deletions(-)

-- 
2.11.0
