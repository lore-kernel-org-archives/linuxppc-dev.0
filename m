Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVSR5nx0zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:42:47 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:42:46 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 13DC43578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:42:44 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435ga6P7012806
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:44 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435gBJa018652
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:11 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 00/26] powerpc/powernv: PCI hotplug preparation
Date: Tue,  3 May 2016 15:41:19 +1000
Message-Id: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series is split from "[PATCH v8 00/45] powerpc/powernv: PCI hotplug
support". The series does couple of things as below. The patches are
required to support PCI hotplug on PowerNV platforms. However, the
patches refactor the code with the goal: not affecting current logic.

   * Code cleanup and refactoring.
   * Track IO/M32/M64 segments consumed by one particular PE.
   * Remove DMA32 list and improve DMA32 segment tracking.
   * M64 support for IODA1 so that we have unified basis for the
     subsequent patches to support PCI hotplug.
   * Couple of fixes to PCI hotplug (used by EEH).
   * Exported functions to be used by PCI hotplug.

Gavin Shan (26):
  powerpc/pci: Cleanup on struct pci_controller_ops
  powerpc/powernv: Cleanup on pci_controller_ops instances
  powerpc/powernv: Drop phb->bdfn_to_pe()
  powerpc/powernv: Reorder fields in struct pnv_phb
  powerpc/powernv: Rename PE# fields in struct pnv_phb
  powerpc/powernv: Data type unsigned int for PE number
  powerpc/powernv: Fix initial IO and M32 segmap
  powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
  powerpc/powernv: IO and M32 mapping based on PCI device resources
  powerpc/powernv: Track M64 segment consumption
  powerpc/powernv: Rename M64 related functions
  powerpc/powernv/ioda1: M64 support on P7IOC
  powerpc/powernv/ioda1: Rename pnv_pci_ioda_setup_dma_pe()
  powerpc/powernv/ioda1: Introduce PNV_IODA1_DMA32_SEGSIZE
  powerpc/powernv: Remove DMA32 PE list
  powerpc/powernv/ioda1: Improve DMA32 segment track
  powerpc/powernv: Use PE instead of number during setup and release
  powerpc/pci: Rename pcibios_{add,remove}_pci_devices()
  powerpc/pci: Rename pcibios_find_pci_bus()
  powerpc/pci: Move pci_find_bus_by_node() around
  powerpc/pci: Export pci_add_device_node_info()
  powerpc/pci: Introduce pci_remove_device_node_info()
  powerpc/pci: Export pci_traverse_device_nodes()
  powerpc/pci: Don't scan empty slot
  powerpc/powernv: Simplify pnv_eeh_reset()
  powerpc/powernv: Exclude root bus in pnv_pci_reset_secondary_bus()

 arch/powerpc/include/asm/pci-bridge.h        |  41 +-
 arch/powerpc/include/asm/ppc-pci.h           |   6 +-
 arch/powerpc/kernel/eeh_driver.c             |  12 +-
 arch/powerpc/kernel/pci-hotplug.c            |  47 +-
 arch/powerpc/kernel/pci_dn.c                 |  66 ++-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  81 ++-
 arch/powerpc/platforms/powernv/pci-ioda.c    | 719 +++++++++++++++------------
 arch/powerpc/platforms/powernv/pci.c         |   4 +-
 arch/powerpc/platforms/powernv/pci.h         |  41 +-
 arch/powerpc/platforms/pseries/msi.c         |   4 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c   |  32 --
 arch/powerpc/platforms/pseries/setup.c       |   2 +-
 drivers/pci/hotplug/rpadlpar_core.c          |   8 +-
 drivers/pci/hotplug/rpaphp_core.c            |   4 +-
 drivers/pci/hotplug/rpaphp_pci.c             |   4 +-
 15 files changed, 592 insertions(+), 479 deletions(-)

-- 
2.1.0
