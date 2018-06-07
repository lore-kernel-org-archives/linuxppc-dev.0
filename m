Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 411fHY4ZZjzF32Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 18:44:57 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ram Pai <linuxram@us.ibm.com>, kvm@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
Subject: [RFC PATCH kernel 0/5] powerpc/P9/vfio: Pass through NVIDIA Tesla V100
Date: Thu,  7 Jun 2018 18:44:15 +1000
Message-Id: <20180607084420.29513-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is an rfc of some patches adding psaa-through support
for NVIDIA V100 GPU found in some POWER9 boxes.

The example P9 system has 6 GPUs, each accompanied with 2 bridges
representing the hardware links (aka NVLink2):

 4  0004:04:00.0 3D: NVIDIA Corporation GV100GL [Tesla V100 SXM2] (rev a1)
 5  0004:05:00.0 3D: NVIDIA Corporation GV100GL [Tesla V100 SXM2] (rev a1)
 6  0004:06:00.0 3D: NVIDIA Corporation GV100GL [Tesla V100 SXM2] (rev a1)
 4  0006:00:00.0 Bridge: IBM Device 04ea (rev 01)
 4  0006:00:00.1 Bridge: IBM Device 04ea (rev 01)
 5  0006:00:01.0 Bridge: IBM Device 04ea (rev 01)
 5  0006:00:01.1 Bridge: IBM Device 04ea (rev 01)
 6  0006:00:02.0 Bridge: IBM Device 04ea (rev 01)
 6  0006:00:02.1 Bridge: IBM Device 04ea (rev 01)
10  0007:00:00.0 Bridge: IBM Device 04ea (rev 01)
10  0007:00:00.1 Bridge: IBM Device 04ea (rev 01)
11  0007:00:01.0 Bridge: IBM Device 04ea (rev 01)
11  0007:00:01.1 Bridge: IBM Device 04ea (rev 01)
12  0007:00:02.0 Bridge: IBM Device 04ea (rev 01)
12  0007:00:02.1 Bridge: IBM Device 04ea (rev 01)
10  0035:03:00.0 3D: NVIDIA Corporation GV100GL [Tesla V100 SXM2] (rev a1)
11  0035:04:00.0 3D: NVIDIA Corporation GV100GL [Tesla V100 SXM2] (rev a1)
12  0035:05:00.0 3D: NVIDIA Corporation GV100GL [Tesla V100 SXM2] (rev a1)

^^ the number is an IOMMU group ID.

Each bridge represents an additional hardware interface called "NVLink2",
it is not a PCI link but separate but. The design inherits from original
NVLink from POWER8.

The new feature of V100 is 16GB of cache coherent memory on GPU board.
This memory is presented to the host via the device tree and remains offline
until the NVIDIA driver loads, trains NVLink2 (via the config space of these
bridges above) and the nvidia-persistenced daemon then onlines it.
The memory remains online as long as nvidia-persistenced is running, when
it stops, it offlines the memory.

The amount of GPUs suggest passing them through to a guest. However,
in order to do so we cannot use the NVIDIA driver so we have a host with
a 128GB window (bigger or equal to actual GPU RAM size) in a system memory
with no page structs backing this window and we cannot touch this memory
before the NVIDIA driver configures it in a host or a guest as
HMI (hardware management interrupt?) occurs.

On the example system the GPU RAM windows are located at:
0x0400 0000 0000
0x0420 0000 0000
0x0440 0000 0000
0x2400 0000 0000
0x2420 0000 0000
0x2440 0000 0000

So the complications are:

1. cannot touch the GPU memory till it is trained, i.e. cannot add ptes
to VFIO-to-userspace or guest-to-host-physical translations till
the driver trains it (i.e. nvidia-persistenced has started), otherwise
prefetching happens and HMI occurs; I am trying to get this changed
somehow;

2. since it appears as normal cache coherent memory, it will be used
for DMA which means it has to be pinned and mapped in the host. Having
no page structs makes it different from the usual case - we only need
translate user addresses to host physical and map GPU RAM memory but
pinning is not required.

This series maps GPU RAM via the GPU vfio-pci device so QEMU can then
register this memory as a KVM memory slot and present memory nodes to
the guest. Unless NVIDIA provides an userspace driver, this is no use
for things like DPDK.


There is another problem which the series does not address but worth
mentioning - it is not strictly necessary to map GPU RAM to the guest
exactly where it is in the host (I tested this to some extent), we still
might want to represent the memory at the same offset as on the host
which increases the size of a TCE table needed to cover such a huge
window: (((0x244000000000 + 0x2000000000) >> 16)*8)>>20 = 4556MB
I am addressing this in a separate patchset by allocating indirect TCE
levels on demand and using 16MB IOMMU pages in the guest as we can now
back emulated pages with the smaller hardware ones.


This is an RFC. Please comment. Thanks.



Alexey Kardashevskiy (5):
  vfio/spapr_tce: Simplify page contained test
  powerpc/iommu_context: Change referencing in API
  powerpc/iommu: Do not pin memory of a memory device
  vfio_pci: Allow mapping extra regions
  vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] [10de:1db1] subdriver

 drivers/vfio/pci/Makefile              |   1 +
 arch/powerpc/include/asm/mmu_context.h |   5 +-
 drivers/vfio/pci/vfio_pci_private.h    |  11 ++
 include/uapi/linux/vfio.h              |   3 +
 arch/powerpc/kernel/iommu.c            |   8 +-
 arch/powerpc/mm/mmu_context_iommu.c    |  70 +++++++++---
 drivers/vfio/pci/vfio_pci.c            |  19 +++-
 drivers/vfio/pci/vfio_pci_nvlink2.c    | 190 +++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_spapr_tce.c    |  42 +++++---
 drivers/vfio/pci/Kconfig               |   4 +
 10 files changed, 319 insertions(+), 34 deletions(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c

-- 
2.11.0
