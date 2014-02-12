Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 025032C009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 15:34:56 +1100 (EST)
Message-ID: <1392179682.3835.76.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Feb 2014 15:34:42 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here is some powerpc goodness for -rc2. Arguably -rc1 material more than
-rc2 but I was travelling (again !)

It's mostly bug fixes including regressions, but there are a couple of
new things that I decided to drop-in.

One is a straightforward patch from Michael to add a bunch of P8 cache
events to perf.

The other one is a patch by myself to add the direct DMA (iommu bypass)
for PCIe on Power8 for 64-bit capable devices. This has been around for
a while, I had lost track of it. However it's been in our internal
kernels we use for testing P8 already and it affects only P8 related
code. Since P8 is still unreleased the risk is pretty much nil at this
point.

Cheers,
Ben.

The following changes since commit b28a960c42fcd9cfc987441fa6d1c1a471f0f9ed:

  Linux 3.14-rc2 (2014-02-09 18:15:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to cd15b048445d0a54f7147c35a86c5a16ef231554:

  powerpc/powernv: Add iommu DMA bypass support for IODA2 (2014-02-11 16:07:37 +1100)

----------------------------------------------------------------
Anshuman Khandual (1):
      powerpc/perf: Configure BHRB filter before enabling PMU interrupts

Anton Blanchard (1):
      powerpc: Fix endian issues in kexec and crash dump code

Benjamin Herrenschmidt (1):
      powerpc/powernv: Add iommu DMA bypass support for IODA2

Kevin Hao (1):
      powerpc/ppc32: Fix the bug in the init of non-base exception stack for UP

Laurent Dufour (1):
      powerpc/relocate fix relocate processing in LE mode

Mahesh Salgaonkar (2):
      powerpc/pseries: Disable relocation on exception while going down during crash.
      powerpc: Fix kdump hang issue on p8 with relocation on exception enabled.

Michael Ellerman (5):
      powerpc/perf: Add Power8 cache & TLB events
      powerpc/pseries: Select ARCH_RANDOM on pseries
      powerpc/xmon: Don't loop forever in get_output_lock()
      powerpc/xmon: Fix timeout loop in get_output_lock()
      powerpc/xmon: Don't signal we've entered until we're finished printing

Nathan Fontenot (1):
      crypto/nx/nx-842: Fix handling of vmalloc addresses

Paul Gortmaker (1):
      powerpc: Fix build failure in sysdev/mpic.c for MPIC_WEIRD=y

Thadeu Lima de Souza Cascardo (1):
      powerpc/eeh: Drop taken reference to driver on eeh_rmv_device

 arch/powerpc/include/asm/dma-mapping.h    |   1 +
 arch/powerpc/include/asm/iommu.h          |   1 +
 arch/powerpc/include/asm/sections.h       |  12 +++
 arch/powerpc/kernel/dma.c                 |  10 ++-
 arch/powerpc/kernel/eeh_driver.c          |   8 +-
 arch/powerpc/kernel/iommu.c               |  12 +++
 arch/powerpc/kernel/irq.c                 |   5 ++
 arch/powerpc/kernel/machine_kexec.c       |  14 ++-
 arch/powerpc/kernel/machine_kexec_64.c    |   6 +-
 arch/powerpc/kernel/reloc_64.S            |   4 +-
 arch/powerpc/kernel/setup_32.c            |   5 ++
 arch/powerpc/mm/hash_utils_64.c           |  14 +++
 arch/powerpc/perf/core-book3s.c           |   5 +-
 arch/powerpc/perf/power8-pmu.c            | 144 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |  84 +++++++++++++++++
 arch/powerpc/platforms/powernv/pci.c      |  10 +++
 arch/powerpc/platforms/powernv/pci.h      |   6 +-
 arch/powerpc/platforms/powernv/powernv.h  |   8 ++
 arch/powerpc/platforms/powernv/setup.c    |   9 ++
 arch/powerpc/platforms/pseries/Kconfig    |   1 +
 arch/powerpc/platforms/pseries/setup.c    |   3 +-
 arch/powerpc/sysdev/mpic.c                |  38 ++++----
 arch/powerpc/xmon/xmon.c                  |  24 +++--
 drivers/crypto/nx/nx-842.c                |  29 +++---
 24 files changed, 398 insertions(+), 55 deletions(-)
