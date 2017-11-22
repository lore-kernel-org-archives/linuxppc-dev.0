Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yhSvS5vrPzDr4S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 14:42:28 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [RFC PATCH kernel] KVM: PPC: Book3S PR: Fix WIMG handling under pHyp
Date: Wed, 22 Nov 2017 14:42:21 +1100
Message-Id: <20171122034221.647-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

96df226 "KVM: PPC: Book3S PR: Preserve storage control bits" added WIMG
bits preserving but it missed 2 special cases:
- a magic page in kvmppc_mmu_book3s_64_xlate() and
- guest real mode in kvmppc_handle_pagefault().

For these ptes WIMG were 0 and pHyp failed on these causing a guest to
stop in the very beginning at NIP=0x100 (due to bd9166ffe
"KVM: PPC: Book3S PR: Exit KVM on failed mapping").

This initializes WIMG to non-zero value HPTE_R_M. The value is chosen
as (0x192 & HPTE_R_WIMG); 0x192 is a magic value from
kvmppc_mmu_map_page().

Fixes: 96df226 "KVM: PPC: Book3S PR: Preserve storage control bits"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This indeed fixes PR KVM + VFIO under pHyp but selection of HPTE_R_M
is arguable.

---
 arch/powerpc/kvm/book3s_64_mmu.c | 1 +
 arch/powerpc/kvm/book3s_pr.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 29ebe2f..a93d719 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -235,6 +235,7 @@ static int kvmppc_mmu_book3s_64_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 		gpte->may_read = true;
 		gpte->may_write = true;
 		gpte->page_size = MMU_PAGE_4K;
+		gpte->wimg = HPTE_R_M;
 
 		return 0;
 	}
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 69a0944..0152efe 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -557,6 +557,7 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		pte.eaddr = eaddr;
 		pte.vpage = eaddr >> 12;
 		pte.page_size = MMU_PAGE_64K;
+		pte.wimg = HPTE_R_M;
 	}
 
 	switch (kvmppc_get_msr(vcpu) & (MSR_DR|MSR_IR)) {
-- 
2.11.0
