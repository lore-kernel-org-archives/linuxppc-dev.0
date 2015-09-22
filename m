Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 4581F1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:50:31 +1000 (AEST)
Message-Id: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 00/25] powerpc/8xx: Use large pages for RAM and IMMR and
 other improvments
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:50:27 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The main purpose of this patchset is to dramatically reduce the time
spent in DTLB miss handler. This is achieved by:
1/ Mapping RAM with 8M pages
2/ Mapping IMMR with a fixed 512K page

On a live running system (VoIP gateway for Air Trafic Control), over
a 10 minutes period (with 277s idle), we get 87 millions DTLB misses
and approximatly 35 secondes are spent in DTLB handler.
This represents 5.8% of the overall time and even 10.8% of the
non-idle time.
Among those 87 millions DTLB misses, 15% are on user addresses and
85% are on kernel addresses. And within the kernel addresses, 93%
are on addresses from the linear address space and only 7% are on
addresses from the virtual address space.

Once the full patchset applied, the number of DTLB misses during the
period is reduced to 11.8 millions for a duration of 5.8s, which
represents 2% of the non-idle time.

This patch also includes other miscellaneous improvements:
1/ Handling of CPU6 ERRATA directly in mtspr() C macro to reduce code
specific to PPC8xx
2/ Rewrite of a few non critical ASM functions in C
3/ Removal of some unused items

See related patches for details

Christophe Leroy (25):
  powerpc/8xx: Save r3 all the time in DTLB miss handler
  powerpc/8xx: Map linear kernel RAM with 8M pages
  powerpc: Update documentation for noltlbs kernel parameter
  powerpc/8xx: move setup_initial_memory_limit() into 8xx_mmu.c
  powerpc/8xx: Fix vaddr for IMMR early remap
  powerpc32: iounmap() cannot vunmap() area mapped by TLBCAMs either
  powerpc32: refactor x_mapped_by_bats() and x_mapped_by_tlbcam()
    together
  powerpc/8xx: Map IMMR area with 512k page at a fixed address
  powerpc/8xx: show IMMR area in startup memory layout
  powerpc/8xx: CONFIG_PIN_TLB unneeded for CONFIG_PPC_EARLY_DEBUG_CPM
  powerpc/8xx: map 16M RAM at startup
  powerpc32: Remove useless/wrong MMU:setio progress message
  powerpc/8xx: also use r3 in the ITLB miss in all situations
  powerpc32: remove ioremap_base
  powerpc/8xx: move 8xx SPRN defines into reg_8xx.h and add some missing
    ones
  powerpc/8xx: Handle CPU6 ERRATA directly in mtspr() macro
  powerpc/8xx: remove special handling of CPU6 errata in set_dec()
  powerpc/8xx: rewrite set_context() in C
  powerpc/8xx: rewrite flush_instruction_cache() in C
  powerpc32: Remove clear_pages() and define clear_page() inline
  powerpc: add inline functions for cache related instructions
  powerpc32: move xxxxx_dcache_range() functions inline
  powerpc: Simplify test in __dma_sync()
  powerpc32: small optimisation in flush_icache_range()
  powerpc32: Remove one insn in mulhdu

 Documentation/kernel-parameters.txt         |   2 +-
 arch/powerpc/Kconfig.debug                  |   2 -
 arch/powerpc/include/asm/cache.h            |  19 +++
 arch/powerpc/include/asm/cacheflush.h       |  55 +++++++-
 arch/powerpc/include/asm/mmu-8xx.h          |  26 ++--
 arch/powerpc/include/asm/page_32.h          |  17 ++-
 arch/powerpc/include/asm/pgtable-ppc32.h    |   5 +
 arch/powerpc/include/asm/reg.h              |   2 +
 arch/powerpc/include/asm/reg_8xx.h          | 106 +++++++++++++++
 arch/powerpc/include/asm/time.h             |   6 +-
 arch/powerpc/kernel/head_8xx.S              | 167 ++++++++++++------------
 arch/powerpc/kernel/misc_32.S               | 107 ++--------------
 arch/powerpc/kernel/ppc_ksyms.c             |   2 +
 arch/powerpc/kernel/ppc_ksyms_32.c          |   1 -
 arch/powerpc/mm/8xx_mmu.c                   | 191 ++++++++++++++++++++++++++++
 arch/powerpc/mm/Makefile                    |   1 +
 arch/powerpc/mm/dma-noncoherent.c           |   2 +-
 arch/powerpc/mm/init_32.c                   |  23 ----
 arch/powerpc/mm/mem.c                       |   4 +
 arch/powerpc/mm/mmu_decl.h                  |  16 +--
 arch/powerpc/mm/pgtable_32.c                |  54 +++++++-
 arch/powerpc/platforms/embedded6xx/mpc10x.h |   8 --
 22 files changed, 553 insertions(+), 263 deletions(-)
 create mode 100644 arch/powerpc/mm/8xx_mmu.c

-- 
2.1.0
