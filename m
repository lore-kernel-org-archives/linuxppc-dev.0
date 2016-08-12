Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9rcP0dz5zDr1y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 02:55:49 +1000 (AEST)
Message-Id: <cover.1471020646.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/6] powerpc/8xx: implementation of huge pages
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Aug 2016 18:55:44 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set provides implementation of huge pages on the 8xx

Christophe Leroy (6):
  powerpc: port 64 bits pgtable_cache to 32 bits
  powerpc: fix usage of _PAGE_RO in hugepage
  powerpc/8xx: use r3 to scratch CR in ITLBmiss
  powerpc/8xx: Move additional DTLBMiss handlers out of exception area
  powerpc/8xx: make user addr DTLB miss the short path
  powerpc/8xx: implementation of huge pages

 arch/powerpc/include/asm/book3s/32/pgalloc.h |  44 ++++-
 arch/powerpc/include/asm/book3s/32/pgtable.h |  43 ++---
 arch/powerpc/include/asm/book3s/64/pgtable.h |   5 +-
 arch/powerpc/include/asm/hugetlb.h           |  20 ++-
 arch/powerpc/include/asm/mmu-8xx.h           |  35 ++++
 arch/powerpc/include/asm/mmu.h               |  25 +--
 arch/powerpc/include/asm/nohash/32/pgalloc.h |  44 ++++-
 arch/powerpc/include/asm/nohash/32/pgtable.h |  45 ++---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |   1 +
 arch/powerpc/include/asm/nohash/64/pgtable.h |   2 -
 arch/powerpc/include/asm/nohash/pgtable.h    |   4 +
 arch/powerpc/include/asm/pgtable.h           |   2 +
 arch/powerpc/include/asm/reg_8xx.h           |   2 +-
 arch/powerpc/kernel/head_8xx.S               | 235 +++++++++++++++++++--------
 arch/powerpc/mm/Makefile                     |   2 +-
 arch/powerpc/mm/hugetlbpage.c                | 184 ++++++++-------------
 arch/powerpc/mm/init-common.c                | 152 +++++++++++++++++
 arch/powerpc/mm/init_32.c                    |   5 -
 arch/powerpc/mm/init_64.c                    |  82 ----------
 arch/powerpc/mm/pgtable_32.c                 |  37 -----
 arch/powerpc/mm/tlb_nohash.c                 |  21 ++-
 arch/powerpc/platforms/8xx/Kconfig           |   1 +
 arch/powerpc/platforms/Kconfig.cputype       |   1 +
 23 files changed, 603 insertions(+), 389 deletions(-)
 create mode 100644 arch/powerpc/mm/init-common.c

-- 
2.1.0
