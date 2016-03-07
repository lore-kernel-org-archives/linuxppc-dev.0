Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67C1C1A01EC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:19 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 7 Mar 2016 13:42:17 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 508ED2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:15 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u273g7355701966
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:15 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u273fgUJ011034
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:41:43 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 0/9] KVM, PPC, VFIO: Enable in-kernel acceleration
Date: Mon,  7 Mar 2016 14:41:08 +1100
Message-Id: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables in-kernel acceleration of H_PUT_TCE/etc hypercalls for pseries
guests using VFIO. As pseries is a para-virtualized environment, the guest
can see and control IOMMUs via special hypercalls which let the guest
to add and remove mappings in real hardware IOMMU.

This was posted last time quite a long time ago so I dropped versions now,
this re-respin is v1. This was successfully used in the PowerKVM product
for quite a while now.

This is based on git://git.kernel.org/pub/scm/virt/kvm/kvm.git , "next"
branch which got "multi-tce in-kernel acceleration" and "64 bit in-kernel
TCE" support.

Please comment. Thanks!


Alexey Kardashevskiy (9):
  KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO capability number
  powerpc/mmu: Add real mode support for IOMMU preregistered memory
  KVM: PPC: Use preregistered memory API to access TCE list
  powerpc/powernv/iommu: Add real mode version of xchg()
  KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64 permanently
  KVM: PPC: Associate IOMMU group with guest view of TCE table
  KVM: PPC: Create a virtual-mode only TCE table handlers
  KVM: PPC: Add in-kernel handling for VFIO
  KVM: PPC: VFIO device: support SPAPR TCE

 Documentation/virtual/kvm/devices/vfio.txt |  21 +-
 arch/powerpc/include/asm/iommu.h           |   7 +
 arch/powerpc/include/asm/kvm_host.h        |   8 +
 arch/powerpc/include/asm/kvm_ppc.h         |   6 +
 arch/powerpc/include/asm/mmu_context.h     |   6 +-
 arch/powerpc/kernel/iommu.c                |  15 ++
 arch/powerpc/kvm/Kconfig                   |   2 +
 arch/powerpc/kvm/Makefile                  |   5 +-
 arch/powerpc/kvm/book3s_64_vio.c           | 344 +++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c        | 280 +++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S    |   4 +-
 arch/powerpc/kvm/powerpc.c                 |   1 +
 arch/powerpc/mm/mmu_context_iommu.c        |  45 +++-
 arch/powerpc/platforms/powernv/pci-ioda.c  |  28 ++-
 include/uapi/linux/kvm.h                   |  10 +
 virt/kvm/vfio.c                            | 106 +++++++++
 16 files changed, 855 insertions(+), 33 deletions(-)

-- 
2.5.0.rc3
