Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9NkD2BngzDqkK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:59:00 +1000 (AEST)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:28:58 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 06DBAE0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:32:08 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7wsPD30998534
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:54 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7wqg9006568
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:53 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 0/7] TLB flush update for radix
Date: Thu, 19 May 2016 13:28:43 +0530
Message-Id: <1463644730-10946-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patch series introduce range based tlb flush and use the same for radix
implementation. We still need to handle the mmu_gather related tlb flush.
That will be done in a later patch.

Aneesh Kumar K.V (7):
  powerpc/mm: Use hugetlb flush functions
  powerpc/mm: Drop multiple definition of mm_is_core_local
  powerpc/mm/radix: Add tlb flush of THP ptes
  powerpc/mm/radix: Rename function and drop unused arg
  powerpc/mm/radix/hugetlb: Add helper for finding page size from hstate
  powerpc/mm/hugetlb: Add flush_hugetlb_tlb_range
  powerpc/mm: remove flush_tlb_page_nohash

 arch/powerpc/include/asm/book3s/64/hugetlb-radix.h | 15 +++++
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  5 --
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h | 16 +++--
 arch/powerpc/include/asm/book3s/64/tlbflush.h      | 27 +++++---
 arch/powerpc/include/asm/hugetlb.h                 |  2 +-
 arch/powerpc/include/asm/tlb.h                     | 13 ++++
 arch/powerpc/include/asm/tlbflush.h                |  1 -
 arch/powerpc/mm/hugetlbpage-radix.c                | 39 +++++------
 arch/powerpc/mm/pgtable-book3s64.c                 |  4 +-
 arch/powerpc/mm/pgtable.c                          |  2 +-
 arch/powerpc/mm/tlb-radix.c                        | 78 ++++++++++++++++++----
 arch/powerpc/mm/tlb_hash32.c                       | 11 ---
 arch/powerpc/mm/tlb_nohash.c                       |  6 --
 mm/hugetlb.c                                       | 10 ++-
 14 files changed, 152 insertions(+), 77 deletions(-)

-- 
2.7.4
