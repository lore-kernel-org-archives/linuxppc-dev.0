Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B45D1A020A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:25 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:25 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6FDC22CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:22 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F98ZLQ65667122
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:08:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PLVH025664
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:22 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 7/7] KVM: PPC: Add support for multiple-TCE hcalls
Date: Tue, 15 Jul 2014 19:25:11 +1000
Message-Id: <1405416311-12429-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416311-12429-1-git-send-email-aik@ozlabs.ru>
References: <1405416311-12429-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds real and virtual mode handlers for the H_PUT_TCE_INDIRECT and
H_STUFF_TCE hypercalls for user space emulated devices such as IBMVIO
devices or emulated PCI.  These calls allow adding multiple entries
(up to 512) into the TCE table in one call which saves time on
transition between kernel and user space.

This adds a tce_tmp_hpas cache to kvm_vcpu_arch to save valid TCEs
(copied from user and verified) before writing the whole list into
the TCE table. This cache will be utilized more in the upcoming
VFIO/IOMMU support to continue TCE list processing in the virtual
mode in the case if the real mode handler failed for some reason.

This adds kvmppc_spapr_tce_init() and kvmppc_spapr_tce_free() helpers
to allocate and free the tce_tmp_hpas cache.

This adds a function to convert a guest physical address to a host
virtual address in order to parse a TCE list from H_PUT_TCE_INDIRECT.

This caches tce_rm_list_pg TCE list page pointer for situation when
the real mode handler managed to reference the list page and
then PTE changed and real mode handler could not dereference the page.
The cached page pointer is dereferenced in virtual mode.

This implements the KVM_CAP_PPC_MULTITCE capability. When present,
the kernel will try handling H_PUT_TCE_INDIRECT and H_STUFF_TCE.
If they can not be handled by the kernel, they are passed on to
the user space. The user space still has to have an implementation
for these.

Both HV and PR-syle KVM are supported.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

---
Changelog:
v12:
* used RCU for kvm->arch.spapr_tce_tables

v11:
* added kvm_vcpu_arch::tce_rm_list_pg to cache page struct pointer
referenced-and-not-dereferenced in real mode
* kvmppc_spapr_tce_init/kvmppc_spapr_tce_free called from PR code now too
* removed get_page/put_page from virtual mode handler'
* srcu_read_lock(&vcpu->kvm->srcu) now protects entire kvmppc_h_put_tce_indirect
(virtual mode handler for H_PUT_TCE_INDIRECT)

v10:
* kvmppc_find_tce_table() changed to take kvm* instead of vcpu*

v8:
* fixed warnings from check_patch.pl

2013/08/01 (v7):
* realmode_get_page/realmode_put_page use was replaced with
get_page_unless_zero/put_page_unless_one

2013/07/11:
* addressed many, many comments from maintainers

2013/07/06:
* fixed number of wrong get_page()/put_page() calls

2013/06/27:
* fixed clear of BUSY bit in kvmppc_lookup_pte()
* H_PUT_TCE_INDIRECT does realmode_get_page() now
* KVM_CAP_SPAPR_MULTITCE now depends on CONFIG_PPC_BOOK3S_64
* updated doc

2013/06/05:
* fixed mistype about IBMVIO in the commit message
* updated doc and moved it to another section
* changed capability number

2013/05/21:
* added kvm_vcpu_arch::tce_tmp
* removed cleanup if put_indirect failed, instead we do not even start
writing to TCE table if we cannot get TCEs from the user and they are
invalid
* kvmppc_emulated_h_put_tce is split to kvmppc_emulated_put_tce
and kvmppc_emulated_validate_tce (for the previous item)
* fixed bug with failthrough for H_IPI
* removed all get_user() from real mode handlers
* kvmppc_lookup_pte() added (instead of making lookup_linux_pte public)
---
 Documentation/virtual/kvm/api.txt       |  26 +++++
 arch/powerpc/include/asm/kvm_host.h     |  30 ++++++
 arch/powerpc/include/asm/kvm_ppc.h      |  12 +++
 arch/powerpc/kvm/book3s_64_vio.c        | 174 +++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c     | 168 +++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv.c            |  30 +++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   4 +-
 arch/powerpc/kvm/book3s_pr.c            |   4 +
 arch/powerpc/kvm/book3s_pr_papr.c       |  35 +++++++
 arch/powerpc/kvm/powerpc.c              |   3 +
 10 files changed, 478 insertions(+), 8 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 0fe3649..e1c72bf 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2494,6 +2494,32 @@ calls by the guest for that service will be passed to userspace to be
 handled.
 
 
