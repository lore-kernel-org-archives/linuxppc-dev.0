Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7JtV20yvzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 21:00:02 +1000 (AEST)
Message-Id: <cover.1492596044.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/3] powerpc/mm: Fix kernel protection and implement
 CONFIG_DEBUG_RODATA on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 19 Apr 2017 12:59:57 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set implements CONFIG_DEBUG_RODATA on Powerpc32
after fixing a few issues related to kernel code page protection.

The second patch of the set was initially submitted as standalone.
This new version takes into account Michael comments. It is part
of the set because it is now based on function change_page_attr()

Christophe Leroy (3):
  powerpc/mm: Ensure change_page_attr() doesn't invalidate pinned TLBs
  powerpc/mm: Fix kernel RAM protection after freeing unused memory on
    PPC32
  powerpc/mm: Implement CONFIG_DEBUG_RODATA on PPC32

 arch/powerpc/Kconfig.debug         | 11 +++++++
 arch/powerpc/include/asm/pgtable.h |  8 ++++++
 arch/powerpc/kernel/ftrace.c       |  2 ++
 arch/powerpc/mm/init_32.c          |  3 +-
 arch/powerpc/mm/mem.c              |  1 +
 arch/powerpc/mm/mmu_decl.h         |  3 ++
 arch/powerpc/mm/pgtable_32.c       | 59 +++++++++++++++++++++++++++++++++-----
 7 files changed, 79 insertions(+), 8 deletions(-)

-- 
2.12.0
