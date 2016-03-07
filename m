Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B38891A0365
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:49 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 7 Mar 2016 13:42:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 37C52357805D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:45 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u273gbkl49872938
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:45 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u273gCcY022186
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:13 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 2/9] powerpc/mmu: Add real mode support for IOMMU
 preregistered memory
Date: Mon,  7 Mar 2016 14:41:10 +1100
Message-Id: <1457322077-26640-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
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
Unlike mm_iommu_ua_to_hpa(), mm_iommu_rm_ua_to_hpa() can fail.

This changes mm_iommu_preregistered() to receive @mm as in real mode
@current does not always have a correct pointer.

This adds realmode version of mm_iommu_lookup() which receives @mm
(for the same reason as for mm_iommu_preregistered()) and uses
lockless version of list_for_each_entry_rcu().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/mmu_context.h |  6 ++++-
 arch/powerpc/mm/mmu_context_iommu.c    | 45 ++++++++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 878c277..3ba652a 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -18,7 +18,7 @@ extern void destroy_context(struct mm_struct *mm);
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 struct mm_iommu_table_group_mem_t;
 
-extern bool mm_iommu_preregistered(void);
+extern bool mm_iommu_preregistered(mm_context_t *mm);
 extern long mm_iommu_get(unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem);
 extern long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem);
@@ -26,10 +26,14 @@ extern void mm_iommu_init(mm_context_t *ctx);
 extern void mm_iommu_cleanup(mm_context_t *ctx);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
 		unsigned long size);
+extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(mm_context_t *mm,
+		unsigned long ua, unsigned long size);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
 		unsigned long entries);
 extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned long *hpa);
+extern long mm_iommu_rm_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
+		unsigned long ua, unsigned long *hpa);
 extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
 extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
 #endif
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index da6a216..aa1565d 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -63,12 +63,9 @@ static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
 	return ret;
 }
 
-bool mm_iommu_preregistered(void)
+bool mm_iommu_preregistered(mm_context_t *mm)
 {
-	if (!current || !current->mm)
-		return false;
-
-	return !list_empty(&current->mm->context.iommu_group_mem_list);
+	return !list_empty(&mm->iommu_group_mem_list);
 }
 EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
 
@@ -231,6 +228,24 @@ unlock_exit:
 }
 EXPORT_SYMBOL_GPL(mm_iommu_put);
 
+struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(mm_context_t *mm,
+		unsigned long ua, unsigned long size)
+{
+	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
+
+	list_for_each_entry_lockless(mem, &mm->iommu_group_mem_list, next) {
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
 struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
 		unsigned long size)
 {
@@ -284,6 +299,26 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 }
 EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
 
+long mm_iommu_rm_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
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
+EXPORT_SYMBOL_GPL(mm_iommu_rm_ua_to_hpa);
+
 long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem)
 {
 	if (atomic64_inc_not_zero(&mem->mapped))
-- 
2.5.0.rc3
