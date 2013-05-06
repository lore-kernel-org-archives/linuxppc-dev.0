Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B6D32C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 17:22:23 +1000 (EST)
Received: by mail-pa0-f53.google.com with SMTP id kq12so1872786pab.26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 00:22:21 -0700 (PDT)
From: aik@ozlabs.ru
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5] VFIO PPC64: add VFIO support on POWERPC64
Date: Mon,  6 May 2013 17:21:56 +1000
Message-Id: <51875a2c.25ac440a.50d9.ffffe8eb@mx.google.com>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The series adds support for VFIO on POWERPC in user space (such as QEMU).
The in-kernel real mode IOMMU support is added by another series posted
separately.

As the first and main aim of this series is the POWERNV platform support,
the "Enable on POWERNV platform" patch goes first and introduces an API
to be used by the VFIO IOMMU driver. The "Enable on pSeries platform" patch
simply registers PHBs in the IOMMU subsystem and expects the API to be present,
it enables VFIO support in fully emulated QEMU guests.

These patches were tested against 3.8 and the "iommu: Move initialization earlier"
patch is already in 3.9 so I am including it here only for the reference.

Change log:
* cleanups and minor fixes
* added support for pSeries
* separated from in-kernel IOMMU handling series (should make it easier to get sob'ed)
* signed-off-by Paul Mackerras

Alexey Kardashevskiy (5):
  iommu: Move initialization earlier
  KVM: PPC: iommu: Add missing
    kvm_iommu_map_pages/kvm_iommu_unmap_pages
  powerpc/vfio: Enable on POWERNV platform
  powerpc/vfio: Implement IOMMU driver for VFIO
  powerpc/vfio: Enable on pSeries platform

 Documentation/vfio.txt                      |   63 +++++
 arch/powerpc/include/asm/iommu.h            |   26 ++
 arch/powerpc/include/asm/kvm_host.h         |   14 +
 arch/powerpc/kernel/iommu.c                 |  319 +++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c   |    1 +
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |    5 +-
 arch/powerpc/platforms/powernv/pci.c        |    2 +
 arch/powerpc/platforms/pseries/iommu.c      |    4 +
 drivers/iommu/Kconfig                       |    8 +
 drivers/iommu/iommu.c                       |    2 +-
 drivers/vfio/Kconfig                        |    6 +
 drivers/vfio/Makefile                       |    1 +
 drivers/vfio/vfio.c                         |    1 +
 drivers/vfio/vfio_iommu_spapr_tce.c         |  377 +++++++++++++++++++++++++++
 include/uapi/linux/vfio.h                   |   34 +++
 15 files changed, 861 insertions(+), 2 deletions(-)
 create mode 100644 drivers/vfio/vfio_iommu_spapr_tce.c

-- 
1.7.10.4
