Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vqDXZ0qY1zDqb3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 17:48:44 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel] KVM: PPC: Exit KVM on failed mapping
Date: Fri, 24 Mar 2017 17:48:10 +1100
Message-Id: <20170324064810.18325-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment kvmppc_mmu_map_page() returns -1 if
mmu_hash_ops.hpte_insert() fails for any reason so the page fault handler
resumes the guest and it faults on the same address again.

This adds distinction to kvmppc_mmu_map_page() to return -EIO if
mmu_hash_ops.hpte_insert() failed for a reason other than full pteg.
At the moment only pSeries_lpar_hpte_insert() returns -2 if
plpar_pte_enter() failed with a code other than H_PTEG_FULL.
Other mmu_hash_ops.hpte_insert() instances can only fail with
-1 "full pteg".

With this change, if PR KVM fails to update HPT, it can signal
the userspace about this instead of returning to guest and having
the very same page fault over and over again.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This was found with nested KVM+VFIO when PR KVM was trying to map MMIO BAR
of a VFIO PCI device but since it would not preserve WIMG bits, HV KVM
would fail, mmu_hash_ops.hpte_insert() would return error and PR KVM
would just continue and trap again on the same memory access.

With this patch but without "KVM: PPC: Preserve storage control bits"
nested QEMU will abort with informative screen instead of endlessly
trying to proceed further in booting.
---
 arch/powerpc/kvm/book3s_64_mmu_host.c | 5 ++++-
 arch/powerpc/kvm/book3s_pr.c          | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index a587e8f4fd26..4b4e927c4822 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -177,12 +177,15 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte,
 	ret = mmu_hash_ops.hpte_insert(hpteg, vpn, hpaddr, rflags, vflags,
 				       hpsize, hpsize, MMU_SEGSIZE_256M);
 
-	if (ret < 0) {
+	if (ret == -1) {
 		/* If we couldn't map a primary PTE, try a secondary */
 		hash = ~hash;
 		vflags ^= HPTE_V_SECONDARY;
 		attempt++;
 		goto map_again;
+	} else if (ret < 0) {
+		r = -EIO;
+		goto out_unlock;
 	} else {
 		trace_kvm_book3s_64_mmu_map(rflags, hpteg,
 					    vpn, hpaddr, orig_pte);
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 633502f52bbb..ce437b98477e 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -625,7 +625,11 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			kvmppc_mmu_unmap_page(vcpu, &pte);
 		}
 		/* The guest's PTE is not mapped yet. Map on the host */
-		kvmppc_mmu_map_page(vcpu, &pte, iswrite);
+		if (kvmppc_mmu_map_page(vcpu, &pte, iswrite) == -EIO) {
+			/* Exit KVM if mapping failed */
+			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			return RESUME_HOST;
+		}
 		if (data)
 			vcpu->stat.sp_storage++;
 		else if (vcpu->arch.mmu.is_dcbz32(vcpu) &&
-- 
2.11.0
