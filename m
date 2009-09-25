Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96413B7B7A
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 10:15:42 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 25 Sep 2009 10:15:32 +1000
Message-Id: <1253837732.7103.484.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here are a few more powerpc bits for 2.6.32. Mostly bug fixes, and a couple
of performance nits from Anton.

Cheers,
Ben.

The following changes since commit 94a8d5caba74211ec76dac80fc6e2d5c391530df:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../rusty/linux-2.6-for-linus

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Anton Blanchard (4):
      powerpc: Move 64bit heap above 1TB on machines with 1TB segments
      powerpc/perf_counter: Fix vdso detection
      powerpc: Increase NODES_SHIFT on 64bit from 4 to 8
      powerpc: Fix ibm,client-architecture-support printout

Becky Bruce (2):
      powerpc: Rename get_dma_direct_offset get_dma_offset
      powerpc: Change archdata dma_data to a union

Benjamin Herrenschmidt (3):
      powerpc/pmc: Don't access lppaca on Book3E
      powerpc/mm: Fix 40x and 8xx vs. _PAGE_SPECIAL
      Fix build of cpm_uart due to core changes

Hendrik Brueckner (1):
      hvc_console: Provide (un)locked version for hvc_resize()

Huang Weiyi (2):
      powerpc/book3e-64: Remove duplicated #include
      powerpc/mm: Remove duplicated #include

Josh Boyer (1):
      powerpc/4xx: Fix erroneous xmon warning on PowerPC 4xx

Rex Feany (1):
      powerpc/8xx: Fix regression introduced by cache coherency rewrite

Tim Abbott (1):
      powerpc: Cleanup linker script using new linker script macros.

Tony Breeds (1):
      powerpc: Check for unsupported relocs when using CONFIG_RELOCATABLE

roel kluin (1):
      powerpc: kmalloc failure ignored in vio_build_iommu_table()

 arch/powerpc/Kconfig                     |    6 +++
 arch/powerpc/Makefile                    |   11 +++++
 arch/powerpc/include/asm/device.h        |   11 ++++-
 arch/powerpc/include/asm/dma-mapping.h   |   27 ++++++++++-
 arch/powerpc/include/asm/iommu.h         |   10 ++++
 arch/powerpc/include/asm/pmc.h           |    2 +-
 arch/powerpc/include/asm/pte-40x.h       |    1 +
 arch/powerpc/include/asm/pte-8xx.h       |    1 +
 arch/powerpc/include/asm/pte-common.h    |    5 --
 arch/powerpc/kernel/dma-iommu.c          |   16 +++---
 arch/powerpc/kernel/dma.c                |   15 ++-----
 arch/powerpc/kernel/exceptions-64e.S     |    1 -
 arch/powerpc/kernel/pci-common.c         |    2 +-
 arch/powerpc/kernel/process.c            |   17 +++++++-
 arch/powerpc/kernel/prom_init.c          |    3 +-
 arch/powerpc/kernel/vdso.c               |   14 ++++--
 arch/powerpc/kernel/vio.c                |    4 +-
 arch/powerpc/kernel/vmlinux.lds.S        |   69 ++++++-----------------------
 arch/powerpc/mm/pgtable.c                |   19 +++++++-
 arch/powerpc/mm/tlb_low_64e.S            |    1 -
 arch/powerpc/platforms/cell/beat_iommu.c |    2 +-
 arch/powerpc/platforms/cell/iommu.c      |    9 +---
 arch/powerpc/platforms/iseries/iommu.c   |    2 +-
 arch/powerpc/platforms/pasemi/iommu.c    |    2 +-
 arch/powerpc/platforms/pseries/iommu.c   |    8 ++--
 arch/powerpc/relocs_check.pl             |   56 ++++++++++++++++++++++++
 arch/powerpc/sysdev/dart_iommu.c         |    2 +-
 arch/powerpc/xmon/xmon.c                 |   16 ++++++-
 drivers/char/hvc_console.c               |    6 +-
 drivers/char/hvc_console.h               |   12 +++++-
 drivers/char/hvc_iucv.c                  |    4 +-
 drivers/serial/cpm_uart/cpm_uart_core.c  |    2 +-
 32 files changed, 237 insertions(+), 119 deletions(-)
 create mode 100755 arch/powerpc/relocs_check.pl
