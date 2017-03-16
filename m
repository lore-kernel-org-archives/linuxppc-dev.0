Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkPtR73YhzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:32:31 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GANhMb136284
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:32:24 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2978e6k0fb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:32:23 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 06:32:23 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 00/11] powerpc/mm/hash: Cleanup and fixes
Date: Thu, 16 Mar 2017 16:01:58 +0530
Message-Id: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This series collect all the different patches sent before into one patch series.
The patch series is also rebased  on top of latest upstream linus.
It also contain fixes to the patches posted earlier.

Aneesh Kumar K.V (11):
  powerpc/mm/nohash: MM_SLICE is only used by book3s 64
  powerpc/mm/slice: when computing slice mask limit lowe slice max addr
    correctly
  powerpc/mm: Cleanup bits definition between hash and radix.
  powerpc/mm/radix: rename _PAGE_LARGE to R_PAGE_LARGE
  powerpc/mm: Add translation mode information in /proc/cpuinfo
  powerpc/mm/hugetlb: Filter out hugepage size not supported by page
    table layout
  powerpc/mm: Conditional defines of pte bits are messy
  powerpc/mm: Express everything based on Radix page table defines
  powerpc/mm: Lower the max real address to 51 bits
  powerpc/mm/radix: Make max pfn bits a variable
  powerpc/mm: Move hash specific pte bits to be top bits of RPN

 arch/powerpc/include/asm/book3s/64/hash-64k.h |  8 ++++--
 arch/powerpc/include/asm/book3s/64/hash.h     | 35 ++++++++++++++++--------
 arch/powerpc/include/asm/book3s/64/hugetlb.h  |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 39 ++++++++++++++++-----------
 arch/powerpc/include/asm/book3s/64/radix.h    | 12 ++++++++-
 arch/powerpc/include/asm/mmu-book3e.h         |  5 ----
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  5 ----
 arch/powerpc/mm/hash_native_64.c              |  1 +
 arch/powerpc/mm/hash_utils_64.c               |  1 +
 arch/powerpc/mm/hugetlbpage-book3e.c          |  7 -----
 arch/powerpc/mm/hugetlbpage.c                 | 20 ++++++++++++++
 arch/powerpc/mm/mmu_context_nohash.c          |  5 ----
 arch/powerpc/mm/pgtable-radix.c               |  1 +
 arch/powerpc/mm/pgtable_64.c                  |  3 +++
 arch/powerpc/mm/slice.c                       |  5 ++--
 arch/powerpc/mm/tlb-radix.c                   |  2 +-
 arch/powerpc/platforms/Kconfig.cputype        |  2 +-
 arch/powerpc/platforms/powernv/setup.c        |  4 +++
 arch/powerpc/platforms/pseries/setup.c        |  4 +++
 19 files changed, 103 insertions(+), 58 deletions(-)

-- 
2.7.4
