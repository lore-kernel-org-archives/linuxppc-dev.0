Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id E370E1A011D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 19:13:27 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2 00/19] powerpc/8xx: Optimise MMU TLB handling and add
 support of 16k pages
Message-Id: <20140829091324.D71E61ABD63@localhost.localdomain>
Date: Fri, 29 Aug 2014 11:13:24 +0200 (CEST)
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

The two differences with first version of the patch are:
1) I removed the patch number 10, which was implementing a 16 bit alignment of the
PGDIR. It is not worth potentially wasting up to 64k of memory just for removing one
instruction (ori).
2) I managed to preserve r11 while calculating the level 2 address, therefore
no more need to save r11 into CR.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

 arch/powerpc/Kconfig                     |    2 +-
 arch/powerpc/include/asm/mmu-8xx.h       |    2 +
 arch/powerpc/include/asm/pgtable-ppc32.h |   21 ++
 arch/powerpc/include/asm/pte-8xx.h       |    7 +-
 arch/powerpc/include/asm/reg.h           |    3 +-
 arch/powerpc/kernel/head_8xx.S           |  342 +++++++++++-------------
 6 files changed, 187 insertions(+), 190 deletions(-)
