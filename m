Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E6A01A005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:01:22 +1100 (AEDT)
Received: by patj18 with SMTP id j18so8075374pat.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:01:19 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 00/19] Refactor PCI controller operations
Date: Tue, 31 Mar 2015 16:00:38 +1100
Message-Id: <1427778057-9505-1-git-send-email-dja@axtens.net>
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
abstraction layer with a desire to make it easy for vendor kernels to
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

The set has been build tested for PowerNV, pSeries, Power Mac, Maple,
Cell, PaSemi and Corenet 64 (for fsl_pci). It builds at every point in
the series.

The set depends on mpe's two recent cleanup patches to remove powernv
RTAS support [1] and drop celleb [2].

Thanks for feedback from mpe, there is one functional change since v1,
and a number of cosmetic ones.
Functionally:

 - A mistake was made regarding in fsl_pci/swiotlb. I though that
   setting ppc_swiotlb_enable in fsl_pci.c couldn't have an effect,
   and removed it in patch #4. This was wrong. Drop the offending
   patch. In the patch that ports fsl_pci/swiotlb to the new
   structure, move the hook around so that it always has the correct
   value.

Cosmetically:
 - Prefer "phb" over "hose" whenever possible.
 - Drop an unnecessary renaming patch. (prev #3)
 - Squash all the shim removal.
 - Squash the creation of the struct with the addition of the first
   member.
 - Better commit messages. (Thanks sfr & mpe)
 - Shims now have names that (where possible) match the ppc_md names,
   rather than the new, non-namespaced names.


The series has also been rebased onto -rc6; no changes were necessary.

The full breakdown of the patches is as follows:
Patches  1 - 3:  minor necessary cleanups
Patches  4 - 9: Introduce struct and shims
Patches 10 - 17: Platform specific migrations
Patch        18: Remove shims
Patch        19: Final cleanup


Daniel Axtens (19):
  powerpc: move find_and_init_phbs() to pSeries specific code
  powerpc/powermac: move pmac_pci_probe_mode from setup.c to pci.c
  powerpc: pcibios_enable_device_hook: return bool rather than int
  powerpc: Create pci_controller_ops.dma_dev_setup and shims
  powerpc: Create pci_controller_ops.dma_bus_setup and shim
  powerpc: Create pci_controller_ops.probe_mode and shim
  powerpc: Create pci_controller_ops.enable_device_hook and shim
  powerpc: Create pci_controller_ops.window_alignment and shim
  powerpc: Create pci_controller_ops.reset_secondary_bus and shim
  powerpc: dart_iommu: optionally populate controller_ops on init
  powerpc/powermac: Move controller ops from ppc_md to controller_ops
  powerpc/pseries: Move controller ops from ppc_md to controller_ops
  powerpc/powernv:  Move controller ops from ppc_md to controller_ops
  powerpc/pasemi: Move controller ops from ppc_md to controller_ops
  powerpc/maple: Move controller ops from ppc_md to controller_ops
  powerpc: fsl_pci, swiotlb: Move controller ops from ppc_md to
    controller_ops
  powerpc/cell: Move controller ops from ppc_md to controller_ops
  powerpc: Remove shims for pci_controller_ops operations
  powerpc: dart_iommu: Remove check for controller_ops == NULL case

 arch/powerpc/include/asm/iommu.h            |  3 +-
 arch/powerpc/include/asm/machdep.h          | 14 --------
 arch/powerpc/include/asm/pci-bridge.h       | 19 +++++++++++
 arch/powerpc/include/asm/pci.h              |  2 +-
 arch/powerpc/include/asm/ppc-pci.h          |  3 --
 arch/powerpc/kernel/dma-swiotlb.c           | 11 +++---
 arch/powerpc/kernel/pci-common.c            | 35 ++++++++++++-------
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
 arch/powerpc/sysdev/fsl_pci.c               | 19 +++++++++++
 31 files changed, 244 insertions(+), 139 deletions(-)
 create mode 100644 arch/powerpc/platforms/cell/cell.h

-- 
2.1.4
