Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Pb8h2xXgzF1S0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 14:32:52 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h69so9918090pfe.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 21:32:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/5] KVM TLB flushing improvements (for radix)
Date: Mon, 16 Apr 2018 14:32:35 +1000
Message-Id: <20180416043240.8796-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series moves some of the radix mode TLB flushing into
powerpc/mm, which allows them them to implement the powerpc:tlbie
tracepoints for KVM invalidations.

This also fixes a partition scoped page fault performance issue
that was found by looking at partition scoped tlbie traces.

Since v1:
- Fixed a bug where I mixed up PRS values, leading to guest page
  fault hangs.
- Fixed up the hash cases that still need to be done in real-mode.
- Dropped the hash changes including the interesting case of a
  hash tlbie issued by a radix host, for mixed mode support.

This has survived some stress testing over the weekend now, so
it should be ready for wider review.

Thanks,
Nick

Nicholas Piggin (5):
  KVM: PPC: Book3S HV: radix use correct tlbie sequence in
    kvmppc_radix_tlbie_page
  powerpc/mm/radix: implement LPID based TLB flushes to be used by KVM
  KVM: PPC: Book3S HV: radix use the Linux TLB flush function in
    kvmppc_radix_tlbie_page
  KVM: PPC: Book3S HV: radix handle process scoped LPID flush in C, with
    relocation on
  KVM: PPC: Book3S HV: radix do not clear partition scoped page table
    when page fault races with other vCPUs.

 .../include/asm/book3s/64/tlbflush-radix.h    |   6 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c        |  78 ++++-----
 arch/powerpc/kvm/book3s_hv.c                  |  26 +++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S       |  13 +-
 arch/powerpc/mm/tlb-radix.c                   | 160 ++++++++++++++++++
 5 files changed, 238 insertions(+), 45 deletions(-)

-- 
2.17.0
