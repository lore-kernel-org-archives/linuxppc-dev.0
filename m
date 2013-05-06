Return-Path: <aik@ozlabs.ru>
Received: from mail-yh0-x230.google.com (mail-yh0-x230.google.com
 [IPv6:2607:f8b0:4002:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E56712C0208
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 17:26:10 +1000 (EST)
Received: by mail-yh0-f48.google.com with SMTP id f35so672106yha.21
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 00:26:07 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] KVM: PPC: IOMMU in-kernel handling
Date: Mon,  6 May 2013 17:25:51 +1000
Message-Id: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Joerg Roedel <joerg.roedel@amd.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is supposed to accelerate IOMMU operations in real and virtual
mode in the host kernel for the KVM guest.

The first user is VFIO however this series does not contain any VFIO related
code as the connection between VFIO and the new handlers is to be made in QEMU
via ioctl to the KVM fd.

Although the series compiles, it does not make sense without VFIO patches which
are posted separately.

The "iommu: Add a function to find an iommu group by id" patch has already
gone to linux-next (from iommu tree) but it is not in upstream yet so
I am including it here for the reference.


Alexey Kardashevskiy (6):
  KVM: PPC: Make lookup_linux_pte public
  KVM: PPC: Add support for multiple-TCE hcalls
  powerpc: Prepare to support kernel handling of IOMMU map/unmap
  iommu: Add a function to find an iommu group by id
  KVM: PPC: Add support for IOMMU in-kernel handling
  KVM: PPC: Add hugepage support for IOMMU in-kernel handling

 Documentation/virtual/kvm/api.txt        |   43 +++
 arch/powerpc/include/asm/kvm_host.h      |    4 +
 arch/powerpc/include/asm/kvm_ppc.h       |   44 ++-
 arch/powerpc/include/asm/pgtable-ppc64.h |    4 +
 arch/powerpc/include/uapi/asm/kvm.h      |    7 +
 arch/powerpc/kvm/book3s_64_vio.c         |  433 +++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c      |  464 ++++++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv.c             |   23 ++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |    5 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |    6 +
 arch/powerpc/kvm/book3s_pr_papr.c        |   37 ++-
 arch/powerpc/kvm/powerpc.c               |   15 +
 arch/powerpc/mm/init_64.c                |   77 ++++-
 drivers/iommu/iommu.c                    |   29 ++
 include/linux/iommu.h                    |    1 +
 include/uapi/linux/kvm.h                 |    3 +
 16 files changed, 1159 insertions(+), 36 deletions(-)

-- 
1.7.10.4
