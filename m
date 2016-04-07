Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgWZs6LlKzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 15:37:57 +1000 (AEST)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 7 Apr 2016 11:07:54 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u375bqeS7143892
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 11:07:52 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u375biSI005961
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 11:07:50 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 dave.hansen@intel.com, aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH 00/10] Enable HugeTLB page migration on POWER
Date: Thu,  7 Apr 2016 11:07:34 +0530
Message-Id: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series enables HugeTLB page migration on POWER platform.
This series has some core VM changes (patch 1, 2, 3) and some powerpc
specific changes (patch 4, 5, 6, 7, 8, 9, 10). Comments, suggestions
and inputs are welcome.

Anshuman Khandual (10):
  mm/mmap: Replace SHM_HUGE_MASK with MAP_HUGE_MASK inside mmap_pgoff
  mm/hugetlb: Add PGD based implementation awareness
  mm/hugetlb: Protect follow_huge_(pud|pgd) functions from race
  powerpc/hugetlb: Add ABI defines for MAP_HUGE_16MB and MAP_HUGE_16GB
  powerpc/hugetlb: Split the function 'huge_pte_alloc'
  powerpc/hugetlb: Split the function 'huge_pte_offset'
  powerpc/hugetlb: Prepare arch functions for ARCH_WANT_GENERAL_HUGETLB
  powerpc/hugetlb: Selectively enable ARCH_WANT_GENERAL_HUGETLB
  powerpc/hugetlb: Selectively enable ARCH_ENABLE_HUGEPAGE_MIGRATION
  selfttest/powerpc: Add memory page migration tests

 arch/powerpc/Kconfig                               |   8 +
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |  10 +
 arch/powerpc/include/uapi/asm/mman.h               |   3 +
 arch/powerpc/mm/hugetlbpage.c                      |  60 +++---
 include/linux/hugetlb.h                            |   3 +
 include/linux/mm.h                                 |  33 ++++
 mm/gup.c                                           |   6 +
 mm/hugetlb.c                                       |  75 +++++++-
 mm/mmap.c                                          |   2 +-
 tools/testing/selftests/powerpc/mm/Makefile        |  14 +-
 .../selftests/powerpc/mm/hugepage-migration.c      |  30 +++
 tools/testing/selftests/powerpc/mm/migration.h     | 205 +++++++++++++++++++++
 .../testing/selftests/powerpc/mm/page-migration.c  |  33 ++++
 tools/testing/selftests/powerpc/mm/run_mmtests     | 104 +++++++++++
 14 files changed, 552 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/hugepage-migration.c
 create mode 100644 tools/testing/selftests/powerpc/mm/migration.h
 create mode 100644 tools/testing/selftests/powerpc/mm/page-migration.c
 create mode 100755 tools/testing/selftests/powerpc/mm/run_mmtests

-- 
2.1.0
