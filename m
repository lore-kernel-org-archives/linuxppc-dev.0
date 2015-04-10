Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87EC91A0406
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 10 Apr 2015 16:32:21 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7D5203578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:19 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A6W9CC28115186
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:19 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A6Vidb009118
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:31:44 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v8 00/31] powerpc/iommu/vfio: Enable Dynamic DMA windows
Date: Fri, 10 Apr 2015 16:30:42 +1000
Message-Id: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This enables sPAPR defined feature called Dynamic DMA windows (DDW).

Each Partitionable Endpoint (IOMMU group) has an address range on a PCI bus
where devices are allowed to do DMA. These ranges are called DMA windows.
By default, there is a single DMA window, 1 or 2GB big, mapped at zero
on a PCI bus.

Hi-speed devices may suffer from the limited size of the window.
The recent host kernels use a TCE bypass window on POWER8 CPU which implements
direct PCI bus address range mapping (with offset of 1<<59) to the host memory.

For guests, PAPR defines a DDW RTAS API which allows pseries guests
querying the hypervisor about DDW support and capabilities (page size mask
for now). A pseries guest may request an additional (to the default)
DMA windows using this RTAS API.
The existing pseries Linux guests request an additional window as big as
the guest RAM and map the entire guest window which effectively creates
direct mapping of the guest memory to a PCI bus.

The multiple DMA windows feature is supported by POWER7/POWER8 CPUs; however
this patchset only adds support for POWER8 as TCE tables are implemented
in POWER7 in a quite different way ans POWER7 is not the highest priority.

This patchset reworks PPC64 IOMMU code and adds necessary structures
to support big windows.

Once a Linux guest discovers the presence of DDW, it does:
1. query hypervisor about number of available windows and page size masks;
2. create a window with the biggest possible page size (today 4K/64K/16M);
3. map the entire guest RAM via H_PUT_TCE* hypercalls;
4. switche dma_ops to direct_dma_ops on the selected PE.

Once this is done, H_PUT_TCE is not called anymore for 64bit devices and
the guest does not waste time on DMA map/unmap operations.

Note that 32bit devices won't use DDW and will keep using the default
DMA window so KVM optimizations will be required (to be posted later).

This is pushed to git@github.com:aik/linux.git
 + 09bb8ea...d9b711d vfio-for-github -> vfio-for-github (forced update)


Please comment. Thank you!


Changes:
v8:
* fixed a bug in error fallback in "powerpc/mmu: Add userspace-to-physical
addresses translation cache"
* fixed subject in "vfio: powerpc/spapr: Check that IOMMU page is fully
contained by system page"
* moved v2 documentation to the correct patch
* added checks for failed vzalloc() in "powerpc/iommu: Add userspace view
of TCE table"

v7:
* moved memory preregistration to the current process's MMU context
* added code preventing unregistration if some pages are still mapped;
for this, there is a userspace view of the table is stored in iommu_table
* added locked_vm counting for DDW tables (including userspace view of those)

v6:
* fixed a bunch of errors in "vfio: powerpc/spapr: Support Dynamic DMA windows"
* moved static IOMMU properties from iommu_table_group to iommu_table_group_ops

v5:
* added SPAPR_TCE_IOMMU_v2 to tell the userspace that there is a memory
pre-registration feature
* added backward compatibility
* renamed few things (mostly powerpc_iommu -> iommu_table_group)

v4:
* moved patches around to have VFIO and PPC patches separated as much as
possible
* now works with the existing upstream QEMU

v3:
* redesigned the whole thing
* multiple IOMMU groups per PHB -> one PHB is needed for VFIO in the guest ->
no problems with locked_vm counting; also we save memory on actual tables
* guest RAM preregistration is required for DDW
* PEs (IOMMU groups) are passed to VFIO with no DMA windows at all so
we do not bother with iommu_table::it_map anymore
* added multilevel TCE tables support to support really huge guests

v2:
* added missing __pa() in "powerpc/powernv: Release replaced TCE"
* reposted to make some noise