+4.87 KVM_CAP_PPC_MULTITCE
+
+Capability: KVM_CAP_PPC_MULTITCE
+Architectures: ppc
+Type: vm
+
+This capability means the kernel is capable of handling hypercalls
+H_PUT_TCE_INDIRECT and H_STUFF_TCE without passing those into the user
+space. This significantly accelerates DMA operations for PPC KVM guests.
+User space should expect that its handlers for these hypercalls
+are not going to be called if user space previously registered LIOBN
+in KVM (via KVM_CREATE_SPAPR_TCE or similar calls).
+
+In order to enable H_PUT_TCE_INDIRECT and H_STUFF_TCE use in the guest,
+user space might have to advertise it for the guest. For example,
+IBM pSeries (sPAPR) guest starts using them if "hcall-multi-tce" is
+present in the "ibm,hypertas-functions" device-tree property.
+
+The hypercalls mentioned above may or may not be processed successfully
+in the kernel based fast path. If they can not be handled by the kernel,
+they will get passed on to user space. So user space still has to have
+an implementation for these despite the in kernel acceleration.
+
+This capability is always enabled.
+
+
 5. The kvm_run structure
 ------------------------
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index bb66d8b..c37fee2 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -30,6 +30,7 @@
 #include <linux/kvm_para.h>
 #include <linux/list.h>
 #include <linux/atomic.h>
+#include <linux/tracepoint.h>
 #include <asm/kvm_asm.h>
 #include <asm/processor.h>
 #include <asm/page.h>
@@ -662,6 +663,35 @@ struct kvm_vcpu_arch {
 	spinlock_t tbacct_lock;
 	u64 busy_stolen;
 	u64 busy_preempt;
+
+	enum {
+		/* Continue handling request from tce_tmp_num in virtmode */
+		TCERM_NONE,
+		/*
+		 * get_page() got a wrong page, undo this in virtmode
+		 * and try again
+		 */
+		TCERM_GETPAGE,
+		/*
+		 * get_page(tce_list) got a wrong page, undo this
+		 * in virtmode and try again
+		 */
+		TCERM_GETLISTPAGE,
+		/* tce_build() failed, retry in virtmode (for INDIRECT only) */
+		TCERM_PUTTCE,
+		/* put_page(tce_list) failed, do put_page in virtmode */
+		TCERM_PUTLISTPAGE,
+		/*
+		 * Realmode does not specifically signal for failed
+		 * put_page(tce) as it clears TCEs which it managed to put
+		 * so virtmode can just put remaining non-zero TCEs
+		 */
+	} tce_rm_fail;			/* failed stage of request processing */
+	struct page *tce_rm_list_pg;	/* unreferenced page from realmode */
+#endif
+#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE) || \
+	defined(CONFIG_KVM_BOOK3S_PR_POSSIBLE)
+	unsigned long *tce_tmp_hpas;	/* TCE cache for TCE_PUT_INDIRECT */
 #endif
 };
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 26e6e1a..b84ed80 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -125,16 +125,28 @@ extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
 			struct kvm_memory_slot *memslot, unsigned long porder);
 extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 
+extern int kvmppc_spapr_tce_init(struct kvm_vcpu *vcpu);
+extern void kvmppc_spapr_tce_free(struct kvm_vcpu *vcpu);
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce *args);
+extern struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(
+		struct kvm *kvm, unsigned long liobn);
 extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 		unsigned long ioba, unsigned long npages);
 extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
 		unsigned long tce);
