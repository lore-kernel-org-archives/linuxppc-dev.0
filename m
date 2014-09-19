Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 4A95E1A015D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 18:36:10 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v4 00/21] powerpc/8xx: Optimise MMU TLB handling and add
 support of 16k pages
Message-Id: <20140919083606.863ED1AB030@localhost.localdomain>
Date: Fri, 19 Sep 2014 10:36:06 +0200 (CEST)
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset:
1) provides several MMU TLB handling optimisation on MPC8xx.
2) adds support of 16k pages on MPC8xx.
All changes have been successfully tested on a custom board equipped with MPC885

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
Changes in v2:
- Patch number 10 removed, it was implementing a 16 bit alignment of the PGDIR.
It is not worth potentially wasting up to 64k of memory just for removing one
instruction (ori).
- Preserve r11 while calculating the level 2 address, therefore no more need to
save r11 into CR.

Changes in v3:
- Few fixes following review from Joachim Tjernlund
- Removed the major hack which was saving resisters in memory for CPU6 errata
- Invalidating non present TLB entries earlier (in head_8xx instead of fault.c)

Changes in v4:
- Resubmitting patch 3 and 7 after new comments from Joachim and feedback
from Scott. Has impact on patch 5, 14, 19 and 21.
- Fixed patch 20 that didn't apply

 arch/powerpc/Kconfig                     |   2 +-
 arch/powerpc/include/asm/mmu-8xx.h       |   2 +
 arch/powerpc/include/asm/pgtable-ppc32.h |  20 ++
 arch/powerpc/include/asm/pte-8xx.h       |   7 +-
 arch/powerpc/include/asm/reg.h           |   3 +-
 arch/powerpc/kernel/head_8xx.S           | 366 ++++++++++++-------------
 arch/powerpc/mm/fault.c                  |   7 -
 7 files changed, 201 insertions(+), 206 deletions(-)
