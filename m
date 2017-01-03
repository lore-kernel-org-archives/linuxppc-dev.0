Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttQrw5RT5zDqFr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 07:43:44 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v03Kceva049682
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jan 2017 15:43:42 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27rcgt2h98-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jan 2017 15:43:42 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Tue, 3 Jan 2017 13:43:41 -0700
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: [PATCH v4 3/4] powerpc/mm: add radix__remove_section_mapping()
Date: Tue,  3 Jan 2017 14:43:37 -0600
In-Reply-To: <1483476218-17271-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1483476218-17271-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1483476218-17271-4-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tear down and free the four-level page tables of physical mappings
during memory hotremove.

Borrow the basic structure of remove_pagetable() and friends from the
identically-named x86 functions. Simplify things a bit so locking and
tlb flushing are only done in the outermost function.

Memory must be offline to be removed, thus not in use. So there
shouldn't be the sort of concurrent page walking activity here that
might prompt us to use RCU.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |   1 +
 arch/powerpc/mm/pgtable-book3s64.c         |   2 +-
 arch/powerpc/mm/pgtable-radix.c            | 149 +++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 43c2571..0032b66 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -294,6 +294,7 @@ static inline unsigned long radix__get_tree_size(void)
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 int radix__create_section_mapping(unsigned long start, unsigned long end);
+int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #endif /* CONFIG_MEMORY_HOTPLUG */
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 2b13f6b..b798ff6 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -139,7 +139,7 @@ int create_section_mapping(unsigned long start, unsigned long end)
 int remove_section_mapping(unsigned long start, unsigned long end)
 {
 	if (radix_enabled())
-		return -ENODEV;
+		return radix__remove_section_mapping(start, end);
 
 	return hash__remove_section_mapping(start, end);
 }
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 3588895..f7a8e625 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -457,10 +457,159 @@ void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+static void free_pte_table(pte_t *pte_start, pmd_t *pmd)
+{
+	pte_t *pte;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		pte = pte_start + i;
+		if (!pte_none(*pte))
+			return;
+	}
+
+	pte_free_kernel(&init_mm, pte_start);
+	pmd_clear(pmd);
+}
+
+static void free_pmd_table(pmd_t *pmd_start, pud_t *pud)
+{
+	pmd_t *pmd;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		pmd = pmd_start + i;
+		if (!pmd_none(*pmd))
+			return;
+	}
+
+	pmd_free(&init_mm, pmd_start);
+	pud_clear(pud);
+}
+
+static void free_pud_table(pud_t *pud_start, pgd_t *pgd)
+{
+	pud_t *pud;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		pud = pud_start + i;
+		if (!pud_none(*pud))
+			return;
+	}
+
+	pud_free(&init_mm, pud_start);
+	pgd_clear(pgd);
+}
+
+static void remove_pte_table(pte_t *pte_start, unsigned long addr,
+			     unsigned long end)
+{
+	unsigned long next;
+	pte_t *pte;
+
+	pte = pte_start + pte_index(addr);
+	for (; addr < end; addr = next, pte++) {
+		next = (addr + PAGE_SIZE) & PAGE_MASK;
+		if (next > end)
+			next = end;
+
+		if (!pte_present(*pte))
+			continue;
+
+		pte_clear(&init_mm, addr, pte);
+	}
+}
+
+static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
+			     unsigned long end)
+{
+	unsigned long next;
+	pte_t *pte_base;
+	pmd_t *pmd;
+
+	pmd = pmd_start + pmd_index(addr);
+	for (; addr < end; addr = next, pmd++) {
+		next = pmd_addr_end(addr, end);
+
+		if (!pmd_present(*pmd))
+			continue;
+
+		if (pmd_huge(*pmd)) {
+			pte_clear(&init_mm, addr, (pte_t *)pmd);
+			continue;
+		}
+
+		pte_base = (pte_t *)pmd_page_vaddr(*pmd);
+		remove_pte_table(pte_base, addr, next);
+		free_pte_table(pte_base, pmd);
+	}
+}
+
+static void remove_pud_table(pud_t *pud_start, unsigned long addr,
+			     unsigned long end)
+{
+	unsigned long next;
+	pmd_t *pmd_base;
+	pud_t *pud;
+
+	pud = pud_start + pud_index(addr);
+	for (; addr < end; addr = next, pud++) {
+		next = pud_addr_end(addr, end);
+
+		if (!pud_present(*pud))
+			continue;
+
+		if (pud_huge(*pud)) {
+			pte_clear(&init_mm, addr, (pte_t *)pud);
+			continue;
+		}
+
+		pmd_base = (pmd_t *)pud_page_vaddr(*pud);
+		remove_pmd_table(pmd_base, addr, next);
+		free_pmd_table(pmd_base, pud);
+	}
+}
+
+static void remove_pagetable(unsigned long start, unsigned long end)
+{
+	unsigned long addr, next;
+	pud_t *pud_base;
+	pgd_t *pgd;
+
+	spin_lock(&init_mm.page_table_lock);
+
+	for (addr = start; addr < end; addr = next) {
+		next = pgd_addr_end(addr, end);
+
+		pgd = pgd_offset_k(addr);
+		if (!pgd_present(*pgd))
+			continue;
+
+		if (pgd_huge(*pgd)) {
+			pte_clear(&init_mm, addr, (pte_t *)pgd);
+			continue;
+		}
+
+		pud_base = (pud_t *)pgd_page_vaddr(*pgd);
+		remove_pud_table(pud_base, addr, next);
+		free_pud_table(pud_base, pgd);
+	}
+
+	spin_unlock(&init_mm.page_table_lock);
+	flush_tlb_kernel_range(start, end);
+}
+
 int __ref radix__create_section_mapping(unsigned long start, unsigned long end)
 {
 	return create_physical_mapping(start, end);
 }
+
+int radix__remove_section_mapping(unsigned long start, unsigned long end)
+{
+	remove_pagetable(start, end);
+	return 0;
+}
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-- 
1.8.3.1
