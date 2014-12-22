Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id CBC721A0C8B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 21:14:48 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH v3 0/2] powerpc32: handle inverted _PAGE_RW bit outside of TLB
 handlers
Message-Id: <20141222101444.3F5DD1A5E15@localhost.localdomain>
Date: Mon, 22 Dec 2014 11:14:43 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some powerpc like the 8xx don't have a RW bit in PTE bits but a RO (Read Only) bit.
This patch implements the handling of a _PAGE_RO flag to be used in place of _PAGE_RW

Patchset:
1) powerpc32: adds handling of _PAGE_RO
2) powerpc/8xx: use _PAGE_RO instead of _PAGE_RW

All changes have been successfully tested on MPC885

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v2 is a complete rework compared to v1
v3 takes into account comments from Scott on v2

 arch/powerpc/include/asm/pgtable-ppc32.h | 12 +++++++-----
 arch/powerpc/include/asm/pgtable.h       |  7 +++++--
 arch/powerpc/include/asm/pte-8xx.h       |  9 ++++-----
 arch/powerpc/include/asm/pte-common.h    | 25 +++++++++++++++++--------
 arch/powerpc/kernel/head_8xx.S           |  3 ---
 arch/powerpc/mm/gup.c                    |  2 ++
 arch/powerpc/mm/pgtable_32.c             |  2 +-
 7 files changed, 36 insertions(+), 24 deletions(-)
