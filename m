Return-Path: <aik@ozlabs.ru>
Received: from mail-ia0-x231.google.com (mail-ia0-x231.google.com
 [IPv6:2607:f8b0:4001:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F8BA2C02B6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 23:01:14 +1100 (EST)
Received: by mail-ia0-f177.google.com with SMTP id k38so895905iah.22
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 04:01:12 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/2] vfio on power
Date: Mon, 11 Feb 2013 22:54:30 +1100
Message-Id: <1360583672-21924-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series introduces a VFIO support on POWER.
The QEMU support is required, the real mode acceleration patches are coming later.

Alexey Kardashevskiy (2):
  vfio powerpc: enabled on powernv platform
  vfio powerpc: implemented IOMMU driver for VFIO

 arch/powerpc/include/asm/iommu.h            |   15 ++
 arch/powerpc/kernel/iommu.c                 |  343 +++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c   |    1 +
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |    5 +-
 arch/powerpc/platforms/powernv/pci.c        |    3 +
 drivers/iommu/Kconfig                       |    8 +
 drivers/vfio/Kconfig                        |    6 +
 drivers/vfio/Makefile                       |    1 +
 drivers/vfio/vfio_iommu_spapr_tce.c         |  269 +++++++++++++++++++++
 include/uapi/linux/vfio.h                   |   31 +++
 10 files changed, 681 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/vfio_iommu_spapr_tce.c

-- 
1.7.10.4
