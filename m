Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 761521A0DC2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:16:57 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 21 Jan 2016 18:16:57 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DCF073578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:16:54 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0L8GakO47579334
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:16:44 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0L8GMcO011649
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:16:22 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 0/4] KVM: PPC: Add in-kernel acceleration for 64bit DMA
Date: Thu, 21 Jan 2016 19:15:22 +1100
Message-Id: <1453364126-22527-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This extends the existing H_PUT_TCE/etc in-kernel acceleration to 64bit
DMA windows mapped at addresses other than zero. This accelerates huge
DMA windows which pseries guests create using Dynamic DMA window (DDW) API.

This does not affect VFIO yet.

This depends on:

69b907297f4e list: Add lockless list traversal primitives
and recently posted:
powerpc: Make vmalloc_to_phys() public
KVM: PPC: Add in-kernel multitce handling


Please comment. Thanks!


Alexey Kardashevskiy (4):
  KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_64 capability number
  KVM: PPC: Add @page_shift to kvmppc_spapr_tce_table
  KVM: PPC: Add @offset to kvmppc_spapr_tce_table
  KVM: PPC: Add support for 64bit TCE windows

 Documentation/virtual/kvm/api.txt   | 32 ++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_host.h |  4 +++-
 arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
 arch/powerpc/include/uapi/asm/kvm.h |  9 +++++++++
 arch/powerpc/kvm/book3s_64_vio.c    | 35 ++++++++++++++++++++---------------
 arch/powerpc/kvm/book3s_64_vio_hv.c | 22 ++++++++++++----------
 arch/powerpc/kvm/powerpc.c          | 25 ++++++++++++++++++++++++-
 include/uapi/linux/kvm.h            |  3 +++
 8 files changed, 104 insertions(+), 28 deletions(-)

-- 
2.5.0.rc3
