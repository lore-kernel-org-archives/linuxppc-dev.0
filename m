Return-Path: <aik@ozlabs.ru>
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com
 [IPv6:2607:f8b0:4001:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 060B12C0108
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 13:33:23 +1000 (EST)
Received: by mail-ie0-f180.google.com with SMTP id ar20so347724iec.39
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 20:33:20 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5 v2] VFIO PPC64: add VFIO support on POWERPC64
Date: Tue, 21 May 2013 13:33:08 +1000
Message-Id: <1369107191-28547-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series adds support for VFIO on POWERPC in user space (such as QEMU).
The in-kernel real mode IOMMU support is added by another series posted
separately.

As the first and main aim of this series is the POWERNV platform support,
the "Enable on POWERNV platform" patch goes first and introduces an API
to be used by the VFIO IOMMU driver. The "Enable on pSeries platform" patch
simply registers PHBs in the IOMMU subsystem and expects the API to be present,
it enables VFIO support in fully emulated QEMU guests.

The main change is that this series was changed and tested against v3.10-rc1.
It also contains some bugfixes which are mentioned (if any) in the patch messages.

Alexey Kardashevskiy (3):
  powerpc/vfio: Enable on POWERNV platform
  powerpc/vfio: Implement IOMMU driver for VFIO
  powerpc/vfio: Enable on pSeries platform

 Documentation/vfio.txt                      |   63 +++++
 arch/powerpc/include/asm/iommu.h            |   26 ++
 arch/powerpc/kernel/iommu.c                 |  323 +++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c   |    1 +
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |    5 +-
 arch/powerpc/platforms/powernv/pci.c        |    2 +
 arch/powerpc/platforms/pseries/iommu.c      |    4 +
 drivers/iommu/Kconfig                       |    8 +
 drivers/vfio/Kconfig                        |    6 +
 drivers/vfio/Makefile                       |    1 +
 drivers/vfio/vfio.c                         |    1 +
 drivers/vfio/vfio_iommu_spapr_tce.c         |  377 +++++++++++++++++++++++++++
 include/uapi/linux/vfio.h                   |   34 +++
 13 files changed, 850 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/vfio_iommu_spapr_tce.c

-- 
1.7.10.4