+extern void kvmppc_tce_put(struct kvmppc_spapr_tce_table *tt,
+		unsigned long idx, unsigned long tce);
 extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			     unsigned long ioba, unsigned long tce);
 extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			     unsigned long ioba);
+extern long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_list, unsigned long npages);
+extern long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages);
 extern struct kvm_rma_info *kvm_alloc_rma(void);
 extern void kvm_release_rma(struct kvm_rma_info *ri);
 extern struct page *kvm_alloc_hpt(unsigned long nr_pages);
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index e9bcb13..2137836 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -14,6 +14,7 @@
  *
  * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
  * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
+ * Copyright 2013 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
  */
 
 #include <linux/types.h>
@@ -37,8 +38,34 @@
 #include <asm/kvm_host.h>
 #include <asm/udbg.h>
 #include <asm/iommu.h>
+#include <asm/tce.h>
 
-#define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
+#define ERROR_ADDR      ((void *)~(unsigned long)0x0)
+
+int kvmppc_spapr_tce_init(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * As we want to minimize the chance of having H_PUT_TCE_INDIRECT
+	 * half executed, we first read TCEs from the user, check them and
+	 * return error if something went wrong and only then put TCEs into
+	 * the TCE table.
+	 *
+	 * tce_tmp_hpas is a cache for TCEs to avoid stack allocation or
+	 * kmalloc as the whole TCE list can take up to 512 items 8 bytes
+	 * each (4096 bytes).
+	 */
+	vcpu->arch.tce_tmp_hpas = kmalloc(4096, GFP_KERNEL);
+
+	return vcpu->arch.tce_tmp_hpas ? 0 : -1;
+}
+EXPORT_SYMBOL_GPL(kvmppc_spapr_tce_init);
+
+void kvmppc_spapr_tce_free(struct kvm_vcpu *vcpu)
+{
+	kfree(vcpu->arch.tce_tmp_hpas);
+	vcpu->arch.tce_tmp_hpas = NULL;
+}
+EXPORT_SYMBOL_GPL(kvmppc_spapr_tce_free);
 
 static long kvmppc_stt_npages(unsigned long window_size)
 {
@@ -149,3 +176,148 @@ fail:
 	}
 	return ret;
 }
