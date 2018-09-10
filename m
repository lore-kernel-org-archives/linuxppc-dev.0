Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 4281SJ2f2TzF3Cg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 18:29:52 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel v2 0/6] KVM: PPC: TCE improvements
Date: Mon, 10 Sep 2018 18:29:06 +1000
Message-Id: <20180910082912.13255-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Here is my current queue of TCE/KVM patches.

1/6 is a bugfix for https://bugzilla.redhat.com/show_bug.cgi?id=1620360
2/6..5/6 are to help with testing https://bugzilla.redhat.com/show_bug.cgi?id=1613190
6/6 is a small cleanup


This is based on sha1
11da3a7 Linus Torvalds "Linux 4.19-rc3".

Please comment. Thanks.


Alex, I cc: you to keep you informed that
[RFC 1/6] did change drivers/vfio/vfio_iommu_spapr_tce.c but
this one does not.


Alexey Kardashevskiy (6):
  KVM: PPC: Avoid marking DMA-mapped pages dirty in real mode
  KVM: PPC: Validate all tces before updating tables
  KVM: PPC: Inform the userspace about TCE update failures
  KVM: PPC: Validate TCEs against preregistered memory page sizes
  KVM: PPC: Propagate errors to the guest when failed instead of
    ignoring
  KVM: PPC: Remove redundand permission bits removal

 arch/powerpc/include/asm/book3s/64/pgtable.h |   1 -
 arch/powerpc/include/asm/iommu.h             |   2 -
 arch/powerpc/include/asm/kvm_ppc.h           |   4 +-
 arch/powerpc/include/asm/mmu_context.h       |   1 +
 arch/powerpc/kernel/iommu.c                  |  25 ------
 arch/powerpc/kvm/book3s_64_vio.c             |  89 +++++++++++++++------
 arch/powerpc/kvm/book3s_64_vio_hv.c          | 114 +++++++++++++++++----------
 arch/powerpc/mm/init_64.c                    |  49 ------------
 arch/powerpc/mm/mmu_context_iommu.c          |  34 +++++++-
 9 files changed, 170 insertions(+), 149 deletions(-)

-- 
2.11.0
