Return-Path: <aik@ozlabs.ru>
Received: from mail-gh0-f175.google.com (mail-gh0-f175.google.com
 [209.85.160.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B8C7B2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jul 2013 01:07:22 +1000 (EST)
Received: by mail-gh0-f175.google.com with SMTP id z19so1078541ghb.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jul 2013 08:07:19 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/8 v5]  KVM: PPC: IOMMU in-kernel handling
Date: Sun,  7 Jul 2013 01:06:59 +1000
Message-Id: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
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
1. rebased on v3.10
2. added arch_spin_locks to protect TCE table in real mode
3. reworked VFIO external API
4. added missing bits for real mode handling of TCE requests on p7ioc

MOre details in the individual patch comments.

Depends on "hashtable: add hash_for_each_possible_rcu_notrace()",
posted earlier today.

Alexey Kardashevskiy (8):
  KVM: PPC: reserve a capability number for multitce support
  KVM: PPC: reserve a capability and ioctl numbers for realmode VFIO
  vfio: add external user support
  powerpc: Prepare to support kernel handling of IOMMU map/unmap
  powerpc: add real mode support for dma operations on powernv
  KVM: PPC: Add support for multiple-TCE hcalls
  KVM: PPC: Add support for IOMMU in-kernel handling
  KVM: PPC: Add hugepage support for IOMMU in-kernel handling

 Documentation/virtual/kvm/api.txt         |  51 +++
 arch/powerpc/include/asm/iommu.h          |   9 +-
 arch/powerpc/include/asm/kvm_host.h       |  37 ++
 arch/powerpc/include/asm/kvm_ppc.h        |  18 +-
 arch/powerpc/include/asm/machdep.h        |  12 +
 arch/powerpc/include/asm/pgtable-ppc64.h  |   4 +
 arch/powerpc/include/uapi/asm/kvm.h       |   7 +
 arch/powerpc/kernel/iommu.c               | 200 +++++++----
 arch/powerpc/kvm/book3s_64_vio.c          | 541 +++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c       | 404 ++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv.c              |  41 ++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |   6 +
 arch/powerpc/kvm/book3s_pr_papr.c         |  37 +-
 arch/powerpc/kvm/powerpc.c                |  15 +
 arch/powerpc/mm/init_64.c                 |  78 ++++-
 arch/powerpc/platforms/powernv/pci-ioda.c |  26 +-
 arch/powerpc/platforms/powernv/pci.c      |  38 ++-
 arch/powerpc/platforms/powernv/pci.h      |   2 +-
 drivers/vfio/vfio.c                       |  35 ++
 include/linux/page-flags.h                |   4 +-
 include/linux/vfio.h                      |   7 +
 include/uapi/linux/kvm.h                  |   3 +
 22 files changed, 1453 insertions(+), 122 deletions(-)

-- 
1.8.3.2
