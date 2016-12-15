Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfkZh5g5gzDw8v
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 06:50:52 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBFJn826043192
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 14:50:50 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27bdmg6wus-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 14:50:49 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 15 Dec 2016 12:50:47 -0700
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: [PATCH v3 4/5] powerpc/mm: add radix__remove_section_mapping()
Date: Thu, 15 Dec 2016 13:50:42 -0600
In-Reply-To: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1481831443-22761-5-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tear down and free the four-level page tables of the linear mapping
during memory hotremove.

We borrow the basic structure of remove_pagetable() and friends from the
identically-named x86 functions.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |   1 +
 arch/powerpc/mm/pgtable-book3s64.c         |   2 +-
 arch/powerpc/mm/pgtable-radix.c            | 163 +++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 1 deletion(-)

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
index 8201d1f..315237c 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -466,6 +466,159 @@ void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
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
+	spin_lock(&init_mm.page_table_lock);
+	pmd_clear(pmd);
+	spin_unlock(&init_mm.page_table_lock);
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
+	spin_lock(&init_mm.page_table_lock);
+	pud_clear(pud);
+	spin_unlock(&init_mm.page_table_lock);
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
+	spin_lock(&init_mm.page_table_lock);
+	pgd_clear(pgd);
+	spin_unlock(&init_mm.page_table_lock);
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
+		spin_lock(&init_mm.page_table_lock);
+		pte_clear(&init_mm, addr, pte);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+
+	flush_tlb_mm(&init_mm);
+}
+
+static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
+			     unsigned long end, unsigned long map_page_size)
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
+		if (map_page_size == PMD_SIZE) {
+			spin_lock(&init_mm.page_table_lock);
+			pte_clear(&init_mm, addr, (pte_t *)pmd);
+			spin_unlock(&init_mm.page_table_lock);
+
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
+			     unsigned long end, unsigned long map_page_size)
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
+		if (map_page_size == PUD_SIZE) {
+			spin_lock(&init_mm.page_table_lock);
+			pte_clear(&init_mm, addr, (pte_t *)pud);
+			spin_unlock(&init_mm.page_table_lock);
+
+			continue;
+		}
+
+		pmd_base = (pmd_t *)pud_page_vaddr(*pud);
+		remove_pmd_table(pmd_base, addr, next, map_page_size);
+		free_pmd_table(pmd_base, pud);
+	}
+}
+
+static void remove_pagetable(unsigned long start, unsigned long end,
+			     unsigned long map_page_size)
+{
+	unsigned long next;
+	unsigned long addr;
+	pgd_t *pgd;
+	pud_t *pud;
+
+	for (addr = start; addr < end; addr = next) {
+		next = pgd_addr_end(addr, end);
+
+		pgd = pgd_offset_k(addr);
+		if (!pgd_present(*pgd))
+			continue;
+
+		pud = (pud_t *)pgd_page_vaddr(*pgd);
+		remove_pud_table(pud, addr, next, map_page_size);
+		free_pud_table(pud, pgd);
+	}
+
+	flush_tlb_mm(&init_mm);
+}
+
 int radix__create_section_mapping(unsigned long start, unsigned long end)
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_linear_psize].shift;
@@ -482,6 +635,16 @@ int radix__create_section_mapping(unsigned long start, unsigned long end)
 
 	return 0;
 }
+
+int radix__remove_section_mapping(unsigned long start, unsigned long end)
+{
+	unsigned long page_size = 1 << mmu_psize_defs[mmu_linear_psize].shift;
+
+	start = _ALIGN_DOWN(start, page_size);
+	remove_pagetable(start, end, page_size);
+
+	return 0;
+}
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-- 
1.8.3.1
