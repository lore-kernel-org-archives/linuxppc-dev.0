Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhgj23lCzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:23:13 +1000 (AEST)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 18:53:10 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D789F1258060
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:55:10 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43DN7Lp6816054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:08 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43DN8Cx031509
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:11 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 00/22] powerpc/powernv: PCI hotplug support
Date: Tue,  3 May 2016 23:22:31 +1000
Message-Id: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series is split from "[PATCH v8 00/45] powerpc/powernv: PCI hotplug
support". Another series (A) sent to linux-ppc-dev maillist as it's only
related to PowerPC. Besides, this series needs the firmware patches (B)
to work. Without the firmware patches, the PCI hotplug driver won't detect
and populate any PCI slots. So this series is working on old firmware.

 (A): https://patchwork.ozlabs.org/patch/617768/
 (B): https://patchwork.ozlabs.org/patch/617749/

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
   * Changes to drivers/of/fdt.c in order to use OF changeset in hotplug driver.
   * PCI hotplug driver for PowerNV platform. The PCI slots are identified by
     firmware and exposed to kernel through device tree. Firmware provides APIs
     to get presence/power state or set power state from/to PCI slot. The PCI
     slot hotplug state is sychronized with its power state. When user changes
     PCI slot power state from off to on through sysfs file, the PCI devices
     behind the PCI slot will be brought into online. Otherwise, the PCI slot's
     subordinate devices will be removed from the system.

Changelog
=========
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

Gavin Shan (22):
  PCI: Add pcibios_setup_bridge()
  powerpc/pci: Override pcibios_setup_bridge()
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
  powerpc/powernv: Functions to get/set PCI slot state
  drivers/of: Split unflatten_dt_node()
  drivers/of: Avoid recursively calling unflatten_dt_node()
  drivers/of: Rename unflatten_dt_node()
  drivers/of: Specify parent node in of_fdt_unflatten_tree()
  drivers/of: Return allocated memory from of_fdt_unflatten_tree()
  drivers/of: Export of_detach_node()
  PCI/hotplug: PowerPC PowerNV PCI hotplug driver

 arch/powerpc/include/asm/eeh.h                 |   2 +-
 arch/powerpc/include/asm/opal-api.h            |  18 +-
 arch/powerpc/include/asm/opal.h                |   9 +-
 arch/powerpc/include/asm/pci-bridge.h          |   2 +
 arch/powerpc/include/asm/pnv-pci.h             |  11 +
 arch/powerpc/include/asm/ppc-pci.h             |   2 -
 arch/powerpc/kernel/eeh_dev.c                  |  17 +-
 arch/powerpc/kernel/pci-common.c               |  16 +-
 arch/powerpc/kernel/pci_dn.c                   |  23 +-
 arch/powerpc/platforms/maple/pci.c             |  34 +-
 arch/powerpc/platforms/pasemi/pci.c            |   3 -
 arch/powerpc/platforms/powermac/pci.c          |  38 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c   |  49 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   5 +
 arch/powerpc/platforms/powernv/pci-ioda.c      | 481 ++++++++++----
 arch/powerpc/platforms/powernv/pci.c           | 105 ++-
 arch/powerpc/platforms/powernv/pci.h           |  10 +-
 arch/powerpc/platforms/pseries/setup.c         |   6 +-
 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c   |   2 +-
 drivers/of/dynamic.c                           |   1 +
 drivers/of/fdt.c                               | 372 +++++++----
 drivers/of/unittest.c                          |   2 +-
 drivers/pci/hotplug/Kconfig                    |  13 +
 drivers/pci/hotplug/Makefile                   |   3 +
 drivers/pci/hotplug/pnv_php.c                  | 869 +++++++++++++++++++++++++
 drivers/pci/setup-bus.c                        |   5 +
 include/linux/of_fdt.h                         |   5 +-
 include/linux/pci.h                            |   1 +
 28 files changed, 1748 insertions(+), 356 deletions(-)
 create mode 100644 drivers/pci/hotplug/pnv_php.c

-- 
2.1.0
