Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE3991A018E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:40 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:40 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9C5BF2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:36 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9PKMD11534638
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:20 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PZvG025944
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:36 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 00/13] powerpc: kvm: Enable in-kernel acceleration for VFIO
Date: Tue, 15 Jul 2014 19:25:20 +1000
Message-Id: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
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

This enables in-kernel acceleration of TCE hypercalls (H_PUT_TCE,
H_PUT_TCE_INDIRECT, H_STUFF_TCE). This implements acceleration
for both real and virtual modes.

This was made on top of both:
[PATCH v1 00/16] powernv: vfio: Add Dynamic DMA windows (DDW)
[PATCH v1 0/7] powerpc/iommu: kvm: Enable MultiTCE support


Alexey Kardashevskiy (13):
  KVM: PPC: Account TCE pages in locked_vm
  KVM: PPC: Rework kvmppc_spapr_tce_table to support variable page size
  KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64 permanently
  KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO capability number
  KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_64 capability number
  KVM: PPC: Add @offset to kvmppc_spapr_tce_table
  KVM: PPC: Add support for 64bit TCE windows
  KVM: PPC: Add hugepage support for IOMMU in-kernel handling
  KVM: PPC: Add page_shift support for in-kernel H_PUT_TCE/etc handlers
  KVM: PPC: Fix kvmppc_gpa_to_hva_and_get() to return host physical
    address
  KVM: PPC: Associate IOMMU group with guest copy of TCE table
  KVM: PPC: vfio kvm device: support spapr tce
  KVM: PPC: Add support for IOMMU in-kernel handling

 Documentation/virtual/kvm/api.txt          |  51 ++++
 Documentation/virtual/kvm/devices/vfio.txt |  20 +-
 arch/powerpc/include/asm/kvm_host.h        |  41 ++-
 arch/powerpc/include/asm/kvm_ppc.h         |   9 +-
 arch/powerpc/include/uapi/asm/kvm.h        |   9 +
 arch/powerpc/kernel/iommu.c                |   6 +-
 arch/powerpc/kvm/Kconfig                   |   2 +
 arch/powerpc/kvm/Makefile                  |   3 +
 arch/powerpc/kvm/book3s_64_vio.c           | 389 +++++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_64_vio_hv.c        | 177 ++++++++++++-
 arch/powerpc/kvm/book3s_hv.c               |   3 +
 arch/powerpc/kvm/powerpc.c                 |  25 +-
 include/uapi/linux/kvm.h                   |  12 +
 virt/kvm/vfio.c                            |  69 +++++
 14 files changed, 775 insertions(+), 41 deletions(-)

-- 
2.0.0
