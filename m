Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9yzp13PPzDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:46 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 20 May 2016 16:42:45 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 10A553578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:41 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4K6gXMX61210734
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:41 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4K6g8bo024904
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:08 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 alistair@popple.id.au, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v10 00/18] powerpc/powernv: PCI hotplug support
Date: Fri, 20 May 2016 16:41:24 +1000
Message-Id: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches need corresponding changes in firmware side to
fully function. Without the firmware changes, the PCI hotplug driver
won't detect and populate any PCI slots. So the code changes are compatible
to old firmware. The firmware patches can be found from:

   https://patchwork.ozlabs.org/patch/624317/

The series of patches is highlighted as below:

   * In order to create PE during PCI hot plugging, pcibios_setup_bridge()
     which is called to update bridge's window populates the PE, together
     with the associated resources like IO/M32/M64 segments, DMA windows etc.
   * One refcount is maintained by each PE to track the number of PCI devices
     that are associated with the PE. The refcount is increased by one when
     a new PCI device joins the PE. It is decreased by one when a PCI device
     is released (pcibios_release_device()). The PE together with the used
     resources will be destroyed when refcount reaches to 0, meaning no PCI
     device needs the PE any more.
   * If the firmware has capability to support PCI slot and reset functionality,
     the reset required by EEH recovery is routed to firmware. Otherwise, it
     is done in kernel as before.
   * PCI hotplug driver for PowerNV platform. The PCI slots are identified by
     firmware and exposed to kernel through device tree. Firmware provides APIs
     to get presence/power state or set power state from/to PCI slot. The PCI
     slot hotplug state is sychronized with its power state. When user changes
     PCI slot power state from off to on through sysfs file, the PCI devices
     behind the PCI slot will be brought into online. Otherwise, the PCI slot's
     subordinate devices will be removed from the system.

Changelog
=========
v10:
   * Rebased to linux-next where the prerequisite patches merged to.
   * Drop FDT patches that have been merged to linux-next.
   * Export pnv_pci_get_slot_id() for CAPI driver to use in future.
   * Use asynchronous message, the driver is simplifed greatly. No
     need to have workqueue and synchronization mechanism for it.
   * Fixed build warning/error when IOMMU_API is disabled.
v9:
   * Rebased to linux-powerpc next branch + (A).
   * Patch order, split and merge (Alexey / Alistair)
   * Lots of misc comments covered, I don't elaborate them one by one (Alexey)
   * One more patch to export detach_of_node()
   * Fixed uninitialized variables, memory leak on @fdt1. Added flush_work()
     and other misc comments (Alexey / Alistair)
   * Same testing scenario carried as v8. More will be carried out later.
   * The confused function names aren't changed. Will check with Alexey and
     Alistair. Or have a separate patch to address it later.
v8:
   * Rebased to linux-powerpc next branch.
   * Resolve comments from Alexey and Daniel on PCI part
   * Resolve comments from Rob on fdt.c
   * Retested (refer to the "Testing section")
v7:
   * Reworked revision to some extent.
   * Rebased to powerpc/next repository.
   * Reorder/split/merge/drop according - Alexey.
   * Defined macros and use array to track IO/M32/M64/DMA32 segments - Alexey.
   * Merged 3 files to one for the hotplug driver - Alexey.
   * As part of OPAL API, defined macros for PCI slot power state, hotplug
     message type. Defined macros for PCI slot power confirmed state in
     hotplug driver.
   * Misc comments from Alexey.
   * Reworked unflatten_dt_node() to avoid recursive function calls.
   * Use EXPORT_SYMBOL_GPL() and document function's input/output - Rob/Frank.
v6:
   * Patch reorder, split, squash - Alexey.
   * Minor coding style - Alexey.
   * Better function names for pcibios_{add,remove}_pci_devices - Bjorn
   * Replace pr_warn() with dev_warn() in PowerNV hotplug driver - Bjorn
   * Concurrent depth as parameter passed to __unflatten_dt_node() - Grant / Alexey
   * Replace overlay with of_changeset - Grant

Gavin Shan (18):
  PCI: Add pcibios_setup_bridge()
  powerpc/pci: Override pcibios_setup_bridge()
  powerpc/powernv: Remove PCI_RESET_DELAY_US
  powerpc/powernv: Move pnv_pci_ioda_setup_opal_tce_kill() around
  powerpc/powernv: Increase PE# capacity
  powerpc/powernv: Allocate PE# in reverse order
  powerpc/powernv: Create PEs in pcibios_setup_bridge()
  powerpc/powernv: Setup PE for root bus
  powerpc/powernv: Extend PCI bridge resources
  powerpc/powernv: Make pnv_ioda_deconfigure_pe() visible
  powerpc/powernv: Dynamically release PE
  powerpc/pci: Update bridge windows on PCI plug
  powerpc/pci: Delay populating pdn
  powerpc/powernv: Support PCI slot ID
  powerpc/powernv: Use PCI slot reset infrastructure
  powerpc/powernv: Introduce pnv_pci_get_slot_id()
  powerpc/powernv: Functions to get/set PCI slot state
  PCI/hotplug: PowerPC PowerNV PCI hotplug driver

 MAINTAINERS                                    |   1 +
 arch/powerpc/include/asm/eeh.h                 |   2 +-
 arch/powerpc/include/asm/opal-api.h            |  19 +-
 arch/powerpc/include/asm/opal.h                |  10 +-
 arch/powerpc/include/asm/pci-bridge.h          |   2 +
 arch/powerpc/include/asm/pnv-pci.h             |  12 +
 arch/powerpc/include/asm/ppc-pci.h             |   2 -
 arch/powerpc/kernel/eeh_dev.c                  |  17 +-
 arch/powerpc/kernel/pci-common.c               |  16 +-
 arch/powerpc/kernel/pci_dn.c                   |  23 +-
 arch/powerpc/platforms/maple/pci.c             |  34 +-
 arch/powerpc/platforms/pasemi/pci.c            |   3 -
 arch/powerpc/platforms/powermac/pci.c          |  38 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c   |  49 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   4 +
 arch/powerpc/platforms/powernv/pci-ioda.c      | 484 +++++++++++-----
 arch/powerpc/platforms/powernv/pci.c           | 124 ++++-
 arch/powerpc/platforms/powernv/pci.h           |  10 +-
 arch/powerpc/platforms/pseries/setup.c         |   6 +-
 drivers/pci/hotplug/Kconfig                    |  13 +
 drivers/pci/hotplug/Makefile                   |   3 +
 drivers/pci/hotplug/pnv_php.c                  | 733 +++++++++++++++++++++++++
 drivers/pci/setup-bus.c                        |   5 +
 include/linux/pci.h                            |   1 +
 24 files changed, 1397 insertions(+), 214 deletions(-)
 create mode 100644 drivers/pci/hotplug/pnv_php.c

-- 
2.1.0
