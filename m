Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 41N7WS2B9kzDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2018 20:44:19 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH kernel v5 0/2] KVM: PPC: Check if IOMMU page is contained in
 the pinned physical page
Date: Sat,  7 Jul 2018 20:44:08 +1000
Message-Id: <20180707104410.46589-1-aik@ozlabs.ru>
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

The get_user_pages() comment says it should be "phased out" but the only
alternative seems to be get_user_pages_longterm(), should that be used
instead (this is longterm reference elevation, however it is not DAX,
whatever this implies)? get_user_pages_remote() seems unnecessarily
complicated because of @locked.


Changes:
v5:
* 2/2: changed compound pages handling

v4:
* 2/2: implemented less strict but still safe max pageshift as David suggested

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
 arch/powerpc/kvm/book3s_64_vio_hv.c    |  6 ++++--
 arch/powerpc/mm/mmu_context_iommu.c    | 33 +++++++++++++++++++++++++++------
 drivers/vfio/vfio_iommu_spapr_tce.c    | 10 +++++-----
 5 files changed, 39 insertions(+), 16 deletions(-)

-- 
2.11.0
