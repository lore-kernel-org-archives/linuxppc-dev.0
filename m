Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E37AA1A0754
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 05:40:30 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 00:10:28 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 73E39125801C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:10 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9CIePct10944778
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:26 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CIePPq013179
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:25 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v3 00/31]  powerpc/mm: Update page table format for book3s 64
Date: Tue, 13 Oct 2015 00:09:44 +0530
Message-Id: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

This patch series attempt to update book3s 64 linux page table format to
make it more flexible. Our current pte format is very restrictive and we
overload multiple pte bits. This is due to the non-availability of free bits
in pte_t. We use pte_t to track the validity of 4K subpages. This patch
series free up pte_t of 11 bits by moving 4K subpage tracking to the
lower half of PTE page. The pte format is updated such that we have a
better method for identifying a pte entry at pmd level. This will also enable
us to implement hugetlb migration(not yet done in this series). 

Before making the changes to the pte format, I am splitting the
pte header definition such that we now have the below layout for headers

book3s
   32
     hash.h pgtable.h 
   64
     hash.h  pgtable.h hash-4k.h hash-64k.h
booke
  32
     pgtable.h pte-40x.h pte-44x.h pte-8xx.h pte-fsl-booke.h
  64
    pgtable-4k.h  pgtable-64k.h  pgtable.h

I have done the header split such that booke headers and modified to the minimum so as to avoid
causing breakage in booke.

Performance numbers with and without patch series.

Path length __hash_page_4k
with patch: 196
without patch: 142

Path length __hash_page_64k
with patch: 219
without patch: 154

But even if we have a path lengh increase of around 50 instructions. We don't see
the impact when running workload. I tried the kernelbuild test. 

With THP enabled (which is default) we see an improvement. I haven't fully looked at
the reason. This could be due to reduced contention of ptl lock. __hash_thp_page is
already a C code.

make -j64 vmlinux modules 
With fix:
---------
real    1m35.509s
user    56m8.565s
sys     4m34.973s

real    1m32.174s
user    57m2.336s
sys     4m39.142s

Without fix:
---------------
real    1m37.703s
user    58m50.783s
sys     7m52.440s

real    1m37.890s
user    57m55.445s
sys     7m50.501s

THP disabled:

make -j64 vmlinux modules 
With fix:
---------
real    1m37.197s
user    58m28.672s
sys     7m58.188s

real    1m44.638s
user    58m37.551s
sys     7m53.960s

Without fix:
------------
real    1m41.224s
user    58m46.944s
sys     7m49.714s

real    1m42.585s
user    59m14.019s
sys     7m52.714s

Changes from V2:
* rebase to -next for powerpc tree

Changes from V1:
1) Build fix with STRICT_MM_TYPES enabled 
2) pte_mkwrite fix for nohash
3) rebase to latest linus tree.



