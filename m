Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDHp6NLWzDqPH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:36:54 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YEcD078228
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:53 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452at76sx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:53 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:36:52 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8_set2 00/13] TLB flush changes 
Date: Wed, 13 Jul 2016 15:06:31 +0530
Message-Id: <1468402604-5130-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patch series add changes to support tracking page size during tlb flush
and use the same in ppc64 so that we can do a tlbie with va range. First
three patches are already in -mm tree.

Aneesh Kumar K.V (13):
  mm/hugetlb: Simplify hugetlb unmap
  mm: Change the interface for __tlb_remove_page
  mm/mmu_gather: Track page size with mmu gather and force flush if page
    size change
  powerpc/mm/radix: Implement tlb mmu gather flush efficiently
  powerpc/mm: Make MMU_FTR_RADIX a MMU family feature
  powerpc/mm/hash: Add helper for finding SLBE LLP encoding
  powerpc/mm: Use hugetlb flush functions
  powerpc/mm: Drop multiple definition of mm_is_core_local
  powerpc/mm/radix: Add tlb flush of THP ptes
  powerpc/mm/radix: Rename function and drop unused arg
  powerpc/mm/radix/hugetlb: Add helper for finding page size from hstate
  powerpc/mm/hugetlb: Add flush_hugetlb_tlb_range
  powerpc/mm: remove flush_tlb_page_nohash

 arch/arm/include/asm/tlb.h                         | 29 ++++++-
 arch/ia64/include/asm/tlb.h                        | 31 ++++++--
 arch/powerpc/include/asm/book3s/64/hugetlb-radix.h | 15 ++++
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |  9 +++
 arch/powerpc/include/asm/book3s/64/mmu.h           |  3 +-
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  5 --
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h | 16 ++--
 arch/powerpc/include/asm/book3s/64/tlbflush.h      | 27 +++++--
 arch/powerpc/include/asm/hugetlb.h                 |  2 +-
 arch/powerpc/include/asm/kvm_book3s_64.h           |  3 +-
 arch/powerpc/include/asm/mmu.h                     | 16 ++--
 arch/powerpc/include/asm/tlb.h                     | 13 ++++
 arch/powerpc/include/asm/tlbflush.h                |  1 -
 arch/powerpc/kernel/entry_64.S                     |  2 +-
 arch/powerpc/kernel/exceptions-64s.S               |  8 +-
 arch/powerpc/kernel/prom.c                         |  4 +-
 arch/powerpc/mm/hash_native_64.c                   |  6 +-
 arch/powerpc/mm/hugetlbpage-radix.c                | 39 ++++------
 arch/powerpc/mm/pgtable-book3s64.c                 |  4 +-
 arch/powerpc/mm/pgtable.c                          |  2 +-
 arch/powerpc/mm/tlb-radix.c                        | 90 ++++++++++++++++++----
 arch/powerpc/mm/tlb_hash32.c                       | 11 ---
 arch/powerpc/mm/tlb_nohash.c                       |  6 --
 arch/s390/include/asm/tlb.h                        | 22 +++++-
 arch/sh/include/asm/tlb.h                          | 20 ++++-
 arch/um/include/asm/tlb.h                          | 20 ++++-
 include/asm-generic/tlb.h                          | 59 +++++++++++---
 mm/huge_memory.c                                   |  2 +-
 mm/hugetlb.c                                       | 64 ++++++++-------
 mm/memory.c                                        | 27 +++++--
 30 files changed, 390 insertions(+), 166 deletions(-)

-- 
2.7.4
