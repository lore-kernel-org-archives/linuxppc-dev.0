Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40L6Rp6VbpzF1x1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 22:48:54 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id bj1-v6so7435258plb.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 05:48:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 0/5] KVM TLB flushing improvements
Date: Tue, 10 Apr 2018 22:48:37 +1000
Message-Id: <20180410124842.30184-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds powerpc:tlbie tracepoints for radix partition
scoped invalidations. After I started getting some traces on a
32 vCPU radix guest it showed a problem with partition scoped
faults/invalidates, so I had a try at fixing it. This seems to
stable be on radix so far (haven't tested hash yet).

Thanks,
Nick

Nicholas Piggin (5):
  powerpc/64s/mm: Implement LPID based TLB flushes to be used by KVM
  KVM: PPC: Book3S HV: kvmppc_radix_tlbie_page use Linux flush function
  KVM: PPC: Book3S HV: kvmhv_p9_set_lpcr use Linux flush function
  KVM: PPC: Book3S HV: handle need_tlb_flush in C before low-level guest
    entry
  KVM: PPC: Book3S HV: Radix do not clear partition scoped page table
    when page fault races with other vCPUs.

 .../include/asm/book3s/64/tlbflush-hash.h     |  2 +
 .../include/asm/book3s/64/tlbflush-radix.h    |  5 ++
 arch/powerpc/kvm/book3s_64_mmu_radix.c        | 65 +++++++-------
 arch/powerpc/kvm/book3s_hv.c                  | 21 ++++-
 arch/powerpc/kvm/book3s_hv_builtin.c          | 14 ++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S       | 43 +--------
 arch/powerpc/mm/hash_native_64.c              |  8 ++
 arch/powerpc/mm/tlb-radix.c                   | 87 +++++++++++++++++++
 8 files changed, 157 insertions(+), 88 deletions(-)

-- 
2.17.0
