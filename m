Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F386E2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 15:02:56 +1000 (EST)
Received: by mail-pd0-f179.google.com with SMTP id q10so164359pdj.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 22:02:54 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/8 v4] KVM: PPC: IOMMU in-kernel handling
Date: Thu, 27 Jun 2013 15:02:28 +1000
Message-Id: <1372309356-28320-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The changes are:
1. rebased on v3.10-rc7
2. removed spinlocks from real mode
3. added security checks between KVM and VFIO

MOre details in the individual patch comments.


Alexey Kardashevskiy (8):
  KVM: PPC: reserve a capability number for multitce support
  KVM: PPC: reserve a capability and ioctl numbers for realmode VFIO
  vfio: add external user support
  hashtable: add hash_for_each_possible_rcu_notrace()
  powerpc: Prepare to support kernel handling of IOMMU map/unmap
  KVM: PPC: Add support for multiple-TCE hcalls
  KVM: PPC: Add support for IOMMU in-kernel handling
  KVM: PPC: Add hugepage support for IOMMU in-kernel handling

 Documentation/virtual/kvm/api.txt        |   51 +++
 arch/powerpc/include/asm/kvm_host.h      |   31 ++
 arch/powerpc/include/asm/kvm_ppc.h       |   18 +-
 arch/powerpc/include/asm/pgtable-ppc64.h |    4 +
 arch/powerpc/include/uapi/asm/kvm.h      |    8 +
 arch/powerpc/kvm/book3s_64_vio.c         |  506 +++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c      |  439 ++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv.c             |   41 ++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |    6 +
 arch/powerpc/kvm/book3s_pr_papr.c        |   37 ++-
 arch/powerpc/kvm/powerpc.c               |   15 +
 arch/powerpc/mm/init_64.c                |   78 ++++-
 drivers/vfio/vfio.c                      |   53 ++++
 include/linux/hashtable.h                |   15 +
 include/linux/page-flags.h               |    4 +-
 include/uapi/linux/kvm.h                 |    3 +
 16 files changed, 1279 insertions(+), 30 deletions(-)

-- 
1.7.10.4
