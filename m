Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKKR4wxGzDrcW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:32:59 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 00/15] PCI: turn some __weak functions into callbacks
Date: Fri, 17 Aug 2018 12:26:30 +0200
Message-Id: <20180817102645.3839621-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bjorn and others,

Triggered by Christoph's patches, I had another go at converting
all of the remaining pci host bridge implementations to be based
on pci_alloc_host_bridge and a separate registration function.

This is made possible through work from Lorenzo and others to
convert many of the existing drivers, as well as the removal
of some of the older architectures that nobody used.

I'm adding a bit of duplication into the less maintained code
here, but it makes everything more consistent, and gives an
easy place to hook up callback functions etc.

The three parts of this series are:

a) push up the registration into the callers (this is where
   code gets added)
b) clean up some of the more common host bridge
   implementations again to integrate that code better.
   This could be done for the rest as well, or we could just
   leave them alone.
c) start moving the __weak functions into callbacks in
   pci_host_bridge. This is intentionally incomplete, since
   it is a lot of work to do it for all those functions,
   and I want to get consensus on the approach first, as well
   as maybe get other developers to help out with the rest.

Please have a look.

       Arnd

[1] https://lore.kernel.org/lkml/4288331.jNpl6KXlNO@wuerfel/
[2] https://patchwork.kernel.org/patch/10555657/

Arnd Bergmann (15):
  PCI: clean up legacy host bridge scan functions
  PCI: move pci_scan_bus into callers
  PCI: move pci_scan_root_bus into callers
  PCI: export pci_register_host_bridge
  PCI: move pci_create_root_bus into callers
  powerpc/pci: fold pci_create_root_bus into pcibios_scan_phb
  PCI/ACPI: clean up acpi_pci_root_create()
  x86: PCI: clean up pcibios_scan_root()
  PCI: xenfront: clean up pcifront_scan_root()
  sparc/PCI: simplify pci_scan_one_pbm
  PCI: hyperv: convert to pci_scan_root_bus_bridge
  PCI: make pcibios_bus_add_device() a callback function
  PCI: turn pcibios_alloc_irq into a callback
  PCI: make pcibios_root_bridge_prepare a callback
  PCI: make pcibios_add_bus/remove_bus callbacks

 arch/arm64/kernel/pci.c               |  40 ++-----
 arch/ia64/pci/pci.c                   |  25 +----
 arch/ia64/sn/kernel/io_init.c         |  27 +++++
 arch/microblaze/pci/pci-common.c      |  27 +++++
 arch/powerpc/include/asm/pci-bridge.h |   3 +
 arch/powerpc/kernel/pci-common.c      |  60 +++++------
 arch/s390/pci/pci.c                   |  30 +++++-
 arch/sh/drivers/pci/pci.c             |   1 +
 arch/sh/drivers/pci/pcie-sh7786.c     |   3 +-
 arch/sh/include/asm/pci.h             |   2 +
 arch/sparc/kernel/pci.c               |  40 ++++---
 arch/sparc/kernel/pcic.c              |  35 ++++++
 arch/x86/pci/acpi.c                   |  15 +--
 arch/x86/pci/common.c                 |  42 ++++----
 arch/xtensa/kernel/pci.c              |  27 +++++
 drivers/acpi/pci_root.c               |  43 +++++---
 drivers/parisc/dino.c                 |  28 +++++
 drivers/parisc/lba_pci.c              |  28 +++++
 drivers/pci/bus.c                     |   8 +-
 drivers/pci/controller/pci-hyperv.c   |  47 ++++----
 drivers/pci/controller/vmd.c          |  30 +++++-
 drivers/pci/hotplug/ibmphp_core.c     |  35 ++++++
 drivers/pci/pci-driver.c              |  13 ++-
 drivers/pci/probe.c                   | 150 +++++++++-----------------
 drivers/pci/xen-pcifront.c            |  40 +++----
 include/linux/acpi.h                  |   2 +
 include/linux/pci.h                   |  17 ++-
 27 files changed, 514 insertions(+), 304 deletions(-)

-- 
2.18.0
