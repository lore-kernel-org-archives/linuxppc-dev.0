Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 425bSk6rkbzF3G4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 19:51:50 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel] KVM: PPC: Remove redundand permission bits removal
Date: Thu,  6 Sep 2018 19:51:46 +1000
Message-Id: <20180906095146.43981-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kvmppc_gpa_to_ua() helper itself takes care of the permission
bits in the TCE and yet every single caller removes them.

This changes semantics of kvmppc_gpa_to_ua() so it takes TCEs
(which are GPAs + TCE permission bits) to make the callers simpler.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is not related to any bug, just noticed this while doing other things.

I can also rename kvmppc_gpa_to_ua() if it makes more sense, does not it?

---
 arch/powerpc/kvm/book3s_64_vio.c    | 10 +++-------
 arch/powerpc/kvm/book3s_64_vio_hv.c | 16 ++++++----------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 174299d..7207481 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -378,8 +378,7 @@ static long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt,
 	if (iommu_tce_check_gpa(stt->page_shift, gpa))
 		return H_TOO_HARD;
 
-	if (kvmppc_gpa_to_ua(stt->kvm, tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
-				&ua, NULL))
+	if (kvmppc_gpa_to_ua(stt->kvm, tce, &ua, NULL))
 		return H_TOO_HARD;
 
 	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
@@ -553,8 +552,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 
-	if ((dir != DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
-			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL)) {
+	if ((dir != DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm, tce, &ua, NULL)) {
 		ret = H_PARAMETER;
 		goto unlock_exit;
 	}
@@ -647,9 +645,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		}
 		tce = be64_to_cpu(tce);
 
-		if (kvmppc_gpa_to_ua(vcpu->kvm,
-				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
-				&ua, NULL))
+		if (kvmppc_gpa_to_ua(vcpu->kvm, tce, &ua, NULL))
 			return H_PARAMETER;
 
 		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 5f810dc..a03cd93 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -110,8 +110,7 @@ static long kvmppc_rm_tce_validate(struct kvmppc_spapr_tce_table *stt,
 	if (iommu_tce_check_gpa(stt->page_shift, gpa))
 		return H_PARAMETER;
 
-	if (kvmppc_gpa_to_ua(stt->kvm, tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
-				&ua, NULL))
+	if (kvmppc_gpa_to_ua(stt->kvm, tce, &ua, NULL))
 		return H_TOO_HARD;
 
 	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
@@ -180,10 +179,10 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
 }
 EXPORT_SYMBOL_GPL(kvmppc_tce_put);
 
-long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
+long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long tce,
 		unsigned long *ua, unsigned long **prmap)
 {
-	unsigned long gfn = gpa >> PAGE_SHIFT;
+	unsigned long gfn = tce >> PAGE_SHIFT;
 	struct kvm_memory_slot *memslot;
 
 	memslot = search_memslots(kvm_memslots(kvm), gfn);
@@ -191,7 +190,7 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
 		return -EINVAL;
 
 	*ua = __gfn_to_hva_memslot(memslot, gfn) |
-		(gpa & ~(PAGE_MASK | TCE_PCI_READ | TCE_PCI_WRITE));
+		(tce & ~(PAGE_MASK | TCE_PCI_READ | TCE_PCI_WRITE));
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	if (prmap)
@@ -366,8 +365,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		return ret;
 
 	dir = iommu_tce_direction(tce);
-	if ((dir != DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
-			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL))
+	if ((dir != DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm, tce, &ua, NULL))
 		return H_PARAMETER;
 
 	entry = ioba >> stt->page_shift;
@@ -520,9 +518,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		unsigned long tce = be64_to_cpu(((u64 *)tces)[i]);
 
 		ua = 0;
-		if (kvmppc_gpa_to_ua(vcpu->kvm,
-				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
-				&ua, NULL))
+		if (kvmppc_gpa_to_ua(vcpu->kvm, tce, &ua, NULL))
 			return H_PARAMETER;
 
 		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
-- 
2.11.0
