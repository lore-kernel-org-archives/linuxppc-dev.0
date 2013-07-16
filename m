Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A44E42C017A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 10:54:20 +1000 (EST)
Received: by mail-pb0-f51.google.com with SMTP id um15so87677pbc.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 17:54:18 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/10 v6] KVM: PPC: IOMMU in-kernel handling
Date: Tue, 16 Jul 2013 10:53:55 +1000
Message-Id: <1373936045-22653-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
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

The changes are:
1. rebased on v3.11-rc1 so the capability numbers changed again
2. fixed multiple comments from maintainers
3. "KVM: PPC: Add support for IOMMU in-kernel handling" is split into
2 patches, the new one is "powerpc/iommu: rework to support realmode".
4. IOMMU_API is now always enabled for KVM_BOOK3S_64.

MOre details in the individual patch comments.

Depends on "hashtable: add hash_for_each_possible_rcu_notrace()",
posted a while ago.


Alexey Kardashevskiy (10):
  KVM: PPC: reserve a capability number for multitce support
  KVM: PPC: reserve a capability and ioctl numbers for realmode VFIO
  vfio: add external user support
  powerpc: Prepare to support kernel handling of IOMMU map/unmap
  powerpc: add real mode support for dma operations on powernv
  KVM: PPC: enable IOMMU_API for KVM_BOOK3S_64 permanently
  KVM: PPC: Add support for multiple-TCE hcalls
  powerpc/iommu: rework to support realmode
  KVM: PPC: Add support for IOMMU in-kernel handling
  KVM: PPC: Add hugepage support for IOMMU in-kernel handling

 Documentation/virtual/kvm/api.txt         |  52 +++
 arch/powerpc/include/asm/iommu.h          |   9 +-
 arch/powerpc/include/asm/kvm_host.h       |  37 +++
 arch/powerpc/include/asm/kvm_ppc.h        |  18 +-
 arch/powerpc/include/asm/machdep.h        |  12 +
 arch/powerpc/include/asm/pgtable-ppc64.h  |   4 +
 arch/powerpc/include/uapi/asm/kvm.h       |   7 +
 arch/powerpc/kernel/iommu.c               | 201 +++++++----
 arch/powerpc/kvm/Kconfig                  |   1 +
 arch/powerpc/kvm/book3s_64_vio.c          | 533 +++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c       | 404 ++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv.c              |  41 ++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |   8 +-
 arch/powerpc/kvm/book3s_pr_papr.c         |  35 ++
 arch/powerpc/kvm/powerpc.c                |  15 +
 arch/powerpc/mm/init_64.c                 |  76 ++++-
 arch/powerpc/platforms/powernv/pci-ioda.c |  47 ++-
 arch/powerpc/platforms/powernv/pci.c      |  38 ++-
 arch/powerpc/platforms/powernv/pci.h      |   3 +-
 drivers/vfio/vfio.c                       |  62 ++++
 include/linux/page-flags.h                |   4 +-
 include/linux/vfio.h                      |   7 +
 include/uapi/linux/kvm.h                  |   5 +
 23 files changed, 1496 insertions(+), 123 deletions(-)

-- 
1.8.3.2
