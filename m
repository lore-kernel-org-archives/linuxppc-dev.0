Return-Path: <paulus@ozlabs.org>
Date: Tue, 6 Dec 2011 17:14:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH 13/13] KVM: PPC: Allow for read-only pages backing a Book3S
 HV guest
Message-ID: <20111206061438.GQ12389@drongo>
References: <20111206060156.GD12389@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111206060156.GD12389@drongo>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With this, if a guest does an H_ENTER with a read/write HPTE on a page
which is currently read-only, we make the actual HPTE inserted be a
read-only version of the HPTE.  We now intercept protection faults as
well as HPTE not found faults, and for a protection fault we work out
whether it should be reflected to the guest (e.g. because the guest HPTE
didn't allow write access to usermode) or handled by switching to
kernel context and calling kvmppc_book3s_hv_page_fault, which will then
request write access to the page and update the actual HPTE.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |   20 ++++++++++++++++-
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |   33 +++++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |   32 ++++++++++++++++++++---------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |    4 +-
 4 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 75a1b42..37755d0 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -115,6 +115,22 @@ static inline unsigned long hpte_rpn(unsigned long ptel, unsigned long psize)
 	return ((ptel & HPTE_R_RPN) & ~(psize - 1)) >> PAGE_SHIFT;
 }
 
+static inline int hpte_is_writable(unsigned long ptel)
+{
+	unsigned long pp = ptel & (HPTE_R_PP0 | HPTE_R_PP);
+
+	return pp != PP_RXRX && pp != PP_RXXX;
+}
+
+static inline unsigned long hpte_make_readonly(unsigned long ptel)
+{
+	if ((ptel & HPTE_R_PP0) || (ptel & HPTE_R_PP) == PP_RWXX)
+		ptel = (ptel & ~HPTE_R_PP) | PP_RXXX;
+	else
+		ptel |= PP_RXRX;
+	return ptel;
+}
+
 static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long io_type)
 {
 	unsigned int wimg = ptel & HPTE_R_WIMG;
@@ -134,7 +150,7 @@ static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long io_type)
  * Lock and read a linux PTE.  If it's present and writable, atomically
  * set dirty and referenced bits and return the PTE, otherwise return 0.
  */
-static inline pte_t kvmppc_read_update_linux_pte(pte_t *p)
+static inline pte_t kvmppc_read_update_linux_pte(pte_t *p, int writing)
 {
 	pte_t pte, tmp;
 
@@ -152,7 +168,7 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *p)
 
 	if (pte_present(pte)) {
 		pte = pte_mkyoung(pte);
-		if (pte_write(pte))
+		if (writing && pte_write(pte))
 			pte = pte_mkdirty(pte);
 	}
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 6919d99..b1b31c7 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -502,6 +502,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	struct page *page, *pages[1];
 	long index, ret, npages;
 	unsigned long is_io;
+	unsigned int writing, write_ok;
 	struct vm_area_struct *vma;
 
 	/*
@@ -552,8 +553,11 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	pfn = 0;
 	page = NULL;
 	pte_size = PAGE_SIZE;
+	writing = (dsisr & DSISR_ISSTORE) != 0;
+	/* If writing != 0, then the HPTE must allow writing, if we get here */
+	write_ok = writing;
 	hva = gfn_to_hva_memslot(memslot, gfn);
-	npages = get_user_pages_fast(hva, 1, 1, pages);
+	npages = get_user_pages_fast(hva, 1, writing, pages);
 	if (npages < 1) {
 		/* Check if it's an I/O mapping */
 		down_read(&current->mm->mmap_sem);
@@ -564,6 +568,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				((hva - vma->vm_start) >> PAGE_SHIFT);
 			pte_size = psize;
 			is_io = hpte_cache_bits(pgprot_val(vma->vm_page_prot));
+			write_ok = vma->vm_flags & VM_WRITE;
 		}
 		up_read(&current->mm->mmap_sem);
 		if (!pfn)
@@ -574,6 +579,18 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			page = compound_head(page);
 			pte_size <<= compound_order(page);
 		}
+		/* if the guest wants write access, see if that is OK */
+		if (!writing && hpte_is_writable(hpte[2])) {
+			pte_t *ptep, pte;
+
+			ptep = find_linux_pte_or_hugepte(current->mm->pgd,
+							 hva, NULL);
+			if (ptep && pte_present(*ptep)) {
+				pte = kvmppc_read_update_linux_pte(ptep, 1);
+				if (pte_write(pte))
+					write_ok = 1;
+			}
+		}
 		pfn = page_to_pfn(page);
 	}
 
