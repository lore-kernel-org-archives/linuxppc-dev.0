Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wc11s6sHSzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 01:32:00 +1000 (AEST)
Message-Id: <cover.1496070452.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/7] powerpc/mm: Fix kernel protection and implement
 STRICT_KERNEL_RWX on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 29 May 2017 17:31:54 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set implements STRICT_KERNEL_RWX on Powerpc32
after fixing a few issues related to kernel code page protection.

It superseeds the previous patch set identified "Fix kernel protection
and implement CONFIG_DEBUG_RODATA on PPC32"

This set is based on Balbir Singh <bsingharora@gmail.com> set identified
"Enable STRICT_KERNEL_RWX" and applies on top of it.

At the end we take the opportunity to get rid of some unneccessary/outdated
fixmap stuff.

Christophe Leroy (7):
  powerpc/mm: rename map_page() to map_kernel_page() on PPC32
  powerpc/mm: Ensure change_page_attr() doesn't invalidate pinned TLBs
  powerpc/mm: Fix kernel RAM protection after freeing unused memory on
    PPC32
  powerpc/mm: Implement STRICT_KERNEL_RWX on PPC32
  powerpc/mm: declare some local functions static
  powerpc/mm: remove __this_fixmap_does_not_exist()
  powerpc/mm: Simplify __set_fixmap()

 arch/powerpc/Kconfig                         |  3 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h |  3 +-
 arch/powerpc/include/asm/fixmap.h            | 10 ++--
 arch/powerpc/include/asm/nohash/32/pgtable.h |  3 +-
 arch/powerpc/kernel/vmlinux.lds.S            |  2 +-
 arch/powerpc/mm/8xx_mmu.c                    |  2 +-
 arch/powerpc/mm/dma-noncoherent.c            |  2 +-
 arch/powerpc/mm/init_32.c                    |  6 +++
 arch/powerpc/mm/mem.c                        |  5 +-
 arch/powerpc/mm/mmu_decl.h                   |  4 +-
 arch/powerpc/mm/pgtable_32.c                 | 73 ++++++++++++++++------------
 11 files changed, 69 insertions(+), 44 deletions(-)

-- 
2.12.0
