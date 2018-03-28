Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409pZj0345zF2F7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 11:26:04 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 0/5] PPC32/ioremap: Use memblock API to check for RAM
Date: Wed, 28 Mar 2018 02:25:39 +0200
Message-Id: <20180328002544.18526-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v1: https://www.spinics.net/lists/linux-mm/msg145939.html

This patchset makes it possible to allocate MMIO ranges that are between
the two RAM chunks on the Wii, MEM1 and MEM2, not only with ioremap
(which previously worked through a hack) but also with kernel/resource.c.

Changes in v2:
- I added back the p < virt_to_phys(high_memory) check in
  __ioremap_caller because high memory should be allocatable through
  ioremap
- I expanded the commit messages a bit

Jonathan Neuschäfer (5):
  powerpc: mm: Simplify page_is_ram by using memblock_is_memory
  powerpc: mm: Use memblock API for PPC32 page_is_ram
  powerpc/mm/32: Use page_is_ram to check for RAM
  powerpc: wii: Don't rely on the reserved memory hack
  powerpc/mm/32: Remove the reserved memory hack

 arch/powerpc/mm/init_32.c                |  5 -----
 arch/powerpc/mm/mem.c                    | 12 +-----------
 arch/powerpc/mm/mmu_decl.h               |  1 -
 arch/powerpc/mm/pgtable_32.c             |  2 +-
 arch/powerpc/platforms/embedded6xx/wii.c | 14 +-------------
 5 files changed, 3 insertions(+), 31 deletions(-)

-- 
2.16.2