+
+/*
+ * Converts guest physical address to host virtual address
+ *
+ * If pg!=NULL, tries to increase page counter via get_user_pages_fast()
+ * and returns ERROR_ADDR if failed.
+ */
+static void __user *kvmppc_gpa_to_hva_and_get(struct kvm_vcpu *vcpu,
+		unsigned long gpa, struct page **pg)
+{
+	unsigned long hva, gfn = gpa >> PAGE_SHIFT;
+	struct kvm_memory_slot *memslot;
+	const int is_write = !!(gpa & TCE_PCI_WRITE);
+
+	memslot = search_memslots(kvm_memslots(vcpu->kvm), gfn);
+	if (!memslot)
+		return ERROR_ADDR;
+
+	hva = __gfn_to_hva_memslot(memslot, gfn) | (gpa & ~PAGE_MASK);
+
+	if (pg && (get_user_pages_fast(hva & PAGE_MASK, 1, is_write, pg) != 1))
+		return ERROR_ADDR;
+
+	return (void *) hva;
+}
+
+long kvmppc_h_put_tce(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce)
+{
+	long ret;
+	struct kvmppc_spapr_tce_table *stt;
+
+	stt = kvmppc_find_tce_table(vcpu->kvm, liobn);
+	if (!stt)
+		return H_TOO_HARD;
+
+	ret = kvmppc_ioba_validate(stt, ioba, 1);
+	if (ret)
+		return ret;
+
+	ret = kvmppc_tce_validate(stt, tce);
+	if (ret)
+		return ret;
+
+	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
+
+	return H_SUCCESS;
+}
+EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
+
+long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_list, unsigned long npages)
+{
+	struct kvmppc_spapr_tce_table *stt;
+	long i, ret = H_SUCCESS, idx;
+	unsigned long __user *tces;
+
+	stt = kvmppc_find_tce_table(vcpu->kvm, liobn);
+	if (!stt)
+		return H_TOO_HARD;
+
+	/*
+	 * The spec says that the maximum size of the list is 512 TCEs
+	 * so the whole table addressed resides in 4K page
+	 */
+	if (npages > 512)
+		return H_PARAMETER;
+
+	if (tce_list & ~IOMMU_PAGE_MASK_4K)
+		return H_PARAMETER;
+
+	ret = kvmppc_ioba_validate(stt, ioba, npages);
+	if (ret)
+		return ret;
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	tces = kvmppc_gpa_to_hva_and_get(vcpu, tce_list, NULL);
+	if (tces == ERROR_ADDR) {
+		ret = H_TOO_HARD;
+		goto unlock_exit;
+	}
+
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	/*
+	 * If real mode handler managed to reference the list page and
+	 * then PTE changed and real mode handler could not dereference
+	 * the page, do it now.
+	 */
+	if ((vcpu->arch.tce_rm_fail != TCERM_GETLISTPAGE) &&
+			vcpu->arch.tce_rm_list_pg)
+		put_page(vcpu->arch.tce_rm_list_pg);
+
+	if (vcpu->arch.tce_rm_fail == TCERM_PUTLISTPAGE)
+		goto unlock_exit;
+#endif
+
+	for (i = 0; i < npages; ++i) {
+		if (get_user(vcpu->arch.tce_tmp_hpas[i], tces + i)) {
+			ret = H_PARAMETER;
+			goto unlock_exit;
+		}
+
+		ret = kvmppc_tce_validate(stt, vcpu->arch.tce_tmp_hpas[i]);
+		if (ret)
+			goto unlock_exit;
+	}
+
+	for (i = 0; i < npages; ++i)
+		kvmppc_tce_put(stt, (ioba >> IOMMU_PAGE_SHIFT_4K) + i,
+				vcpu->arch.tce_tmp_hpas[i]);
+
+unlock_exit:
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kvmppc_h_put_tce_indirect);
+
+long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages)
+{
+	struct kvmppc_spapr_tce_table *stt;
+	long i, ret;
+
+	stt = kvmppc_find_tce_table(vcpu->kvm, liobn);
+	if (!stt)
+		return H_TOO_HARD;
+
+	ret = kvmppc_ioba_validate(stt, ioba, npages);
+	if (ret)
+		return ret;
+
+	ret = kvmppc_tce_validate(stt, tce_value);
+	if (ret || (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ)))
+		return H_PARAMETER;
+
+	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE_4K)
+		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
+
+	return H_SUCCESS;
+}
+EXPORT_SYMBOL_GPL(kvmppc_h_stuff_tce);
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 79406f1..79a39bb 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -14,6 +14,7 @@
  *
  * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
  * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
+ * Copyright 2013 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
  */
 
 #include <linux/types.h>
@@ -37,9 +38,16 @@
 #include <asm/udbg.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
+#include <asm/iommu.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
+#define ERROR_ADDR      (~(unsigned long)0x0)
 
+/* Finds a TCE table descriptor by LIOBN.
+ *
+ * WARNING: This will be called in real or virtual mode on HV KVM and virtual
+ *          mode on PR KVM
+ */
 struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(struct kvm *kvm,
 		unsigned long liobn)
 {
@@ -146,11 +154,75 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
 }
 EXPORT_SYMBOL_GPL(kvmppc_tce_put);
 
-/* WARNING: This will be called in real-mode on HV KVM and virtual
- *          mode on PR KVM
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+/*
+ * Converts guest physical address to host physical address.
+ *
+ * Tries to increase page counter via get_page_unless_zero() and
+ * returns ERROR_ADDR if failed.
+ *
+ * Returns ERROR_ADDR if the page has gone before we increased
+ * page use counter. *pg may not be NULL if put_page_unless_one()
+ * failed to put the page.
  */
