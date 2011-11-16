Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Nov 2011 09:59:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org
Subject: [RFC PATCH 06/11] KVM: PPC: Use Linux page tables in h_enter and
 map_vrma
Message-ID: <20111116225948.GG26985@bloggs.ozlabs.ibm.com>
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This changes kvmppc_h_enter() and kvmppc_map_vrma to get the real page
numbers that they put into the guest HPT from the Linux page tables
for our userspace as an alternative to getting them from the slot_pfns
arrays.  In future this will enable us to avoid pinning all of guest
memory on POWER7, but we will still have to pin all guest memory on
PPC970 as it doesn't support virtual partition memory.

This also exports find_linux_pte_or_hugepte() since we need it when
KVM is modular.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |   31 +++++++
 arch/powerpc/include/asm/kvm_host.h      |    2 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |   26 +++++-
 arch/powerpc/kvm/book3s_hv.c             |    1 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  127 ++++++++++++++++--------------
 arch/powerpc/mm/hugetlbpage.c            |    2 +
 6 files changed, 125 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 9243f35..307e649 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -121,4 +121,35 @@ static inline unsigned long *kvmppc_pfn_entry(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_BOOK3S_64_HV */
 
+/*
+ * Lock and read a linux PTE.  If it's present and writable, atomically
+ * set dirty and referenced bits and return the PFN, otherwise return 0.
+ */
+static inline unsigned long kvmppc_read_update_linux_pte(pte_t *p)
+{
+	pte_t pte, tmp;
+	unsigned long pfn = 0;
+
+	/* wait until _PAGE_BUSY is clear then set it atomically */
+	__asm__ __volatile__ (
+		"1:	ldarx	%0,0,%3\n"
+		"	andi.	%1,%0,%4\n"
+		"	bne-	1b\n"
+		"	ori	%1,%0,%4\n"
+		"	stdcx.	%1,0,%3\n"
+		"	bne-	1b"
+		: "=&r" (pte), "=&r" (tmp), "=m" (*p)
+		: "r" (p), "i" (_PAGE_BUSY)
+		: "cc");
+
+	if (pte_present(pte) && pte_write(pte)) {
+		pfn = pte_pfn(pte);
+		pte = pte_mkdirty(pte_mkyoung(pte));
+	}
+
+	*p = pte;	/* clears _PAGE_BUSY */
+
+	return pfn;
+}
+
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 93b7e04..f211643 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -32,6 +32,7 @@
 #include <linux/atomic.h>
 #include <asm/kvm_asm.h>
 #include <asm/processor.h>
+#include <asm/page.h>
 
 #define KVM_MAX_VCPUS		NR_CPUS
 #define KVM_MAX_VCORES		NR_CPUS
@@ -432,6 +433,7 @@ struct kvm_vcpu_arch {
 	struct list_head run_list;
 	struct task_struct *run_task;
 	struct kvm_run *kvm_run;
+	pgd_t *pgdir;
 #endif
 };
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 4d558c4..99187db 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -111,13 +111,15 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 	unsigned long npages;
 	unsigned long pfn;
 	unsigned long *hpte;
-	unsigned long addr, hash;
+	unsigned long addr, hash, hva;
 	unsigned long psize;
 	int porder;
 	struct revmap_entry *rev;
 	struct kvm_memory_slot *memslot;
 	unsigned long hp0, hp1;
 	unsigned long *pfns;
+	pte_t *p;
+	unsigned int shift;
 
 	memslot = &kvm->memslots->memslots[mem->slot];
 	pfns = kvm->arch.slot_pfns[mem->slot];
@@ -138,10 +140,26 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 		HPTE_R_R | HPTE_R_C | HPTE_R_M | PP_RWXX;
 
 	for (i = 0; i < npages; ++i) {
-		pfn = pfns[i];
-		if (!pfn)
-			continue;
 		addr = i << porder;
+		if (pfns) {
+			pfn = pfns[i];
+		} else {
+			pfn = 0;
+			local_irq_disable();
+			hva = addr + mem->userspace_addr;
+			p = find_linux_pte_or_hugepte(current->mm->pgd, hva,
+						      &shift);
+			if (p && (psize == PAGE_SIZE || shift == porder))
+				pfn = kvmppc_read_update_linux_pte(p);
+			local_irq_enable();
+		}
+
+		if (!pfn) {
+			pr_err("KVM: Couldn't find page for VRMA at %lx\n",
+			       addr);
+			break;
+		}
+
 		/* can't use hpt_hash since va > 64 bits */
 		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & HPT_HASH_MASK;
 		/*
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7434258..cb21845 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -868,6 +868,7 @@ int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	flush_altivec_to_thread(current);
 	flush_vsx_to_thread(current);
 	vcpu->arch.wqp = &vcpu->arch.vcore->wq;
+	vcpu->arch.pgdir = current->mm->pgd;
 
 	do {
 		r = kvmppc_run_vcpu(run, vcpu);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 5438442..1778091 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -59,37 +59,27 @@ static struct kvm_memory_slot *builtin_gfn_to_memslot(struct kvm *kvm,
 long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		    long pte_index, unsigned long pteh, unsigned long ptel)
 {
-	unsigned long porder;
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long i, pa, gpa, gfn, psize;
+	unsigned long slot_fn, hva;
 	unsigned long *hpte;
 	struct revmap_entry *rev;
 	unsigned long g_ptel = ptel;
 	struct kvm_memory_slot *memslot;
 	unsigned long *pfnp, pte_size;
+	unsigned long is_io;
+	pte_t *ptep;
+	unsigned int shift;
 
-	/* only handle 4k, 64k and 16M pages for now */
-	porder = 12;
-	if (pteh & HPTE_V_LARGE) {
-		if (cpu_has_feature(CPU_FTR_ARCH_206) &&
-		    (ptel & 0xf000) == 0x1000) {
-			/* 64k page */
-			porder = 16;
-		} else if ((ptel & 0xff000) == 0) {
-			/* 16M page */
-			porder = 24;
-			/* lowest AVA bit must be 0 for 16M pages */
-			if (pteh & 0x80)
-				return H_PARAMETER;
-		} else
-			return H_PARAMETER;
-	}
-	psize = (1ul << porder);
+	psize = hpte_page_size(pteh, ptel);
+	if (!psize)
+		return H_PARAMETER;
 
-	/* We do not allow the guest to set key 31 which is reserved
-	 * for MMIO emulation. We don't want to allow MMIO emulation
-	 * to be used to access RAM due to possible races between
-	 * emulation and TLB invalidations.
+	/*
+	 * We do not allow the guest to set key 31 which is reserved
+	 * for MMIO emulation and non-present RAM pages.  We don't want
+	 * to allow MMIO emulation to be used to access RAM due to possible
+	 * races between emulation and TLB invalidations.
 	 *
 	 * Emulated accesses are emulated by looking at the hash for
 	 * translation once, then performing the access later. The
@@ -106,66 +96,79 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	    (HPTE_R_KEY_HI | HPTE_R_KEY_LO))
 		return H_PARAMETER;
 
-	/* Figure out the type of page and handle accordingly,
-	 * first check for RAM pages
-	 */
+	/* Find the memslot (if any) for this address */
 	gpa = (ptel & HPTE_R_RPN) & ~(psize - 1);
 	gfn = gpa >> PAGE_SHIFT;
 	memslot = builtin_gfn_to_memslot(kvm, gfn);
+	pa = 0;
+	is_io = 1;
 	if (memslot && !(memslot->flags & KVM_MEMSLOT_INVALID)) {
-		unsigned long egfn = (gpa + psize) >> PAGE_SHIFT;
-
 		/* Check if the requested page fits entirely in the memslot. */
-		if ((egfn - memslot->base_gfn) > memslot->npages)
+		slot_fn = gfn - memslot->base_gfn;
+		if (slot_fn + (psize >> PAGE_SHIFT) > memslot->npages) 
 			return H_PARAMETER;
+		is_io = memslot->flags & KVM_MEMSLOT_IO;
 
-		/* Check for MMIO pass-through */
-		if (memslot->flags & KVM_MEMSLOT_IO) {
-			/* Check WIMG */
-			if ((ptel & HPTE_R_WIMG) != (HPTE_R_I) &&
-			    (ptel & HPTE_R_WIMG) != (HPTE_R_I | HPTE_R_G))
-				return H_PARAMETER;		
-		} else {
-			/* System RAM */
-			if (porder > kvm->arch.slot_page_order[memslot->id])
+		pfnp = kvmppc_pfn_entry(kvm, memslot, gfn);
+		if (pfnp) {
+			pte_size = 1ul << kvm->arch.slot_page_order[memslot->id];
+			if (!is_io && psize > pte_size)
 				return H_PARAMETER;
-
-			/* Check WIMG */
-			if ((ptel & HPTE_R_WIMG) != HPTE_R_M &&
-			    (ptel & HPTE_R_WIMG) != (HPTE_R_W | HPTE_R_I | HPTE_R_M))
+			pfnp = real_vmalloc_addr(pfnp);
+			pa = *pfnp << PAGE_SHIFT;
+			if (!pa)
 				return H_PARAMETER;
+		} else {
+			/* Translate to host virtual address */
+			hva = gfn_to_hva_memslot(memslot, gfn);
+
+			/* Look up the Linux PTE for the backing page */
+			ptep = find_linux_pte_or_hugepte(vcpu->arch.pgdir, hva,
+							 &shift);
+			if (ptep) {
+				if (shift)
+					pte_size = 1ul << shift;
+				else
+					pte_size = PAGE_SIZE;
+				if (pte_size < psize)
+					return H_PARAMETER;
+				pa = kvmppc_read_update_linux_pte(ptep);
+				pa <<= PAGE_SHIFT;
+			}
 		}
-		pfnp = kvmppc_pfn_entry(kvm, memslot, gfn);
-		if (!pfnp)
-			return H_PARAMETER;
-		pfnp = real_vmalloc_addr(pfnp);
-		pa = *pfnp << PAGE_SHIFT;
-		if (!pa)
-			return H_PARAMETER;
-		pte_size = 1ul << kvm->arch.slot_page_order[memslot->id];
-		pa |= gpa & (pte_size - 1);
+		if (pa && pte_size > psize)
+			pa |= gpa & (pte_size - 1);
 
 		/* check if the start pfn has page size alignment */
 		if (pa & (psize - 1))
 			return H_PARAMETER;
 		ptel &= ~(HPTE_R_PP0 - psize);
 		ptel |= pa;
-
+	}
+	pteh &= ~0x60UL;
+	
+	/* Check WIMG */
+	if (is_io) {
+		if ((ptel & HPTE_R_WIMG) != (HPTE_R_I) &&
+		    (ptel & HPTE_R_WIMG) != (HPTE_R_I | HPTE_R_G))
+			return H_PARAMETER;
 	} else {
-		/* Else check for MMIO emulation */
-		if (!cpu_has_feature(CPU_FTR_ARCH_206))
+		if ((ptel & HPTE_R_WIMG) != HPTE_R_M &&
+		    (ptel & HPTE_R_WIMG) != (HPTE_R_W | HPTE_R_I | HPTE_R_M))
 			return H_PARAMETER;
+	}
 
-		/* Leave RPN intact */
-		/* We force no-execute and set key to 1 to cause
-		 * faults on access.
-		 * XXX Should we instead just return H_PARAMETER if
-		 * N isn't already set ?
+	if (!pa) {
+		/*
+		 * If this is a non-present page for any reason
+		 * and this is a POWER7, set the key to 31 and set N.
+		 * On 970 we have to have all pages present.
 		 */
+		if (!cpu_has_feature(CPU_FTR_ARCH_206))
+			return H_PARAMETER;
 		ptel |= HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_R_N;
 	}
-	pteh &= ~0x60UL;
-	
+
 	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
 	if (likely((flags & H_EXACT) == 0)) {
@@ -190,10 +193,14 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
 	if (rev)
 		rev->guest_rpte = g_ptel;
+
 	hpte[1] = ptel;
+
+	/* Write the first HPTE dword, unlocking the HPTE and making it valid */
 	eieio();
 	hpte[0] = pteh;
 	asm volatile("ptesync" : : : "memory");
+
 	vcpu->arch.gpr[4] = pte_index;
 	return H_SUCCESS;
 }
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 0b9a5c1..701e920 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
+#include <linux/module.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -105,6 +106,7 @@ pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift
 		*shift = hugepd_shift(*hpdp);
 	return hugepte_offset(hpdp, ea, pdshift);
 }
+EXPORT_SYMBOL_GPL(find_linux_pte_or_hugepte);
 
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
-- 
1.7.7.2
