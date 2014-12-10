Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 2B3361A09D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 05:01:16 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/4] powerpc32: fix of PTE accessors and handle inverted HW
 bits via PTE accessors
Message-Id: <20141210180028.72FA71A5D62@localhost.localdomain>
Date: Wed, 10 Dec 2014 19:00:28 +0100 (CET)
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

Some powerpc like the 8xx do invert some PTE bits in HW. In order to avoid
having to invert the bits each time we set them into hardware, this patch adds
the invertion logic into the PTE accessors in order to get them already properly
inversed in the tables.

Patchset:
1) powerpc32: misuse of accessors to pte_t objects
2) powerpc32: properly clear page table when 0 is not a good default PTE value
3) powerpc32: adds direct support to hardware inverted values in pte accessors
4) powerpc32/8xx: invert _PAGE_RW bit in PTE accessors

All changes have been successfully tested on MPC885

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/include/asm/page.h          |  8 +++----
 arch/powerpc/include/asm/pgtable-ppc32.h | 37 +++++++++++++++++++++-----------
 arch/powerpc/include/asm/pgtable.h       | 17 ++++++++-------
 arch/powerpc/include/asm/pte-8xx.h       |  1 +
 arch/powerpc/include/asm/pte-common.h    |  3 +++
 arch/powerpc/kernel/head_8xx.S           |  3 ---
 arch/powerpc/mm/pgtable_32.c             | 14 ++++++++++++
 7 files changed, 56 insertions(+), 27 deletions(-)
