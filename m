Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmHz35hYzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:14:23 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:14:20 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id F204619D803F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:02:09 -0600 (MDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396EH9J36503554
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:14:17 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396EG0H026456
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:14:16 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 00/68] PowerISA 3.0 Radix page table support
Date: Sat,  9 Apr 2016 11:42:56 +0530
Message-Id: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series implements Radix page table support for ppc64 book3s
as defined by PowerISA 3.0.

Changes from V1:
* Make sure each patch build without errors on different configs
* Address review feedback

Aneesh Kumar K.V (68):
  powerpc/cxl: Use REGION_ID instead of opencoding
  powerpc/mm/nohash: Return correctly from flush_tlb_page
  powerpc/mm/nohash: Update non SMP version of flush_tlb_page to handle
    hugetlb address
  powerpc/mm: Use big endian page table for book3s 64
  powerpc/mm: use _PAGE_READ to indicate Read access
  powerpc/mm/subpage: Clear RWX bit to indicate no access
  powerpc/mm: Use pte_user instead of opencoding
  powerpc/mm: Replace _PAGE_USER with _PAGE_PRIVILEGED
  powerpc/mm: Remove RPN_SHIFT and RPN_SIZE
  powerpc/mm: Update _PAGE_KERNEL_RO
  powerpc/mm: Use helper for finding pte bits mapping I/O area
  powerpc/mm: Drop WIMG in favour of new constants
  powerpc/mm: Use generic version of pmdp_clear_flush_young
  powerpc/mm: Use generic version of ptep_clear_flush_young
  powerpc/mm: Move common data structure between radix and hash to
    book3s 64 generic headers
  powerpc/mm/power9: Add partition table format
  powerpc/mm/hash: Add support for POWER9 hash
  powerpc/mm: Move hash and no hash code to separate files
  powerpc/mm/book3s: Rename hash specific PTE bits to carry H_ prefix
  powerpc/mm: Handle _PTE_NONE_MASK
  powerpc/mm: Move common pte bits and accessors to book3s/64/pgtable.h
  powerpc/mm: Move pte accessors that operate on common pte bits to
    pgtable.h
  powerpc/mm: Make page table size a variable
  powerpc/mm: Move page table index and and vaddr to pgtable.h
  powerpc/mm: Move pte related function together
  powerpc/mm/radix: Add radix pte defines
  powerpc/mm/radix: Dummy radix_enabled()
  powerpc/mm: Add radix callbacks to pte accessors
  powerpc/mm: Move hugetlb and THP related pmd accessors to pgtable.h
  powerpc/mm/radix: Add radix callback for pmd accessors
  powerpc/mm: Abstraction for early init routines
  powerpc/mm/radix: Add radix callback for early init routines
  powerpc/mm: Abstraction for vmemmap and map_kernel_page
  powerpc/mm/radix: Add radix callback for vmemmap and map_kernel page
  powerpc/mm: Abstraction for switch_mmu_context
  powerpc/mm/radix: Add mmu context handling callback for radix
  powerpc/mm: Rename mmu_context_hash64.c to mmu_context_book3s64.c
  powerpc/mm: Hash linux abstraction for tlbflush routines
  powerpc/mm/radix: Add tlbflush routines
  powerpc/mm/radix: Add MMU_FTR_RADIX
  powerpc/mm/radix: Use STD_MMU_64 to properly isolate hash related code
  powerpc/mm/radix: Isolate hash table function from pseries guest code
  powerpc/mm/radix: Add checks in slice code to catch radix usage
  powerpc/mm/radix: Limit paca allocation in radix
  powerpc/mm/radix: Pick the address layout for radix config
  powerpc/mm/radix: Update secondary PTCR
  powerpc/mm: Make a copy of pgalloc.h for 32 and 64 book3s
  powerpc/mm: Copy pgalloc (part 2)
  powerpc/mm: Revert changes made to nohash pgalloc-64.h
  powerpc/mm: Simplify the code dropping 4 level table #ifdef
  powerpc/mm: Rename function to indicate we are allocating fragments
  powerpc/mm: make 4k and 64k use pte_t for pgtable_t
  powerpc/mm: Add radix pgalloc details
  powerpc/mm: Update pte filter for radix
  powerpc/mm: VMALLOC abstraction
  powerpc/radix: update mmu cache
  powerpc/mm: pte_frag abstraction
  powerpc/mm: Fix vma_mmu_pagesize for radix
  powerpc/mm: Add radix support for hugetlb
  powerpc/mm/radix: Make sure swapper pgdir is properly aligned
  powerpc/mm/radix: Add hugetlb support 4K page size
  powerpc/mm: Drop PTE_ATOMIC_UPDATES from pmd_hugepage_update
  powerpc/mm: THP is only available on hash64 as of now
  powerpc/mm/thp: Abstraction for THP functions
  powerpc/mm/radix: Add radix THP callbacks
  powerpc/mm/radix: Add THP support for 4k linux page size
  powerpc/mm/radix: Cputable update for radix
  powerpc/mm/radix: Use firmware feature to disable radix

 arch/powerpc/include/asm/book3s/32/mmu-hash.h      |   6 +-
 arch/powerpc/include/asm/book3s/32/pgalloc.h       | 109 +++
 arch/powerpc/include/asm/book3s/64/hash-4k.h       | 136 ++--
 arch/powerpc/include/asm/book3s/64/hash-64k.h      | 213 ++----
 arch/powerpc/include/asm/book3s/64/hash.h          | 477 ++----------
 arch/powerpc/include/asm/book3s/64/hugetlb-radix.h |  14 +
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |  79 +-
 arch/powerpc/include/asm/book3s/64/mmu.h           | 137 ++++
 arch/powerpc/include/asm/book3s/64/pgalloc.h       | 207 ++++++
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h    |  53 ++
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h   |  64 ++
 arch/powerpc/include/asm/book3s/64/pgtable.h       | 812 +++++++++++++++++++--
 arch/powerpc/include/asm/book3s/64/radix-4k.h      |  12 +
 arch/powerpc/include/asm/book3s/64/radix-64k.h     |  12 +
 arch/powerpc/include/asm/book3s/64/radix.h         | 188 +++++
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  41 +-
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  33 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |  76 ++
 arch/powerpc/include/asm/book3s/pgalloc.h          |  19 +
 arch/powerpc/include/asm/hugetlb.h                 |  23 +-
 arch/powerpc/include/asm/kvm_book3s_64.h           |  42 +-
 arch/powerpc/include/asm/machdep.h                 |   1 +
 arch/powerpc/include/asm/mmu.h                     |  32 +-
 arch/powerpc/include/asm/mmu_context.h             |  29 +-
 .../asm/{pgalloc-32.h => nohash/32/pgalloc.h}      |   0
 .../asm/{pgalloc-64.h => nohash/64/pgalloc.h}      |  92 +--
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  10 +-
 arch/powerpc/include/asm/nohash/pgalloc.h          |  23 +
 arch/powerpc/include/asm/page.h                    |  14 +-
 arch/powerpc/include/asm/page_64.h                 |   2 +-
 arch/powerpc/include/asm/pgalloc.h                 |  19 +-
 arch/powerpc/include/asm/pgtable-be-types.h        | 104 +++
 arch/powerpc/include/asm/pte-common.h              |   9 +
 arch/powerpc/include/asm/reg.h                     |   5 +
 arch/powerpc/include/asm/tlbflush.h                |   3 +-
 arch/powerpc/kernel/asm-offsets.c                  |   4 +
 arch/powerpc/kernel/btext.c                        |   2 +-
 arch/powerpc/kernel/cputable.c                     |   2 +-
 arch/powerpc/kernel/entry_64.S                     |   7 +-
 arch/powerpc/kernel/exceptions-64s.S               |  28 +-
 arch/powerpc/kernel/head_64.S                      |  13 +-
 arch/powerpc/kernel/isa-bridge.c                   |   4 +-
 arch/powerpc/kernel/machine_kexec_64.c             |   6 +-
 arch/powerpc/kernel/mce_power.c                    |  13 +-
 arch/powerpc/kernel/pci_64.c                       |   5 +-
 arch/powerpc/kernel/process.c                      |  15 +-
 arch/powerpc/kernel/prom.c                         |   1 +
 arch/powerpc/kernel/swsusp.c                       |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |  11 +-
 arch/powerpc/kvm/book3s_hv.c                       |   6 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |  12 +-
 arch/powerpc/kvm/book3s_pr.c                       |   6 +-
 arch/powerpc/mm/Makefile                           |  10 +-
 arch/powerpc/mm/hash64_4k.c                        |  32 +-
 arch/powerpc/mm/hash64_64k.c                       |  77 +-
 arch/powerpc/mm/hash_native_64.c                   |  11 +-
 arch/powerpc/mm/hash_utils_64.c                    | 161 +++-
 arch/powerpc/mm/hugepage-hash64.c                  |  25 +-
 arch/powerpc/mm/hugetlbpage-book3e.c               |   8 +
 arch/powerpc/mm/hugetlbpage-hash64.c               |  32 +-
 arch/powerpc/mm/hugetlbpage-radix.c                |  87 +++
 arch/powerpc/mm/hugetlbpage.c                      |  20 +-
 arch/powerpc/mm/init_64.c                          |  73 +-
 arch/powerpc/mm/mem.c                              |   2 +
 arch/powerpc/mm/mmap.c                             | 109 +++
 ...mmu_context_hash64.c => mmu_context_book3s64.c} |  42 +-
 arch/powerpc/mm/mmu_context_nohash.c               |   3 +-
 arch/powerpc/mm/mmu_decl.h                         |   5 -
 arch/powerpc/mm/pgtable-book3e.c                   | 129 ++++
 arch/powerpc/mm/pgtable-book3s64.c                 | 123 ++++
 arch/powerpc/mm/pgtable-hash64.c                   | 347 +++++++++
 arch/powerpc/mm/pgtable-radix.c                    | 527 +++++++++++++
 arch/powerpc/mm/pgtable.c                          |  24 +-
 arch/powerpc/mm/pgtable_64.c                       | 555 ++------------
 arch/powerpc/mm/slb_low.S                          |   4 +-
 arch/powerpc/mm/slice.c                            |  20 +-
 arch/powerpc/mm/tlb-radix.c                        | 252 +++++++
 arch/powerpc/mm/tlb_hash64.c                       |   6 +-
 arch/powerpc/mm/tlb_nohash.c                       |   7 +-
 arch/powerpc/perf/callchain.c                      |   2 +-
 arch/powerpc/platforms/Kconfig.cputype             |   6 +-
 arch/powerpc/platforms/cell/spu_base.c             |   2 +-
 arch/powerpc/platforms/cell/spufs/fault.c          |   4 +-
 arch/powerpc/platforms/powernv/setup.c             |   5 +-
 arch/powerpc/platforms/ps3/htab.c                  |   2 +-
 arch/powerpc/platforms/ps3/spu.c                   |   4 +-
 arch/powerpc/platforms/pseries/lpar.c              |  20 +-
 arch/powerpc/platforms/pseries/lparcfg.c           |   3 +-
 arch/powerpc/xmon/xmon.c                           |   2 +-
 drivers/cpufreq/pmac32-cpufreq.c                   |   2 +-
 drivers/macintosh/via-pmu.c                        |   4 +-
 drivers/misc/cxl/fault.c                           |  10 +-
 drivers/pcmcia/electra_cf.c                        |   2 +-
 93 files changed, 4280 insertions(+), 1712 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/32/pgalloc.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/mmu.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgalloc.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable-4k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable-64k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/radix-4k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/radix-64k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/radix.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/tlbflush.h
 create mode 100644 arch/powerpc/include/asm/book3s/pgalloc.h
 rename arch/powerpc/include/asm/{pgalloc-32.h => nohash/32/pgalloc.h} (100%)
 rename arch/powerpc/include/asm/{pgalloc-64.h => nohash/64/pgalloc.h} (68%)
 create mode 100644 arch/powerpc/include/asm/nohash/pgalloc.h
 create mode 100644 arch/powerpc/include/asm/pgtable-be-types.h
 create mode 100644 arch/powerpc/mm/hugetlbpage-radix.c
 rename arch/powerpc/mm/{mmu_context_hash64.c => mmu_context_book3s64.c} (78%)
 create mode 100644 arch/powerpc/mm/pgtable-book3e.c
 create mode 100644 arch/powerpc/mm/pgtable-book3s64.c
 create mode 100644 arch/powerpc/mm/pgtable-hash64.c
 create mode 100644 arch/powerpc/mm/pgtable-radix.c
 create mode 100644 arch/powerpc/mm/tlb-radix.c

-- 
2.5.0
