Return-Path: <dja@axtens.net>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A1D31A025A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:08 +1100 (AEDT)
Received: by pdnc3 with SMTP id c3so17178009pdn.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:36:06 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/27] Refactor PCI controller operations
Date: Wed, 25 Mar 2015 16:35:34 +1100
Message-Id: <1427261761-22952-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set moves some PCI controller operations out of ppc_md and
into a new pci_controller_ops struct.

This is desirable for systems with more than one type of PCI
controller. In particular, it's intended that this new interface will
be used by the CXL (aka CAPI) driver.

The design tries to balance a desire to avoid having yet another
abstratction layer with a desire to make it easy for vendor kernels to
pull in as little or as much as they are comfortable with.

To this end, it's in 3 main parts:

 1) Set up the pci_controller_ops structure. For each function we add
 to the structure, set up a shim that calls the controller_ops
 function if it exists, or the ppc_md function otherwise. Modify
 callsites to use the shims.

 2) Move each affected platform over from using ppc_md to using the
 controller_ops structure.

 3) Take out the shims and the ppc_md entries. Modify the callsites to
 use the controller_ops calls.

MSI and some legacy functions have been deliberately deferred, and
will be to be tackled at a later point.

The set has been:

 - Build tested for PowerNV, pSeries, Power Mac, Maple, Cell, PaSemi
 and Corenet 64 (for fsl_pci). It builds at every point in the series.

 - Boot tested on pSeries and PowerNV.

The set depends on mpe's two recent cleanup patches to remove powernv
RTAS support [1] and drop celleb [2].

The full breakdown of the patches is as follows:
Patches  1 - 5: minor necessary cleanups
Patches  6 - 12: Introduce struct and shims
Patches 13 - 20: Platform specific migrations
Patches 21 - 26: Remove shims
Patch        27: Final cleanup

Daniel Axtens (27):
  powerpc: move find_and_init_phbs() to pSeries specific code
  powerpc/powermac: move pmac_pci_probe_mode from setup.c to pci.c
  powerpc/swiotlb: give init call a less misleading name
  powerpc/fsl_pci: Don't change ppc_swiotlb_enable after
    swiotlb_subsys_init
  powerpc: pcibios_enable_device_hook: return bool rather than int
  powerpc: Create the pci_controller_ops struct.
  powerpc: ppc_md.pci_dma_dev_setup -> pci_controller_ops.dma_dev_setup
  powerpc: ppc_md.pci_dma_bus_setup -> pci_controller_ops.dma_bus_setup
  powerpc: ppc_md.pci_probe_mode -> pci_controller_ops.probe_mode
  powerpc: ppc_md.pcibios_enable_device_hook ->
    pci_controller_ops.enable_device_hook
  powerpc: ppc_md.pcibios_window_alignment ->
    pci_controller_ops.window_alignment
  powerpc: ppc_md.pcibios_reset_secondary_bus ->
    pci_controller_ops.reset_secondary_bus
  powerpc: dart_iommu: optionally populate controller_ops on init
  powerpc/powermac: Move controller ops from ppc_md to controller_ops
  powerpc/pseries: Move controller ops from ppc_md to controller_ops
  powerpc/powernv:  Move controller ops from ppc_md to controller_ops
  powerpc/pasemi: Move controller ops from ppc_md to controller_ops
  powerpc/maple: Move controller ops from ppc_md to controller_ops
  powerpc: fsl_pci, swiotlb: Move controller ops from ppc_md to
    controller_ops
  powerpc/cell: Move controller ops from ppc_md to controller_ops
  powerpc: Remove shim for pci_controller_ops.window_alignment
  powerpc: Remove shim for pci_controller_ops.reset_secondary_bus
  powerpc: Remove shim for pci_controller_ops.enable_device_hook
  powerpc: Remove shim for pci_controller_ops.probe_mode
  powerpc: Remove shim for pci_controller_ops.dma_dev_setup
  powerpc: Remove shim for pci_controller_ops.dma_bus_setup
  powerpc: dart_iommu: Remove check for controller_ops == NULL case

 arch/powerpc/include/asm/iommu.h            |  3 +-
 arch/powerpc/include/asm/machdep.h          | 14 --------
 arch/powerpc/include/asm/pci-bridge.h       | 19 +++++++++++
 arch/powerpc/include/asm/pci.h              |  2 +-
 arch/powerpc/include/asm/ppc-pci.h          |  3 --
 arch/powerpc/kernel/dma-swiotlb.c           | 11 +++---
 arch/powerpc/kernel/pci-common.c            | 34 +++++++++++-------
 arch/powerpc/kernel/pci-hotplug.c           |  7 ++--
 arch/powerpc/kernel/pci_of_scan.c           |  7 ++--
 arch/powerpc/kernel/rtas_pci.c              | 47 -------------------------
 arch/powerpc/platforms/cell/cell.h          | 24 +++++++++++++
 arch/powerpc/platforms/cell/iommu.c         |  7 ++--
 arch/powerpc/platforms/cell/setup.c         |  5 +++
 arch/powerpc/platforms/maple/maple.h        |  2 ++
 arch/powerpc/platforms/maple/pci.c          |  4 +++
 arch/powerpc/platforms/maple/setup.c        |  2 +-
 arch/powerpc/platforms/pasemi/iommu.c       |  6 ++--
 arch/powerpc/platforms/pasemi/pasemi.h      |  1 +
 arch/powerpc/platforms/pasemi/pci.c         |  5 +++
 arch/powerpc/platforms/powermac/pci.c       | 38 ++++++++++++++++++---
 arch/powerpc/platforms/powermac/pmac.h      |  3 +-
 arch/powerpc/platforms/powermac/setup.c     | 22 +-----------
 arch/powerpc/platforms/powernv/pci-ioda.c   | 15 ++++----
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  1 +
 arch/powerpc/platforms/powernv/pci.c        |  5 ++-
 arch/powerpc/platforms/powernv/powernv.h    |  2 ++
 arch/powerpc/platforms/pseries/iommu.c      |  9 ++---
 arch/powerpc/platforms/pseries/pseries.h    |  2 ++
 arch/powerpc/platforms/pseries/setup.c      | 53 ++++++++++++++++++++++++++++-
 arch/powerpc/sysdev/dart_iommu.c            | 10 +++---
 arch/powerpc/sysdev/fsl_pci.c               | 23 +++++++++++--
 31 files changed, 244 insertions(+), 142 deletions(-)
 create mode 100644 arch/powerpc/platforms/cell/cell.h

-- 
2.1.4
