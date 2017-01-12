Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzfzl2pgHzDqSZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 20:07:47 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 16/18] KVM: PPC: Book3S HV: Make HPT-specific hypercalls
 return error in radix mode
Date: Thu, 12 Jan 2017 20:07:24 +1100
Message-Id: <1484212046-29591-17-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
References: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the guest is in radix mode, then it doesn't have a hashed page
table (HPT), so all of the hypercalls that manipulate the HPT can't
work and should return an error.  This adds checks to make them
return H_FUNCTION ("function not supported").

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 9ef3c4b..6c1ac3d 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -182,6 +182,8 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	unsigned long mmu_seq;
 	unsigned long rcbits, irq_flags = 0;
 
+	if (kvm_is_radix(kvm))
+		return H_FUNCTION;
 	psize = hpte_page_size(pteh, ptel);
 	if (!psize)
 		return H_PARAMETER;
@@ -458,6 +460,8 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	struct revmap_entry *rev;
 	u64 pte, orig_pte, pte_r;
 
+	if (kvm_is_radix(kvm))
+		return H_FUNCTION;
 	if (pte_index >= kvm->arch.hpt_npte)
 		return H_PARAMETER;
 	hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
@@ -529,6 +533,8 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 	struct revmap_entry *rev, *revs[4];
 	u64 hp0, hp1;
 
+	if (kvm_is_radix(kvm))
+		return H_FUNCTION;
 	global = global_invalidates(kvm, 0);
 	for (i = 0; i < 4 && ret == H_SUCCESS; ) {
 		n = 0;
@@ -642,6 +648,8 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long v, r, rb, mask, bits;
 	u64 pte_v, pte_r;
 
+	if (kvm_is_radix(kvm))
+		return H_FUNCTION;
 	if (pte_index >= kvm->arch.hpt_npte)
 		return H_PARAMETER;
 
@@ -711,6 +719,8 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 	int i, n = 1;
 	struct revmap_entry *rev = NULL;
 
+	if (kvm_is_radix(kvm))
+		return H_FUNCTION;
 	if (pte_index >= kvm->arch.hpt_npte)
 		return H_PARAMETER;
 	if (flags & H_READ_4) {
@@ -750,6 +760,8 @@ long kvmppc_h_clear_ref(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long *rmap;
 	long ret = H_NOT_FOUND;
 
+	if (kvm_is_radix(kvm))
+		return H_FUNCTION;
 	if (pte_index >= kvm->arch.hpt_npte)
 		return H_PARAMETER;
 
@@ -796,6 +808,8 @@ long kvmppc_h_clear_mod(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long *rmap;
 	long ret = H_NOT_FOUND;
 
+	if (kvm_is_radix(kvm))
+		return H_FUNCTION;
 	if (pte_index >= kvm->arch.hpt_npte)
 		return H_PARAMETER;
 
-- 
2.7.4
