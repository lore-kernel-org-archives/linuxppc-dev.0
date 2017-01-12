Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzfzk2rBHzDqR0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 20:07:46 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 15/18] KVM: PPC: Book3S HV: Implement dirty page logging for
 radix guests
Date: Thu, 12 Jan 2017 20:07:23 +1100
Message-Id: <1484212046-29591-16-git-send-email-paulus@ozlabs.org>
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

This adds code to keep track of dirty pages when requested (that is,
when memslot->dirty_bitmap is non-NULL) for radix guests.  We use the
dirty bits in the PTEs in the second-level (partition-scoped) page
tables, together with a bitmap of pages that were dirty when their
PTE was invalidated (e.g., when the page was paged out).  This bitmap
is stored in the first half of the memslot->dirty_bitmap area, and
kvm_vm_ioctl_get_dirty_log_hv() now uses the second half for the
bitmap that gets returned to userspace.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s.h  |   7 ++-
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |  28 ++++-----
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 111 ++++++++++++++++++++++++++++++---
 arch/powerpc/kvm/book3s_hv.c           |  31 +++++++--
 4 files changed, 144 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 952cc4b..57dc407 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -198,6 +198,8 @@ extern int kvm_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			unsigned long gfn);
 extern int kvm_test_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			unsigned long gfn);
+extern long kvmppc_hv_get_dirty_log_radix(struct kvm *kvm,
+			struct kvm_memory_slot *memslot, unsigned long *map);
 
 /* XXX remove this export when load_last_inst() is generic */
 extern int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr, bool data);
@@ -228,8 +230,11 @@ extern long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 extern long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 			unsigned long pte_index, unsigned long avpn,
 			unsigned long *hpret);
-extern long kvmppc_hv_get_dirty_log(struct kvm *kvm,
+extern long kvmppc_hv_get_dirty_log_hpt(struct kvm *kvm,
 			struct kvm_memory_slot *memslot, unsigned long *map);
+extern void kvmppc_harvest_vpa_dirty(struct kvmppc_vpa *vpa,
+			struct kvm_memory_slot *memslot,
+			unsigned long *map);
 extern void kvmppc_update_lpcr(struct kvm *kvm, unsigned long lpcr,
 			unsigned long mask);
 extern void kvmppc_set_fscr(struct kvm_vcpu *vcpu, u64 fscr);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index fbb3de4..7a9afbe 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1068,7 +1068,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 	return npages_dirty;
 }
 
-static void harvest_vpa_dirty(struct kvmppc_vpa *vpa,
+void kvmppc_harvest_vpa_dirty(struct kvmppc_vpa *vpa,
 			      struct kvm_memory_slot *memslot,
 			      unsigned long *map)
 {
@@ -1086,12 +1086,11 @@ static void harvest_vpa_dirty(struct kvmppc_vpa *vpa,
 		__set_bit_le(gfn - memslot->base_gfn, map);
 }
 
-long kvmppc_hv_get_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot,
-			     unsigned long *map)
+long kvmppc_hv_get_dirty_log_hpt(struct kvm *kvm,
+			struct kvm_memory_slot *memslot, unsigned long *map)
 {
 	unsigned long i, j;
 	unsigned long *rmapp;
-	struct kvm_vcpu *vcpu;
 
 	preempt_disable();
 	rmapp = memslot->arch.rmap;
@@ -1107,15 +1106,6 @@ long kvmppc_hv_get_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot,
 				__set_bit_le(j, map);
 		++rmapp;
 	}
-
-	/* Harvest dirty bits from VPA and DTL updates */
-	/* Note: we never modify the SLB shadow buffer areas */
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		spin_lock(&vcpu->arch.vpa_update_lock);
-		harvest_vpa_dirty(&vcpu->arch.vpa, memslot, map);
-		harvest_vpa_dirty(&vcpu->arch.dtl, memslot, map);
-		spin_unlock(&vcpu->arch.vpa_update_lock);
-	}
 	preempt_enable();
 	return 0;
 }
@@ -1170,10 +1160,14 @@ void kvmppc_unpin_guest_page(struct kvm *kvm, void *va, unsigned long gpa,
 	srcu_idx = srcu_read_lock(&kvm->srcu);
 	memslot = gfn_to_memslot(kvm, gfn);
 	if (memslot) {
-		rmap = &memslot->arch.rmap[gfn - memslot->base_gfn];
-		lock_rmap(rmap);
-		*rmap |= KVMPPC_RMAP_CHANGED;
-		unlock_rmap(rmap);
+		if (!kvm_is_radix(kvm)) {
+			rmap = &memslot->arch.rmap[gfn - memslot->base_gfn];
+			lock_rmap(rmap);
+			*rmap |= KVMPPC_RMAP_CHANGED;
+			unlock_rmap(rmap);
+		} else if (memslot->dirty_bitmap) {
+			mark_page_dirty(kvm, gfn);
+		}
 	}
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 }
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 69cabad..125cc7c 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -158,18 +158,21 @@ static void kvmppc_radix_tlbie_page(struct kvm *kvm, unsigned long addr,
 	asm volatile("ptesync": : :"memory");
 }
 
