Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRsXL27XgzDqj8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 19:26:42 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4G9NnLW133596
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 05:26:35 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afwhj3nh5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 05:26:35 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 May 2017 03:26:34 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/mm: Rename find_linux_pte_or_hugepte
Date: Tue, 16 May 2017 14:56:21 +0530
In-Reply-To: <1494926782-25700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1494926782-25700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1494926782-25700-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No functional change. Add newer helpers with addtional warnings and use those.
---
 arch/powerpc/include/asm/pgtable.h     | 10 +--------
 arch/powerpc/include/asm/pte-walk.h    | 38 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/eeh.c              |  4 ++--
 arch/powerpc/kernel/io-workarounds.c   |  5 +++--
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |  5 +++--
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 33 ++++++++++++++++-------------
 arch/powerpc/kvm/book3s_64_vio_hv.c    |  3 ++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c    | 12 ++++-------
 arch/powerpc/kvm/e500_mmu_host.c       |  3 ++-
 arch/powerpc/mm/hash_utils_64.c        |  5 +++--
 arch/powerpc/mm/hugetlbpage.c          | 24 ++++++++++++---------
 arch/powerpc/mm/tlb_hash64.c           |  6 ++++--
 arch/powerpc/perf/callchain.c          |  3 ++-
 13 files changed, 97 insertions(+), 54 deletions(-)
 create mode 100644 arch/powerpc/include/asm/pte-walk.h

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index dd01212935ac..9fa263ad7cb3 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -66,16 +66,8 @@ extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_large(pmd)		0
 #endif
-pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
-				   bool *is_thp, unsigned *shift);
-static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
-					       bool *is_thp, unsigned *shift)
-{
-	VM_WARN(!arch_irqs_disabled(),
-		"%s called with irq enabled\n", __func__);
-	return __find_linux_pte_or_hugepte(pgdir, ea, is_thp, shift);
-}
 
+/* can we use this in kvm */
 unsigned long vmalloc_to_phys(void *vmalloc_addr);
 
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
diff --git a/arch/powerpc/include/asm/pte-walk.h b/arch/powerpc/include/asm/pte-walk.h
new file mode 100644
index 000000000000..ea30c4ddd211
--- /dev/null
+++ b/arch/powerpc/include/asm/pte-walk.h
@@ -0,0 +1,38 @@
+#ifndef _ASM_POWERPC_PTE_WALK_H
+#define _ASM_POWERPC_PTE_WALK_H
+
+#ifndef __ASSEMBLY__
+#include <linux/sched.h>
+
+/* Don't use this directly */
+extern pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
+			       bool *is_thp, unsigned *hshift);
+
+static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea,
+				    bool *is_thp, unsigned *hshift)
+{
+	VM_WARN((!arch_irqs_disabled() && !__hard_irqs_disabled()) ,
+		"%s called with irq enabled\n", __func__);
+	return __find_linux_pte(pgdir, ea, is_thp, hshift);
+}
+
+static inline pte_t *find_init_mm_pte(unsigned long ea, unsigned *hshift)
+{
+	pgd_t *pgdir = init_mm.pgd;
+	return __find_linux_pte(pgdir, ea, NULL, hshift);
+}
+/*
+ * This is what we should always use. Any other lockless page table lookup needs
+ * careful audit against THP split.
+ */
+static inline pte_t *find_current_mm_pte(pgd_t *pgdir, unsigned long ea,
+					 bool *is_thp, unsigned *hshift)
+{
+	VM_WARN((!arch_irqs_disabled() && !__hard_irqs_disabled()) ,
+		"%s called with irq enabled\n", __func__);
+	VM_WARN(pgdir != current->mm->pgd,
+		"%s lock less page table lookup called on wrong mm\n", __func__);
+	return __find_linux_pte(pgdir, ea, is_thp, hshift);
+}
+#endif
+#endif
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 63992b2d8e15..5e6887c40528 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -44,6 +44,7 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 #include <asm/rtas.h>
+#include <asm/pte-walk.h>
 
 
 /** Overview:
@@ -352,8 +353,7 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 	 * worried about _PAGE_SPLITTING/collapse. Also we will not hit
 	 * page table free, because of init_mm.
 	 */
