Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s464j0mtXzDqSY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:41:57 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 09/15] powerpc/mmu: Add real mode support for IOMMU
 preregistered memory
Date: Wed,  3 Aug 2016 18:40:50 +1000
Message-Id: <1470213656-1042-10-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes mm_iommu_lookup() able to work in realmode by replacing
list_for_each_entry_rcu() (which can do debug stuff which can fail in
real mode) with list_for_each_entry_lockless().

This adds realmode version of mm_iommu_ua_to_hpa() which adds
explicit vmalloc'd-to-linear address conversion.
Unlike mm_iommu_ua_to_hpa(), mm_iommu_ua_to_hpa_rm() can fail.

This changes mm_iommu_preregistered() to receive @mm as in real mode
@current does not always have a correct pointer.

This adds realmode version of mm_iommu_lookup() which receives @mm
(for the same reason as for mm_iommu_preregistered()) and uses
lockless version of list_for_each_entry_rcu().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/mmu_context.h |  4 ++++
 arch/powerpc/mm/mmu_context_iommu.c    | 39 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index a4c4ed5..939030c 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -27,10 +27,14 @@ extern long mm_iommu_put(struct mm_struct *mm,
 extern void mm_iommu_init(struct mm_struct *mm);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
 		unsigned long ua, unsigned long size);
+extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(
+		struct mm_struct *mm, unsigned long ua, unsigned long size);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries);
 extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned long *hpa);
+extern long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
+		unsigned long ua, unsigned long *hpa);
 extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
 extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
 #endif
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 10f01fe..36a906c 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -242,6 +242,25 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
 }
 EXPORT_SYMBOL_GPL(mm_iommu_lookup);
 
+struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(struct mm_struct *mm,
+		unsigned long ua, unsigned long size)
+{
+	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
+
+	list_for_each_entry_lockless(mem, &mm->context.iommu_group_mem_list,
+			next) {
+		if ((mem->ua <= ua) &&
+				(ua + size <= mem->ua +
+				 (mem->entries << PAGE_SHIFT))) {
+			ret = mem;
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_lookup_rm);
+
 struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries)
 {
@@ -273,6 +292,26 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 }
 EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
 
+long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
+		unsigned long ua, unsigned long *hpa)
+{
+	const long entry = (ua - mem->ua) >> PAGE_SHIFT;
+	void *va = &mem->hpas[entry];
+	unsigned long *ra;
+
+	if (entry >= mem->entries)
+		return -EFAULT;
+
+	ra = (void *) vmalloc_to_phys(va);
+	if (!ra)
+		return -EFAULT;
+
+	*hpa = *ra | (ua & ~PAGE_MASK);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa_rm);
+
 long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem)
 {
 	if (atomic64_inc_not_zero(&mem->mapped))
-- 
2.5.0.rc3
