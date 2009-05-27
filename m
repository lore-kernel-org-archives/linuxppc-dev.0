Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 30C9FDDF9C
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 16:41:21 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 27 May 2009 16:40:53 +1000
Message-Id: <1243406453.17847.185.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus

And here's the rest of the fixes I was talking about. Hopefully that
should bring back all non-coherent DMA platforms into proper working
conditions. It's a bit invasive so late in the process but it's been
reasonably well tested for a few days.

The following changes since commit cd86a536c81e9300d984327517548ca0652eebf9:
  Linus Torvalds (1):
        Merge branch 'x86-fixes-for-linus' of git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (4):
      Revert "powerpc: Rework dma-noncoherent to use generic vmalloc layer"
      powerpc: Move dma-noncoherent.c from arch/powerpc/lib to arch/powerpc/mm
      powerpc: Minor cleanups of kernel virt address space definitions
      powerpc: Fix up dma_alloc_coherent() on platforms without cache coherency.

 arch/powerpc/Kconfig                     |   12 +
 arch/powerpc/include/asm/dma-mapping.h   |    6 +-
 arch/powerpc/include/asm/fixmap.h        |    4 +-
 arch/powerpc/include/asm/pgtable-ppc32.h |   26 ++-
 arch/powerpc/kernel/dma.c                |    2 +-
 arch/powerpc/lib/Makefile                |    1 -
 arch/powerpc/lib/dma-noncoherent.c       |  237 ------------------
 arch/powerpc/mm/Makefile                 |    1 +
 arch/powerpc/mm/dma-noncoherent.c        |  400 ++++++++++++++++++++++++++++++
 arch/powerpc/mm/init_32.c                |    8 +-
 arch/powerpc/mm/mem.c                    |   17 ++
 arch/powerpc/mm/pgtable_32.c             |    2 -
 12 files changed, 463 insertions(+), 253 deletions(-)
 delete mode 100644 arch/powerpc/lib/dma-noncoherent.c
 create mode 100644 arch/powerpc/mm/dma-noncoherent.c
