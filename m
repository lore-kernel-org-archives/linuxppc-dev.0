Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 49A291A04EC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 20:14:35 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH v2 0/2] powerpc32: handle inverted _PAGE_RW bit outside of TLB
 handlers
Message-Id: <20141217091431.AD47B1A5E0F@localhost.localdomain>
Date: Wed, 17 Dec 2014 10:14:31 +0100 (CET)
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

 arch/powerpc/include/asm/pgtable-ppc32.h | 11 ++++++-----
 arch/powerpc/include/asm/pgtable.h       | 10 +++++++---
 arch/powerpc/include/asm/pte-8xx.h       |  7 +++----
 arch/powerpc/include/asm/pte-common.h    | 27 ++++++++++++++++++---------
 arch/powerpc/kernel/head_8xx.S           |  3 ---
 arch/powerpc/mm/gup.c                    |  2 ++
 arch/powerpc/mm/mem.c                    |  2 +-
 arch/powerpc/mm/pgtable_32.c             | 24 ++++++++++++++++++++----
 8 files changed, 57 insertions(+), 29 deletions(-)