Aneesh Kumar K.V (31):
  powerpc/mm: move pte headers to book3s directory
  powerpc/mm: move pte headers to book3s directory (part 2)
  powerpc/mm: make a separate copy for book3s
  powerpc/mm: make a separate copy for book3s (part 2)
  powerpc/mm: Move hash specific pte width and other defines to book3s
  powerpc/mm: Delete booke bits from book3s
  powerpc/mm: Don't have generic headers introduce functions touching
    pte bits
  powerpc/mm: Drop pte-common.h from BOOK3S 64
  powerpc/mm: Don't use pte_val as lvalue
  powerpc/mm: Don't use pmd_val,pud_val and pgd_val as lvalue
  powerpc/mm: Move hash64 PTE bits from book3s/64/pgtable.h to hash.h
  powerpc/mm: Move PTE bits from generic functions to hash64 functions.
  powerpc/booke: Move nohash headers (part 1)
  powerpc/booke: Move nohash headers (part 2)
  powerpc/booke: Move nohash headers (part 3)
  powerpc/booke: Move nohash headers (part 4)
  powerpc/booke: Move nohash headers (part 5)
  powerpc/mm: Increase the pte frag size.
  powerpc/mm: Convert 4k hash insert to C
  powerpc/mm: update __real_pte to take address as argument
  powerpc/mm: make pte page hash index slot 8 bits
  powerpc/mm: Don't track subpage valid bit in pte_t
  powerpc/mm: Increase the width of #define
  powerpc/mm: Convert __hash_page_64K to C
  powerpc/mm: Convert 4k insert from asm to C
  powerpc/mm: Remove the dependency on pte bit position in asm code
  powerpc/mm: Add helper for converting pte bit to hpte bits
  powerpc/mm: Move WIMG update to helper.
  powerpc/mm: Move hugetlb related headers
  powerpc/mm: Move THP headers around
  powerpc/mm: Add a _PAGE_PTE bit

 .../include/asm/{pte-hash32.h => book3s/32/hash.h} |    6 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |  476 ++++++++++
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |  132 +++
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |  296 ++++++
 arch/powerpc/include/asm/book3s/64/hash.h          |  523 ++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  266 ++++++
 arch/powerpc/include/asm/book3s/pgtable.h          |   29 +
 arch/powerpc/include/asm/mmu-hash64.h              |    2 +-
 .../asm/{pgtable-ppc32.h => nohash/32/pgtable.h}   |   25 +-
 arch/powerpc/include/asm/{ => nohash/32}/pte-40x.h |    6 +-
 arch/powerpc/include/asm/{ => nohash/32}/pte-44x.h |    6 +-
 arch/powerpc/include/asm/{ => nohash/32}/pte-8xx.h |    6 +-
 .../include/asm/{ => nohash/32}/pte-fsl-booke.h    |    6 +-
 .../{pgtable-ppc64-4k.h => nohash/64/pgtable-4k.h} |   12 +-
 .../64/pgtable-64k.h}                              |    6 +-
 .../asm/{pgtable-ppc64.h => nohash/64/pgtable.h}   |  307 +-----
 arch/powerpc/include/asm/nohash/pgtable.h          |  252 +++++
 arch/powerpc/include/asm/{ => nohash}/pte-book3e.h |    6 +-
 arch/powerpc/include/asm/page.h                    |   90 +-
 arch/powerpc/include/asm/pgalloc-32.h              |   34 +-
 arch/powerpc/include/asm/pgalloc-64.h              |   29 +-
 arch/powerpc/include/asm/pgtable.h                 |  200 +---
 arch/powerpc/include/asm/pte-common.h              |    5 +
 arch/powerpc/include/asm/pte-hash64-4k.h           |   17 -
 arch/powerpc/include/asm/pte-hash64-64k.h          |  102 --
 arch/powerpc/include/asm/pte-hash64.h              |   54 --
 arch/powerpc/kernel/exceptions-64s.S               |   16 +-
 arch/powerpc/mm/Makefile                           |    9 +-
 arch/powerpc/mm/hash64_4k.c                        |  123 +++
 arch/powerpc/mm/hash64_64k.c                       |  313 ++++++
 arch/powerpc/mm/hash_low_64.S                      | 1003 --------------------
 arch/powerpc/mm/hash_native_64.c                   |   10 +
 arch/powerpc/mm/hash_utils_64.c                    |  105 +-
 arch/powerpc/mm/hugepage-hash64.c                  |   20 +-
 arch/powerpc/mm/hugetlbpage-hash64.c               |   15 +-
 arch/powerpc/mm/hugetlbpage.c                      |   58 +-
 arch/powerpc/mm/pgtable.c                          |    4 +
 arch/powerpc/mm/pgtable_64.c                       |   28 +-
 arch/powerpc/mm/tlb_hash64.c                       |    2 +-
 arch/powerpc/platforms/pseries/lpar.c              |   10 +
 40 files changed, 2691 insertions(+), 1918 deletions(-)
 rename arch/powerpc/include/asm/{pte-hash32.h => book3s/32/hash.h} (93%)
 create mode 100644 arch/powerpc/include/asm/book3s/32/pgtable.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/hash-4k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/hash-64k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/hash.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable.h
 create mode 100644 arch/powerpc/include/asm/book3s/pgtable.h
 rename arch/powerpc/include/asm/{pgtable-ppc32.h => nohash/32/pgtable.h} (96%)
 rename arch/powerpc/include/asm/{ => nohash/32}/pte-40x.h (95%)
 rename arch/powerpc/include/asm/{ => nohash/32}/pte-44x.h (96%)
 rename arch/powerpc/include/asm/{ => nohash/32}/pte-8xx.h (95%)
 rename arch/powerpc/include/asm/{ => nohash/32}/pte-fsl-booke.h (88%)
 rename arch/powerpc/include/asm/{pgtable-ppc64-4k.h => nohash/64/pgtable-4k.h} (92%)
 rename arch/powerpc/include/asm/{pgtable-ppc64-64k.h => nohash/64/pgtable-64k.h} (90%)
 rename arch/powerpc/include/asm/{pgtable-ppc64.h => nohash/64/pgtable.h} (56%)
 create mode 100644 arch/powerpc/include/asm/nohash/pgtable.h
 rename arch/powerpc/include/asm/{ => nohash}/pte-book3e.h (95%)
 delete mode 100644 arch/powerpc/include/asm/pte-hash64-4k.h
 delete mode 100644 arch/powerpc/include/asm/pte-hash64-64k.h
 delete mode 100644 arch/powerpc/include/asm/pte-hash64.h
 create mode 100644 arch/powerpc/mm/hash64_4k.c
 create mode 100644 arch/powerpc/mm/hash64_64k.c
 delete mode 100644 arch/powerpc/mm/hash_low_64.S

-- 
2.5.0
