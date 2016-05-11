Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4fXM0FmgzDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 01:04:01 +1000 (AEST)
Message-Id: <cover.1462052179.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 0/7] powerpc/8xx: Optimisation of TLB handling for IMMR and
 RAM
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 11 May 2016 17:03:55 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The purpose of this set of patches is to continue on TLB handling
optimisation on the 8xx with the handling of IMMR area as a
single 512k area instead of multiple 4k pages.

This set includes a rework of linear RAM mapping in order to not use
page table but direct linear mapping. The result is equivalent to the
use of BATs on other PPCs and it avoids reading the page table.

This set also includes a rework of the handling of PIN_TLB config
option. This option used to be linked to the quantity of RAM available.
It is now independant, users having only 8M memory can also use PIN_TLB.

Christophe Leroy (7):
  powerpc/8xx: Fix vaddr for IMMR early remap
  powerpc/8xx: Map IMMR area with 512k page at a fixed address
  powerpc/8xx: CONFIG_PIN_TLB unneeded for CONFIG_PPC_EARLY_DEBUG_CPM
  powerpc/8xx: unpin all TLBs before flushing
  powerpc/8xx: Don't use page table for linear memory space
  powerpc/8xx: Rework CONFIG_PIN_TLB handling
  powerpc/8xx: add CONFIG_PIN_TLB_IMMR

 arch/powerpc/Kconfig              |   5 ++
 arch/powerpc/Kconfig.debug        |   1 -
 arch/powerpc/include/asm/fixmap.h |   7 ++
 arch/powerpc/kernel/asm-offsets.c |   8 ++
 arch/powerpc/kernel/head_8xx.S    | 159 +++++++++++++++++++-------------------
 arch/powerpc/mm/8xx_mmu.c         | 131 +++++++++++++++++++++----------
 arch/powerpc/mm/mmu_decl.h        |  10 ++-
 arch/powerpc/sysdev/cpm_common.c  |  15 +++-
 8 files changed, 211 insertions(+), 125 deletions(-)

-- 
v2: Fixed a test in the 6/7
2.1.0
