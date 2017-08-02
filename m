Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMvjM71k8zDsTg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 23:51:03 +1000 (AEST)
Message-Id: <cover.1501679953.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 0/5] powerpc/mm: Fix kernel protection and implement
 STRICT_KERNEL_RWX on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  2 Aug 2017 15:50:58 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set implements STRICT_KERNEL_RWX on Powerpc32
after fixing a few issues related to kernel code page protection.

At the end we take the opportunity to get rid of some unneccessary/outdated
fixmap stuff.

Changes from v2 to v3:
* Rebased on latest linux-powerpc/merge branch
* Function remap_init_ram() renamed mark_initmem_nx() to match new
  PPC64 implementation

Changes from v1 to v2:
* Rebased on latest linux-next following including of STRICT_KERNEL_RWX for PPC64
* Removed from the serie the two patches already applied.

Christophe Leroy (5):
  powerpc/mm: Ensure change_page_attr() doesn't invalidate pinned TLBs
  powerpc/mm: Fix kernel RAM protection after freeing unused memory on
    PPC32
  powerpc/mm: Implement STRICT_KERNEL_RWX on PPC32
  powerpc/mm: declare some local functions static
  powerpc/mm: Simplify __set_fixmap()

 arch/powerpc/Kconfig                         |  2 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h |  3 --
 arch/powerpc/include/asm/fixmap.h            | 10 +++--
 arch/powerpc/include/asm/nohash/32/pgtable.h |  3 --
 arch/powerpc/include/asm/pgtable.h           |  2 +-
 arch/powerpc/kernel/vmlinux.lds.S            |  2 +-
 arch/powerpc/mm/init_32.c                    |  6 +++
 arch/powerpc/mm/pgtable_32.c                 | 66 ++++++++++++++++++----------
 8 files changed, 58 insertions(+), 36 deletions(-)

-- 
2.13.3