-long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
-		      unsigned long ioba, unsigned long tce)
+static unsigned long kvmppc_rm_gpa_to_hpa_and_get(struct kvm_vcpu *vcpu,
+		unsigned long gpa, struct page **pg)
+{
+	struct kvm_memory_slot *memslot;
+	pte_t *ptep, pte;
+	unsigned long hva, hpa = ERROR_ADDR;
+	unsigned long gfn = gpa >> PAGE_SHIFT;
+	unsigned shift = 0;
+
+	memslot = search_memslots(kvm_memslots(vcpu->kvm), gfn);
+	if (!memslot)
+		return ERROR_ADDR;
+
+	hva = __gfn_to_hva_memslot(memslot, gfn);
+
+	ptep = find_linux_pte_or_hugepte(vcpu->arch.pgdir, hva, &shift);
+	if (!ptep || !pte_present(*ptep))
+		return ERROR_ADDR;
+	pte = *ptep;
+
+	if (!shift)
+		shift = PAGE_SHIFT;
+
+	/* Avoid handling anything potentially complicated in realmode */
+	if (shift > PAGE_SHIFT)
+		return ERROR_ADDR;
+
+	if ((gpa & TCE_PCI_WRITE) && !(pte_write(pte) && pte_dirty(pte)))
+		return ERROR_ADDR;
+
+	if (!pte_young(pte))
+		return ERROR_ADDR;
+
+	/* Increase page counter */
+	*pg = realmode_pfn_to_page(pte_pfn(pte));
+	if (!*pg || PageCompound(*pg) || !get_page_unless_zero(*pg)) {
+		*pg = NULL;
+		return ERROR_ADDR;
+	}
+
+	hpa = (pte_pfn(pte) << PAGE_SHIFT) + (gpa & ((1 << shift) - 1));
+
+	/*
+	 * Page has gone since we got pte, safer to put
+	 * the request to virt mode
+	 */
+	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
+		hpa = ERROR_ADDR;
+		/* Try drop the page, if failed, let virtmode do that */
+		if (put_page_unless_one(*pg))
+			*pg = NULL;
+	}
+
+	return hpa;
+}
+
+long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
+		unsigned long ioba, unsigned long tce)
 {
 	struct kvmppc_spapr_tce_table *stt;
 	long ret;
@@ -163,6 +235,8 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (!stt)
 		return H_TOO_HARD;
 
+	vcpu->arch.tce_rm_fail = TCERM_NONE;
+
 	ret = kvmppc_ioba_validate(stt, ioba, 1);
 	if (ret)
 		return ret;
@@ -176,7 +250,89 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 	return H_SUCCESS;
 }
-EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
+
+long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_list,	unsigned long npages)
+{
+	struct kvmppc_spapr_tce_table *stt;
+	long i, ret = H_SUCCESS;
+	unsigned long tces;
+	struct page *pg = NULL;
+
+	stt = kvmppc_find_tce_table(vcpu->kvm, liobn);
+	if (!stt)
+		return H_TOO_HARD;
+
+	/*
+	 * The spec says that the maximum size of the list is 512 TCEs
+	 * so the whole table addressed resides in 4K page
+	 */
+	if (npages > 512)
+		return H_PARAMETER;
+
+	if (tce_list & ~IOMMU_PAGE_MASK_4K)
+		return H_PARAMETER;
+
+	ret = kvmppc_ioba_validate(stt, ioba, npages);
+	if (ret)
+		return ret;
+
+	vcpu->arch.tce_rm_fail = TCERM_NONE;
+	vcpu->arch.tce_rm_list_pg = NULL;
+	tces = kvmppc_rm_gpa_to_hpa_and_get(vcpu, tce_list, &pg);
+	if (tces == ERROR_ADDR) {
+		vcpu->arch.tce_rm_fail = pg ? TCERM_NONE : TCERM_GETLISTPAGE;
+		vcpu->arch.tce_rm_list_pg = pg;
+		return H_TOO_HARD;
+	}
+
+	for (i = 0; i < npages; ++i) {
+		unsigned long tce = ((unsigned long *)tces)[i];
+
+		ret = kvmppc_tce_validate(stt, tce);
+		if (ret)
+			goto put_page_exit;
+		vcpu->arch.tce_tmp_hpas[i] = tce;
+	}
+
+	for (i = 0; i < npages; ++i)
+		kvmppc_tce_put(stt, (ioba >> IOMMU_PAGE_SHIFT_4K) + i,
+				vcpu->arch.tce_tmp_hpas[i]);
+
+put_page_exit:
+	if (pg && !put_page_unless_one(pg)) {
+		vcpu->arch.tce_rm_fail = TCERM_PUTLISTPAGE;
+		ret = H_TOO_HARD;
+	}
+
+	return ret;
+}
+
+long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages)
+{
+	struct kvmppc_spapr_tce_table *stt;
+	long i, ret;
+
+	stt = kvmppc_find_tce_table(vcpu->kvm, liobn);
+	if (!stt)
+		return H_TOO_HARD;
+
+	ret = kvmppc_ioba_validate(stt, ioba, npages);
+	if (ret)
+		return ret;
+
+	ret = kvmppc_tce_validate(stt, tce_value);
+	if (ret || (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ)))
+		return H_PARAMETER;
+
+	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE_4K)
+		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
+
+	return H_SUCCESS;
+}
 
 long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba)
