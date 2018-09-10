Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 4281SY359nzF3F7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 18:30:05 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel v2 6/6] KVM: PPC: Remove redundand permission bits
 removal
Date: Mon, 10 Sep 2018 18:29:12 +1000
Message-Id: <20180910082912.13255-7-aik@ozlabs.ru>
In-Reply-To: <20180910082912.13255-1-aik@ozlabs.ru>
References: <20180910082912.13255-1-aik@ozlabs.ru>
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
Changes:
v2:
* %s/kvmppc_gpa_to_ua/kvmppc_tce_to_ua/g
---
 arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
 arch/powerpc/kvm/book3s_64_vio.c    | 12 ++++--------
 arch/powerpc/kvm/book3s_64_vio_hv.c | 22 +++++++++-------------
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 2f5d431..38d0328 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -194,7 +194,7 @@ extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
 		(iommu_tce_check_ioba((stt)->page_shift, (stt)->offset, \
 				(stt)->size, (ioba), (npages)) ?        \
 				H_PARAMETER : H_SUCCESS)
-extern long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
+extern long kvmppc_tce_to_ua(struct kvm *kvm, unsigned long tce,
 		unsigned long *ua, unsigned long **prmap);
 extern void kvmppc_tce_put(struct kvmppc_spapr_tce_table *tt,
 		unsigned long idx, unsigned long tce);
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 8231b17..c0c64d1 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -378,8 +378,7 @@ static long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt,
 	if (iommu_tce_check_gpa(stt->page_shift, gpa))
 		return H_TOO_HARD;
 
-	if (kvmppc_gpa_to_ua(stt->kvm, tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
-				&ua, NULL))
+	if (kvmppc_tce_to_ua(stt->kvm, tce, &ua, NULL))
 		return H_TOO_HARD;
 
 	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
@@ -552,8 +551,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 
-	if ((dir != DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
-			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL)) {
+	if ((dir != DMA_NONE) && kvmppc_tce_to_ua(vcpu->kvm, tce, &ua, NULL)) {
 		ret = H_PARAMETER;
 		goto unlock_exit;
 	}
@@ -614,7 +612,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		return ret;
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
-	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL)) {
+	if (kvmppc_tce_to_ua(vcpu->kvm, tce_list, &ua, NULL)) {
 		ret = H_TOO_HARD;
 		goto unlock_exit;
 	}
@@ -649,9 +647,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		}
 		tce = be64_to_cpu(tce);
 
-		if (kvmppc_gpa_to_ua(vcpu->kvm,
-				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
-				&ua, NULL))
+		if (kvmppc_tce_to_ua(vcpu->kvm, tce, &ua, NULL))
 			return H_PARAMETER;
 
 		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index adf3b21..389dac1 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -110,8 +110,7 @@ static long kvmppc_rm_tce_validate(struct kvmppc_spapr_tce_table *stt,
 	if (iommu_tce_check_gpa(stt->page_shift, gpa))
 		return H_PARAMETER;
 
-	if (kvmppc_gpa_to_ua(stt->kvm, tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
-				&ua, NULL))
+	if (kvmppc_tce_to_ua(stt->kvm, tce, &ua, NULL))
 		return H_TOO_HARD;
 
 	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
@@ -180,10 +179,10 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
 }
 EXPORT_SYMBOL_GPL(kvmppc_tce_put);
 
-long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
+long kvmppc_tce_to_ua(struct kvm *kvm, unsigned long tce,
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
@@ -200,7 +199,7 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
+EXPORT_SYMBOL_GPL(kvmppc_tce_to_ua);
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 static long iommu_tce_xchg_rm(struct mm_struct *mm, struct iommu_table *tbl,
@@ -389,8 +388,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		return ret;
 
 	dir = iommu_tce_direction(tce);
-	if ((dir != DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
-			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL))
+	if ((dir != DMA_NONE) && kvmppc_tce_to_ua(vcpu->kvm, tce, &ua, NULL))
 		return H_PARAMETER;
 
 	entry = ioba >> stt->page_shift;
@@ -492,7 +490,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		 */
 		struct mm_iommu_table_group_mem_t *mem;
 
-		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
+		if (kvmppc_tce_to_ua(vcpu->kvm, tce_list, &ua, NULL))
 			return H_TOO_HARD;
 
 		mem = mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K);
@@ -508,7 +506,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		 * We do not require memory to be preregistered in this case
 		 * so lock rmap and do __find_linux_pte_or_hugepte().
 		 */
-		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
+		if (kvmppc_tce_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
 			return H_TOO_HARD;
 
 		rmap = (void *) vmalloc_to_phys(rmap);
@@ -542,9 +540,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		unsigned long tce = be64_to_cpu(((u64 *)tces)[i]);
 
 		ua = 0;
-		if (kvmppc_gpa_to_ua(vcpu->kvm,
-				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
-				&ua, NULL))
+		if (kvmppc_tce_to_ua(vcpu->kvm, tce, &ua, NULL))
 			return H_PARAMETER;
 
 		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
-- 
2.11.0