@@ -598,6 +615,8 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	hpte[0] = (hpte[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
 	hpte[1] = (rev->guest_rpte & ~(HPTE_R_PP0 - pte_size)) |
 		(pfn << PAGE_SHIFT);
+	if (hpte_is_writable(hpte[1]) && !write_ok)
+		hpte[1] = hpte_make_readonly(hpte[1]);
 
 	rmap = &memslot->rmap[gfn - memslot->base_gfn];
 	lock_rmap(rmap);
@@ -609,13 +628,21 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		hptep[0] &= ~HPTE_V_HVLOCK;
 		goto out_put;
 	}
-	kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
+
+	if (hptep[0] & HPTE_V_VALID) {
+		/* HPTE was previously valid, so we need to invalidate it */
+		unlock_rmap(rmap);
+		hptep[0] |= HPTE_V_ABSENT;
+		kvmppc_invalidate_hpte(kvm, hptep, index);
+	} else {
+		kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
+	}
 
 	hptep[1] = hpte[1];
 	eieio();
 	hptep[0] = hpte[0];
 	asm volatile("ptesync" : : : "memory");
-	if (page)
+	if (page && hpte_is_writable(hpte[1]))
 		SetPageDirty(page);
 
  out_put:
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 6248536..2fded8a 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -123,7 +123,7 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
 }
 
 static pte_t lookup_linux_pte(struct kvm_vcpu *vcpu, unsigned long hva,
-			      unsigned long *pte_sizep)
+			      int writing, unsigned long *pte_sizep)
 {
 	pte_t *ptep;
 	unsigned long ps = *pte_sizep;
@@ -140,7 +140,7 @@ static pte_t lookup_linux_pte(struct kvm_vcpu *vcpu, unsigned long hva,
 		return __pte(0);
 	if (!pte_present(*ptep))
 		return __pte(0);
-	return kvmppc_read_update_linux_pte(ptep);
+	return kvmppc_read_update_linux_pte(ptep, writing);
 }
 
 long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
@@ -157,12 +157,14 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long is_io;
 	unsigned long *rmap;
 	pte_t pte;
+	unsigned int writing;
 	unsigned long mmu_seq;
 	bool realmode = vcpu->arch.vcore->vcore_state == VCORE_RUNNING;
 
 	psize = hpte_page_size(pteh, ptel);
 	if (!psize)
 		return H_PARAMETER;
+	writing = hpte_is_writable(ptel);
 	pteh &= ~(HPTE_V_HVLOCK | HPTE_V_ABSENT | HPTE_V_VALID);
 
 	/* used later to detect if we might have been invalidated */
@@ -211,8 +213,11 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 
 		/* Look up the Linux PTE for the backing page */
 		pte_size = psize;
-		pte = lookup_linux_pte(vcpu, hva, &pte_size);
+		pte = lookup_linux_pte(vcpu, hva, writing, &pte_size);
 		if (pte_present(pte)) {
+			if (writing && !pte_write(pte))
+				/* make the actual HPTE be read-only */
+				ptel = hpte_make_readonly(ptel);
 			is_io = hpte_cache_bits(pte_val(pte));
 			pa = pte_pfn(pte) << PAGE_SHIFT;
 		}
@@ -673,7 +678,9 @@ EXPORT_SYMBOL(kvmppc_hv_find_lock_hpte);
 
 /*
  * Called in real mode to check whether an HPTE not found fault
- * is due to accessing a paged-out page or an emulated MMIO page.
+ * is due to accessing a paged-out page or an emulated MMIO page,
+ * or if a protection fault is due to accessing a page that the
+ * guest wanted read/write access to but which we made read-only.
  * Returns a possibly modified status (DSISR) value if not
  * (i.e. pass the interrupt to the guest),
  * -1 to pass the fault up to host kernel mode code, -2 to do that
@@ -691,12 +698,17 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 	struct revmap_entry *rev;
 	unsigned long pp, key;
 
-	valid = HPTE_V_VALID | HPTE_V_ABSENT;
+	/* For protection fault, expect to find a valid HPTE */
+	valid = HPTE_V_VALID;
+	if (status & DSISR_NOHPTE)
+		valid |= HPTE_V_ABSENT;
 
 	index = kvmppc_hv_find_lock_hpte(kvm, addr, slb_v, valid);
-	if (index < 0)
-		return status;		/* there really was no HPTE */
-
+	if (index < 0) {
+		if (status & DSISR_NOHPTE)
+			return status;	/* there really was no HPTE */
+		return 0;		/* for prot fault, HPTE disappeared */
+	}
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
 	v = hpte[0] & ~HPTE_V_HVLOCK;
 	r = hpte[1];
@@ -707,8 +719,8 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 	asm volatile("lwsync" : : : "memory");
 	hpte[0] = v;
 
-	/* If the HPTE is valid by now, retry the instruction */
-	if (v & HPTE_V_VALID)
+	/* For not found, if the HPTE is valid by now, retry the instruction */
+	if ((status & DSISR_NOHPTE) && (v & HPTE_V_VALID))
 		return 0;
 
 	/* Check access permissions to the page */
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 930e09e..7b8dbf6 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1111,8 +1111,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 kvmppc_hdsi:
 	mfspr	r4, SPRN_HDAR
 	mfspr	r6, SPRN_HDSISR
-	/* HPTE not found fault? */
-	andis.	r0, r6, DSISR_NOHPTE@h
+	/* HPTE not found fault or protection fault? */
+	andis.	r0, r6, (DSISR_NOHPTE | DSISR_PROTFAULT)@h
 	beq	1f			/* if not, send it to the guest */
 	andi.	r0, r11, MSR_DR		/* data relocation enabled? */
 	beq	3f
-- 
1.7.5.4