@@ -204,3 +360,5 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	return H_SUCCESS;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_get_tce);
+
+#endif /* KVM_BOOK3S_HV_POSSIBLE */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7a12edb..7f6d18a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -630,7 +630,31 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		if (kvmppc_xics_enabled(vcpu)) {
 			ret = kvmppc_xics_hcall(vcpu, req);
 			break;
-		} /* fallthrough */
+		}
+		return RESUME_HOST;
+	case H_PUT_TCE:
+		ret = kvmppc_h_put_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
+						kvmppc_get_gpr(vcpu, 5),
+						kvmppc_get_gpr(vcpu, 6));
+		if (ret == H_TOO_HARD)
+			return RESUME_HOST;
+		break;
+	case H_PUT_TCE_INDIRECT:
+		ret = kvmppc_h_put_tce_indirect(vcpu, kvmppc_get_gpr(vcpu, 4),
+						kvmppc_get_gpr(vcpu, 5),
+						kvmppc_get_gpr(vcpu, 6),
+						kvmppc_get_gpr(vcpu, 7));
+		if (ret == H_TOO_HARD)
+			return RESUME_HOST;
+		break;
+	case H_STUFF_TCE:
+		ret = kvmppc_h_stuff_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
+						kvmppc_get_gpr(vcpu, 5),
+						kvmppc_get_gpr(vcpu, 6),
+						kvmppc_get_gpr(vcpu, 7));
+		if (ret == H_TOO_HARD)
+			return RESUME_HOST;
+		break;
 	default:
 		return RESUME_HOST;
 	}
@@ -1306,6 +1330,9 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 	vcpu->arch.cpu_type = KVM_CPU_3S_64;
 	kvmppc_sanity_check(vcpu);
 
+	if (kvmppc_spapr_tce_init(vcpu))
+		goto free_vcpu;
+
 	return vcpu;
 
 free_vcpu:
@@ -1328,6 +1355,7 @@ static void kvmppc_core_vcpu_free_hv(struct kvm_vcpu *vcpu)
 	unpin_vpa(vcpu->kvm, &vcpu->arch.slb_shadow);
 	unpin_vpa(vcpu->kvm, &vcpu->arch.vpa);
 	spin_unlock(&vcpu->arch.vpa_update_lock);
+	kvmppc_spapr_tce_free(vcpu);
 	kvm_vcpu_uninit(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 868347e..3623d95 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1953,7 +1953,7 @@ hcall_real_table:
 	.long	0		/* 0x14 - H_CLEAR_REF */
 	.long	DOTSYM(kvmppc_h_protect) - hcall_real_table
 	.long	DOTSYM(kvmppc_h_get_tce) - hcall_real_table
-	.long	DOTSYM(kvmppc_h_put_tce) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_put_tce) - hcall_real_table
 	.long	0		/* 0x24 - H_SET_SPRG0 */
 	.long	DOTSYM(kvmppc_h_set_dabr) - hcall_real_table
 	.long	0		/* 0x2c */
