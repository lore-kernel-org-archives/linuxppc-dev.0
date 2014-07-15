Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 478201A019A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:44 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:43 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7325A2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:41 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F98tht58196002
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:08:55 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9Pe9O022381
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:41 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 08/13] KVM: PPC: Add hugepage support for IOMMU in-kernel
 handling
Date: Tue, 15 Jul 2014 19:25:28 +1000
Message-Id: <1405416333-12477-9-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
References: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
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

This adds special support for huge pages (16MB) in real mode.
The reference counting cannot be easily done for such pages in real
mode (when MMU is off) so this adds a hash table of huge pages.
It is populated in virtual mode and get_page is called just once
per a huge page. Real mode handlers check if the requested page is
in the hash table, then no reference counting is done, otherwise
an exit to virtual mode happens. The hash table is released at KVM
exit.

This defines kvmppc_spapr_iommu_hugepage hash table entry and adds it
to kvm_arch.

This adds kvmppc_iommu_hugepages_init() and
kvmppc_iommu_hugepages_cleanup() helpers. The latter puts cached pages.

This fixes iommu_clear_tces_and_put_pages() not to put huge pages as this
is to be done by kvmppc_iommu_hugepages_cleanup().

This implements a real mode kvmppc_rm_hugepage_gpa_to_hpa() helper to
find a hash entry and a virtual mode kvmppc_iommu_hugepage_try_add()
helper to add one.

At the moment the fastest card available for tests uses up to 9 huge
pages so walking through this hash table does not cost much.
However this can change and we may want to optimize this.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

---

Changes:
v11:
* moved hashtables from IOMMU to KVM

2013/07/12:
* removed multiple #ifdef IOMMU_API as IOMMU_API is always enabled
for KVM_BOOK3S_64

