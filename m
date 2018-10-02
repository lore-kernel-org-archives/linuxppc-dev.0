Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDC1C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:35:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D76204FD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="w816GpxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D76204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PdsW1YG0zDr44
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:35:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="w816GpxJ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSW02CGzF390
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:32:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="w816GpxJ"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSV34s0z9t1r; Tue,  2 Oct 2018 21:32:10 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcST4b8Rz9sjB;
 Tue,  2 Oct 2018 21:32:09 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479929; bh=xHNSOuNBzGN7pzDEFF/OXJgeYyTHEFSWuVA3G7TGLoM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=w816GpxJJAZnDIKv+mfIFrGl7RvajzqP4LF2YfVMvfhItovn4sqAhgcL502ybzA3y
 SP5M8SM6ZtdzqT7T68WhcQsJNNI6F4sheFwjzcEiizySF2oyT3125S14v78/vt1DqI
 hyVCNHHwq25BOj2CpnAjLEJRDrwOvlwX5GQRwcG+ghDqfHe1D50ChYkQSxTrgavNnf
 QuQ42XQn0WU8Bvr/0IHn73IIGIEX9oroyyepV7HCPR6Jtu60p4SWuMiAkt9r/KT/mu
 p7BG3eJqnQQKjl8+7mtw8GoI5ZnbC9dn4wucqy1LOTl3ciYWXxnQIJQJvvFTPbIHI6
 2Hr0p90mDGqNw==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 23/33] KVM: PPC: Book3S HV: Introduce rmap to track nested
 guest mappings
Date: Tue,  2 Oct 2018 21:31:22 +1000
Message-Id: <1538479892-14835-24-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

When a host (L0) page which is mapped into a (L1) guest is in turn
mapped through to a nested (L2) guest we keep a reverse mapping (rmap)
so that these mappings can be retrieved later.

Whenever we create an entry in a shadow_pgtable for a nested guest we
create a corresponding rmap entry and add it to the list for the
L1 guest memslot at the index of the L1 guest page it maps. This means
at the L1 guest memslot we end up with lists of rmaps.

When we are notified of a host page being invalidated which has been
mapped through to a (L1) guest, we can then walk the rmap list for that
guest page, and find and invalidate all of the corresponding
shadow_pgtable entries.

In order to reduce memory consumption, we compress the information for
each rmap entry down to 52 bits -- 12 bits for the LPID and 40 bits
for the guest real page frame number -- which will fit in a single
unsigned long.  To avoid a scenario where a guest can trigger
unbounded memory allocations, we scan the list when adding an entry to
see if there is already an entry with the contents we need.  This can
occur, because we don't ever remove entries from the middle of a list.

A struct nested guest rmap is a list pointer and an rmap entry;
----------------
| next pointer |
----------------
| rmap entry   |
----------------

Thus the rmap pointer for each guest frame number in the memslot can be
either NULL, a single entry, or a pointer to a list of nested rmap entries.

gfn	 memslot rmap array
 	-------------------------
 0	| NULL			|	(no rmap entry)
 	-------------------------
 1	| single rmap entry	|	(rmap entry with low bit set)
 	-------------------------
 2	| list head pointer	|	(list of rmap entries)
 	-------------------------

The final entry always has the lowest bit set and is stored in the next
pointer of the last list entry, or as a single rmap entry.
With a list of rmap entries looking like;

-----------------	-----------------	-------------------------
| list head ptr	| ----> | next pointer	| ---->	| single rmap entry	|
-----------------	-----------------	-------------------------
			| rmap entry	|	| rmap entry		|
			-----------------	-------------------------

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s.h    |   3 +
 arch/powerpc/include/asm/kvm_book3s_64.h |  70 ++++++++++++++++-
 arch/powerpc/kvm/book3s_64_mmu_radix.c   |  44 +++++++----
 arch/powerpc/kvm/book3s_hv.c             |   1 +
 arch/powerpc/kvm/book3s_hv_nested.c      | 130 ++++++++++++++++++++++++++++++-
 5 files changed, 233 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index d983778..1d2286d 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -196,6 +196,9 @@ extern int kvmppc_mmu_radix_translate_table(struct kvm_vcpu *vcpu, gva_t eaddr,
 			int table_index, u64 *pte_ret_p);
 extern int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 			struct kvmppc_pte *gpte, bool data, bool iswrite);
