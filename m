Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PmMK47qSzDqxs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 21:27:41 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3GBRdeY063762
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:27:39 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hcqhs1hej-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:27:38 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 16 Apr 2018 07:27:37 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V1 00/11] powerpc/mm/book3s64: Support for split pmd ptlock
Date: Mon, 16 Apr 2018 16:57:12 +0530
Message-Id: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series add split pmd pagetable lock for book3s64. nohash64 also should
be able to switch to this. I need to workout the code dependency. This series
also migh have broken the build on platforms otherthan book3s64. I am sending this early
to get feedback on whether we should continue with the approach.

We switch the pmd allocator to use something similar to what we already use for
level 4 pagetable allocation. We get an order 0 page and divide that to fragments
and hand over fragments when we get request for a pmd pagetable. The pmd lock is
now stashed in the struct page backing the allocated page.

The series helps in reducing lock contention on mm->page_table_lock.


without patch

    32.72%  mmap_bench  [kernel.vmlinux]            [k] do_raw_spin_lock
            |
            ---do_raw_spin_lock
               |
                --32.68%--0
                          |
                          |--15.82%--pte_fragment_alloc
                          |          |
                          |           --15.79%--do_huge_pmd_anonymous_page
                          |                     __handle_mm_fault
                          |                     handle_mm_fault
                          |                     __do_page_fault
                          |                     handle_page_fault
                          |                     test_mmap
                          |                     test_mmap
                          |                     start_thread
                          |                     __clone
                          |
                          |--14.95%--do_huge_pmd_anonymous_page
                          |          __handle_mm_fault
                          |          handle_mm_fault
                          |          __do_page_fault
                          |          handle_page_fault
                          |          test_mmap
                          |          test_mmap
                          |          start_thread
                          |          __clone
                          |

with patch

    12.89%  mmap_bench  [kernel.vmlinux]            [k] do_raw_spin_lock
            |
            ---do_raw_spin_lock
               |
                --12.83%--0
                          |
                          |--3.21%--pagevec_lru_move_fn
                          |          __lru_cache_add
                          |          |
                          |           --2.74%--do_huge_pmd_anonymous_page
                          |                     __handle_mm_fault
                          |                     handle_mm_fault
                          |                     __do_page_fault
                          |                     handle_page_fault
                          |                     test_mmap
                          |                     test_mmap
                          |                     start_thread
                          |                     __clone
                          |
                          |--3.11%--do_huge_pmd_anonymous_page
                          |          __handle_mm_fault
                          |          handle_mm_fault
                          |          __do_page_fault
                          |          handle_page_fault
                          |          test_mmap
                          |          test_mmap
                          |          start_thread
                          |          __clone

.....
                          |
                           --0.55%--pte_fragment_alloc
                                     |
                                      --0.55%--do_huge_pmd_anonymous_page
                                                __handle_mm_fault
                                                handle_mm_fault
                                                __do_page_fault
                                                handle_page_fault
                                                test_mmap
                                                test_mmap
                                                start_thread
                                                __clone



Aneesh Kumar K.V (11):
  powerpc/mm/book3s64: Move book3s64 code to pgtable-book3s64
  powerpc/kvm: Switch kvm pmd allocator to custom allocator
  powerpc/mm: Use pmd_lockptr instead of opencoding it
  powerpc/mm: Rename pte fragment functions
  powerpc/mm/book3e/64: Remove unsupported 64Kpage size from 64bit booke
  powerpc/mm/nohash: Remove pte fragment dependency from nohash
  powerpc/mm/book3s64/4k: Switch 4k pagesize config to use pagetable
    fragment
  powerpc/book3s64/mm: Simplify the rcu callback for page table free
  powerpc/mm: Implement helpers for pagetable fragment support at PMD
    level
  powerpc/mm: Use page fragments for allocation page table at PMD level
  powerpc/book3s64: Enable split pmd ptlock.

 arch/powerpc/include/asm/book3s/64/hash-4k.h     |   8 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h    |   7 +
 arch/powerpc/include/asm/book3s/64/hash.h        |  10 -
 arch/powerpc/include/asm/book3s/64/mmu.h         |   7 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h     |  46 +---
 arch/powerpc/include/asm/book3s/64/pgtable.h     |  20 +-
 arch/powerpc/include/asm/book3s/64/radix-4k.h    |   3 +
 arch/powerpc/include/asm/book3s/64/radix-64k.h   |   4 +
 arch/powerpc/include/asm/mmu-book3e.h            |   6 -
 arch/powerpc/include/asm/nohash/64/pgalloc.h     |  95 +++-----
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h |  57 -----
 arch/powerpc/include/asm/nohash/64/pgtable.h     |   8 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c           |  36 ++-
 arch/powerpc/mm/hash_utils_64.c                  |   3 +-
 arch/powerpc/mm/mmu_context_book3s64.c           |  39 +++-
 arch/powerpc/mm/pgtable-book3s64.c               | 267 ++++++++++++++++++++++-
 arch/powerpc/mm/pgtable-hash64.c                 |   8 +-
 arch/powerpc/mm/pgtable-radix.c                  |   5 +-
 arch/powerpc/mm/pgtable_64.c                     | 171 ---------------
 arch/powerpc/platforms/Kconfig.cputype           |   4 +
 20 files changed, 427 insertions(+), 377 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/nohash/64/pgtable-64k.h

-- 
2.14.3
