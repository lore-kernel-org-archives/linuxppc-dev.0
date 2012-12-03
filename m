Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 500532C007B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2012 13:53:13 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id ro12so1386564pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Dec 2012 18:53:11 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 0/2] vfio on power: yet another try
Date: Mon,  3 Dec 2012 13:52:56 +1100
Message-Id: <1354503178-2602-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1353661396-14374-1-git-send-email-aik@ozlabs.ru>
References: <1353661396-14374-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The set includes 2 patches.

The first one adds necessary support for VFIO IOMMU support,
the second one adds a SPAPR TCE IOMMU driver to VFIO.

At the moment we have decided to get rid of DMA64 window
properties because we need more API than just 2 properties
(such as dynamic window allocation) but have not decided
about its actual design yet.

Alexey Kardashevskiy (2):
  vfio powerpc: enabled on powernv platform
  vfio powerpc: implemented IOMMU driver for VFIO

 arch/powerpc/include/asm/iommu.h     |    9 +
 arch/powerpc/kernel/iommu.c          |  186 ++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.c |  135 +++++++++++++
 drivers/iommu/Kconfig                |    8 +
 drivers/vfio/Kconfig                 |    6 +
 drivers/vfio/Makefile                |    1 +
 drivers/vfio/vfio_iommu_spapr_tce.c  |  350 ++++++++++++++++++++++++++++++++++
 include/linux/vfio.h                 |   26 +++
 8 files changed, 721 insertions(+)
 create mode 100644 drivers/vfio/vfio_iommu_spapr_tce.c

-- 
1.7.10.4
