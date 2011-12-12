Return-Path: <paulus@ozlabs.org>
Date: Tue, 13 Dec 2011 09:32:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH v3 09/14] KVM: PPC: Allow I/O mappings in memory slots
Message-ID: <20111212223226.GJ18868@bloggs.ozlabs.ibm.com>
References: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This provides for the case where userspace maps an I/O device into the
address range of a memory slot using a VM_PFNMAP mapping.  In that
case, we work out the pfn from vma->vm_pgoff, and record the cache
enable bits from vma->vm_page_prot in two low-order bits in the
slot_phys array entries.  Then, in kvmppc_h_enter() we check that the
cache bits in the HPTE that the guest wants to insert match the cache
bits in the slot_phys array entry.  However, we do allow the guest to
create what it thinks is a non-cacheable or write-through mapping to
memory that is actually cacheable, so that we can use normal system
memory as part of an emulated device later on.  In that case the actual
HPTE we insert is a cacheable HPTE.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |   26 ++++++++++++
 arch/powerpc/include/asm/kvm_host.h      |    2 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |   65 ++++++++++++++++++++----------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |   15 +++++-
 4 files changed, 84 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 10920f7..18b590d 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -113,6 +113,32 @@ static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
 	return 0;				/* error */
 }
 
+static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long io_type)
+{
+	unsigned int wimg = ptel & HPTE_R_WIMG;
+
+	/* Handle SAO */
+	if (wimg == (HPTE_R_W | HPTE_R_I | HPTE_R_M) &&
+	    cpu_has_feature(CPU_FTR_ARCH_206))
+		wimg = HPTE_R_M;
+
+	if (!io_type)
+		return wimg == HPTE_R_M;
+
+	return (wimg & (HPTE_R_W | HPTE_R_I)) == io_type;
+}
+
+/* Return HPTE cache control bits corresponding to Linux pte bits */
+static inline unsigned long hpte_cache_bits(unsigned long pte_val)
+{
+#if _PAGE_NO_CACHE == HPTE_R_I && _PAGE_WRITETHRU == HPTE_R_W
+	return pte_val & (HPTE_R_W | HPTE_R_I);
+#else
+	return ((pte_val & _PAGE_NO_CACHE) ? HPTE_R_I : 0) +
+		((pte_val & _PAGE_WRITETHRU) ? HPTE_R_W : 0);
+#endif
+}
+
 static inline bool slot_is_aligned(struct kvm_memory_slot *memslot,
 				   unsigned long pagesize)
 {
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 9252d5e..243bc80 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -178,6 +178,8 @@ struct revmap_entry {
 
 /* Low-order bits in kvm->arch.slot_phys[][] */
 #define KVMPPC_PAGE_ORDER_MASK	0x1f
+#define KVMPPC_PAGE_NO_CACHE	HPTE_R_I	/* 0x20 */
+#define KVMPPC_PAGE_WRITETHRU	HPTE_R_W	/* 0x40 */
 #define KVMPPC_GOT_PAGE		0x80
 
 struct kvm_arch {
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index cc18f3d..b904c40 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -199,7 +199,8 @@ static long kvmppc_get_guest_page(struct kvm *kvm, unsigned long gfn,
 	struct page *page, *hpage, *pages[1];
 	unsigned long s, pgsize;
 	unsigned long *physp;
-	unsigned int got, pgorder;
+	unsigned int is_io, got, pgorder;
+	struct vm_area_struct *vma;
 	unsigned long pfn, i, npages;
 
 	physp = kvm->arch.slot_phys[memslot->id];
@@ -208,34 +209,51 @@ static long kvmppc_get_guest_page(struct kvm *kvm, unsigned long gfn,
 	if (physp[gfn - memslot->base_gfn])
 		return 0;
 
+	is_io = 0;
+	got = 0;
 	page = NULL;
 	pgsize = psize;
+	err = -EINVAL;
 	start = gfn_to_hva_memslot(memslot, gfn);
 
 	/* Instantiate and get the page we want access to */
 	np = get_user_pages_fast(start, 1, 1, pages);
-	if (np != 1)
-		return -EINVAL;
-	page = pages[0];
-	got = KVMPPC_GOT_PAGE;
+	if (np != 1) {
+		/* Look up the vma for the page */
+		down_read(&current->mm->mmap_sem);
+		vma = find_vma(current->mm, start);
+		if (!vma || vma->vm_start > start ||
+		    start + psize > vma->vm_end ||
+		    !(vma->vm_flags & VM_PFNMAP))
+			goto up_err;
+		is_io = hpte_cache_bits(pgprot_val(vma->vm_page_prot));
+		pfn = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
+		/* check alignment of pfn vs. requested page size */
+		if (psize > PAGE_SIZE && (pfn & ((psize >> PAGE_SHIFT) - 1)))
+			goto up_err;
+		up_read(&current->mm->mmap_sem);
 
-	/* See if this is a large page */
-	s = PAGE_SIZE;
-	if (PageHuge(page)) {
-		hpage = compound_head(page);
-		s <<= compound_order(hpage);
-		/* Get the whole large page if slot alignment is ok */
-		if (s > psize && slot_is_aligned(memslot, s) &&
-		    !(memslot->userspace_addr & (s - 1))) {
-			start &= ~(s - 1);
-			pgsize = s;
-			page = hpage;
+	} else {
+		page = pages[0];
+		got = KVMPPC_GOT_PAGE;
+
+		/* See if this is a large page */
+		s = PAGE_SIZE;
+		if (PageHuge(page)) {
+			hpage = compound_head(page);
+			s <<= compound_order(hpage);
+			/* Get the whole large page if slot alignment is ok */
+			if (s > psize && slot_is_aligned(memslot, s) &&
+			    !(memslot->userspace_addr & (s - 1))) {
+				start &= ~(s - 1);
+				pgsize = s;
+				page = hpage;
+			}
 		}
+		if (s < psize)
+			goto out;
+		pfn = page_to_pfn(page);
 	}
-	err = -EINVAL;
-	if (s < psize)
-		goto out;
-	pfn = page_to_pfn(page);
 
 	npages = pgsize >> PAGE_SHIFT;
 	pgorder = __ilog2(npages);
@@ -243,7 +261,8 @@ static long kvmppc_get_guest_page(struct kvm *kvm, unsigned long gfn,
 	spin_lock(&kvm->arch.slot_phys_lock);
 	for (i = 0; i < npages; ++i) {
 		if (!physp[i]) {
-			physp[i] = ((pfn + i) << PAGE_SHIFT) + got + pgorder;
+			physp[i] = ((pfn + i) << PAGE_SHIFT) +
+				got + is_io + pgorder;
 			got = 0;
 		}
 	}
@@ -257,6 +276,10 @@ static long kvmppc_get_guest_page(struct kvm *kvm, unsigned long gfn,
 		put_page(page);
 	}
 	return err;
+
+ up_err:
+	up_read(&current->mm->mmap_sem);
+	return err;
 }
 
 /*
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index c086eb0..3f5b016 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -65,6 +65,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long g_ptel = ptel;
 	struct kvm_memory_slot *memslot;
 	unsigned long *physp, pte_size;
+	unsigned long is_io;
 	bool realmode = vcpu->arch.vcore->vcore_state == VCORE_RUNNING;
 
 	psize = hpte_page_size(pteh, ptel);
@@ -92,6 +93,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	pa = *physp;
 	if (!pa)
 		return H_TOO_HARD;
+	is_io = pa & (HPTE_R_I | HPTE_R_W);
 	pte_size = PAGE_SIZE << (pa & KVMPPC_PAGE_ORDER_MASK);
 	pa &= PAGE_MASK;
 
@@ -104,9 +106,16 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	ptel |= pa;
 
 	/* Check WIMG */
-	if ((ptel & HPTE_R_WIMG) != HPTE_R_M &&
-	    (ptel & HPTE_R_WIMG) != (HPTE_R_W | HPTE_R_I | HPTE_R_M))
-		return H_PARAMETER;
+	if (!hpte_cache_flags_ok(ptel, is_io)) {
+		if (is_io)
+			return H_PARAMETER;
+		/*
+		 * Allow guest to map emulated device memory as
+		 * uncacheable, but actually make it cacheable.
+		 */
+		ptel &= ~(HPTE_R_W|HPTE_R_I|HPTE_R_G);
+		ptel |= HPTE_R_M;
+	}
 	pteh &= ~0x60UL;
 	pteh |= HPTE_V_VALID;
 
-- 
1.7.7.3