@@ -2031,6 +2031,8 @@ hcall_real_table:
 	.long	0		/* 0x12c */
 	.long	0		/* 0x130 */
 	.long	DOTSYM(kvmppc_h_set_xdabr) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_stuff_tce) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_put_tce_indirect) - hcall_real_table
 hcall_real_table_end:
 
 ignore_hdec:
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 8eef1e5..0897823 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1342,6 +1342,9 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_pr(struct kvm *kvm,
 	if (err < 0)
 		goto uninit_vcpu;
 
+	if (kvmppc_spapr_tce_init(vcpu))
+		goto uninit_vcpu;
+
 	return vcpu;
 
 uninit_vcpu:
@@ -1363,6 +1366,7 @@ static void kvmppc_core_vcpu_free_pr(struct kvm_vcpu *vcpu)
 	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
 
 	free_page((unsigned long)vcpu->arch.shared & PAGE_MASK);
+	kvmppc_spapr_tce_free(vcpu);
 	kvm_vcpu_uninit(vcpu);
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
 	kfree(vcpu->arch.shadow_vcpu);
diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_pr_papr.c
index 52a63bf..f82ca62 100644
--- a/arch/powerpc/kvm/book3s_pr_papr.c
+++ b/arch/powerpc/kvm/book3s_pr_papr.c
@@ -257,6 +257,37 @@ static int kvmppc_h_pr_put_tce(struct kvm_vcpu *vcpu)
 	return EMULATE_DONE;
 }
 
+static int kvmppc_h_pr_put_tce_indirect(struct kvm_vcpu *vcpu)
+{
+	unsigned long liobn = kvmppc_get_gpr(vcpu, 4);
+	unsigned long ioba = kvmppc_get_gpr(vcpu, 5);
+	unsigned long tce = kvmppc_get_gpr(vcpu, 6);
+	unsigned long npages = kvmppc_get_gpr(vcpu, 7);
+	long rc;
+
+	rc = kvmppc_h_put_tce_indirect(vcpu, liobn, ioba,
+			tce, npages);
+	if (rc == H_TOO_HARD)
+		return EMULATE_FAIL;
+	kvmppc_set_gpr(vcpu, 3, rc);
+	return EMULATE_DONE;
+}
+
+static int kvmppc_h_pr_stuff_tce(struct kvm_vcpu *vcpu)
+{
+	unsigned long liobn = kvmppc_get_gpr(vcpu, 4);
+	unsigned long ioba = kvmppc_get_gpr(vcpu, 5);
+	unsigned long tce_value = kvmppc_get_gpr(vcpu, 6);
+	unsigned long npages = kvmppc_get_gpr(vcpu, 7);
+	long rc;
+
+	rc = kvmppc_h_stuff_tce(vcpu, liobn, ioba, tce_value, npages);
+	if (rc == H_TOO_HARD)
+		return EMULATE_FAIL;
+	kvmppc_set_gpr(vcpu, 3, rc);
+	return EMULATE_DONE;
+}
+
 static int kvmppc_h_pr_xics_hcall(struct kvm_vcpu *vcpu, u32 cmd)
 {
 	long rc = kvmppc_xics_hcall(vcpu, cmd);
@@ -277,6 +308,10 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd)
 		return kvmppc_h_pr_bulk_remove(vcpu);
 	case H_PUT_TCE:
 		return kvmppc_h_pr_put_tce(vcpu);
+	case H_PUT_TCE_INDIRECT:
+		return kvmppc_h_pr_put_tce_indirect(vcpu);
+	case H_STUFF_TCE:
+		return kvmppc_h_pr_stuff_tce(vcpu);
 	case H_CEDE:
 		kvmppc_set_msr_fast(vcpu, kvmppc_get_msr(vcpu) | MSR_EE);
 		kvm_vcpu_block(vcpu);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 61c738a..e66793b 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -473,6 +473,9 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_PPC_GET_SMMU_INFO:
 		r = 1;
 		break;
+	case KVM_CAP_SPAPR_MULTITCE:
+		r = 1;
+		break;
 #endif
 	default:
 		r = 0;
-- 
2.0.0