+extern void kvmppc_unmap_pte(struct kvm *kvm, pte_t *pte, unsigned long gpa,
+			unsigned int shift, struct kvm_memory_slot *memslot,
+			unsigned int lpid);
 extern bool kvmppc_hv_handle_set_rc(struct kvm *kvm, pgd_t *pgtable,
 				    bool writing, unsigned long gpa,
 				    unsigned int lpid);
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 5496152..38614f0 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -53,6 +53,66 @@ struct kvm_nested_guest {
 	struct kvm_nested_guest *next;
 };
 
+/*
+ * We define a nested rmap entry as a single 64-bit quantity
+ * 0xFFF0000000000000	12-bit lpid field
+ * 0x000FFFFFFFFFF000	40-bit guest physical address field
+ * 0x0000000000000001	1-bit  single entry flag
+ */
+#define RMAP_NESTED_LPID_MASK		0xFFF0000000000000UL
+#define RMAP_NESTED_LPID_SHIFT		(52)
+#define RMAP_NESTED_GPA_MASK		0x000FFFFFFFFFF000UL
+#define RMAP_NESTED_IS_SINGLE_ENTRY	0x0000000000000001UL
+
+/* Structure for a nested guest rmap entry */
+struct rmap_nested {
+	struct llist_node list;
+	u64 rmap;
+};
+
+/*
+ * for_each_nest_rmap_safe - iterate over the list of nested rmap entries
+ *			     safe against removal of the list entry or NULL list
+ * @pos:	a (struct rmap_nested *) to use as a loop cursor
+ * @node:	pointer to the first entry
+ *		NOTE: this can be NULL
+ * @rmapp:	an (unsigned long *) in which to return the rmap entries on each
+ *		iteration
+ *		NOTE: this must point to already allocated memory
+ *
+ * The nested_rmap is a llist of (struct rmap_nested) entries pointed to by the
+ * rmap entry in the memslot. The list is always terminated by a "single entry"
+ * stored in the list element of the final entry of the llist. If there is ONLY
+ * a single entry then this is itself in the rmap entry of the memslot, not a
+ * llist head pointer.
+ *
+ * Note that the iterator below assumes that a nested rmap entry is always
+ * non-zero.  This is true for our usage because the LPID field is always
+ * non-zero (zero is reserved for the host).
+ *
+ * This should be used to iterate over the list of rmap_nested entries with
+ * processing done on the u64 rmap value given by each iteration. This is safe
+ * against removal of list entries and it is always safe to call free on (pos).
+ *
+ * e.g.
+ * struct rmap_nested *cursor;
+ * struct llist_node *first;
+ * unsigned long rmap;
+ * for_each_nest_rmap_safe(cursor, first, &rmap) {
+ *	do_something(rmap);
+ *	free(cursor);
+ * }
+ */
+#define for_each_nest_rmap_safe(pos, node, rmapp)			       \
+	for ((pos) = llist_entry((node), typeof(*(pos)), list);		       \
+	     (node) &&							       \
+	     (*(rmapp) = ((RMAP_NESTED_IS_SINGLE_ENTRY & ((u64) (node))) ?     \
+			  ((u64) (node)) : ((pos)->rmap))) &&		       \
+	     (((node) = ((RMAP_NESTED_IS_SINGLE_ENTRY & ((u64) (node))) ?      \
+			 ((struct llist_node *) ((pos) = NULL)) :	       \
+			 (pos)->list.next)), true);			       \
+	     (pos) = llist_entry((node), typeof(*(pos)), list))
+
 struct kvm_nested_guest *kvmhv_get_nested(struct kvm *kvm, int l1_lpid,
 					  bool create);
 void kvmhv_put_nested(struct kvm_nested_guest *gp);
@@ -551,7 +611,15 @@ static inline void copy_to_checkpoint(struct kvm_vcpu *vcpu)
 
 extern int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 			     unsigned long gpa, unsigned int level,