Alexey Kardashevskiy (31):
  vfio: powerpc/spapr: Move page pinning from arch code to VFIO IOMMU
    driver
  vfio: powerpc/spapr: Do cleanup when releasing the group
  vfio: powerpc/spapr: Check that IOMMU page is fully contained by
    system page
  vfio: powerpc/spapr: Use it_page_size
  vfio: powerpc/spapr: Move locked_vm accounting to helpers
  vfio: powerpc/spapr: Disable DMA mappings on disabled container
  vfio: powerpc/spapr: Moving pinning/unpinning to helpers
  vfio: powerpc/spapr: Rework groups attaching
  powerpc/powernv: Do not set "read" flag if direction==DMA_NONE
  powerpc/iommu: Move tce_xxx callbacks from ppc_md to iommu_table
  powerpc/iommu: Introduce iommu_table_alloc() helper
  powerpc/spapr: vfio: Switch from iommu_table to new iommu_table_group
  vfio: powerpc/spapr: powerpc/iommu: Rework IOMMU ownership control
  vfio: powerpc/spapr: powerpc/powernv/ioda2: Rework IOMMU ownership
    control
  powerpc/iommu: Fix IOMMU ownership control functions
  powerpc/powernv/ioda/ioda2: Rework tce_build()/tce_free()
  powerpc/iommu/powernv: Release replaced TCE
  powerpc/powernv/ioda2: Rework iommu_table creation
  powerpc/powernv/ioda2: Introduce
    pnv_pci_ioda2_create_table/pnc_pci_free_table
  powerpc/powernv/ioda2: Introduce pnv_pci_ioda2_set_window
  powerpc/iommu: Split iommu_free_table into 2 helpers
  powerpc/powernv: Implement multilevel TCE tables
  powerpc/powernv: Change prototypes to receive iommu
  powerpc/powernv/ioda: Define and implement DMA table/window management
    callbacks
  vfio: powerpc/spapr: powerpc/powernv/ioda2: Rework ownership
  powerpc/iommu: Add userspace view of TCE table
  powerpc/iommu/ioda2: Add get_table_size() to calculate the size of
    fiture table
  powerpc/mmu: Add userspace-to-physical addresses translation cache
  vfio: powerpc/spapr: Register memory and define IOMMU v2
  vfio: powerpc/spapr: Support multiple groups in one container if
    possible
  vfio: powerpc/spapr: Support Dynamic DMA windows

 Documentation/vfio.txt                      |   50 +-
 arch/powerpc/include/asm/iommu.h            |  111 ++-
 arch/powerpc/include/asm/machdep.h          |   25 -
 arch/powerpc/include/asm/mmu-hash64.h       |    3 +
 arch/powerpc/include/asm/mmu_context.h      |   17 +
 arch/powerpc/kernel/iommu.c                 |  336 +++++----
 arch/powerpc/kernel/vio.c                   |    5 +
 arch/powerpc/mm/Makefile                    |    1 +
 arch/powerpc/mm/mmu_context_hash64.c        |    6 +
 arch/powerpc/mm/mmu_context_hash64_iommu.c  |  215 ++++++
 arch/powerpc/platforms/cell/iommu.c         |    8 +-
 arch/powerpc/platforms/pasemi/iommu.c       |    7 +-
 arch/powerpc/platforms/powernv/pci-ioda.c   |  589 ++++++++++++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |   33 +-
 arch/powerpc/platforms/powernv/pci.c        |  116 ++-
 arch/powerpc/platforms/powernv/pci.h        |   12 +-
 arch/powerpc/platforms/pseries/iommu.c      |   55 +-
 arch/powerpc/sysdev/dart_iommu.c            |   12 +-
 drivers/vfio/vfio_iommu_spapr_tce.c         | 1021 ++++++++++++++++++++++++---
 include/uapi/linux/vfio.h                   |   88 ++-
 20 files changed, 2218 insertions(+), 492 deletions(-)
 create mode 100644 arch/powerpc/mm/mmu_context_hash64_iommu.c

-- 
2.0.0
