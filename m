Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m96b53jZzF14v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 20:05:27 +1000 (AEST)
Message-Id: <cover.1526464250.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 00/14] Implement use of HW assistance on TLB table walk on
 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 May 2018 12:05:23 +0200 (CEST)
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

First part is to make L1 entries and L2 entries independant.
For that, we need to alter ioremap functions in order to handle GUARD attribute
at the PGD/PMD level.

Last part is to reuse PTE fragment implemented on PPC64 in order to
not waste 16k Pages for page tables as only 4k are used.

Tested successfully on 8xx.

Successfull compilation on following defconfigs:
ppc64_defconfig
ppc64e_defconfig
pseries_defconfig
pmac32_defconfig
linkstation_defconfig
corenet32_smp_defconfig
ppc40x_defconfig
storcenter_defconfig
ppc44x_defconfig

Changes in v2:
 - Removed the 3 first patchs which have been applied already
 - Fixed compilation errors reported by Michael
 - Squashed the commonalisation of ioremap functions into a single patch
 - Fixed the use of pte_fragment
 - Added a patch optimising perf counting of TLB misses and instructions

Christophe Leroy (14):
  Revert "powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED for
    CONFIG_SWAP"
  powerpc: move io mapping functions into ioremap.c
  powerpc: make ioremap_bot common to PPC32 and PPC64
  powerpc: common ioremap functions.
  powerpc: use _ALIGN_DOWN macro for VMALLOC_BASE
  powerpc/nohash32: allow setting GUARDED attribute in the PMD directly
  powerpc/8xx: set GUARDED attribute in the PMD directly
  powerpc/8xx: Remove PTE_ATOMIC_UPDATES
  powerpc/mm: Use hardware assistance in TLB handlers on the 8xx
  powerpc/8xx: reunify TLB handler routines
  powerpc/8xx: Free up SPRN_SPRG_SCRATCH2
  powerpc/mm: Make pte_fragment_alloc() common to PPC32 and PPC64
  powerpc/mm: Use pte_fragment_alloc() on 8xx
  powerpc/8xx: Move SW perf counters in first 32kb of memory

 arch/powerpc/include/asm/book3s/32/pgtable.h |  29 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |   2 +
 arch/powerpc/include/asm/highmem.h           |  11 -
 arch/powerpc/include/asm/hugetlb.h           |   4 +-
 arch/powerpc/include/asm/machdep.h           |   2 +-
 arch/powerpc/include/asm/mmu-8xx.h           |  38 +--
 arch/powerpc/include/asm/mmu_context.h       |  28 ++
 arch/powerpc/include/asm/nohash/32/pgalloc.h |  56 +++-
 arch/powerpc/include/asm/nohash/32/pgtable.h |  77 +++--
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |   6 +-
 arch/powerpc/include/asm/nohash/pgtable.h    |   4 +
 arch/powerpc/include/asm/page.h              |   2 +-
 arch/powerpc/include/asm/pgtable-types.h     |   4 +
 arch/powerpc/kernel/head_8xx.S               | 409 +++++++++++----------------
 arch/powerpc/mm/8xx_mmu.c                    |  12 +-
 arch/powerpc/mm/Makefile                     |   2 +-
 arch/powerpc/mm/dma-noncoherent.c            |   2 +-
 arch/powerpc/mm/dump_linuxpagetables.c       |  32 ++-
 arch/powerpc/mm/hugetlbpage.c                |  12 +
 arch/powerpc/mm/init_32.c                    |   6 +-
 arch/powerpc/mm/ioremap.c                    | 254 +++++++++++++++++
 arch/powerpc/mm/mem.c                        |  16 +-
 arch/powerpc/mm/mmu_context_book3s64.c       |  28 --
 arch/powerpc/mm/mmu_context_nohash.c         |   4 +
 arch/powerpc/mm/pgtable.c                    |  75 +++++
 arch/powerpc/mm/pgtable_32.c                 | 167 +++--------
 arch/powerpc/mm/pgtable_64.c                 | 244 ----------------
 arch/powerpc/platforms/Kconfig.cputype       |   9 +
 28 files changed, 790 insertions(+), 745 deletions(-)
 create mode 100644 arch/powerpc/mm/ioremap.c

-- 
2.13.3
