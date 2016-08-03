Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s464974WczDqS6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:41:29 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 10/15] KVM: PPC: Use preregistered memory API to access
 TCE list
Date: Wed,  3 Aug 2016 18:40:51 +1000
Message-Id: <1470213656-1042-11-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VFIO on sPAPR already implements guest memory pre-registration
when the entire guest RAM gets pinned. This can be used to translate
the physical address of a guest page containing the TCE list
from H_PUT_TCE_INDIRECT.

This makes use of the pre-registrered memory API to access TCE list
pages in order to avoid unnecessary locking on the KVM memory
reverse map as we know that all of guest memory is pinned and
we have a flat array mapping GPA to HPA which makes it simpler and
quicker to index into that array (even with looking up the
kernel page tables in vmalloc_to_phys) than it is to find the memslot,
lock the rmap entry, look up the user page tables, and unlock the rmap
entry. Note that the rmap pointer is initialized to NULL where declared
(not in this patch).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* updated the commit log with Paul's comment
---
 arch/powerpc/kvm/book3s_64_vio_hv.c | 65 ++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index d461c44..a3be4bd 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -180,6 +180,17 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
 EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+static inline bool kvmppc_preregistered(struct kvm_vcpu *vcpu)
+{
+	return mm_iommu_preregistered(vcpu->kvm->mm);
+}
+
+static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
+		struct kvm_vcpu *vcpu, unsigned long ua, unsigned long size)
+{
+	return mm_iommu_lookup_rm(vcpu->kvm->mm, ua, size);
+}
+
 long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		unsigned long ioba, unsigned long tce)
 {
@@ -260,23 +271,44 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
-		return H_TOO_HARD;
+	if (kvmppc_preregistered(vcpu)) {
+		/*
+		 * We get here if guest memory was pre-registered which
+		 * is normally VFIO case and gpa->hpa translation does not
+		 * depend on hpt.
+		 */
+		struct mm_iommu_table_group_mem_t *mem;
 
-	rmap = (void *) vmalloc_to_phys(rmap);
+		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
+			return H_TOO_HARD;
 
-	/*
-	 * Synchronize with the MMU notifier callbacks in
-	 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
-	 * While we have the rmap lock, code running on other CPUs
-	 * cannot finish unmapping the host real page that backs
-	 * this guest real page, so we are OK to access the host
-	 * real page.
-	 */
-	lock_rmap(rmap);
-	if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
-		ret = H_TOO_HARD;
-		goto unlock_exit;
+		mem = kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
+		if (!mem || mm_iommu_ua_to_hpa_rm(mem, ua, &tces))
+			return H_TOO_HARD;
+	} else {
+		/*
+		 * This is emulated devices case.
+		 * We do not require memory to be preregistered in this case
+		 * so lock rmap and do __find_linux_pte_or_hugepte().
+		 */
+		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
+			return H_TOO_HARD;
+
+		rmap = (void *) vmalloc_to_phys(rmap);
+
+		/*
+		 * Synchronize with the MMU notifier callbacks in
+		 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
+		 * While we have the rmap lock, code running on other CPUs
+		 * cannot finish unmapping the host real page that backs
+		 * this guest real page, so we are OK to access the host
+		 * real page.
+		 */
+		lock_rmap(rmap);
+		if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
+			ret = H_TOO_HARD;
+			goto unlock_exit;
+		}
 	}
 
 	for (i = 0; i < npages; ++i) {
@@ -290,7 +322,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	}
 
 unlock_exit:
-	unlock_rmap(rmap);
+	if (rmap)
+		unlock_rmap(rmap);
 
 	return ret;
 }
-- 
2.5.0.rc3
