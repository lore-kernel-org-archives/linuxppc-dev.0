Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC8A21A025F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 16:04:11 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 May 2015 16:04:10 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 57A6C2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 16:04:07 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4163xao42598628
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 16:04:07 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4163Xnl000445
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 16:03:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 00/21] PowerPC/PowerNV: PCI Slot Management
Date: Fri,  1 May 2015 16:02:47 +1000
Message-Id: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches intend to support PCI slot for PowerPC PowerNV platform,
which is running on top of skiboot firmware. The patchset requires corresponding
changes from skiboot firmware, which is sent to skiboot@lists.ozlabs.org
for review. The PCI slots are exposed by skiboot with device node properties,
and kernel utilizes those properties to populated PCI slots accordingly.

The original PCI infrastructure on PowerNV platform can't support hotplug 
because the PE is assigned during PHB fixup time, which is called for once
during system boot time. For this, the PCI infrastructure on PowerNV platform
has been reworked for a lot. After that, the PE and its corresponding resources
(IODT, M32DT, M64 segments, DMA32 and bypass window) are assigned upon updating
PCI bridge's resources, which might decide PE# assigned to the PE (e.g. M64
resources, on P8 strictly speaking). Each PE will maintain a reference count,
which is (number of child PCI devices + 1). That indicates when last child PCI
device leaves the PE, the PE and its included resources will be relased and put
back into free pool again. With this design, the PE will be released when EEH PE
is released. PATCH[1 - 8] are related to this part.

>From skiboot perspective, PCI slot is providing (hot/fundamental/complete) 
resets to EEH. The kernel gets to know if skiboot supports various reset on one 
particular PCI slot through device-tree node. If it does, EEH will utilize the 
functionality provided by skiboot. Besides, the device-tree nodes have to change
in order to support PCI hotplug. For example, when one PCI adapter inserted to
one slot, its device-tree node should be added to the system dynamically. Conversely,
the device-tree node should be removed from the system when the PCI adapter is going
to be offline. Since pci_dn and eeh_dev have same life cyle as PCI device nodes,
they should be added/removed accordingly during PCI hotplug. Patch[9 - 20] are
doing the related work.

The last patch is the standalone PCI hotplug driver for PowerNV platform. When
removing PCI adapter from one PCI slot, which is invoked by command in userland,
the skiboot will power off the slot to save power and remove all device-tree
nodes for all PCI devices behind the slot. Conversely, the Power to the slot
is turned on, the PCI devices behind the slot is rescanned, and the device-tree
nodes for those newly detected PCI devices will be built in skiboot. For both
of cases, one message will be sent to kernel by skiboot so that the kernel
can adjust the device-tree accordingly. At the same time, the kernel also have
to deallocate or allocate PE# and its related resources (PE# and so on) for the
removed/added PCI devices.

Changelog
=========
v4:
   * Rebased to 4.1.RC1
   * Added API to unflatten FDT blob to device node sub-tree, which is attached
     the indicated parent device node. The original mechanism based on formatted
     string stream has been dropped.
   * The PATCH[v3 09/21] ("powerpc/eeh: Delay probing EEH device during hotplug")
     was picked up sent to linux-ppc@ separately for review as Richard's "VF EEH
     Support" depends on that.
v3:
   * Rebased to 4.1.RC0
   * PowerNV PCI infrasturcture is total refactored in order to support PCI
     hotplug. The PowerNV hotplug driver is also reworked a lot because of
     the changes in skiboot in order to support PCI hotplug.

Gavin Shan (21):
  pci: Add pcibios_setup_bridge()
  powerpc/powernv: Enable M64 on P7IOC
  powerpc/powernv: M64 support improvement
  powerpc/powernv: Improve IO and M32 mapping
  powerpc/powernv: Improve DMA32 segment assignment
  powerpc/powernv: Create PEs dynamically
  powerpc/powernv: Release PEs dynamically
  powerpc/powernv: Drop pnv_ioda_setup_dev_PE()
  powerpc/powernv: Use PCI slot reset infrastructure
  powerpc/powernv: Fundamental reset for PCI bus reset
  powerpc/pci: Don't scan empty slot
  powerpc/pci: Move pcibios_find_pci_bus() around
  powerpc/powernv: Introduce pnv_pci_poll()
  powerpc/powernv: Functions to get/reset PCI slot status
  powerpc/pci: Delay creating pci_dn
  powerpc/pci: Create eeh_dev while creating pci_dn
  powerpc/pci: Export traverse_pci_device_nodes()
  powerpc/pci: Update bridge windows on PCI plugging
  drivers/of: Support adding sub-tree
  powerpc/powernv: Select OF_DYNAMIC
  pci/hotplug: PowerPC PowerNV PCI hotplug driver

 arch/powerpc/include/asm/eeh.h                 |    7 +-
 arch/powerpc/include/asm/opal-api.h            |    7 +-
 arch/powerpc/include/asm/opal.h                |    7 +-
 arch/powerpc/include/asm/pci-bridge.h          |    7 +-
 arch/powerpc/include/asm/pnv-pci.h             |    5 +
 arch/powerpc/include/asm/ppc-pci.h             |    7 +-
 arch/powerpc/kernel/eeh_dev.c                  |   20 +-
 arch/powerpc/kernel/pci-common.c               |   18 +-
 arch/powerpc/kernel/pci-hotplug.c              |   44 +-
 arch/powerpc/kernel/pci_dn.c                   |  119 +-
 arch/powerpc/platforms/maple/pci.c             |   35 +-
 arch/powerpc/platforms/pasemi/pci.c            |    3 -
 arch/powerpc/platforms/powermac/pci.c          |   39 +-
 arch/powerpc/platforms/powernv/Kconfig         |    1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c   |  245 ++--
 arch/powerpc/platforms/powernv/opal-wrappers.S |    3 +
 arch/powerpc/platforms/powernv/pci-ioda.c      | 1657 +++++++++++++++---------
 arch/powerpc/platforms/powernv/pci.c           |   64 +-
 arch/powerpc/platforms/powernv/pci.h           |   52 +-
 arch/powerpc/platforms/pseries/msi.c           |    4 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c     |   32 -
 arch/powerpc/platforms/pseries/setup.c         |    9 +-
 drivers/of/dynamic.c                           |   19 +-
 drivers/of/fdt.c                               |  133 +-
 drivers/pci/hotplug/Kconfig                    |   12 +
 drivers/pci/hotplug/Makefile                   |    4 +
 drivers/pci/hotplug/powernv_php.c              |  146 +++
 drivers/pci/hotplug/powernv_php.h              |   78 ++
 drivers/pci/hotplug/powernv_php_slot.c         |  643 +++++++++
 drivers/pci/setup-bus.c                        |   12 +-
 include/linux/of.h                             |    2 +
 include/linux/of_fdt.h                         |    1 +
 include/linux/pci.h                            |    1 +
 33 files changed, 2473 insertions(+), 963 deletions(-)
 create mode 100644 drivers/pci/hotplug/powernv_php.c
 create mode 100644 drivers/pci/hotplug/powernv_php.h
 create mode 100644 drivers/pci/hotplug/powernv_php_slot.c

-- 
2.1.0
