Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F8Kt3rzvzF3FJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 02:57:06 +1000 (AEST)
Message-Id: <cover.1537288312.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 00/20] Implement use of HW assistance on TLB table walk on
 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 18 Sep 2018 16:57:02 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The purpose of this serie is to implement hardware assistance for TLB table walk
on the 8xx.

First part switches to patch_site instead of patch_instruction,
as it makes the code clearer and avoids pollution with global symbols.

Optimise access to perf counters (hence reduce number of registers used)

Second part implements HW assistance in TLB routines.

Last part is to make L1 entries and L2 entries independant. For that,
we need to alter ioremap functions in order to handle GUARD attribute
at the PGD/PMD level.

Tested successfully on 8xx.

This serie applies after the two following series:
- [v2 00/24] ban the use of _PAGE_XXX flags outside platform specific code (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=65376)
- [v2,1/4] powerpc/mm: enable the use of page table cache of order 0 (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=60777)

Successfull compilation on kisskb (v4)
http://kisskb.ellerman.id.au/kisskb/branch/chleroy/head/cfdf3349e3877df4cbfa9193ad1f4f4e4ada52de/

Successfull compilation on following defconfigs (v3):
ppc64_defconfig
ppc64e_defconfig

Successfull compilation on following defconfigs (v2):
ppc64_defconfig
ppc64e_defconfig
pseries_defconfig
pmac32_defconfig
linkstation_defconfig
corenet32_smp_defconfig
ppc40x_defconfig
storcenter_defconfig
ppc44x_defconfig

Changes in v4:
 - Reordered the serie to put at the end the modifications which makes
   L1 and L2 entries independant.
 - No modifications to ppc64 ioremap (we still have an opportunity to
   merge them, for a future patch serie)
 - 8xx code modified to use patch_site instead of patch_instruction
   to get a clearer code and avoid object pollution with global symbols
 - Moved perf counters in first 32kb of memory to optimise access
 - Split the big bang to HW assistance in several steps:
   1. Temporarily removes support of 16k pages and 512k hugepages
   2. Change TLB routines to use HW assistance for 4k pages and 8M hugepages
   3. Add back support for 512k hugepages
   4. Add back support for 16k pages (using pte_fragment as page tables are still 4k)

Changes in v3:
 - Fixed an issue in the 09/14 when CONFIG_PIN_TLB_TEXT was not enabled
 - Added performance measurement in the 09/14 commit log
 - Rebased on latest 'powerpc/merge' tree, which conflicted with 13/14

Changes in v2:
 - Removed the 3 first patchs which have been applied already
 - Fixed compilation errors reported by Michael
 - Squashed the commonalisation of ioremap functions into a single patch
 - Fixed the use of pte_fragment
 - Added a patch optimising perf counting of TLB misses and instructions

Christophe Leroy (20):
  Revert "powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED for
    CONFIG_SWAP"
  powerpc/code-patching: add a helper to get the address of a patch_site
  powerpc/8xx: Use patch_site for memory setup patching
  powerpc/8xx: Use patch_site for perf counters setup
  powerpc/8xx: Move SW perf counters in first 32kb of memory
  powerpc/8xx: Temporarily disable 16k pages and 512k hugepages
  powerpc/mm: Use hardware assistance in TLB handlers on the 8xx
  powerpc/mm: Enable 512k hugepage support with HW assistance on the 8xx
  powerpc/8xx: don't use r12/SPRN_SPRG_SCRATCH2 in TLB Miss handlers
  powerpc/8xx: regroup TLB handler routines
  powerpc/mm: don't use pte_alloc_one_kernel() before slab is available
  powerpc/mm: inline pte_alloc_one() and pte_alloc_one_kernel() in PPC32
  powerpc/book3s32: Remove CONFIG_BOOKE dependent code
  powerpc/mm: Move pte_fragment_alloc() to a common location
  powerpc/mm: Avoid useless lock with single page fragments
  powerpc/mm: Extend pte_fragment functionality to nohash/32
  powerpc/8xx: Remove PTE_ATOMIC_UPDATES
  powerpc/mm: reintroduce 16K pages with HW assistance on 8xx
  powerpc/nohash32: allow setting GUARDED attribute in the PMD directly
  powerpc/8xx: set GUARDED attribute in the PMD directly

 arch/powerpc/include/asm/book3s/32/pgalloc.h |  28 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h |  16 +-
 arch/powerpc/include/asm/code-patching.h     |   5 +
 arch/powerpc/include/asm/hugetlb.h           |   4 +-
 arch/powerpc/include/asm/mmu-40x.h           |   1 +
 arch/powerpc/include/asm/mmu-44x.h           |   1 +
 arch/powerpc/include/asm/mmu-8xx.h           |  44 +--
 arch/powerpc/include/asm/mmu-book3e.h        |   1 +
 arch/powerpc/include/asm/mmu_context.h       |   2 +-
 arch/powerpc/include/asm/nohash/32/pgalloc.h |  43 ++-
 arch/powerpc/include/asm/nohash/32/pgtable.h |  45 ++-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |   6 +-
 arch/powerpc/include/asm/nohash/pgtable.h    |   4 +
 arch/powerpc/include/asm/page.h              |   6 +-
 arch/powerpc/include/asm/pgtable-types.h     |   4 +
 arch/powerpc/include/asm/pgtable.h           |   8 +
 arch/powerpc/kernel/head_8xx.S               | 425 +++++++++++----------------
 arch/powerpc/mm/8xx_mmu.c                    |  29 +-
 arch/powerpc/mm/Makefile                     |   7 +-
 arch/powerpc/mm/dump_linuxpagetables.c       |  21 +-
 arch/powerpc/mm/hugetlbpage.c                |  13 +
 arch/powerpc/mm/mem.c                        |   7 +
 arch/powerpc/mm/mmu_context.c                |   1 -
 arch/powerpc/mm/mmu_context_book3s64.c       |  67 -----
 arch/powerpc/mm/mmu_context_nohash.c         |   1 +
 arch/powerpc/mm/pgtable-book3s64.c           |  85 ------
 arch/powerpc/mm/pgtable-frag.c               | 176 +++++++++++
 arch/powerpc/mm/pgtable_32.c                 | 103 ++++---
 arch/powerpc/perf/8xx-pmu.c                  |  27 +-
 arch/powerpc/platforms/Kconfig.cputype       |   3 +
 30 files changed, 620 insertions(+), 563 deletions(-)
 create mode 100644 arch/powerpc/mm/pgtable-frag.c

-- 
2.13.3
