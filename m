Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 412BHy4z9zzF36b
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 15:47:10 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH kernel 0/6] powerpc/powernv/iommu: Optimize memory use
Date: Fri,  8 Jun 2018 15:46:27 +1000
Message-Id: <20180608054633.18659-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset aims to reduce actual memory use for guests with
sparse memory. The pseries guest uses dynamic DMA windows to map
the entire guest RAM but it only actually maps onlined memory
which may be not be contiguous. I hit this when tried passing
through NVLink2-connected GPU RAM of NVIDIA V100 and trying to
map this RAM at the same offset as in the real hardware
forced me to rework I handle these windows.

This moves userspace-to-host-physical translation table
(iommu_table::it_userspace) from VFIO TCE IOMMU subdriver to
the platform code and reuses the already existing multilevel
TCE table code which we have for the hardware tables.
At last in 6/6 I switch to on-demand allocation so we do not
allocate huge chunks of the table if we do not have to;
there is some math in 6/6.


Please comment. Thanks.



Alexey Kardashevskiy (6):
  powerpc/powernv: Remove useless wrapper
  powerpc/powernv: Move TCE manupulation code to its own file
  KVM: PPC: Make iommu_table::it_userspace big endian
  powerpc/powernv: Add indirect levels to it_userspace
  powerpc/powernv: Rework TCE level allocation
  powerpc/powernv/ioda: Allocate indirect TCE levels on demand

 arch/powerpc/platforms/powernv/Makefile       |   2 +-
 arch/powerpc/include/asm/iommu.h              |  11 +-
 arch/powerpc/platforms/powernv/pci.h          |  44 ++-
 arch/powerpc/kvm/book3s_64_vio.c              |  11 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c           |  18 +-
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 395 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c     | 192 ++-----------
 arch/powerpc/platforms/powernv/pci.c          | 158 -----------
 drivers/vfio/vfio_iommu_spapr_tce.c           |  65 +----
 9 files changed, 482 insertions(+), 414 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/pci-ioda-tce.c

-- 
2.11.0
