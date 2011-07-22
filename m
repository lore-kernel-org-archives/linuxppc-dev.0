Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D29A7B6F74
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jul 2011 13:46:05 +1000 (EST)
Subject: [git pull] Please pull powerpc.git of-pci branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 22 Jul 2011 13:44:13 +1000
Message-ID: <1311306253.25044.568.camel@pasglop>
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

This branch contains some rework and consolidation of the code
to establish the mapping between device-tree nodes for PCI 
devices (if they exist) and the corresponding Linux struct device.

It moves it all to generic code in a way that is a lot cleaner
than any of the previous implementations. It specifically allows
me to get rid of a two subtly different ways of doing the same
thing I had in powerpc between 32-bit and 64-bit, and updates
microblaze and x86 to use that common code as well.

This has been in -next for a while with no complaints so far
and is completely orthogonal to the powerpc changes I will send
you in a couple of days (I want to wait for some other trees
to go in first to address a couple of known collisions).

Cheers,
Ben.

The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:

  Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git of-pci

Benjamin Herrenschmidt (6):
      pci/of: Match PCI devices to OF nodes dynamically
      microblaze/pci: Remove powermac originated cruft
      microblaze/pci: Move the remains of pci_32.c to pci-common.c
      x86/devicetree: Use generic PCI <-> OF matching
      pci/of: Consolidate pci_device_to_OF_node()
      pci/of: Consolidate pci_bus_to_OF_node()

 arch/microblaze/include/asm/pci-bridge.h |   13 -
 arch/microblaze/include/asm/pci.h        |    3 +-
 arch/microblaze/include/asm/prom.h       |   15 -
 arch/microblaze/pci/Makefile             |    2 +-
 arch/microblaze/pci/pci-common.c         |  112 ++++++++
 arch/microblaze/pci/pci_32.c             |  432 ------------------------------
 arch/powerpc/include/asm/pci-bridge.h    |   29 +--
 arch/powerpc/include/asm/pci.h           |    3 +-
 arch/powerpc/include/asm/prom.h          |   14 -
 arch/powerpc/kernel/pci-common.c         |   11 +-
 arch/powerpc/kernel/pci_32.c             |  150 +----------
 arch/powerpc/kernel/pci_dn.c             |   47 ----
 arch/powerpc/kernel/pci_of_scan.c        |    9 +-
 arch/powerpc/platforms/powermac/pci.c    |    3 +-
 arch/sparc/include/asm/pci_32.h          |    3 -
 arch/sparc/include/asm/pci_64.h          |    3 -
 arch/sparc/kernel/pci.c                  |    8 +-
 arch/sparc/kernel/pcic.c                 |    8 -
 arch/x86/include/asm/prom.h              |   11 -
 arch/x86/kernel/devicetree.c             |   60 ++---
 drivers/of/Kconfig                       |    8 +-
 drivers/of/Makefile                      |    1 +
 drivers/of/of_pci.c                      |  112 ++------
 drivers/of/of_pci_irq.c                  |   92 +++++++
 drivers/pci/Makefile                     |    2 +
 drivers/pci/hotplug/rpadlpar_core.c      |    2 +-
 drivers/pci/of.c                         |   61 +++++
 drivers/pci/probe.c                      |    7 +-
 include/linux/of_pci.h                   |    5 +
 include/linux/pci.h                      |   28 ++
 30 files changed, 395 insertions(+), 859 deletions(-)
 delete mode 100644 arch/microblaze/pci/pci_32.c
 create mode 100644 drivers/of/of_pci_irq.c
 create mode 100644 drivers/pci/of.c
