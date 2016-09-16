Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb6d40BghzDsZH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:40:08 +1000 (AEST)
Message-Id: <cover.1474009019.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 0/3] powerpc: implementation of huge pages for 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 16 Sep 2016 09:40:01 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is v2 of patch serie is the implementation of support of
hugepages for the 8xx.
v1 of the serie was including some other fixes and
optimisations/reorganisations for the 8xx. Now the patch has been
split and this part only focuses on the implementation of
hugepages.

Compared the v1, the last patch has been split in two parts.

This patch serie applies on top of the patch serie named
"Optimisation on 8xx prior to hugepage implementation"

Christophe Leroy (3):
  powerpc: port 64 bits pgtable_cache to 32 bits
  powerpc: get hugetlbpage handling more generic
  powerpc/8xx: Implement support of hugepages

 arch/powerpc/include/asm/book3s/32/pgalloc.h |  44 +++++-
 arch/powerpc/include/asm/book3s/32/pgtable.h |  43 +++---
 arch/powerpc/include/asm/book3s/64/pgtable.h |   3 -
 arch/powerpc/include/asm/hugetlb.h           |  19 ++-
 arch/powerpc/include/asm/mmu-8xx.h           |  35 +++++
 arch/powerpc/include/asm/mmu.h               |  23 +--
 arch/powerpc/include/asm/nohash/32/pgalloc.h |  44 +++++-
 arch/powerpc/include/asm/nohash/32/pgtable.h |  45 +++---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |   1 +
 arch/powerpc/include/asm/nohash/64/pgtable.h |   2 -
 arch/powerpc/include/asm/nohash/pgtable.h    |   4 +
 arch/powerpc/include/asm/pgtable.h           |   2 +
 arch/powerpc/include/asm/reg_8xx.h           |   2 +-
 arch/powerpc/kernel/head_8xx.S               | 119 ++++++++++++++-
 arch/powerpc/mm/Makefile                     |   3 +-
 arch/powerpc/mm/hugetlbpage.c                | 212 ++++++++++++---------------
 arch/powerpc/mm/init-common.c                | 147 +++++++++++++++++++
 arch/powerpc/mm/init_64.c                    |  77 ----------
 arch/powerpc/mm/pgtable_32.c                 |  37 -----
 arch/powerpc/mm/tlb_nohash.c                 |  21 ++-
 arch/powerpc/platforms/8xx/Kconfig           |   1 +
 arch/powerpc/platforms/Kconfig.cputype       |   1 +
 22 files changed, 572 insertions(+), 313 deletions(-)
 create mode 100644 arch/powerpc/mm/init-common.c

-- 
2.1.0