-void kvmppc_radix_update_pte(struct kvm *kvm, pte_t *ptep, unsigned long clr,
-			     unsigned long set, unsigned long addr,
-			     unsigned int shift)
+unsigned long kvmppc_radix_update_pte(struct kvm *kvm, pte_t *ptep,
+				      unsigned long clr, unsigned long set,
+				      unsigned long addr, unsigned int shift)
 {
+	unsigned long old = 0;
+
 	if (!(clr & _PAGE_PRESENT) && cpu_has_feature(CPU_FTR_POWER9_DD1) &&
 	    pte_present(*ptep)) {
 		/* have to invalidate it first */
-		__radix_pte_update(ptep, _PAGE_PRESENT, 0);
+		old = __radix_pte_update(ptep, _PAGE_PRESENT, 0);
 		kvmppc_radix_tlbie_page(kvm, addr, shift);
 		set |= _PAGE_PRESENT;
+		old &= _PAGE_PRESENT;
 	}
-	__radix_pte_update(ptep, clr, set);
+	return __radix_pte_update(ptep, clr, set) | old;
 }
 
 void kvmppc_radix_set_pte_at(struct kvm *kvm, unsigned long addr,
@@ -197,6 +200,7 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 	pud_t *pud, *new_pud = NULL;
 	pmd_t *pmd, *new_pmd = NULL;
 	pte_t *ptep, *new_ptep = NULL;
+	unsigned long old;
 	int ret;
 
 	/* Traverse the guest's 2nd-level tree, allocate new levels needed */
@@ -262,9 +266,11 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 		ptep = pte_offset_kernel(pmd, gpa);
 		if (pte_present(*ptep)) {
 			/* PTE was previously valid, so invalidate it */
-			kvmppc_radix_update_pte(kvm, ptep, _PAGE_PRESENT,
-						0, gpa, 0);
+			old = kvmppc_radix_update_pte(kvm, ptep, _PAGE_PRESENT,
+						      0, gpa, 0);
 			kvmppc_radix_tlbie_page(kvm, gpa, 0);
+			if (old & _PAGE_DIRTY)
+				mark_page_dirty(kvm, gpa >> PAGE_SHIFT);
 		}
 		kvmppc_radix_set_pte_at(kvm, gpa, ptep, pte);
 	} else {
@@ -463,6 +469,26 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+static void mark_pages_dirty(struct kvm *kvm, struct kvm_memory_slot *memslot,
+			     unsigned long gfn, unsigned int order)
+{
+	unsigned long i, limit;
+	unsigned long *dp;
+
+	if (!memslot->dirty_bitmap)
+		return;
+	limit = 1ul << order;
+	if (limit < BITS_PER_LONG) {
+		for (i = 0; i < limit; ++i)
+			mark_page_dirty(kvm, gfn + i);
+		return;
+	}
+	dp = memslot->dirty_bitmap + (gfn - memslot->base_gfn);
+	limit /= BITS_PER_LONG;
+	for (i = 0; i < limit; ++i)
+		*dp++ = ~0ul;
+}
+
 /* Called with kvm->lock held */
 int kvm_unmap_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		    unsigned long gfn)
@@ -470,13 +496,21 @@ int kvm_unmap_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	pte_t *ptep;
 	unsigned long gpa = gfn << PAGE_SHIFT;
 	unsigned int shift;
+	unsigned long old;
 
 	ptep = __find_linux_pte_or_hugepte(kvm->arch.pgtable, gpa,
 					   NULL, &shift);
 	if (ptep && pte_present(*ptep)) {
-		kvmppc_radix_update_pte(kvm, ptep, _PAGE_PRESENT, 0,
-					gpa, shift);
+		old = kvmppc_radix_update_pte(kvm, ptep, _PAGE_PRESENT, 0,
+					      gpa, shift);
 		kvmppc_radix_tlbie_page(kvm, gpa, shift);
+		if (old & _PAGE_DIRTY) {
+			if (!shift)
+				mark_page_dirty(kvm, gfn);
+			else
+				mark_pages_dirty(kvm, memslot,
+						 gfn, shift - PAGE_SHIFT);
+		}
 	}
 	return 0;				
 }
@@ -517,6 +551,65 @@ int kvm_test_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	return ref;
 }
 