-	ptep = __find_linux_pte_or_hugepte(init_mm.pgd, token,
-					   NULL, &hugepage_shift);
+	ptep = find_init_mm_pte(token, &hugepage_shift);
 	if (!ptep)
 		return token;
 	WARN_ON(hugepage_shift);
diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
index a582e0d42525..bbe85f5aea71 100644
--- a/arch/powerpc/kernel/io-workarounds.c
+++ b/arch/powerpc/kernel/io-workarounds.c
@@ -19,6 +19,8 @@
 #include <asm/pgtable.h>
 #include <asm/ppc-pci.h>
 #include <asm/io-workarounds.h>
+#include <asm/pte-walk.h>
+
 
 #define IOWA_MAX_BUS	8
 
@@ -75,8 +77,7 @@ struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
 		 * We won't find huge pages here (iomem). Also can't hit
 		 * a page table free due to init_mm
 		 */
-		ptep = __find_linux_pte_or_hugepte(init_mm.pgd, vaddr,
-						   NULL, &hugepage_shift);
+		ptep = find_init_mm_pte(vaddr, &hugepage_shift);
 		if (ptep == NULL)
 			paddr = 0;
 		else {
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 8c68145ba1bd..f8f60f5e3aca 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -37,6 +37,7 @@
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
 #include <asm/cputable.h>
+#include <asm/pte-walk.h>
 
 #include "trace_hv.h"
 
@@ -597,8 +598,8 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			 * hugepage split and collapse.
 			 */
 			local_irq_save(flags);
-			ptep = find_linux_pte_or_hugepte(current->mm->pgd,
-							 hva, NULL, NULL);
+			ptep = find_current_mm_pte(current->mm->pgd,
+						   hva, NULL, NULL);
 			if (ptep) {
 				pte = kvmppc_read_update_linux_pte(ptep, 1);
 				if (__pte_write(pte))
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index f6b3e67c5762..dcd9e975c3d3 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -17,6 +17,7 @@
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
+#include <asm/pte-walk.h>
 
 /*
  * Supported radix tree geometry.
@@ -359,8 +360,7 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		if (writing)
 			pgflags |= _PAGE_DIRTY;
 		local_irq_save(flags);
-		ptep = __find_linux_pte_or_hugepte(current->mm->pgd, hva,
-						   NULL, NULL);
+		ptep = find_current_mm_pte(current->mm->pgd, hva, NULL, NULL);
 		if (ptep) {
 			pte = READ_ONCE(*ptep);
 			if (pte_present(pte) &&
@@ -374,8 +374,16 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				spin_unlock(&kvm->mmu_lock);
 				return RESUME_GUEST;
 			}
-			ptep = __find_linux_pte_or_hugepte(kvm->arch.pgtable,
-							gpa, NULL, &shift);
+			/*
+			 * it is ok to do the lookup with arch.pgtable here, because
+			 * we are doing this on secondary cpus and current task there
+			 * is not the hypervisor. Also this is safe against THP in the
+			 * host, because an IPI to primary thread will wait for the secondary
+			 * to exit which will agains result in the below page table walk
+			 * to finish.
+			 */
+			ptep = find_linux_pte(kvm->arch.pgtable,
+					      gpa, NULL, &shift);
 			if (ptep && pte_present(*ptep)) {
 				kvmppc_radix_update_pte(kvm, ptep, 0, pgflags,
 							gpa, shift);
@@ -427,8 +435,8 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			pgflags |= _PAGE_WRITE;
 		} else {
 			local_irq_save(flags);
-			ptep = __find_linux_pte_or_hugepte(current->mm->pgd,
-							hva, NULL, NULL);
+			ptep = find_current_mm_pte(current->mm->pgd,
+						   hva, NULL, NULL);
 			if (ptep && pte_write(*ptep) && pte_dirty(*ptep))
 				pgflags |= _PAGE_WRITE;
 			local_irq_restore(flags);
@@ -499,8 +507,8 @@ int kvm_unmap_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	unsigned int shift;
 	unsigned long old;
 
-	ptep = __find_linux_pte_or_hugepte(kvm->arch.pgtable, gpa,
-					   NULL, &shift);
+	/* is that safe ? */
+	ptep = find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep)) {
 		old = kvmppc_radix_update_pte(kvm, ptep, _PAGE_PRESENT, 0,
 					      gpa, shift);
@@ -525,8 +533,7 @@ int kvm_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	unsigned int shift;
 	int ref = 0;
 
-	ptep = __find_linux_pte_or_hugepte(kvm->arch.pgtable, gpa,
-					   NULL, &shift);
+	ptep = find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep) && pte_young(*ptep)) {
 		kvmppc_radix_update_pte(kvm, ptep, _PAGE_ACCESSED, 0,
 					gpa, shift);
@@ -545,8 +552,7 @@ int kvm_test_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	unsigned int shift;
 	int ref = 0;
 
-	ptep = __find_linux_pte_or_hugepte(kvm->arch.pgtable, gpa,
-					   NULL, &shift);
+	ptep = find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep) && pte_young(*ptep))
 		ref = 1;
 	return ref;
