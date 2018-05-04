Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40crzS40JyzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 22:33:55 +1000 (AEST)
Message-Id: <cover.1525435203.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 00/17] Implement use of HW assistance on TLB table walk on 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  4 May 2018 14:33:50 +0200 (CEST)
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

Last part is to try and reuse PTE fragment implemented on PPC64 in order to
not waste 16k Pages for page tables as only 4k are used. For the time being,
it doesn't work, but I include it in the serie anyway in order to get feedback.

Tested successfully on 8xx up to the one before the last.

Didn't have time to do compilation test on other configs, I send it anyway
before leaving for one week vacation in order to get feedback.

Christophe Leroy (17):
  powerpc/nohash: remove hash related code from nohash headers.
  powerpc/nohash: remove _PAGE_BUSY
  powerpc/nohash: use IS_ENABLED() to simplify __set_pte_at()
  Revert "powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED for
    CONFIG_SWAP"
  powerpc: move io mapping functions into ioremap.c
  powerpc: common ioremap functions.
  powerpc: make ioremap_bot common to PPC32 and PPC64
  powerpc: make __iounmap() common to PPC32 and PPC64
  powerpc: make __ioremap_caller() common to PPC32 and PPC64
  powerpc: use _ALIGN macro
  powerpc/nohash32: set GUARDED attribute in the PMD directly
  powerpc/8xx: Remove PTE_ATOMIC_UPDATES
  powerpc/mm: Use hardware assistance in TLB handlers on the 8xx
  powerpc/8xx: reunify TLB handler routines
  powerpc/8xx: Free up SPRN_SPRG_SCRATCH2
  powerpc/mm: Make pte_fragment_alloc() common to PPC32 and PPC64
  powerpc/mm: Use pte_fragment_alloc() on 8xx (Not Working yet)

 arch/powerpc/include/asm/book3s/32/pgtable.h |  16 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |   2 +
 arch/powerpc/include/asm/hugetlb.h           |   4 +-
 arch/powerpc/include/asm/machdep.h           |   2 +-
 arch/powerpc/include/asm/mmu-8xx.h           |  38 +--
 arch/powerpc/include/asm/mmu_context.h       |  28 +++
 arch/powerpc/include/asm/nohash/32/pgalloc.h |  39 ++-
 arch/powerpc/include/asm/nohash/32/pgtable.h |  88 +++----
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |   6 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h |  26 +-
 arch/powerpc/include/asm/nohash/pgtable.h    |  61 ++---
 arch/powerpc/include/asm/nohash/pte-book3e.h |   6 -
 arch/powerpc/include/asm/pgtable-types.h     |   4 +
 arch/powerpc/kernel/head_8xx.S               | 350 ++++++++++-----------------
 arch/powerpc/mm/8xx_mmu.c                    |  12 +-
 arch/powerpc/mm/Makefile                     |   2 +-
 arch/powerpc/mm/dma-noncoherent.c            |   2 +-
 arch/powerpc/mm/dump_linuxpagetables.c       |  32 ++-
 arch/powerpc/mm/hugetlbpage.c                |  12 +
 arch/powerpc/mm/init_32.c                    |   6 +-
 arch/powerpc/mm/ioremap.c                    | 250 +++++++++++++++++++
 arch/powerpc/mm/mem.c                        |  16 +-
 arch/powerpc/mm/mmu_context_book3s64.c       |  28 ---
 arch/powerpc/mm/mmu_context_nohash.c         |   4 +
 arch/powerpc/mm/pgtable.c                    |  75 ++++++
 arch/powerpc/mm/pgtable_32.c                 | 167 +++----------
 arch/powerpc/mm/pgtable_64.c                 | 244 -------------------
 arch/powerpc/platforms/Kconfig.cputype       |   9 +
 28 files changed, 730 insertions(+), 799 deletions(-)
 create mode 100644 arch/powerpc/mm/ioremap.c

-- 
2.13.3
