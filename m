Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 532541A017B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:24:53 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:24:50 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D66FD357805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:24:45 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9OS4Z3998032
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:24:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9Oigg004902
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:24:44 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 00/16] powernv: vfio: Add Dynamic DMA windows (DDW)
Date: Tue, 15 Jul 2014 19:24:24 +1000
Message-Id: <1405416280-12318-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This prepares existing upstream kernel for DDW (Dynamic DMA windows) and
adds actual DDW support for VFIO.

This patchset does not contain any in-kernel acceleration stuff.

This patchset does not enable DDW for emulated devices.


Alexey Kardashevskiy (16):
  powerpc/iommu: Fix comments with it_page_shift
  KVM: PPC: Use RCU when adding to arch.spapr_tce_tables
  powerpc/powernv: Use it_page_shift for TCE invalidation
  powerpc/powernv: Use it_page_shift in TCE build
  powerpc/powernv: Add a page size parameter to
    pnv_pci_setup_iommu_table()
  powerpc/powernv: Make invalidate() callback an iommu_table callback
  powerpc/spapr: vfio: Implement spapr_tce_iommu_ops
  powerpc/powernv: Convert/move set_bypass() callback to
    take_ownership()
  powerpc/iommu: Fix IOMMU ownership control functions
  powerpc/iommu: Fix missing permission bits in
    iommu_put_tce_user_mode()
  powerpc/iommu: Extend ppc_md.tce_build(_rm) to return old TCE values
  powerpc/powernv: Return non-zero TCE from pnv_tce_build
  powerpc/iommu: Implement put_page() if TCE had non-zero value
  powerpc/powernv: Implement Dynamic DMA windows (DDW) for IODA
  vfio: Use it_page_size
  vfio: powerpc: Enable Dynamic DMA windows

 arch/powerpc/include/asm/iommu.h            |  11 +-
 arch/powerpc/include/asm/machdep.h          |   2 +
 arch/powerpc/include/asm/tce.h              |  36 ++++
 arch/powerpc/kernel/iommu.c                 |  95 +++++++---
 arch/powerpc/kvm/book3s_64_vio.c            |   2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c   | 253 ++++++++++++++++++++++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |   4 +-
 arch/powerpc/platforms/powernv/pci.c        |  60 ++++--
 arch/powerpc/platforms/powernv/pci.h        |   4 +-
 arch/powerpc/platforms/pseries/iommu.c      |  17 +-
 arch/powerpc/sysdev/dart_iommu.c            |   1 +
 drivers/vfio/vfio_iommu_spapr_tce.c         | 280 ++++++++++++++++++++++++----
 include/uapi/linux/vfio.h                   |  37 +++-
 13 files changed, 679 insertions(+), 123 deletions(-)

-- 
2.0.0