@@ -562,8 +568,7 @@ static int kvm_radix_test_clear_dirty(struct kvm *kvm,
 	unsigned int shift;
 	int ret = 0;
 
-	ptep = __find_linux_pte_or_hugepte(kvm->arch.pgtable, gpa,
-					   NULL, &shift);
+	ptep = find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep) && pte_dirty(*ptep)) {
 		ret = 1;
 		if (shift)
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index e4c4ea973e57..2ac2c0daddff 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -39,6 +39,7 @@
 #include <asm/udbg.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
+#include <asm/pte-walk.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
@@ -210,7 +211,7 @@ static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
 	pte_t *ptep, pte;
 	unsigned shift = 0;
 
-	ptep = __find_linux_pte_or_hugepte(vcpu->arch.pgdir, ua, NULL, &shift);
+	ptep = find_linux_pte(vcpu->arch.pgdir, ua, NULL, &shift);
 	if (!ptep || !pte_present(*ptep))
 		return -ENXIO;
 	pte = *ptep;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index ce6f2121fffe..f8bfd947fe90 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -21,6 +21,7 @@
 #include <asm/hvcall.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
+#include <asm/pte-walk.h>
 
 /* Translate address of a vmalloc'd thing to a linear map address */
 static void *real_vmalloc_addr(void *x)
@@ -32,7 +33,7 @@ static void *real_vmalloc_addr(void *x)
 	 * So don't worry about THP collapse/split. Called
 	 * Only in realmode, hence won't need irq_save/restore.
 	 */
-	p = __find_linux_pte_or_hugepte(swapper_pg_dir, addr, NULL, NULL);
+	p = find_init_mm_pte(addr, NULL);
 	if (!p || !pte_present(*p))
 		return NULL;
 	addr = (pte_pfn(*p) << PAGE_SHIFT) | (addr & ~PAGE_MASK);
@@ -229,14 +230,9 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	 * If we had a page table table change after lookup, we would
 	 * retry via mmu_notifier_retry.
 	 */
-	if (realmode)
-		ptep = __find_linux_pte_or_hugepte(pgdir, hva, NULL,
-						   &hpage_shift);
-	else {
+	if (!realmode)
 		local_irq_save(irq_flags);
-		ptep = find_linux_pte_or_hugepte(pgdir, hva, NULL,
-						 &hpage_shift);
-	}
+	ptep = find_linux_pte(pgdir, hva, NULL, &hpage_shift);
 	if (ptep) {
 		pte_t pte;
 		unsigned int host_pte_size;
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 0fda4230f6c0..3284b2c2c865 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -30,6 +30,7 @@
 #include <linux/vmalloc.h>
 #include <linux/hugetlb.h>
 #include <asm/kvm_ppc.h>
+#include <asm/pte-walk.h>
 
 #include "e500.h"
 #include "timing.h"
@@ -476,7 +477,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	 * can't run hence pfn won't change.
 	 */
 	local_irq_save(flags);
-	ptep = find_linux_pte_or_hugepte(pgdir, hva, NULL, NULL);
+	ptep = find_linux_pte(pgdir, hva, NULL, NULL);
 	if (ptep) {
 		pte_t pte = READ_ONCE(*ptep);
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f2095ce9d4b0..2e5e04933350 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -61,6 +61,7 @@
 #include <asm/tm.h>
 #include <asm/trace.h>
 #include <asm/ps3.h>
+#include <asm/pte-walk.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -1295,7 +1296,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 #endif /* CONFIG_PPC_64K_PAGES */
 
 	/* Get PTE and page size from page tables */
-	ptep = __find_linux_pte_or_hugepte(pgdir, ea, &is_thp, &hugeshift);
+	ptep = find_linux_pte(pgdir, ea, &is_thp, &hugeshift);
 	if (ptep == NULL || !pte_present(*ptep)) {
 		DBG_LOW(" no PTE !\n");
 		rc = 1;
@@ -1524,7 +1525,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	 * THP pages use update_mmu_cache_pmd. We don't do
 	 * hash preload there. Hence can ignore THP here
 	 */
-	ptep = find_linux_pte_or_hugepte(pgdir, ea, NULL, &hugepage_shift);
+	ptep = find_current_mm_pte(pgdir, ea, NULL, &hugepage_shift);
 	if (!ptep)
 		goto out_exit;
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 4ebaa18f2495..a2ed4084e578 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -25,6 +25,8 @@
 #include <asm/tlb.h>
 #include <asm/setup.h>
 #include <asm/hugetlb.h>
+#include <asm/pte-walk.h>
+
 
 #ifdef CONFIG_HUGETLB_PAGE
 
@@ -60,8 +62,11 @@ static unsigned nr_gpages;
 
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
-	/* Only called for hugetlbfs pages, hence can ignore THP */
-	return __find_linux_pte_or_hugepte(mm->pgd, addr, NULL, NULL);
+	/*
+	 * Only called for hugetlbfs pages, hence can ignore THP and the
+	 * irq disabled walk.
+	 */
+	return __find_linux_pte(mm->pgd, addr, NULL, NULL);
 }
 
 static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
@@ -963,9 +968,8 @@ void flush_dcache_icache_hugepage(struct page *page)
  * This function need to be called with interrupts disabled. We use this variant
  * when we have MSR[EE] = 0 but the paca->soft_enabled = 1
  */
-
-pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
-				   bool *is_thp, unsigned *shift)
+pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
+			bool *is_thp, unsigned *hpage_shift)
 {
 	pgd_t pgd, *pgdp;
 	pud_t pud, *pudp;
@@ -974,8 +978,8 @@ pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 	hugepd_t *hpdp = NULL;
 	unsigned pdshift = PGDIR_SHIFT;
 
-	if (shift)
-		*shift = 0;
+	if (hpage_shift)
+		*hpage_shift = 0;
 
 	if (is_thp)
 		*is_thp = false;
@@ -1045,11 +1049,11 @@ pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 	ret_pte = hugepte_offset(*hpdp, ea, pdshift);
 	pdshift = hugepd_shift(*hpdp);
 out:
-	if (shift)
-		*shift = pdshift;
+	if (hpage_shift)
+		*hpage_shift = pdshift;
 	return ret_pte;
 }
-EXPORT_SYMBOL_GPL(__find_linux_pte_or_hugepte);
+EXPORT_SYMBOL_GPL(__find_linux_pte);
 
 int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		unsigned long end, int write, struct page **pages, int *nr)
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 4517aa43a8b1..b3e6116b4317 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -29,6 +29,8 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <asm/bug.h>
+#include <asm/pte-walk.h>
+
 
 #include <trace/events/thp.h>
 
@@ -209,8 +211,8 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	local_irq_save(flags);
 	arch_enter_lazy_mmu_mode();
 	for (; start < end; start += PAGE_SIZE) {
-		pte_t *ptep = find_linux_pte_or_hugepte(mm->pgd, start, &is_thp,
-							&hugepage_shift);
+		pte_t *ptep = find_current_mm_pte(mm->pgd, start, &is_thp,
+						  &hugepage_shift);
 		unsigned long pte;
 
 		if (ptep == NULL)
diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 0fc26714780a..0af051a1974e 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -22,6 +22,7 @@
 #ifdef CONFIG_PPC64
 #include "../kernel/ppc32.h"
 #endif
+#include <asm/pte-walk.h>
 
 
 /*
@@ -127,7 +128,7 @@ static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 		return -EFAULT;
 
 	local_irq_save(flags);
-	ptep = find_linux_pte_or_hugepte(pgdir, addr, NULL, &shift);
+	ptep = find_current_mm_pte(pgdir, addr, NULL, &shift);
 	if (!ptep)
 		goto err_out;
 	if (!shift)
-- 
2.7.4