+/* Returns the number of PAGE_SIZE pages that are dirty */
+static int kvm_radix_test_clear_dirty(struct kvm *kvm,
+				struct kvm_memory_slot *memslot, int pagenum)
+{
+	unsigned long gfn = memslot->base_gfn + pagenum;
+	unsigned long gpa = gfn << PAGE_SHIFT;
+	pte_t *ptep;
+	unsigned int shift;
+	int ret = 0;
+
+	ptep = __find_linux_pte_or_hugepte(kvm->arch.pgtable, gpa,
+					   NULL, &shift);
+	if (ptep && pte_present(*ptep) && pte_dirty(*ptep)) {
+		ret = 1;
+		if (shift)
+			ret = 1 << (shift - PAGE_SHIFT);
+		kvmppc_radix_update_pte(kvm, ptep, _PAGE_DIRTY, 0,
+					gpa, shift);
+		kvmppc_radix_tlbie_page(kvm, gpa, shift);
+	}
+	return ret;
+}
+
+long kvmppc_hv_get_dirty_log_radix(struct kvm *kvm,
+			struct kvm_memory_slot *memslot, unsigned long *map)
+{
+	unsigned long i, j;
+	unsigned long n, *p;
+	int npages;
+
+	/*
+	 * Radix accumulates dirty bits in the first half of the
+	 * memslot's dirty_bitmap area, for when pages are paged
+	 * out or modified by the host directly.  Pick up these
+	 * bits and add them to the map.
+	 */
+	n = kvm_dirty_bitmap_bytes(memslot) / sizeof(long);
+	p = memslot->dirty_bitmap;
+	for (i = 0; i < n; ++i)
+		map[i] |= xchg(&p[i], 0);
+
+	for (i = 0; i < memslot->npages; i = j) {
+		npages = kvm_radix_test_clear_dirty(kvm, memslot, i);
+
+		/*
+		 * Note that if npages > 0 then i must be a multiple of npages,
+		 * since huge pages are only used to back the guest at guest
+		 * real addresses that are a multiple of their size.
+		 * Since we have at most one PTE covering any given guest
+		 * real address, if npages > 1 we can skip to i + npages.
+		 */
+		j = i + 1;
+		if (npages)
+			for (j = i; npages; ++j, --npages)
+				__set_bit_le(j, map);
+	}
+	return 0;
+}
+
 void kvmppc_free_radix(struct kvm *kvm)
 {
 	unsigned long ig, iu, im;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 4c2d054..ab5adcd 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2962,8 +2962,10 @@ static int kvm_vm_ioctl_get_dirty_log_hv(struct kvm *kvm,
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	int r;
+	int i, r;
 	unsigned long n;
+	unsigned long *buf;
+	struct kvm_vcpu *vcpu;
 
 	mutex_lock(&kvm->slots_lock);
 
@@ -2977,15 +2979,32 @@ static int kvm_vm_ioctl_get_dirty_log_hv(struct kvm *kvm,
 	if (!memslot->dirty_bitmap)
 		goto out;
 
+	/*
+	 * Use second half of bitmap area because radix accumulates
+	 * bits in the first half.
+	 */
 	n = kvm_dirty_bitmap_bytes(memslot);
-	memset(memslot->dirty_bitmap, 0, n);
+	buf = memslot->dirty_bitmap + n / sizeof(long);
+	memset(buf, 0, n);
 
-	r = kvmppc_hv_get_dirty_log(kvm, memslot, memslot->dirty_bitmap);
+	if (kvm_is_radix(kvm))
+		r = kvmppc_hv_get_dirty_log_radix(kvm, memslot, buf);
+	else
+		r = kvmppc_hv_get_dirty_log_hpt(kvm, memslot, buf);
 	if (r)
 		goto out;
 
+	/* Harvest dirty bits from VPA and DTL updates */
+	/* Note: we never modify the SLB shadow buffer areas */
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		spin_lock(&vcpu->arch.vpa_update_lock);
+		kvmppc_harvest_vpa_dirty(&vcpu->arch.vpa, memslot, buf);
+		kvmppc_harvest_vpa_dirty(&vcpu->arch.dtl, memslot, buf);
+		spin_unlock(&vcpu->arch.vpa_update_lock);
+	}
+
 	r = -EFAULT;
-	if (copy_to_user(log->dirty_bitmap, memslot->dirty_bitmap, n))
+	if (copy_to_user(log->dirty_bitmap, buf, n))
 		goto out;
 
 	r = 0;
@@ -3038,7 +3057,7 @@ static void kvmppc_core_commit_memory_region_hv(struct kvm *kvm,
 	if (npages)
 		atomic64_inc(&kvm->arch.mmio_update);
 
-	if (npages && old->npages) {
+	if (npages && old->npages && !kvm_is_radix(kvm)) {
 		/*
 		 * If modifying a memslot, reset all the rmap dirty bits.
 		 * If this is a new memslot, we don't need to do anything
@@ -3047,7 +3066,7 @@ static void kvmppc_core_commit_memory_region_hv(struct kvm *kvm,
 		 */
 		slots = kvm_memslots(kvm);
 		memslot = id_to_memslot(slots, mem->slot);
-		kvmppc_hv_get_dirty_log(kvm, memslot, NULL);
+		kvmppc_hv_get_dirty_log_hpt(kvm, memslot, NULL);
 	}
 }
 
-- 
2.7.4
