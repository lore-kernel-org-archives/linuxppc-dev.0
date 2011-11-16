Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Nov 2011 09:58:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 04/11] KVM: PPC: Remove io_slot_pfn array
Message-ID: <20111116225839.GE26985@bloggs.ozlabs.ibm.com>
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

This stores the PFNs for I/O mappings in the slot->rmap array, as is
now done for system RAM.  This simplifies the h_enter code and allows
us to remove the io_slot_pfn array.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_host.h |    2 --
 arch/powerpc/kvm/book3s_hv.c        |   16 +++++++++-------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c |   22 +++++++++++-----------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 52fd741..e0751e5 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -188,8 +188,6 @@ struct kvm_arch {
 	struct list_head spapr_tce_tables;
 	unsigned short last_vcpu[NR_CPUS];
 	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
-	unsigned long io_slot_pfn[KVM_MEMORY_SLOTS +
-				  KVM_PRIVATE_MEM_SLOTS];
 #endif /* CONFIG_KVM_BOOK3S_64_HV */
 };
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index bc512ef..48a0648 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1078,7 +1078,7 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 	struct kvmppc_rma_info *ri = NULL;
 	struct vm_area_struct *vma;
 	struct page *page;
-	unsigned long hva;
+	unsigned long hva, pfn;
 	unsigned long lpcr;
 
 	/*
@@ -1092,6 +1092,8 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 	if (!vma || vma->vm_start > mem->userspace_addr)
 		goto err_unlock;
 
+	npages = mem->memory_size >> PAGE_SHIFT;
+
 	/* For now require the memory to be in one vma */
 	if (mem->userspace_addr + mem->memory_size > vma->vm_end) {
 		pr_err("not one vma %llx > %lx\n",
@@ -1114,15 +1116,16 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 		if ((vma->vm_flags & (VM_READ | VM_WRITE)) !=
 		    (VM_READ | VM_WRITE))
 			goto err_unlock;
+		up_read(&current->mm->mmap_sem);
 
 		/*
-		 * Tag the memslot with a private flag and store the pfn
-		 * in a separate array for use by H_ENTER
+		 * Tag the memslot with a private flag and store the pfns
+		 * in the rmap array.
 		 */
 		memslot->flags |= KVM_MEMSLOT_IO;
-		kvm->arch.io_slot_pfn[memslot->id] =
-			vma->vm_pgoff + (offset >> PAGE_SHIFT);
-		up_read(&current->mm->mmap_sem);
+		pfn = vma->vm_pgoff + (offset >> PAGE_SHIFT);
+		for (i = 0; i < npages; ++i)
+			memslot->rmap[i] = pfn++;
 		return 0;
 	}
 
@@ -1218,7 +1221,6 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 			ri->base_pfn << PAGE_SHIFT, rma_size, lpcr);
 	}
 
-	npages = mem->memory_size >> PAGE_SHIFT;
 	for (i = 0; i < npages; ++i) {
 		hva = mem->userspace_addr + (i << PAGE_SHIFT);
 		page = hva_to_page(hva);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index b82da85..5a84791 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -121,12 +121,6 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 
 		/* Check for MMIO pass-through */
 		if (memslot->flags & KVM_MEMSLOT_IO) {
-			/* check if the start pfn has page size alignment */
-			pa = kvm->arch.io_slot_pfn[memslot->id] << PAGE_SHIFT;
-			pa += gpa - (memslot->base_gfn << PAGE_SHIFT);
-			if (pa & (psize - 1))
-				return H_PARAMETER;
-
 			/* Check WIMG */
 			if ((ptel & HPTE_R_WIMG) != (HPTE_R_I) &&
 			    (ptel & HPTE_R_WIMG) != (HPTE_R_I | HPTE_R_G))
@@ -135,17 +129,23 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			/* System RAM */
 			if (porder > kvm->arch.ram_porder)
 				return H_PARAMETER;
-			rmap_entry = &memslot->rmap[gfn - memslot->base_gfn];
-			rmap_entry = real_vmalloc_addr(rmap_entry);
-			pa = *rmap_entry << PAGE_SHIFT;
-			if (!pa)
-				return H_PARAMETER;
 
 			/* Check WIMG */
 			if ((ptel & HPTE_R_WIMG) != HPTE_R_M &&
 			    (ptel & HPTE_R_WIMG) != (HPTE_R_W | HPTE_R_I | HPTE_R_M))
 				return H_PARAMETER;
 		}
+		rmap_entry = &memslot->rmap[gfn - memslot->base_gfn];
+		rmap_entry = real_vmalloc_addr(rmap_entry);
+		if (!rmap_entry)
+			return H_PARAMETER;
+		pa = *rmap_entry << PAGE_SHIFT;
+		if (!pa)
+			return H_PARAMETER;
+
+		/* check if the start pfn has page size alignment */
+		if (pa & (psize - 1))
+			return H_PARAMETER;
 		ptel &= ~(HPTE_R_PP0 - psize);
 		ptel |= pa;
 
-- 
1.7.7.2
