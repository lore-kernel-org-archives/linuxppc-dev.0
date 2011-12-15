Return-Path: <paulus@ozlabs.org>
Date: Thu, 15 Dec 2011 23:04:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH 5/5] KVM: PPC: Book3s HV: Implement H_CLEAR_REF and
 H_CLEAR_MOD hcalls
Message-ID: <20111215120417.GF20629@bloggs.ozlabs.ibm.com>
References: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds implementations for the H_CLEAR_REF (test and clear reference
bit) and H_CLEAR_MOD (test and clear changed bit) hypercalls.  These
hypercalls are not used by Linux guests at this stage, and these
implementations are only compile tested.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c     |   69 +++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    4 +-
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 76864a8..718b5a7 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -624,6 +624,75 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 	return H_SUCCESS;
 }
 
+long kvmppc_h_clear_ref(struct kvm_vcpu *vcpu, unsigned long flags,
+			unsigned long pte_index)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long *hpte, v, r, gr;
+	struct revmap_entry *rev;
+
+	if (pte_index >= HPT_NPTE)
+		return H_PARAMETER;
+
+	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
+	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
+		cpu_relax();
+	v = hpte[0];
+	r = hpte[1];
+	gr = rev->guest_rpte;
+	rev->guest_rpte &= ~HPTE_R_R;
+	if (v & HPTE_V_VALID) {
+		gr |= r & (HPTE_R_R | HPTE_R_C);
+		if (r & HPTE_R_R)
+			kvmppc_clear_ref_hpte(kvm, hpte, pte_index);
+	}
+	unlock_hpte(hpte, v & ~HPTE_V_HVLOCK);
+
+	if (!(v & (HPTE_V_VALID | HPTE_V_ABSENT)))
+		return H_NOT_FOUND;
+
+	vcpu->arch.gpr[4] = gr;
+	return H_SUCCESS;
+}
+
+long kvmppc_h_clear_mod(struct kvm_vcpu *vcpu, unsigned long flags,
+			unsigned long pte_index)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long *hpte, v, r, gr;
+	struct revmap_entry *rev;
+
+	if (pte_index >= HPT_NPTE)
+		return H_PARAMETER;
+
+	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
+	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
+		cpu_relax();
+	v = hpte[0];
+	r = hpte[1];
+	gr = rev->guest_rpte;
+	rev->guest_rpte &= ~HPTE_R_C;
+	if (v & HPTE_V_VALID) {
+		gr |= r & (HPTE_R_R | HPTE_R_C);
+		if (r & HPTE_R_C) {
+			hpte[0] |= HPTE_V_ABSENT;
+			kvmppc_invalidate_hpte(kvm, hpte, pte_index);
+			hpte[1] &= ~HPTE_R_C;
+			eieio();
+			hpte[0] = v;
+		}
+	}
+	unlock_hpte(hpte, v & ~HPTE_V_HVLOCK);
+
+	if (!(v & (HPTE_V_VALID | HPTE_V_ABSENT)))
+		return H_NOT_FOUND;
+
+	vcpu->arch.gpr[4] = gr;
+	return H_SUCCESS;
+}
+
 void kvmppc_invalidate_hpte(struct kvm *kvm, unsigned long *hptep,
 			unsigned long pte_index)
 {
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index b70bf22..4c52d6d 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1276,8 +1276,8 @@ hcall_real_table:
 	.long	.kvmppc_h_remove - hcall_real_table
 	.long	.kvmppc_h_enter - hcall_real_table
 	.long	.kvmppc_h_read - hcall_real_table
-	.long	0		/* 0x10 - H_CLEAR_MOD */
-	.long	0		/* 0x14 - H_CLEAR_REF */
+	.long	.kvmppc_h_clear_mod - hcall_real_table
+	.long	.kvmppc_h_clear_ref - hcall_real_table
 	.long	.kvmppc_h_protect - hcall_real_table
 	.long	0		/* 0x1c - H_GET_TCE */
 	.long	.kvmppc_h_put_tce - hcall_real_table
-- 
1.7.7.3
