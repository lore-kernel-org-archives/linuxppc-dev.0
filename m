Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3D1A1A2C36
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Sep 2015 20:50:41 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 38A932CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:39 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8FAoU4052166716
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8FAo6JH007297
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:06 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 0/9] KVM: PPC: Add in-kernel multitce handling
Date: Tue, 15 Sep 2015 20:49:30 +1000
Message-Id: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches enable in-kernel acceleration for H_PUT_TCE_INDIRECT and
H_STUFF_TCE hypercalls which allow doing multiple (up to 512) TCE entries
update in a single call saving time on switching context. QEMU already
supports these hypercalls so this is just an optimization.

Both HV and PR KVM modes are supported.

This does not affect VFIO, this support is coming next.

Please comment. Thanks.


Alexey Kardashevskiy (9):
  rcu: Define notrace version of list_for_each_entry_rcu
  KVM: PPC: Make real_vmalloc_addr() public
  KVM: PPC: Rework H_PUT_TCE/H_GET_TCE handlers
  KVM: PPC: Use RCU for arch.spapr_tce_tables
  KVM: PPC: Account TCE-containing pages in locked_vm
  KVM: PPC: Replace SPAPR_TCE_SHIFT with IOMMU_PAGE_SHIFT_4K
  KVM: PPC: Move reusable bits of H_PUT_TCE handler to helpers
  KVM: Fix KVM_SMI chapter number
  KVM: PPC: Add support for multiple-TCE hcalls

 Documentation/virtual/kvm/api.txt        |  27 ++-
 arch/powerpc/include/asm/kvm_book3s_64.h |   2 -
 arch/powerpc/include/asm/kvm_host.h      |   1 +
 arch/powerpc/include/asm/kvm_ppc.h       |  16 ++
 arch/powerpc/include/asm/mmu-hash64.h    |   3 +
 arch/powerpc/kvm/book3s.c                |   2 +-
 arch/powerpc/kvm/book3s_64_vio.c         | 185 ++++++++++++++++--
 arch/powerpc/kvm/book3s_64_vio_hv.c      | 310 +++++++++++++++++++++++++++----
 arch/powerpc/kvm/book3s_hv.c             |  26 ++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  17 --
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |   6 +-
 arch/powerpc/kvm/book3s_pr_papr.c        |  35 ++++
 arch/powerpc/kvm/powerpc.c               |   3 +
 arch/powerpc/mm/hash_utils_64.c          |  17 ++
 include/linux/rculist.h                  |  38 ++++
 15 files changed, 610 insertions(+), 78 deletions(-)

-- 
2.4.0.rc3.8.gfb3e7d5
