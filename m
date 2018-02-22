Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znCxB3ndczF15j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 23:15:41 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
 Christophe LEROY <christophe.leroy@c-s.fr>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/5] PPC32/ioremap: Use memblock API to check for RAM
Date: Thu, 22 Feb 2018 13:15:11 +0100
Message-Id: <20180222121516.23415-1-j.neuschaefer@gmx.net>
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

This patchset solves the same problem as my previous one[1] but follows
a rather different approach. Instead of implementing DISCONTIGMEM for
PowerPC32, I simply switched the "is this RAM" check in __ioremap_caller
to the existing page_is_ram function, and unified page_is_ram to search
memblock.memory on PPC64 and PPC32.

The intended result is, as before, that my Wii can allocate the MMIO
range of its GPIO controller, which was previously not possible, because
the reserved memory hack (__allow_ioremap_reserved) didn't affect the
API in kernel/resource.c.

Thanks to Christophe Leroy for reviewing the previous patchset.

[1]: https://www.spinics.net/lists/kernel/msg2726786.html

Jonathan Neuschäfer (5):
  powerpc: mm: Simplify page_is_ram by using memblock_is_memory
  powerpc: mm: Use memblock API for PPC32 page_is_ram
  powerpc/mm/32: Use page_is_ram to check for RAM
  powerpc: wii: Don't rely on the reserved memory hack
  powerpc/mm/32: Remove the reserved memory hack

 arch/powerpc/mm/init_32.c                |  5 -----
 arch/powerpc/mm/mem.c                    | 12 +-----------
 arch/powerpc/mm/mmu_decl.h               |  1 -
 arch/powerpc/mm/pgtable_32.c             |  4 +---
 arch/powerpc/platforms/embedded6xx/wii.c | 14 +-------------
 5 files changed, 3 insertions(+), 33 deletions(-)

-- 
2.16.1
