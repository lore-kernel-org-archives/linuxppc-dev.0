Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97B131A0350
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:25 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 15 Feb 2016 11:56:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EA1662BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:21 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1F1u69w47710212
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:21 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1F1tgNU025262
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:55:42 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v3 0/7] KVM: PPC: Add in-kernel multitce handling
Date: Mon, 15 Feb 2016 12:55:02 +1100
Message-Id: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
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

This includes "powerpc: Make vmalloc_to_phys() public" as the patch depends
on it. The individual patches have changelog.

This is based on sha1 c05235d (kernelrelease = v4.5.0-rc3).

Please comment. Thanks.


Alexey Kardashevskiy (7):
  powerpc: Make vmalloc_to_phys() public
  KVM: PPC: Rework H_PUT_TCE/H_GET_TCE handlers
  KVM: PPC: Use RCU for arch.spapr_tce_tables
  KVM: PPC: Account TCE-containing pages in locked_vm
  KVM: PPC: Replace SPAPR_TCE_SHIFT with IOMMU_PAGE_SHIFT_4K
  KVM: PPC: Move reusable bits of H_PUT_TCE handler to helpers
  KVM: PPC: Add support for multiple-TCE hcalls

 Documentation/virtual/kvm/api.txt        |  25 +++
 arch/powerpc/include/asm/kvm_book3s_64.h |   2 -
 arch/powerpc/include/asm/kvm_host.h      |   1 +
 arch/powerpc/include/asm/kvm_ppc.h       |  16 ++
 arch/powerpc/include/asm/pgtable.h       |   3 +
 arch/powerpc/kvm/book3s.c                |   2 +-
 arch/powerpc/kvm/book3s_64_vio.c         | 146 ++++++++++++--
 arch/powerpc/kvm/book3s_64_vio_hv.c      | 322 +++++++++++++++++++++++++++----
 arch/powerpc/kvm/book3s_hv.c             |  26 ++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |   4 +-
 arch/powerpc/kvm/book3s_pr_papr.c        |  35 ++++
 arch/powerpc/kvm/powerpc.c               |   3 +
 arch/powerpc/mm/pgtable.c                |   8 +
 arch/powerpc/perf/hv-24x7.c              |   8 -
 14 files changed, 531 insertions(+), 70 deletions(-)

-- 
2.5.0.rc3
