Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39C311A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 17:55:49 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 1 Mar 2016 16:55:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B82C72BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 17:55:44 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u216tV3556950864
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 17:55:44 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u216t6SL015751
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 17:55:06 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: kvm-ppc@vger.kernel.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: [PATCH kernel v2 0/4] KVM: PPC: Add in-kernel acceleration for 64bit
 DMA
Date: Tue,  1 Mar 2016 17:54:36 +1100
Message-Id: <1456815280-38546-1-git-send-email-aik@ozlabs.ru>
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

This is made against git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git ,
kvm-ppc-next branch.


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
 arch/powerpc/kvm/book3s_64_vio.c    | 28 ++++++++++++++++------------
 arch/powerpc/kvm/book3s_64_vio_hv.c | 24 +++++++++++++-----------
 arch/powerpc/kvm/powerpc.c          | 25 ++++++++++++++++++++++++-
 include/uapi/linux/kvm.h            |  3 +++
 8 files changed, 101 insertions(+), 26 deletions(-)

-- 
2.5.0.rc3
