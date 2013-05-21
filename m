Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A2D92C0107
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 13:07:06 +1000 (EST)
Received: by mail-pa0-f54.google.com with SMTP id kx1so235023pab.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 20:07:04 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4 v2] KVM: PPC: IOMMU in-kernel handling
Date: Tue, 21 May 2013 13:06:43 +1000
Message-Id: <1369105607-20957-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This accelerates IOMMU operations in real and virtual
mode in the host kernel for the KVM guest.

The first patch with multitce support is useful for emulated devices as is.

The other patches are designed for VFIO although this series
does not contain any VFIO related code as the connection between
VFIO and the new handlers is to be made in QEMU
via ioctl to the KVM fd.

The series was made and tested against v3.10-rc1.


Alexey Kardashevskiy (4):
  KVM: PPC: Add support for multiple-TCE hcalls
  powerpc: Prepare to support kernel handling of IOMMU map/unmap
  KVM: PPC: Add support for IOMMU in-kernel handling
  KVM: PPC: Add hugepage support for IOMMU in-kernel handling

 Documentation/virtual/kvm/api.txt        |   42 +++
 arch/powerpc/include/asm/kvm_host.h      |    7 +
 arch/powerpc/include/asm/kvm_ppc.h       |   40 ++-
 arch/powerpc/include/asm/pgtable-ppc64.h |    4 +
 arch/powerpc/include/uapi/asm/kvm.h      |    7 +
 arch/powerpc/kvm/book3s_64_vio.c         |  398 ++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c      |  471 ++++++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv.c             |   39 +++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |    6 +
 arch/powerpc/kvm/book3s_pr_papr.c        |   37 ++-
 arch/powerpc/kvm/powerpc.c               |   15 +
 arch/powerpc/mm/init_64.c                |   77 ++++-
 include/uapi/linux/kvm.h                 |    5 +
 13 files changed, 1120 insertions(+), 28 deletions(-)

-- 
1.7.10.4
