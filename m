Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FF811A02D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:21 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:21 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0D8552BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:18 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F98VPT26148972
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:08:31 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PHft005820
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:17 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 0/7] powerpc/iommu: kvm: Enable MultiTCE support
Date: Tue, 15 Jul 2014 19:25:04 +1000
Message-Id: <1405416311-12429-1-git-send-email-aik@ozlabs.ru>
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


This prepares upstream kernel for in-kernel acceleration of TCE hypercalls
(H_PUT_TCE, H_PUT_TCE_INDIRECT, H_STUFF_TCE). This implements acceleration
for both real and virtual modes. As it requires gup() for real mode to
parse TCE list page, this implements gup() for realmode.

This only accelerates emulated PCI and VIO devices. DDW is not affected.

This was made on top of
[PATCH v1 00/16] powernv: vfio: Add Dynamic DMA windows (DDW)



Alexey Kardashevskiy (7):
  powerpc/iommu: Change prototypes for realmode support
  powerpc/iommu: Support real mode
  powerpc/iommu: Clean up IOMMU API
  KVM: PPC: Replace SPAPR_TCE_SHIFT with IOMMU_PAGE_SHIFT_4K
  KVM: PPC: Move reusable bits of H_PUT_TCE handler to helpers
  KVM: PPC: Add kvmppc_find_tce_table()
  KVM: PPC: Add support for multiple-TCE hcalls

 Documentation/virtual/kvm/api.txt         |  26 +++
 arch/powerpc/include/asm/iommu.h          |   9 +-
 arch/powerpc/include/asm/kvm_book3s_64.h  |   2 -
 arch/powerpc/include/asm/kvm_host.h       |  30 +++
 arch/powerpc/include/asm/kvm_ppc.h        |  16 ++
 arch/powerpc/kernel/iommu.c               | 140 +++++++-----
 arch/powerpc/kvm/book3s_64_vio.c          | 177 ++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c       | 343 ++++++++++++++++++++++++++----
 arch/powerpc/kvm/book3s_hv.c              |  30 ++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |   4 +-
 arch/powerpc/kvm/book3s_pr.c              |   4 +
 arch/powerpc/kvm/book3s_pr_papr.c         |  35 +++
 arch/powerpc/kvm/powerpc.c                |   3 +
 arch/powerpc/platforms/powernv/pci-ioda.c |   3 +-
 drivers/vfio/vfio_iommu_spapr_tce.c       |   6 +-
 15 files changed, 720 insertions(+), 108 deletions(-)

-- 
2.0.0
