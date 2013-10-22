Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26DA12C034B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 22:41:40 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 22 Oct 2013 17:11:38 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4B3918E9263
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 17:00:08 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9MBVRbo19136528
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 17:01:27 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9MBSZJk023230
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 16:58:35 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, linux-mm@kvack.org
Subject: [RFC PATCH 7/9] mm: numafaults: Use change_pmd_protnuma for updating
 _PAGE_NUMA for regular pmds
Date: Tue, 22 Oct 2013 16:58:18 +0530
Message-Id: <1382441300-1513-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1382441300-1513-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1382441300-1513-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Archs like ppc64 have different layout for pmd entries pointing to PTE
page. Hence add a separate function for modifying them

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable.h | 17 +++++++++++++++++
 include/asm-generic/pgtable.h      | 20 ++++++++++++++++++++
 mm/memory.c                        |  2 +-
 mm/mprotect.c                      | 24 ++++++------------------
 4 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 9d87125..67ea8fb 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -75,6 +75,23 @@ static inline pte_t pte_mknuma(pte_t pte)
 	return pte;
 }
 
+#define change_pmd_protnuma change_pmd_protnuma
+static inline void change_pmd_protnuma(struct mm_struct *mm, unsigned long addr,
+				       pmd_t *pmdp, int prot_numa)
+{
+	/*
+	 * We don't track the _PAGE_PRESENT bit here
+	 */
+	unsigned long pmd_val;
+	pmd_val = pmd_val(*pmdp);
+	if (prot_numa)
+		pmd_val |= _PAGE_NUMA;
+	else
+		pmd_val &= ~_PAGE_NUMA;
+	pmd_set(pmdp, pmd_val | _PAGE_NUMA);
+}
+
+
 #define pmd_numa pmd_numa
 static inline int pmd_numa(pmd_t pmd)
 {
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index f330d28..568a8c4 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -697,6 +697,18 @@ static inline pmd_t pmd_mknuma(pmd_t pmd)
 	return pmd_clear_flags(pmd, _PAGE_PRESENT);
 }
 #endif
+
+#ifndef change_pmd_protnuma
+static inline void change_pmd_protnuma(struct mm_struct *mm, unsigned long addr,
+				       pmd_t *pmd, int prot_numa)
+{
+	if (prot_numa)
+		set_pmd_at(mm, addr & PMD_MASK, pmd, pmd_mknuma(*pmd));
+	else
+		set_pmd_at(mm, addr & PMD_MASK, pmd, pmd_mknonnuma(*pmd));
+}
+
+#endif
 #else
 extern int pte_numa(pte_t pte);
 extern int pmd_numa(pmd_t pmd);
@@ -704,6 +716,8 @@ extern pte_t pte_mknonnuma(pte_t pte);
 extern pmd_t pmd_mknonnuma(pmd_t pmd);
 extern pte_t pte_mknuma(pte_t pte);
 extern pmd_t pmd_mknuma(pmd_t pmd);
+extern void change_pmd_protnuma(struct mm_struct *mm, unsigned long addr,
+				pmd_t *pmd, int prot_numa);
 #endif /* CONFIG_ARCH_USES_NUMA_PROT_NONE */
 #else
 static inline int pmd_numa(pmd_t pmd)
@@ -735,6 +749,12 @@ static inline pmd_t pmd_mknuma(pmd_t pmd)
 {
 	return pmd;
 }
+
+static inline void change_pmd_protnuma(struct mm_struct *mm, unsigned long addr,
+				       pmd_t *pmd, int prot_numa)
+{
+	BUG();
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #endif /* CONFIG_MMU */
diff --git a/mm/memory.c b/mm/memory.c
index ca00039..e930e50 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3605,7 +3605,7 @@ static int do_pmd_numa_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_lock(&mm->page_table_lock);
 	pmd = *pmdp;
 	if (pmd_numa(pmd)) {
-		set_pmd_at(mm, _addr, pmdp, pmd_mknonnuma(pmd));
+		change_pmd_protnuma(mm, _addr, pmdp, 0);
 		numa = true;
 	}
 	spin_unlock(&mm->page_table_lock);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 94722a4..88de575 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -112,22 +112,6 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	return pages;
 }
 
-#ifdef CONFIG_NUMA_BALANCING
-static inline void change_pmd_protnuma(struct mm_struct *mm, unsigned long addr,
-				       pmd_t *pmd)
-{
-	spin_lock(&mm->page_table_lock);
-	set_pmd_at(mm, addr & PMD_MASK, pmd, pmd_mknuma(*pmd));
-	spin_unlock(&mm->page_table_lock);
-}
-#else
-static inline void change_pmd_protnuma(struct mm_struct *mm, unsigned long addr,
-				       pmd_t *pmd)
-{
-	BUG();
-}
-#endif /* CONFIG_NUMA_BALANCING */
-
 static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, int dirty_accountable, int prot_numa)
@@ -161,8 +145,12 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		 * node. This allows a regular PMD to be handled as one fault
 		 * and effectively batches the taking of the PTL
 		 */
-		if (prot_numa && all_same_node)
-			change_pmd_protnuma(vma->vm_mm, addr, pmd);
+		if (prot_numa && all_same_node) {
+			spin_lock(&vma->vm_mm->page_table_lock);
+			change_pmd_protnuma(vma->vm_mm, addr, pmd, 1);
+			spin_unlock(&vma->vm_mm->page_table_lock);
+
+		}
 	} while (pmd++, addr = next, addr != end);
 
 	return pages;
-- 
1.8.3.2
