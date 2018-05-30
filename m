Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wxFV6HB5zDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 02:41:49 +1000 (AEST)
Message-Id: <cover.1527697995.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 0/8] Remove unneccessary included headers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 May 2018 16:41:43 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The purpose of this serie is to limit the number of includes to
only the necessary ones in order to reduce the number of files
recompiled everytime a header file is modified.

This is the start of the work, please provide feedback if any so
that I don't go in the wrong direction.

Christophe Leroy (8):
  powerpc: remove kdump.h from page.h
  powerpc: remove unneeded inclusions of cpu_has_feature.h
  powerpc: remove superflous inclusions of asm-compat.h
  powerpc: remove superflous inclusions of asm/feature-fixups.h
  powerpc: remove superflous inclusions of asm/fixmap.h
  powerpc: declare set_breakpoint() static
  powerpc/book3s: Remove PPC_PIN_SIZE
  powerpc: fix includes in asm/processor.h

 arch/powerpc/include/asm/book3s/32/pgtable.h |  5 -----
 arch/powerpc/include/asm/cacheflush.h        |  1 -
 arch/powerpc/include/asm/cputable.h          |  2 --
 arch/powerpc/include/asm/cputime.h           |  1 -
 arch/powerpc/include/asm/dbell.h             |  1 -
 arch/powerpc/include/asm/debug.h             |  1 -
 arch/powerpc/include/asm/dt_cpu_ftrs.h       |  3 ---
 arch/powerpc/include/asm/feature-fixups.h    |  2 ++
 arch/powerpc/include/asm/firmware.h          |  1 -
 arch/powerpc/include/asm/fixmap.h            |  2 --
 arch/powerpc/include/asm/hw_breakpoint.h     |  1 +
 arch/powerpc/include/asm/mmu.h               |  1 -
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/page.h              |  1 -
 arch/powerpc/include/asm/ppc-opcode.h        |  1 -
 arch/powerpc/include/asm/processor.h         |  5 ++---
 arch/powerpc/include/asm/reg.h               |  1 +
 arch/powerpc/kernel/head_8xx.S               |  1 -
 arch/powerpc/kernel/process.c                | 14 +++++++-------
 arch/powerpc/kernel/setup_32.c               |  1 +
 arch/powerpc/kernel/vdso.c                   |  1 -
 arch/powerpc/mm/dump_hashpagetable.c         |  1 -
 arch/powerpc/sysdev/cpm_common.c             |  1 -
 23 files changed, 15 insertions(+), 35 deletions(-)

-- 
2.13.3