-			     unsigned long mmu_seq, unsigned int lpid);
+			     unsigned long mmu_seq, unsigned int lpid,
+			     unsigned long *rmapp, struct rmap_nested **n_rmap);
+extern void kvmhv_insert_nest_rmap(struct kvm *kvm, unsigned long *rmapp,
+				   struct rmap_nested **n_rmap);
+extern void kvmhv_remove_nest_rmap_range(struct kvm *kvm,
+				struct kvm_memory_slot *memslot,
+				unsigned long gpa, unsigned long hpa,
+				unsigned long nbytes);
+extern void kvmhv_free_memslot_nest_rmap(struct kvm_memory_slot *free);
 
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index ee6f493..4f0fae2 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -256,27 +256,38 @@ static void kvmppc_pmd_free(pmd_t *pmdp)
 	kmem_cache_free(kvm_pmd_cache, pmdp);
 }
 
-void kvmppc_unmap_pte(struct kvm *kvm, pte_t *pte,
-		      unsigned long gpa, unsigned int shift,
-		      struct kvm_memory_slot *memslot,
+/* Called with kvm->mmu_lock held */
+void kvmppc_unmap_pte(struct kvm *kvm, pte_t *pte, unsigned long gpa,
+		      unsigned int shift, struct kvm_memory_slot *memslot,
 		      unsigned int lpid)
 
 {
 	unsigned long old;
+	unsigned long gfn = gpa >> PAGE_SHIFT;
+	unsigned long page_size = PAGE_SIZE;
+	unsigned long hpa;
 
 	old = kvmppc_radix_update_pte(kvm, pte, ~0UL, 0, gpa, shift);
 	kvmppc_radix_tlbie_page(kvm, gpa, shift, lpid);
-	if ((old & _PAGE_DIRTY) && (lpid == kvm->arch.lpid)) {
-		unsigned long gfn = gpa >> PAGE_SHIFT;
-		unsigned long page_size = PAGE_SIZE;
 
-		if (shift)
-			page_size = 1ul << shift;
+	/* The following only applies to L1 entries */
+	if (lpid != kvm->arch.lpid)
+		return;
+
+	if (!memslot) {
+		memslot = gfn_to_memslot(kvm, gfn);
 		if (!memslot)
-			memslot = gfn_to_memslot(kvm, gfn);
-		if (memslot && memslot->dirty_bitmap)
-			kvmppc_update_dirty_map(memslot, gfn, page_size);
+			return;
 	}
+	if (shift)
+		page_size = 1ul << shift;
+
+	gpa &= ~(page_size - 1);
+	hpa = old & PTE_RPN_MASK;
+	kvmhv_remove_nest_rmap_range(kvm, memslot, gpa, hpa, page_size);
+
+	if ((old & _PAGE_DIRTY) && memslot->dirty_bitmap)
+		kvmppc_update_dirty_map(memslot, gfn, page_size);
 }
 
 /*
@@ -432,7 +443,8 @@ static void kvmppc_unmap_free_pud_entry_table(struct kvm *kvm, pud_t *pud,
 
 int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 		      unsigned long gpa, unsigned int level,
-		      unsigned long mmu_seq, unsigned int lpid)
+		      unsigned long mmu_seq, unsigned int lpid,
+		      unsigned long *rmapp, struct rmap_nested **n_rmap)
 {
 	pgd_t *pgd;
 	pud_t *pud, *new_pud = NULL;
@@ -511,6 +523,8 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 			kvmppc_unmap_free_pud_entry_table(kvm, pud, gpa, lpid);
 		}
 		kvmppc_radix_set_pte_at(kvm, gpa, (pte_t *)pud, pte);
+		if (rmapp && n_rmap)
+			kvmhv_insert_nest_rmap(kvm, rmapp, n_rmap);
 		ret = 0;
 		goto out_unlock;
 	}
@@ -561,6 +575,8 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 			kvmppc_unmap_free_pmd_entry_table(kvm, pmd, gpa, lpid);
 		}
 		kvmppc_radix_set_pte_at(kvm, gpa, pmdp_ptep(pmd), pte);
+		if (rmapp && n_rmap)
+			kvmhv_insert_nest_rmap(kvm, rmapp, n_rmap);
 		ret = 0;
 		goto out_unlock;
 	}
@@ -585,6 +601,8 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 		goto out_unlock;
 	}
 	kvmppc_radix_set_pte_at(kvm, gpa, ptep, pte);
+	if (rmapp && n_rmap)
+		kvmhv_insert_nest_rmap(kvm, rmapp, n_rmap);
 	ret = 0;
 
  out_unlock:
@@ -712,7 +730,7 @@ int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 
 	/* Allocate space in the tree and write the PTE */
 	ret = kvmppc_create_pte(kvm, kvm->arch.pgtable, pte, gpa, level,
-				mmu_seq, kvm->arch.lpid);
+				mmu_seq, kvm->arch.lpid, NULL, NULL);
 	if (inserted_pte)
 		*inserted_pte = pte;
 	if (levelp)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index b975683..6629df4 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4292,6 +4292,7 @@ static void kvmppc_core_free_memslot_hv(struct kvm_memory_slot *free,
 					struct kvm_memory_slot *dont)
 {
 	if (!dont || free->arch.rmap != dont->arch.rmap) {
+		kvmhv_free_memslot_nest_rmap(free);
 		vfree(free->arch.rmap);
 		free->arch.rmap = NULL;
 	}
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index c160df3..4efa1f7 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/kvm_host.h>
+#include <linux/llist.h>
 
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
@@ -531,6 +532,123 @@ void kvmhv_put_nested(struct kvm_nested_guest *gp)
 		kvmhv_release_nested(gp);
 }
 
+static struct kvm_nested_guest *kvmhv_find_nested(struct kvm *kvm, int lpid)
+{
+	if (lpid > kvm->arch.max_nested_lpid)
+		return NULL;
+	return kvm->arch.nested_guests[lpid];
+}
+
+static inline bool kvmhv_n_rmap_is_equal(u64 rmap_1, u64 rmap_2)
+{
+	return !((rmap_1 ^ rmap_2) & (RMAP_NESTED_LPID_MASK |
+				       RMAP_NESTED_GPA_MASK));
+}
+
+void kvmhv_insert_nest_rmap(struct kvm *kvm, unsigned long *rmapp,
+			    struct rmap_nested **n_rmap)
+{
+	struct llist_node *entry = ((struct llist_head *) rmapp)->first;
+	struct rmap_nested *cursor;
+	u64 rmap, new_rmap = (*n_rmap)->rmap;
+
+	/* Are there any existing entries? */
+	if (!(*rmapp)) {
+		/* No -> use the rmap as a single entry */
+		*rmapp = new_rmap | RMAP_NESTED_IS_SINGLE_ENTRY;
+		return;
+	}
+
+	/* Do any entries match what we're trying to insert? */
+	for_each_nest_rmap_safe(cursor, entry, &rmap) {
+		if (kvmhv_n_rmap_is_equal(rmap, new_rmap))
+			return;
+	}
+
+	/* Do we need to create a list or just add the new entry? */
+	rmap = *rmapp;
+	if (rmap & RMAP_NESTED_IS_SINGLE_ENTRY) /* Not previously a list */
+		*rmapp = 0UL;
+	llist_add(&((*n_rmap)->list), (struct llist_head *) rmapp);
+	if (rmap & RMAP_NESTED_IS_SINGLE_ENTRY) /* Not previously a list */
+		(*n_rmap)->list.next = (struct llist_node *) rmap;
+
+	/* Set NULL so not freed by caller */
+	*n_rmap = NULL;
+}
+
+static void kvmhv_remove_nest_rmap(struct kvm *kvm, u64 n_rmap,
+				   unsigned long hpa, unsigned long mask)
+{
+	struct kvm_nested_guest *gp;
+	unsigned long gpa;
+	unsigned int shift, lpid;
+	pte_t *ptep;
+
+	gpa = n_rmap & RMAP_NESTED_GPA_MASK;
+	lpid = (n_rmap & RMAP_NESTED_LPID_MASK) >> RMAP_NESTED_LPID_SHIFT;
+	gp = kvmhv_find_nested(kvm, lpid);
+	if (!gp)
+		return;
+
+	/* Find and invalidate the pte */
+	ptep = __find_linux_pte(gp->shadow_pgtable, gpa, NULL, &shift);
+	/* Don't spuriously invalidate ptes if the pfn has changed */
+	if (ptep && pte_present(*ptep) && ((pte_val(*ptep) & mask) == hpa))
+		kvmppc_unmap_pte(kvm, ptep, gpa, shift, NULL, gp->shadow_lpid);
+}
+
+static void kvmhv_remove_nest_rmap_list(struct kvm *kvm, unsigned long *rmapp,
+					unsigned long hpa, unsigned long mask)
+{
+	struct llist_node *entry = llist_del_all((struct llist_head *) rmapp);
+	struct rmap_nested *cursor;
+	unsigned long rmap;
+
+	for_each_nest_rmap_safe(cursor, entry, &rmap) {
+		kvmhv_remove_nest_rmap(kvm, rmap, hpa, mask);
+		kfree(cursor);
+	}
+}
+
+/* called with kvm->mmu_lock held */
+void kvmhv_remove_nest_rmap_range(struct kvm *kvm,
+				  struct kvm_memory_slot *memslot,
+				  unsigned long gpa, unsigned long hpa,
+				  unsigned long nbytes)
+{
+	unsigned long gfn, end_gfn;
+	unsigned long addr_mask;
+
+	if (!memslot)
+		return;
+	gfn = (gpa >> PAGE_SHIFT) - memslot->base_gfn;
+	end_gfn = gfn + (nbytes >> PAGE_SHIFT);
+
+	addr_mask = PTE_RPN_MASK & ~(nbytes - 1);
+	hpa &= addr_mask;
+
+	for (; gfn < end_gfn; gfn++) {
+		unsigned long *rmap = &memslot->arch.rmap[gfn];
+		kvmhv_remove_nest_rmap_list(kvm, rmap, hpa, addr_mask);
+	}
+}
+
+void kvmhv_free_memslot_nest_rmap(struct kvm_memory_slot *free)
+{
+	unsigned long page;
+
+	for (page = 0; page < free->npages; page++) {
+		unsigned long rmap, *rmapp = &free->arch.rmap[page];
+		struct rmap_nested *cursor;
+		struct llist_node *entry;
+
+		entry = llist_del_all((struct llist_head *) rmapp);
+		for_each_nest_rmap_safe(cursor, entry, &rmap)
+			kfree(cursor);
+	}
+}
+
 static bool kvmhv_invalidate_shadow_pte(struct kvm_vcpu *vcpu,
 					struct kvm_nested_guest *gp,
 					long gpa, int *shift_ret)
@@ -736,11 +854,13 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 {
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_memory_slot *memslot;
+	struct rmap_nested *n_rmap;
 	struct kvmppc_pte gpte;
 	pte_t pte, *pte_p;
 	unsigned long mmu_seq;
 	unsigned long dsisr = vcpu->arch.fault_dsisr;
 	unsigned long ea = vcpu->arch.fault_dar;
+	unsigned long *rmapp;
 	unsigned long n_gpa, gpa, gfn, perm = 0UL;
 	unsigned int shift, l1_shift, level;
 	bool writing = !!(dsisr & DSISR_ISSTORE);
@@ -874,8 +994,16 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 
 	/* 4. Insert the pte into our shadow_pgtable */
 
+	n_rmap = kzalloc(sizeof(*n_rmap), GFP_KERNEL);
+	if (!n_rmap)
+		return RESUME_GUEST; /* Let the guest try again */
+	n_rmap->rmap = (n_gpa & RMAP_NESTED_GPA_MASK) |
+		(((unsigned long) gp->l1_lpid) << RMAP_NESTED_LPID_SHIFT);
+	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
 	ret = kvmppc_create_pte(kvm, gp->shadow_pgtable, pte, n_gpa, level,
-				mmu_seq, gp->shadow_lpid);
+				mmu_seq, gp->shadow_lpid, rmapp, &n_rmap);
+	if (n_rmap)
+		kfree(n_rmap);
 	if (ret == -EAGAIN)
 		ret = RESUME_GUEST;	/* Let the guest try again */
 
-- 
2.7.4

