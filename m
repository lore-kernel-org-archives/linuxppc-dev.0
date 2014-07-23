Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 505951A01C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:13 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 23 Jul 2014 13:06:10 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7D0582BB0063
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N2nCgg57081908
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 12:49:13 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N367rD030987
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:08 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 00/18] powernv: vfio: Add Dynamic DMA windows (DDW)
Date: Wed, 23 Jul 2014 13:05:46 +1000
Message-Id: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
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

Changes:
v2:
* moved "Account TCE pages in locked_vm" here (was in later series)
* added counting for huge window to locked_vm (ugly but better than nothing)
* fixed bug with missing >>PAGE_SHIFT when calling pfn_to_page


Alexey Kardashevskiy (18):
  powerpc/iommu: Fix comments with it_page_shift
  KVM: PPC: Use RCU when adding to arch.spapr_tce_tables
  KVM: PPC: Account TCE pages in locked_vm
  vfio: powerpc: Move locked_vm accounting to a helper
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
 arch/powerpc/include/asm/tce.h              |  36 +++
 arch/powerpc/kernel/iommu.c                 |  95 +++++---
 arch/powerpc/kvm/book3s_64_vio.c            |  37 ++-
 arch/powerpc/platforms/powernv/pci-ioda.c   | 253 ++++++++++++++++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |   4 +-
 arch/powerpc/platforms/powernv/pci.c        |  60 +++--
 arch/powerpc/platforms/powernv/pci.h        |   4 +-
 arch/powerpc/platforms/pseries/iommu.c      |  17 +-
 arch/powerpc/sysdev/dart_iommu.c            |   1 +
 drivers/vfio/vfio_iommu_spapr_tce.c         | 362 ++++++++++++++++++++++++----
 include/uapi/linux/vfio.h                   |  37 ++-
 13 files changed, 780 insertions(+), 139 deletions(-)

-- 
2.0.0
