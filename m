Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95A1A1A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:50 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 7 Mar 2016 13:42:49 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 65DB12BB0062
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:45 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u273gbjP63176718
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:45 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u273gDqG024945
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:13 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 3/9] KVM: PPC: Use preregistered memory API to access
 TCE list
Date: Mon,  7 Mar 2016 14:41:11 +1100
Message-Id: <1457322077-26640-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
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
reverse map.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio_hv.c | 86 ++++++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 44be73e..af155f6 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -180,6 +180,38 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
 EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+static mm_context_t *kvmppc_mm_context(struct kvm_vcpu *vcpu)
+{
+	struct task_struct *task;
+
+	task = vcpu->arch.run_task;
+	if (unlikely(!task || !task->mm))
+		return NULL;
+
+	return &task->mm->context;
+}
+
+static inline bool kvmppc_preregistered(struct kvm_vcpu *vcpu)
+{
+	mm_context_t *mm = kvmppc_mm_context(vcpu);
+
+	if (unlikely(!mm))
+		return false;
+
+	return mm_iommu_preregistered(mm);
+}
+
+static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
+		struct kvm_vcpu *vcpu, unsigned long ua, unsigned long size)
+{
+	mm_context_t *mm = kvmppc_mm_context(vcpu);
+
+	if (unlikely(!mm))
+		return NULL;
+
+	return mm_iommu_lookup_rm(mm, ua, size);
+}
+
 long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba, unsigned long tce)
 {
@@ -261,23 +293,44 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
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
+		if (!mem || mm_iommu_rm_ua_to_hpa(mem, ua, &tces))
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
@@ -291,7 +344,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	}
 
 unlock_exit:
-	unlock_rmap(rmap);
+	if (rmap)
+		unlock_rmap(rmap);
 
 	return ret;
 }
-- 
2.5.0.rc3
