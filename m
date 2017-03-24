Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vqDYL2fQRzDqck
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 17:49:26 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel] KVM: PPC: Preserve storage control bits
Date: Fri, 24 Mar 2017 17:49:22 +1100
Message-Id: <20170324064922.18429-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PR KVM page fault handler performs eaddr to pte translation for a guest,
however kvmppc_mmu_book3s_64_xlate() does not preserve WIMG bits
(storage control) in the kvmppc_pte struct. If PR KVM is running as
a second level guest under HV KVM, and PR KVM tries inserting HPT entry,
this fails in HV KVM if it already has this mapping.

This preserves WIMG bits between kvmppc_mmu_book3s_64_xlate() and
kvmppc_mmu_map_page().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This allows MMIO BAR mapping for nested guest with VFIO.

This is the check in HV KVM which failed:

arch/powerpc/kvm/book3s_hv_rm_mmu.c
long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
[...]

        /*If we had host pte mapping then  Check WIMG */
        if (ptep && !hpte_cache_flags_ok(ptel, is_ci)) {
                if (is_ci)
                        return H_PARAMETER;
                /*
                 * Allow guest to map emulated device memory as
                 * uncacheable, but actually make it cacheable.
                 */
                ptel &= ~(HPTE_R_W|HPTE_R_I|HPTE_R_G);
                ptel |= HPTE_R_M;
        }
---
 arch/powerpc/include/asm/kvm_host.h   | 1 +
 arch/powerpc/kvm/book3s_64_mmu.c      | 1 +
 arch/powerpc/kvm/book3s_64_mmu_host.c | 2 ++
 arch/powerpc/kvm/book3s_pr.c          | 2 +-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 7bba8f415627..bf6822cd4f86 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -345,6 +345,7 @@ struct kvmppc_pte {
 	bool may_read		: 1;
 	bool may_write		: 1;
 	bool may_execute	: 1;
+	unsigned long wimg;
 	u8 page_size;		/* MMU_PAGE_xxx */
 };
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 70153578131a..29ebe2fd5867 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -319,6 +319,7 @@ static int kvmppc_mmu_book3s_64_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 		gpte->may_execute = true;
 	gpte->may_read = false;
 	gpte->may_write = false;
+	gpte->wimg = r & HPTE_R_WIMG;
 
 	switch (pp) {
 	case 0:
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 4b4e927c4822..145a61892c48 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -145,6 +145,8 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte,
 	else
 		kvmppc_mmu_flush_icache(pfn);
 
+	rflags = (rflags & ~HPTE_R_WIMG) | orig_pte->wimg;
+
 	/*
 	 * Use 64K pages if possible; otherwise, on 64K page kernels,
 	 * we need to transfer 4 more bits from guest real to host real addr.
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index ce437b98477e..f026b062c0ed 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -537,7 +537,7 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	int r = RESUME_GUEST;
 	int relocated;
 	int page_found = 0;
-	struct kvmppc_pte pte;
+	struct kvmppc_pte pte = { 0 };
 	bool dr = (kvmppc_get_msr(vcpu) & MSR_DR) ? true : false;
 	bool ir = (kvmppc_get_msr(vcpu) & MSR_IR) ? true : false;
 	u64 vsid;
-- 
2.11.0
