Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vkKNy0dKhzDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:10:09 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v9 01/10] powerpc/mmu: Add real mode support for IOMMU
 preregistered memory
Date: Thu, 16 Mar 2017 18:09:23 +1100
Message-Id: <20170316070932.4385-2-aik@ozlabs.ru>
In-Reply-To: <20170316070932.4385-1-aik@ozlabs.ru>
References: <20170316070932.4385-1-aik@ozlabs.ru>
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/mmu_context.h |  4 ++++
 arch/powerpc/mm/mmu_context_iommu.c    | 39 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b9e3f0aca261..c70c8272523d 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -29,10 +29,14 @@ extern void mm_iommu_init(struct mm_struct *mm);
 extern void mm_iommu_cleanup(struct mm_struct *mm);
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
index 497130c5c742..fc67bd766eaf 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -314,6 +314,25 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
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
@@ -345,6 +364,26 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 }
 EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
 
+long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
+		unsigned long ua, unsigned long *hpa)
+{
+	const long entry = (ua - mem->ua) >> PAGE_SHIFT;
+	void *va = &mem->hpas[entry];
+	unsigned long *pa;
+
+	if (entry >= mem->entries)
+		return -EFAULT;
+
+	pa = (void *) vmalloc_to_phys(va);
+	if (!pa)
+		return -EFAULT;
+
+	*hpa = *pa | (ua & ~PAGE_MASK);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa_rm);
+
 long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem)
 {
 	if (atomic64_inc_not_zero(&mem->mapped))
-- 
2.11.0
