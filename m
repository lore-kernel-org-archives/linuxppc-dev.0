Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rHdhP2QNqzDqWm
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 May 2016 22:04:05 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, acsawdey@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc: Avoid load hit store when using
 find_linux_pte_or_hugepte()
Date: Sun, 29 May 2016 22:03:52 +1000
Message-Id: <1464523432-12605-3-git-send-email-anton@ozlabs.org>
In-Reply-To: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
References: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

In many cases we disable interrupts right before calling
find_linux_pte_or_hugepte().

find_linux_pte_or_hugepte() first checks interrupts are disabled
before calling __find_linux_pte_or_hugepte():

        if (!arch_irqs_disabled()) {
                pr_info("%s called with irq enabled\n", __func__);
                dump_stack();
        }
        return __find_linux_pte_or_hugepte(pgdir, ea, is_thp, shift);

We know interrupts are disabled, but since the arch_irqs_*() macros
are hidden from the compiler with inline assembly, gcc does not. We
end up with a pretty awful load hit store:

	li      r9,0
	lbz     r24,570(r13)
	stb     r9,570(r13)	<----
	lbz     r9,570(r13)	<---- ouch
	cmpdi   cr7,r9,0
	bne     cr7,c000000000049d30

Find these cases, and call __find_linux_pte_or_hugepte() directly.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 2 +-
 arch/powerpc/kvm/e500_mmu_host.c    | 2 +-
 arch/powerpc/mm/hash_utils_64.c     | 2 +-
 arch/powerpc/mm/hugetlbpage.c       | 2 +-
 arch/powerpc/mm/tlb_hash64.c        | 5 +++--
 arch/powerpc/perf/callchain.c       | 2 +-
 7 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 05f09ae..ff53db5 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -543,7 +543,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			 * hugepage split and collapse.
 			 */
 			local_irq_save(flags);
-			ptep = find_linux_pte_or_hugepte(current->mm->pgd,
+			ptep = __find_linux_pte_or_hugepte(current->mm->pgd,
 							 hva, NULL, NULL);
 			if (ptep) {
 				pte = kvmppc_read_update_linux_pte(ptep, 1);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 99b4e9d..8ee1f49 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -225,7 +225,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 						   &hpage_shift);
 	else {
 		local_irq_save(irq_flags);
-		ptep = find_linux_pte_or_hugepte(pgdir, hva, NULL,
+		ptep = __find_linux_pte_or_hugepte(pgdir, hva, NULL,
 						 &hpage_shift);
 	}
 	if (ptep) {
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index b0333cc..b6487f5 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -476,7 +476,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	 * can't run hence pfn won't change.
 	 */
 	local_irq_save(flags);
-	ptep = find_linux_pte_or_hugepte(pgdir, hva, NULL, NULL);
+	ptep = __find_linux_pte_or_hugepte(pgdir, hva, NULL, NULL);
 	if (ptep) {
 		pte_t pte = READ_ONCE(*ptep);
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5926896..5e47caa 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1384,7 +1384,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	 * THP pages use update_mmu_cache_pmd. We don't do
 	 * hash preload there. Hence can ignore THP here
 	 */
-	ptep = find_linux_pte_or_hugepte(pgdir, ea, NULL, &hugepage_shift);
+	ptep = __find_linux_pte_or_hugepte(pgdir, ea, NULL, &hugepage_shift);
 	if (!ptep)
 		goto out_exit;
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 5aac1a3..ee8bc5b 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -637,7 +637,7 @@ follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 	struct page *page = ERR_PTR(-EINVAL);
 
 	local_irq_save(flags);
-	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &is_thp, &shift);
+	ptep = __find_linux_pte_or_hugepte(mm->pgd, address, &is_thp, &shift);
 	if (!ptep)
 		goto no_page;
 	pte = READ_ONCE(*ptep);
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 4517aa4..f41bf3d 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -209,8 +209,9 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	local_irq_save(flags);
 	arch_enter_lazy_mmu_mode();
 	for (; start < end; start += PAGE_SIZE) {
-		pte_t *ptep = find_linux_pte_or_hugepte(mm->pgd, start, &is_thp,
-							&hugepage_shift);
+		pte_t *ptep = __find_linux_pte_or_hugepte(mm->pgd, start,
+							  &is_thp,
+							  &hugepage_shift);
 		unsigned long pte;
 
 		if (ptep == NULL)
diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 0fc2671..f4d1d88 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -127,7 +127,7 @@ static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 		return -EFAULT;
 
 	local_irq_save(flags);
-	ptep = find_linux_pte_or_hugepte(pgdir, addr, NULL, &shift);
+	ptep = __find_linux_pte_or_hugepte(pgdir, addr, NULL, &shift);
 	if (!ptep)
 		goto err_out;
 	if (!shift)
-- 
2.7.4
