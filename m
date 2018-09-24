Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JdZn0ZxFzF13T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 19:05:20 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8O95HUD065673
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 05:05:18 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mpu70mfs9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 05:05:18 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 24 Sep 2018 03:05:06 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 3/5] arch/powerpc/mm: Nest MMU workaround for
 mprotect/autonuma RW upgrade.
Date: Mon, 24 Sep 2018 14:34:16 +0530
In-Reply-To: <20180924090418.31282-1-aneesh.kumar@linux.ibm.com>
References: <20180924090418.31282-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180924090418.31282-4-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NestMMU requires us to mark the pte invalid and flush the tlb when we do a
RW upgrade of pte. We fixed a variant of this in the fault path in commit
Fixes: bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")

Do the same for mprotect and autonuma upgrades.

Hugetlb is handled in the next patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 18 +++++++++++
 arch/powerpc/mm/pgtable-book3s64.c           | 34 ++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 13a688fc8cd0..5b4ac83a5649 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1291,6 +1291,24 @@ static inline const int pud_pfn(pud_t pud)
 	BUILD_BUG();
 	return 0;
 }
+#define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
+pte_t ptep_modify_prot_start(struct vm_area_struct *, unsigned long, pte_t *);
+void ptep_modify_prot_commit(struct vm_area_struct *, unsigned long,
+			     pte_t *, pte_t, pte_t);
+
+/*
+ * Returns true for a Read or Write upgrade of pte.
+ */
+static inline bool is_pte_upgrade(unsigned long old_val, unsigned long new_val)
+{
+	if ((!(old_val & _PAGE_READ)) && (new_val & _PAGE_READ))
+		return true;
+
+	if ((!(old_val & _PAGE_WRITE)) && (new_val & _PAGE_WRITE))
+		return true;
+
+	return false;
+}
 
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 01d7c0f7c4f0..243a7cb1bdba 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -477,3 +477,37 @@ void arch_report_meminfo(struct seq_file *m)
 		   atomic_long_read(&direct_pages_count[MMU_PAGE_1G]) << 20);
 }
 #endif /* CONFIG_PROC_FS */
+
+pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr,
+			     pte_t *ptep)
+{
+	unsigned long pte_val;
+
+	/*
+	 * Clear the _PAGE_PRESENT so that no hardware parallel update is
+	 * possible. Also keep the pte_present true so that we don't take
+	 * wrong fault.
+	 */
+	pte_val = pte_update(vma->vm_mm, addr, ptep, _PAGE_PRESENT, _PAGE_INVALID, 0);
+
+	return __pte(pte_val);
+
+}
+EXPORT_SYMBOL(ptep_modify_prot_start);
+
+void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
+			     pte_t *ptep, pte_t old_pte, pte_t pte)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	/*
+	 * To avoid NMMU hang while relaxing access we need to flush the tlb before
+	 * we set the new value.
+	 */
+	if (is_pte_upgrade(pte_val(old_pte), pte_val(pte)) &&
+	    (atomic_read(&mm->context.copros) > 0))
+		flush_tlb_page(vma, addr);
+
+	set_pte_at(mm, addr, ptep, pte);
+}
+EXPORT_SYMBOL(ptep_modify_prot_commit);
-- 
2.17.1
