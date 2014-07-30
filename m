Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 595681A01A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:43 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 30 Jul 2014 19:31:41 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 756463578048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:38 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6U9EXMu66846858
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:14:34 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6U9Vbfa026552
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:37 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 00/16] powernv: vfio: Add Dynamic DMA windows (DDW)
Date: Wed, 30 Jul 2014 19:31:19 +1000
Message-Id: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <michael@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
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
v4:
* addressed Ben's comments
* big rework with moving tce_xxx callbacks out of ppc_md

v3:
* applied multiple comments from Gavin regarding error checking
and callbacks placements

v2:
* moved "Account TCE pages in locked_vm" here (was in later series)
* added counting for huge window to locked_vm (ugly but better than nothing)
* fixed bug with missing >>PAGE_SHIFT when calling pfn_to_page




Alexey Kardashevskiy (16):
  rcu: Define notrace version of list_for_each_entry_rcu and
    list_entry_rcu
  KVM: PPC: Use RCU for arch.spapr_tce_tables
  mm: Add helpers for locked_vm
  KVM: PPC: Account TCE-containing pages in locked_vm
  powerpc/iommu: Fix comments with it_page_shift
  powerpc/powernv: Make invalidate() a callback
  powerpc/spapr: vfio: Implement spapr_tce_iommu_ops
  powerpc/powernv: Convert/move set_bypass() callback to
    take_ownership()
  powerpc/iommu: Fix IOMMU ownership control functions
  powerpc: Move tce_xxx callbacks from ppc_md to iommu_table
  powerpc/powernv: Release replaced TCE
  powerpc/pseries/lpar: Enable VFIO
  powerpc/powernv: Implement Dynamic DMA windows (DDW) for IODA
  vfio: powerpc/spapr: Reuse locked_vm accounting helpers
  vfio: powerpc/spapr: Use it_page_size
  vfio: powerpc/spapr: Enable Dynamic DMA windows

 arch/powerpc/include/asm/iommu.h            |  33 ++-
 arch/powerpc/include/asm/kvm_host.h         |   1 +
 arch/powerpc/include/asm/machdep.h          |  25 --
 arch/powerpc/include/asm/tce.h              |  38 +++
 arch/powerpc/kernel/iommu.c                 | 158 ++++++++-----
 arch/powerpc/kernel/vio.c                   |   5 +-
 arch/powerpc/kvm/book3s.c                   |   2 +-
 arch/powerpc/kvm/book3s_64_vio.c            |  43 +++-
 arch/powerpc/kvm/book3s_64_vio_hv.c         |   6 +-
 arch/powerpc/platforms/cell/iommu.c         |   9 +-
 arch/powerpc/platforms/pasemi/iommu.c       |   8 +-
 arch/powerpc/platforms/powernv/pci-ioda.c   | 239 ++++++++++++++++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |   4 +-
 arch/powerpc/platforms/powernv/pci.c        |  86 ++++---
 arch/powerpc/platforms/powernv/pci.h        |  16 +-
 arch/powerpc/platforms/pseries/iommu.c      |  77 ++++--
 arch/powerpc/sysdev/dart_iommu.c            |  13 +-
 drivers/vfio/vfio_iommu_spapr_tce.c         | 348 ++++++++++++++++++++++++----
 include/linux/mm.h                          |   3 +
 include/linux/rculist.h                     |  38 +++
 include/uapi/linux/vfio.h                   |  37 ++-
 mm/mlock.c                                  |  49 ++++
 22 files changed, 990 insertions(+), 248 deletions(-)

-- 
2.0.0
