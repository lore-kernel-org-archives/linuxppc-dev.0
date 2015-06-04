Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6D5C1A0889
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:15 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:43:14 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8E761357804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:10 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546h24E65994846
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:10 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546gbtH004579
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:42:38 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 00/42] PowerPC/PowerNV: PCI Slot Management
Date: Thu,  4 Jun 2015 16:41:29 +1000
Message-Id: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
is released. PATCH[1 - 24] are related to this part.

>From skiboot perspective, PCI slot is providing (hot/fundamental/complete)
resets to EEH. The kernel gets to know if skiboot supports various reset on one
particular PCI slot through device-tree node. If it does, EEH will utilize the
functionality provided by skiboot. Besides, the device-tree nodes have to change
in order to support PCI hotplug. For example, when one PCI adapter inserted to
one slot, its device-tree node should be added to the system dynamically. Conversely,
the device-tree node should be removed from the system when the PCI adapter is going
to be offline. Since pci_dn and eeh_dev have same life cyle as PCI device nodes,
they should be added/removed accordingly during PCI hotplug. PATCH[25 - 38] are
doing the related work.

The OF driver is changed to support unflattening FDT blob for sub-stree, which
is covered by PATCH[39 - 41].

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
v5:
   * Rebased to 4.1.rc6 and some unmerged patches as below:
     Alexey's DDW patchset (v11);
     Gavin's EEH error injection support (in mpe's next branch);
     Richard's EEH cleanup patches (in mpe's next branch);
     Richard's EEH support for VF (v7);
     Gavin's misc EEH fixes for 4.2;
   * The revision bases on skiboot corresponding patches (v7):
     https://patchwork.ozlabs.org/patch/480437/
   * Utilize OF overlay to update device-tree with help of newly introduced
     OPAL API opal_get_overlay_dt().
   * Split patches for easy review according to aik's comments.
   * Fix coding style from checkpatchc.pl as pointed by aik.
   * Code cleanup and misc fixup according to aik's input.
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


Gavin Shan (42):
  PCI: Add pcibios_setup_bridge()
  powerpc/powernv: Enable M64 on P7IOC
  powerpc/powernv: M64 support improvement
  powerpc/powernv: Trace consumed IO and M32 segments by PE
  powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
  powerpc/powernv: Improve IO and M32 mapping
  powerpc/powernv: Calculate PHB's DMA weight dynamically
  powerpc/powernv: DMA32 cleanup
  powerpc/powernv: pnv_ioda_setup_dma() configure one PE only
  powerpc/powernv: Trace DMA32 segments consumed by PE
  powerpc/powernv: Increase PE# capacity
  powerpc/pci: Cleanup on pci_controller_ops
  powerpc/pci: Override pcibios_setup_bridge()
  powerpc/powernv: Allocate PE# in deasending order
  powerpc/powernv: Reserve PE# for root bus
  powerpc/powernv: Create PEs dynamically
  powerpc/powernv: PE oriented during configuration
  powerpc/powernv: Helper function pnv_ioda_init_pe()
  powerpc/powernv: Remove DMA32 list of PEs
  powerpc/powernv: Rename pnv_ioda_get_pe() to pnv_ioda_dev_to_pe()
  powerpc/powernv: Drop pnv_ioda_setup_dev_PE()
  powerpc/powernv: Move functions around
  powerpc/powernv: Cleanup on pnv_pci_ioda2_release_dma_pe()
  powerpc/powernv: Release PEs dynamically
  powerpc/powernv: Supports slot ID
  powerpc/powernv: Use PCI slot reset infrastructure
  powerpc/powernv: Simplify pnv_eeh_reset()
  powerpc/powernv: Don't cover root bus in pnv_pci_reset_secondary_bus()
  powerpc/powernv: Issue fundamental reset in
    pnv_pci_reset_secondary_bus()
  powerpc/pci: Don't scan empty slot
  powerpc/pci: Move pcibios_find_pci_bus() around
  powerpc/powernv: Introduce pnv_pci_poll()
  powerpc/powernv: Functions to get/reset PCI slot status
  powerpc/pci: Delay creating pci_dn
  powerpc/pci: Create eeh_dev while creating pci_dn
  powerpc/pci: Export traverse_pci_device_nodes()
  powerpc/pci: Update bridge windows on PCI plugging
  powerpc/powernv: Select OF_OVERLAY
  drivers/of: Unflatten nodes equal or deeper than specified level
  drivers/of: Allow to specify root node in of_fdt_unflatten_tree()
  drivers/of: Return allocated memory chunk from of_fdt_unflatten_tree()
  pci/hotplug: PowerPC PowerNV PCI hotplug driver

 MAINTAINERS                                    |    6 +
 arch/powerpc/include/asm/eeh.h                 |    6 +-
 arch/powerpc/include/asm/opal-api.h            |    8 +-
 arch/powerpc/include/asm/opal.h                |    8 +-
 arch/powerpc/include/asm/pci-bridge.h          |   14 +-
 arch/powerpc/include/asm/pnv-pci.h             |    7 +
 arch/powerpc/include/asm/ppc-pci.h             |    8 +-
 arch/powerpc/kernel/eeh_dev.c                  |   20 +-
 arch/powerpc/kernel/pci-common.c               |   16 +-
 arch/powerpc/kernel/pci-hotplug.c              |   44 +-
 arch/powerpc/kernel/pci_dn.c                   |   91 +-
 arch/powerpc/platforms/maple/pci.c             |   35 +-
 arch/powerpc/platforms/pasemi/pci.c            |    3 -
 arch/powerpc/platforms/powermac/pci.c          |   39 +-
 arch/powerpc/platforms/powernv/Kconfig         |    1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c   |  180 +--
 arch/powerpc/platforms/powernv/opal-wrappers.S |    4 +
 arch/powerpc/platforms/powernv/pci-ioda.c      | 1770 ++++++++++++++----------
 arch/powerpc/platforms/powernv/pci.c           |   90 +-
 arch/powerpc/platforms/powernv/pci.h           |   59 +-
 arch/powerpc/platforms/pseries/msi.c           |    4 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c     |   32 -
 arch/powerpc/platforms/pseries/setup.c         |    9 +-
 drivers/of/fdt.c                               |   85 +-
 drivers/of/unittest.c                          |    2 +-
 drivers/pci/hotplug/Kconfig                    |   12 +
 drivers/pci/hotplug/Makefile                   |    4 +
 drivers/pci/hotplug/powernv_php.c              |  140 ++
 drivers/pci/hotplug/powernv_php.h              |   90 ++
 drivers/pci/hotplug/powernv_php_slot.c         |  732 ++++++++++
 drivers/pci/setup-bus.c                        |    5 +
 include/linux/of_fdt.h                         |    5 +-
 include/linux/pci.h                            |    1 +
 33 files changed, 2559 insertions(+), 971 deletions(-)
 create mode 100644 drivers/pci/hotplug/powernv_php.c
 create mode 100644 drivers/pci/hotplug/powernv_php.h
 create mode 100644 drivers/pci/hotplug/powernv_php_slot.c

-- 
2.1.0
