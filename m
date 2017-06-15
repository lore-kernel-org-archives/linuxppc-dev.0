Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wpCHj0tBBzDqLq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 15:49:21 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongji Xie <elohimes@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH kernel 0/3 REPOST] vfio-pci: Add support for mmapping MSI-X
 table
Date: Thu, 15 Jun 2017 15:48:42 +1000
Message-Id: <20170615054845.8428-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Here is a patchset which Yongji was working on before
leaving IBM LTC. Since we still want to have this functionality
in the kernel (DPDK is the first user), here is a rebase
on the current upstream.


Current vfio-pci implementation disallows to mmap the page
containing MSI-X table in case that users can write directly
to MSI-X table and generate an incorrect MSIs.

However, this will cause some performance issue when there
are some critical device registers in the same page as the
MSI-X table. We have to handle the mmio access to these
registers in QEMU emulation rather than in guest.

To solve this issue, this series allows to expose MSI-X table
to userspace when hardware enables the capability of interrupt
remapping which can ensure that a given PCI device can only
shoot the MSIs assigned for it. And we introduce a new bus_flags
PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side
for different archs.

The patch 3 are based on the proposed patchset[1].

Changelog
v3:
- rebased on the current upstream

v2:
- Make the commit log more clear
- Replace pci_bus_check_msi_remapping() with pci_bus_msi_isolated()
  so that we could clearly know what the function does
- Set PCI_BUS_FLAGS_MSI_REMAP in pci_create_root_bus() instead
  of iommu_bus_notifier()
- Reserve VFIO_REGION_INFO_FLAG_CAPS when we allow to mmap MSI-X
  table so that we can know whether we allow to mmap MSI-X table
  in QEMU

[1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html


This is based on sha1
63f700aab4c1 Linus Torvalds "Merge tag 'xtensa-20170612' of git://github.com/jcmvbkbc/linux-xtensa".

Please comment. Thanks.



Yongji Xie (3):
  PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
  pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
  vfio-pci: Allow to expose MSI-X table to userspace if interrupt
    remapping is enabled

 include/linux/pci.h                       |  1 +
 arch/powerpc/platforms/powernv/pci-ioda.c |  8 ++++++++
 drivers/vfio/pci/vfio_pci.c               | 18 +++++++++++++++---
 drivers/vfio/pci/vfio_pci_rdwr.c          |  3 ++-
 4 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.11.0
