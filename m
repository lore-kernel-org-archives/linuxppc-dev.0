Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXwy475VzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:58:42 +1000 (AEST)
Message-Id: <cover.1502191399.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 00/12] powerpc/8xx: Some cleanup
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  8 Aug 2017 13:58:37 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This serie does some cleanup in the area of the 8xx.

In the same spirit as what Michael did for 4xx, move 8xx
specific stuff into platforms/8xx

Then try to reduce the amount of #ifdefs specific to 8xx

Remove the CONFIG_8xx which is redundant with CONFIG_PPC_8xx

Plus some misc cleanups

Christophe Leroy (12):
  powerpc/8xx: Simplify CONFIG_8xx checks in Makefile
  powerpc/8xx: Move 8xx machine check handlers into platforms/8xx
  powerpc/8xx: Remove SoftwareEmulation()
  powerpc/cpm1: link to CONFIG_CPM1 instead of CONFIG_8xx
  powerpc/8xx: Move mpc8xx_pic.c from sysdev to platform/8xx
  powerpc/time: refactor MFTB() to limit number of ifdefs
  powerpc/kconfig: Simplify PCI_QSPAN selection
  powerpc/8xx: Getting rid of remaining use of CONFIG_8xx
  powerpc/8xx: remove CONFIG_8xx
  powerpc/8xx: Use symbolic PVR value
  powerpc/8xx: Use symbolic names for DSISR bits in DSI
  powerpc/8xx: Remove cpu dependent macro instructions from head_8xx

 arch/powerpc/Kconfig                               |  8 ++--
 arch/powerpc/Makefile                              |  2 +-
 arch/powerpc/boot/Makefile                         |  4 +-
 arch/powerpc/boot/ppc_asm.h                        |  8 ++++
 arch/powerpc/boot/util.S                           | 24 +++---------
 arch/powerpc/include/asm/cache.h                   |  2 +-
 arch/powerpc/include/asm/cputable.h                |  4 +-
 arch/powerpc/include/asm/fs_pd.h                   |  2 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |  2 +-
 arch/powerpc/include/asm/ppc_asm.h                 | 14 +++++--
 arch/powerpc/include/asm/reg.h                     | 16 ++++----
 arch/powerpc/include/asm/timex.h                   |  6 +--
 arch/powerpc/kernel/Makefile                       |  2 +-
 arch/powerpc/kernel/cputable.c                     |  6 +--
 arch/powerpc/kernel/head_8xx.S                     |  9 ++---
 arch/powerpc/kernel/irq.c                          |  2 +-
 arch/powerpc/kernel/kgdb.c                         |  4 +-
 arch/powerpc/kernel/traps.c                        | 43 ----------------------
 arch/powerpc/kernel/vdso32/gettimeofday.S          | 12 ++----
 arch/powerpc/mm/fault.c                            |  4 +-
 arch/powerpc/mm/mem.c                              |  2 +-
 arch/powerpc/mm/mmu_decl.h                         | 10 ++---
 arch/powerpc/mm/tlb_nohash_low.S                   |  2 +-
 arch/powerpc/platforms/8xx/Kconfig                 |  1 -
 arch/powerpc/platforms/8xx/Makefile                |  2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c            |  2 +-
 arch/powerpc/platforms/8xx/machine_check.c         | 37 +++++++++++++++++++
 .../{sysdev/mpc8xx_pic.c => platforms/8xx/pic.c}   |  2 +-
 .../{sysdev/mpc8xx_pic.h => platforms/8xx/pic.h}   |  0
 arch/powerpc/platforms/Kconfig.cputype             |  7 +---
 arch/powerpc/sysdev/Makefile                       |  2 +-
 arch/powerpc/sysdev/fsl_soc.c                      |  2 +-
 arch/powerpc/sysdev/fsl_soc.h                      |  2 +-
 33 files changed, 109 insertions(+), 136 deletions(-)
 create mode 100644 arch/powerpc/platforms/8xx/machine_check.c
 rename arch/powerpc/{sysdev/mpc8xx_pic.c => platforms/8xx/pic.c} (99%)
 rename arch/powerpc/{sysdev/mpc8xx_pic.h => platforms/8xx/pic.h} (100%)

-- 
2.13.3
