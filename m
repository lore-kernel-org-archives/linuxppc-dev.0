Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E3DE1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 15:48:37 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 23:48:35 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 8C65C6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 23:35:23 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N4mW5p23068754
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 04:48:32 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N4igsw012986
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 23:44:43 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 00/18] Book3s abstraction in preparation for new MMU model
Date: Tue, 23 Feb 2016 10:18:02 +0530
Message-Id: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello,

This series mostly consisting of code movement. One new thing added in this series
is to switch book3s 64 to 4 level page table. The changes are done to accomodate
the upcoming new memory model in future powerpc chips. The details of the new
MMU model can be found at

 http://ibm.biz/power-isa3 (Needs registration). I am including a summary of the changes below.

ISA 3.0 adds support for the radix tree style of MMU with full
virtualization and related control mechanisms that manage its
coexistence with the HPT. Radix-using operating systems will
manage their own translation tables instead of relying on hcalls.

Radix style MMU model requires us to do a 4 level page table
with 64K and 4K page size. The table index size different page size
is listed below

PGD -> 13 bits
PUD -> 9 (1G hugepage)
PMD -> 9 (2M huge page)
PTE -> 5 (for 64k), 9 (for 4k)

We also require the page table to be in big endian format.

Changes from V3:
 * rebase on top of PTE bits movement patch series
 * Drop all the hash linux abstraction patches
 * Keep only 4 level table and other code movement patches.

Changes from V2:
 * rebase to latest kernel
 * Update commit messages
 * address review comments

Changes from V1:
* move patches adding helpers to the next series


NOTE:
 This is lightly tested. Right now 4K linux page size is what is being tested. Once that is done
 I will have to do 64K linux page size tests.

-aneesh

Aneesh Kumar K.V (17):
  powerp/mm: Update code comments
  powerpc/mm: add _PAGE_HASHPTE similar to 4K hash
  powerpc/mm: Split pgtable types to separate header
  powerpc/mm: Don't have conditional defines for real_pte_t
  powerpc/mm: Switch book3s 64 with 64K page size to 4 level page table
  powerpc/mm: Update masked bits for linux page table
  powerpc/mm: Copy pgalloc (part 1)
  powerpc/mm: Copy pgalloc (part 2)
  powerpc/mm: Copy pgalloc (part 3)
  powerpc/mm: Hugetlbfs is book3s_64 and fsl_book3e (32 or 64)
  powerpc/mm: Use flush_tlb_page in ptep_clear_flush_young
  powerpc/mm: Move hash related mmu-*.h headers to book3s/
  powerpc/mm: Create a new headers for tlbflush for hash64
  powerpc/mm: Move hash page table related functions to pgtable-hash64.c
  powerpc/mm: THP is only available on hash64 as of now
  powerpc/mm: Use generic version of pmdp_clear_flush_young
  powerpc/mm: Move hash64 specific definitions to separate header

Kirill A. Shutemov (1):
  mm: Some arch may want to use HPAGE_PMD related values as variables

 arch/powerpc/Kconfig                               |   1 +
 .../asm/{mmu-hash32.h => book3s/32/mmu-hash.h}     |   0
 arch/powerpc/include/asm/book3s/32/pgalloc.h       | 109 ++++
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |  33 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |  31 +-
 arch/powerpc/include/asm/book3s/64/hash.h          |  58 +-
 .../asm/{mmu-hash64.h => book3s/64/mmu-hash.h}     |   2 +-
 .../include/asm/book3s/64/pgalloc-hash-4k.h        |  92 +++
 .../include/asm/book3s/64/pgalloc-hash-64k.h       |  51 ++
 arch/powerpc/include/asm/book3s/64/pgalloc-hash.h  |  59 ++
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |  69 +++
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  72 ++-
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  94 ++++
 arch/powerpc/include/asm/book3s/pgalloc.h          |  19 +
 arch/powerpc/include/asm/hugetlb.h                 |   1 +
 arch/powerpc/include/asm/mmu.h                     |   4 +-
 .../asm/{pgalloc-32.h => nohash/32/pgalloc.h}      |   0
 .../asm/{pgalloc-64.h => nohash/64/pgalloc.h}      |  28 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h       |   3 +
 arch/powerpc/include/asm/nohash/pgalloc.h          |  23 +
 arch/powerpc/include/asm/page.h                    | 104 +---
 arch/powerpc/include/asm/pgalloc.h                 |  19 +-
 arch/powerpc/include/asm/pgtable-types.h           | 103 ++++
 arch/powerpc/include/asm/tlbflush.h                |  92 +--
 arch/powerpc/kernel/idle_power7.S                  |   2 +-
 arch/powerpc/kvm/book3s_32_mmu_host.c              |   2 +-
 arch/powerpc/kvm/book3s_64_mmu.c                   |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c              |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |   2 +-
 arch/powerpc/kvm/book3s_64_vio.c                   |   2 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c                |   2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |   2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   2 +-
 arch/powerpc/mm/Makefile                           |   3 +-
 arch/powerpc/mm/hash64_4k.c                        |   2 +-
 arch/powerpc/mm/hash64_64k.c                       |   8 +-
 arch/powerpc/mm/hugepage-hash64.c                  |   2 +-
 arch/powerpc/mm/hugetlbpage-book3e.c               | 293 ++++++++++
 arch/powerpc/mm/hugetlbpage-hash64.c               | 122 +++-
 arch/powerpc/mm/hugetlbpage.c                      | 401 +-------------
 arch/powerpc/mm/init_64.c                          | 105 +---
 arch/powerpc/mm/mem.c                              |  29 +-
 arch/powerpc/mm/mmu_decl.h                         |   5 -
 arch/powerpc/mm/pgtable-book3e.c                   | 163 ++++++
 arch/powerpc/mm/pgtable-hash64.c                   | 614 +++++++++++++++++++++
 arch/powerpc/mm/pgtable.c                          |   9 +
 arch/powerpc/mm/pgtable_64.c                       | 454 ---------------
 arch/powerpc/mm/ppc_mmu_32.c                       |  30 +
 include/linux/bug.h                                |   9 +
 include/linux/huge_mm.h                            |   3 -
 mm/huge_memory.c                                   |  17 +-
 51 files changed, 2037 insertions(+), 1317 deletions(-)
 rename arch/powerpc/include/asm/{mmu-hash32.h => book3s/32/mmu-hash.h} (100%)
 create mode 100644 arch/powerpc/include/asm/book3s/32/pgalloc.h
 rename arch/powerpc/include/asm/{mmu-hash64.h => book3s/64/mmu-hash.h} (99%)
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgalloc-hash-4k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgalloc-hash-64k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgalloc-hash.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgalloc.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
 create mode 100644 arch/powerpc/include/asm/book3s/pgalloc.h
 rename arch/powerpc/include/asm/{pgalloc-32.h => nohash/32/pgalloc.h} (100%)
 rename arch/powerpc/include/asm/{pgalloc-64.h => nohash/64/pgalloc.h} (90%)
 create mode 100644 arch/powerpc/include/asm/nohash/pgalloc.h
 create mode 100644 arch/powerpc/include/asm/pgtable-types.h
 create mode 100644 arch/powerpc/mm/pgtable-book3e.c
 create mode 100644 arch/powerpc/mm/pgtable-hash64.c

-- 
2.5.0
