Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vdJDc2sQqzDqY0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 14:00:32 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v7 08/10] KVM: PPC: Use preregistered memory API to
 access TCE list
Date: Wed,  8 Mar 2017 14:00:09 +1100
Message-Id: <20170308030011.26780-9-aik@ozlabs.ru>
In-Reply-To: <20170308030011.26780-1-aik@ozlabs.ru>
References: <20170308030011.26780-1-aik@ozlabs.ru>
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
entry. Note that the rmap pointer is initialized to NULL
where declared (not in this patch).

If a requested chunk of memory has not been preregistered, this will
fall back to non-preregistered case and lock rmap.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v4:
* removed oneline inlines
* now falls back to locking rmap if TCE list is not in preregistered memory

v2:
* updated the commit log with David's comment
---
 arch/powerpc/kvm/book3s_64_vio_hv.c | 58 +++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 918af76ab2b6..0f145fc7a3a5 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -239,6 +239,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	long i, ret = H_SUCCESS;
 	unsigned long tces, entry, ua = 0;
 	unsigned long *rmap = NULL;
+	bool prereg = false;
 
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
@@ -259,23 +260,47 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
-		return H_TOO_HARD;
+	if (mm_iommu_preregistered(vcpu->kvm->mm)) {
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
+		mem = mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K);
+		if (mem)
+			prereg = mm_iommu_ua_to_hpa_rm(mem, ua, &tces) == 0;
+	}
+
+	if (!prereg) {
+		/*
+		 * This is usually a case of a guest with emulated devices only
+		 * when TCE list is not in preregistered memory.
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
@@ -289,7 +314,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	}
 
 unlock_exit:
-	unlock_rmap(rmap);
+	if (rmap)
+		unlock_rmap(rmap);
 
 	return ret;
 }
-- 
2.11.0
