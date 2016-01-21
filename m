Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F5701A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 18:40:40 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 21 Jan 2016 17:40:39 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E170D2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 18:40:35 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0L7eTTO34471972
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 18:40:37 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0L7e378030966
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 18:40:03 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v2 0/6] KVM: PPC: Add in-kernel multitce handling
Date: Thu, 21 Jan 2016 18:39:31 +1100
Message-Id: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
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

This depends on "powerpc: Make vmalloc_to_phys() public".

Please comment. Thanks.


Alexey Kardashevskiy (6):
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
 arch/powerpc/kvm/book3s.c                |   2 +-
 arch/powerpc/kvm/book3s_64_vio.c         | 188 ++++++++++++++++--
 arch/powerpc/kvm/book3s_64_vio_hv.c      | 318 ++++++++++++++++++++++++++-----
 arch/powerpc/kvm/book3s_hv.c             |  26 ++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |   6 +-
 arch/powerpc/kvm/book3s_pr_papr.c        |  35 ++++
 arch/powerpc/kvm/powerpc.c               |   3 +
 11 files changed, 557 insertions(+), 65 deletions(-)

-- 
2.5.0.rc3