2013/06/27:
* list of huge pages replaces with hashtable for better performance
* spinlock removed from real mode and only protects insertion of new
huge [ages descriptors into the hashtable

2013/06/05:
* fixed compile error when CONFIG_IOMMU_API=n

2013/05/20:
* the real mode handler now searches for a huge page by gpa (used to be pte)
* the virtual mode handler prints warning if it is called twice for the same
huge page as the real mode handler is expected to fail just once - when a huge
page is not in the list yet.
* the huge page is refcounted twice - when added to the hugepage list and
when used in the virtual mode hcall handler (can be optimized but it will
make the patch less nice).
---
 arch/powerpc/include/asm/kvm_host.h |  34 +++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  |   2 +
 arch/powerpc/kernel/iommu.c         |   6 +-
 arch/powerpc/kvm/book3s_64_vio.c    | 116 +++++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c |  25 ++++++++
 arch/powerpc/kvm/book3s_hv.c        |   3 +
 6 files changed, 183 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ed96b09..8a3b465 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -31,6 +31,7 @@
 #include <linux/list.h>
 #include <linux/atomic.h>
 #include <linux/tracepoint.h>
+#include <linux/hashtable.h>
 #include <asm/kvm_asm.h>
 #include <asm/processor.h>
 #include <asm/page.h>
@@ -191,6 +192,36 @@ struct kvm_rma_info {
 	unsigned long base_pfn;
 };
 
+/*
+ * The KVM guest can be backed with 16MB pages.
+ * In this case, we cannot do page counting from the real mode
+ * as the compound pages are used - they are linked in a list
+ * with pointers as virtual addresses which are inaccessible
+ * in real mode.
+ *
+ * To address the issue, here is what we do:
+ *
+ * 1) add a hashtable per KVM, each entry is kvmppc_spapr_iommu_hugepage
+ * and describes gpa-to-hpa mapping;
+ * 2) in real mode, if gpa is in the hash table, use the cached hpa;
+ * otherwise pass the request to virtual mode;
+ * 3) in virtual mode, check if gpa is in the hash table and use cached
+ * hpa; otherwise translate gpa to hpa and reference the page.
+ *
+ * hpa of every used hugepage will be cached in the hash table
+ * and referenced just once. Pages are released at KVM exit.
+ */
+#define KVMPPC_SPAPR_HUGEPAGE_HASH(gpa)	hash_32(gpa >> 24, 32)
+#define KVMPPC_SPAPR_HUGEPAGE_BUCKETS   64
+
+struct kvmppc_spapr_iommu_hugepage {
+	struct hlist_node hash_node;
+	unsigned long gpa;	/* Guest physical address */
+	unsigned long hpa;	/* Host physical address */
+	struct page *page;	/* page struct of the very first subpage */
+	unsigned long size;	/* Huge page size (always 16MB at the moment) */
+};
+
 /* XICS components, defined in book3s_xics.c */
 struct kvmppc_xics;
 struct kvmppc_icp;
@@ -266,6 +297,9 @@ struct kvm_arch {
 #ifdef CONFIG_PPC_BOOK3S_64
 	struct list_head spapr_tce_tables;
 	struct list_head rtas_tokens;
+	DECLARE_HASHTABLE(hugepages_hash_tab,
+			ilog2(KVMPPC_SPAPR_HUGEPAGE_BUCKETS));
+	spinlock_t hugepages_write_lock;
 #endif
 #ifdef CONFIG_KVM_MPIC
 	struct openpic *mpic;
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index e0a68ef..86f5015 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -127,6 +127,8 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 
 extern int kvmppc_spapr_tce_init(struct kvm_vcpu *vcpu);
 extern void kvmppc_spapr_tce_free(struct kvm_vcpu *vcpu);
+extern void kvmppc_iommu_hugepages_init(struct kvm_arch *ka);
+extern void kvmppc_iommu_hugepages_cleanup(struct kvm_arch *ka);
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce_64 *args);
 extern struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 259ddb5..bf45d5f 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1018,7 +1018,8 @@ int iommu_clear_tces_and_put_pages(struct iommu_table *tbl,
 			if (!pg) {
 				ret = -EAGAIN;
 			} else if (PageCompound(pg)) {
-				ret = -EAGAIN;
+				/* Hugepages will be released at KVM exit */
+				ret = 0;
 			} else {
 				if (oldtce & TCE_PCI_WRITE)
 					SetPageDirty(pg);
@@ -1030,6 +1031,9 @@ int iommu_clear_tces_and_put_pages(struct iommu_table *tbl,
 
 			if (!pg) {
 				ret = -EAGAIN;
+			} else if (PageCompound(pg)) {
+				/* Hugepages will be released at KVM exit */
+				ret = 0;
 			} else {
 				if (oldtce & TCE_PCI_WRITE)
 					SetPageDirty(pg);
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 2c6ab20..2648d88 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
@@ -67,6 +68,104 @@ void kvmppc_spapr_tce_free(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvmppc_spapr_tce_free);
 
+/*
+ * API to support huge pages in real mode
+ */
+void kvmppc_iommu_hugepages_init(struct kvm_arch *ka)
+{
+	spin_lock_init(&ka->hugepages_write_lock);
+	hash_init(ka->hugepages_hash_tab);
+}
+EXPORT_SYMBOL_GPL(kvmppc_iommu_hugepages_init);
+
+void kvmppc_iommu_hugepages_cleanup(struct kvm_arch *ka)
+{
+	int bkt;
+	struct kvmppc_spapr_iommu_hugepage *hp;
+	struct hlist_node *tmp;
+
+	spin_lock(&ka->hugepages_write_lock);
+	hash_for_each_safe(ka->hugepages_hash_tab, bkt, tmp, hp, hash_node) {
+		pr_debug("Release HP #%u gpa=%lx hpa=%lx size=%ld\n",
+				bkt, hp->gpa, hp->hpa, hp->size);
+		hlist_del_rcu(&hp->hash_node);
+
+		put_page(hp->page);
+		kfree(hp);
+	}
+	spin_unlock(&ka->hugepages_write_lock);
+}
+EXPORT_SYMBOL_GPL(kvmppc_iommu_hugepages_cleanup);
+
+/* Returns true if a page with GPA is already in the hash table */
+static bool kvmppc_iommu_hugepage_lookup_gpa(struct kvm_arch *ka,
+		unsigned long gpa)
+{
+	struct kvmppc_spapr_iommu_hugepage *hp;
+	const unsigned key = KVMPPC_SPAPR_HUGEPAGE_HASH(gpa);
+
+	hash_for_each_possible_rcu(ka->hugepages_hash_tab, hp,
+			hash_node, key) {
+		if ((hp->gpa <= gpa) && (gpa < hp->gpa + hp->size))
+			return true;
+	}
+
+	return false;
+}
+
+/* Returns true if a page with GPA has been added to the hash table */
+static bool kvmppc_iommu_hugepage_add(struct kvm_vcpu *vcpu,
+		unsigned long hva, unsigned long gpa)
+{
+	struct kvm_arch *ka = &vcpu->kvm->arch;
+	struct kvmppc_spapr_iommu_hugepage *hp;
+	const unsigned key = KVMPPC_SPAPR_HUGEPAGE_HASH(gpa);
+	pte_t *ptep;
+	unsigned int shift = 0;
+	static const int is_write = 1;
+
+	ptep = find_linux_pte_or_hugepte(vcpu->arch.pgdir, hva, &shift);
+	WARN_ON(!ptep);
+
+	if (!ptep || (shift <= PAGE_SHIFT))
+		return false;
+
+	hp = kzalloc(sizeof(*hp), GFP_KERNEL);
+	if (!hp)
+		return false;
+
+	hp->gpa = gpa & ~((1 << shift) - 1);
+	hp->hpa = (pte_pfn(*ptep) << PAGE_SHIFT);
+	hp->size = 1 << shift;
+
+	if (get_user_pages_fast(hva & ~(hp->size - 1), 1,
+			is_write, &hp->page) != 1) {
+		kfree(hp);
+		return false;
+	}
+	hash_add_rcu(ka->hugepages_hash_tab, &hp->hash_node, key);
+
+	return true;
+}
+
+/*
+ * Returns true if a page with GPA is in the hash table or
+ * has just been added.
+ */
+static bool kvmppc_iommu_hugepage_try_add(struct kvm_vcpu *vcpu,
+		unsigned long hva, unsigned long gpa)
+{
+	struct kvm_arch *ka = &vcpu->kvm->arch;
+	bool ret;
+
+	spin_lock(&ka->hugepages_write_lock);
+	ret = kvmppc_iommu_hugepage_lookup_gpa(ka, gpa) ||
+			kvmppc_iommu_hugepage_add(vcpu, hva, gpa);
+	spin_unlock(&ka->hugepages_write_lock);
+
+	return ret;
+}
+
 static long kvmppc_stt_npages(unsigned long size)
 {
 	return ALIGN(size * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
@@ -234,8 +333,21 @@ static void __user *kvmppc_gpa_to_hva_and_get(struct kvm_vcpu *vcpu,
 
 	hva = __gfn_to_hva_memslot(memslot, gfn) | (gpa & ~PAGE_MASK);
 
-	if (pg && (get_user_pages_fast(hva & PAGE_MASK, 1, is_write, pg) != 1))
-		return ERROR_ADDR;
+	if (pg) {
+		if (get_user_pages_fast(hva & PAGE_MASK, 1, is_write, pg) != 1)
+			return ERROR_ADDR;
+
+		/*
+		 * Check if this GPA is taken care of by the hash table.
+		 * If this is the case, do not show the caller page struct
+		 * address as huge pages will be released at KVM exit.
+		 */
+		if (PageCompound(*pg) && kvmppc_iommu_hugepage_try_add(
+				vcpu, hva, gpa)) {
+			put_page(*pg);
+			*pg = NULL;
+		}
+	}
 
 	return (void *) hva;
 }
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index a3a6597..6c0b95d 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -156,6 +156,23 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
 EXPORT_SYMBOL_GPL(kvmppc_tce_put);
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+
+static unsigned long kvmppc_rm_hugepage_gpa_to_hpa(
+		struct kvm_arch *ka,
+		unsigned long gpa)
+{
+	struct kvmppc_spapr_iommu_hugepage *hp;
+	const unsigned key = KVMPPC_SPAPR_HUGEPAGE_HASH(gpa);
+
+	hash_for_each_possible_rcu_notrace(ka->hugepages_hash_tab, hp,
+			hash_node, key) {
+		if ((gpa <= hp->gpa) && (gpa < hp->gpa + hp->size))
+			return hp->hpa + (gpa & (hp->size - 1));
+	}
+
+	return ERROR_ADDR;
+}
+
 /*
  * Converts guest physical address to host physical address.
  *
@@ -175,6 +192,14 @@ static unsigned long kvmppc_rm_gpa_to_hpa_and_get(struct kvm_vcpu *vcpu,
 	unsigned long gfn = gpa >> PAGE_SHIFT;
 	unsigned shift = 0;
 
+	/* Check if it is a hugepage */
+	hpa = kvmppc_rm_hugepage_gpa_to_hpa(&vcpu->kvm->arch, gpa);
+	if (hpa != ERROR_ADDR) {
+		*pg = NULL; /* Tell the caller not to put page */
+		return hpa;
+	}
+
+	/* System page size case */
 	memslot = search_memslots(kvm_memslots(vcpu->kvm), gfn);
 	if (!memslot)
 		return ERROR_ADDR;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7f6d18a..708be66 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1333,6 +1333,8 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 	if (kvmppc_spapr_tce_init(vcpu))
 		goto free_vcpu;
 
+	kvmppc_iommu_hugepages_init(&vcpu->kvm->arch);
+
 	return vcpu;
 
 free_vcpu:
@@ -1356,6 +1358,7 @@ static void kvmppc_core_vcpu_free_hv(struct kvm_vcpu *vcpu)
 	unpin_vpa(vcpu->kvm, &vcpu->arch.vpa);
 	spin_unlock(&vcpu->arch.vpa_update_lock);
 	kvmppc_spapr_tce_free(vcpu);
+	kvmppc_iommu_hugepages_cleanup(&vcpu->kvm->arch);
 	kvm_vcpu_uninit(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
-- 
2.0.0
