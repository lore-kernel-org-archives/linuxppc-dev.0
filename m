Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB70C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 06:33:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B935E20870
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 06:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B935E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FkQL2cDvzDqtn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 17:33:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Fk5L3LT7zDqcF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 17:18:30 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 65735AE8035E;
 Thu, 13 Dec 2018 01:17:55 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v5 03/20] powerpc/vfio/iommu/kvm: Do not pin device
 memory
Date: Thu, 13 Dec 2018 17:17:17 +1100
Message-Id: <20181213061734.16651-4-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213061734.16651-1-aik@ozlabs.ru>
References: <20181213061734.16651-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This new memory does not have page structs as it is not plugged to
the host so gup() will fail anyway.

This adds 2 helpers:
- mm_iommu_newdev() to preregister the "memory device" memory so
the rest of API can still be used;
- mm_iommu_is_devmem() to know if the physical address is one of thise
new regions which we must avoid unpinning of.

This adds @mm to tce_page_is_contained() and iommu_tce_xchg() to test
if the memory is device memory to avoid pfn_to_page().

This adds a check for device memory in mm_iommu_ua_mark_dirty_rm() which
does delayed pages dirtying.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v5:
* mm_iommu_is_devmem() now returns the actual size which might me smaller
than the pageshift so  tce_page_is_contained() won't do pfn_to_page()
if @hpa..@hpa+64K is preregistered but page_shift is bigger than 16
* removed David's r-by because of the change in mm_iommu_is_devmem

v4:
* added device memory check in the real mode path
---
 arch/powerpc/include/asm/iommu.h       |  5 +-
 arch/powerpc/include/asm/mmu_context.h |  5 ++
 arch/powerpc/kernel/iommu.c            | 11 ++-
 arch/powerpc/kvm/book3s_64_vio.c       | 18 ++---
 arch/powerpc/mm/mmu_context_iommu.c    | 93 +++++++++++++++++++++++---
 drivers/vfio/vfio_iommu_spapr_tce.c    | 29 +++++---
 6 files changed, 129 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 35db0cb..a8aeac0 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -218,8 +218,9 @@ extern void iommu_register_group(struct iommu_table_group *table_group,
 extern int iommu_add_device(struct device *dev);
 extern void iommu_del_device(struct device *dev);
 extern int __init tce_iommu_bus_notifier_init(void);
-extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
-		unsigned long *hpa, enum dma_data_direction *direction);
+extern long iommu_tce_xchg(struct mm_struct *mm, struct iommu_table *tbl,
+		unsigned long entry, unsigned long *hpa,
+		enum dma_data_direction *direction);
 #else
 static inline void iommu_register_group(struct iommu_table_group *table_group,
 					int pci_domain_number,
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 268e112..4e4656d 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -24,6 +24,9 @@ extern bool mm_iommu_preregistered(struct mm_struct *mm);
 extern long mm_iommu_new(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem);
+extern long mm_iommu_newdev(struct mm_struct *mm, unsigned long ua,
+		unsigned long entries, unsigned long dev_hpa,
+		struct mm_iommu_table_group_mem_t **pmem);
 extern long mm_iommu_put(struct mm_struct *mm,
 		struct mm_iommu_table_group_mem_t *mem);
 extern void mm_iommu_init(struct mm_struct *mm);
@@ -39,6 +42,8 @@ extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 extern long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
 extern void mm_iommu_ua_mark_dirty_rm(struct mm_struct *mm, unsigned long ua);
+extern bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
+		unsigned int pageshift, unsigned long *size);
 extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
 extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
 #endif
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index f0dc680..cbcc615 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -47,6 +47,7 @@
 #include <asm/fadump.h>
 #include <asm/vio.h>
 #include <asm/tce.h>
+#include <asm/mmu_context.h>
 
 #define DBG(...)
 
@@ -993,15 +994,19 @@ int iommu_tce_check_gpa(unsigned long page_shift, unsigned long gpa)
 }
 EXPORT_SYMBOL_GPL(iommu_tce_check_gpa);
 
-long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
-		unsigned long *hpa, enum dma_data_direction *direction)
+long iommu_tce_xchg(struct mm_struct *mm, struct iommu_table *tbl,
+		unsigned long entry, unsigned long *hpa,
+		enum dma_data_direction *direction)
 {
 	long ret;
+	unsigned long size = 0;
 
 	ret = tbl->it_ops->exchange(tbl, entry, hpa, direction);
 
 	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
-			(*direction == DMA_BIDIRECTIONAL)))
+			(*direction == DMA_BIDIRECTIONAL)) &&
+			!mm_iommu_is_devmem(mm, *hpa, tbl->it_page_shift,
+					&size))
 		SetPageDirty(pfn_to_page(*hpa >> PAGE_SHIFT));
 
 	/* if (unlikely(ret))
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 62a8d03..532ab797 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -397,12 +397,13 @@ static long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt,
 	return H_SUCCESS;
 }
 
-static void kvmppc_clear_tce(struct iommu_table *tbl, unsigned long entry)
+static void kvmppc_clear_tce(struct mm_struct *mm, struct iommu_table *tbl,
+		unsigned long entry)
 {
 	unsigned long hpa = 0;
 	enum dma_data_direction dir = DMA_NONE;
 
-	iommu_tce_xchg(tbl, entry, &hpa, &dir);
+	iommu_tce_xchg(mm, tbl, entry, &hpa, &dir);
 }
 
 static long kvmppc_tce_iommu_mapped_dec(struct kvm *kvm,
@@ -433,7 +434,7 @@ static long kvmppc_tce_iommu_do_unmap(struct kvm *kvm,
 	unsigned long hpa = 0;
 	long ret;
 
-	if (WARN_ON_ONCE(iommu_tce_xchg(tbl, entry, &hpa, &dir)))
+	if (WARN_ON_ONCE(iommu_tce_xchg(kvm->mm, tbl, entry, &hpa, &dir)))
 		return H_TOO_HARD;
 
 	if (dir == DMA_NONE)
@@ -441,7 +442,7 @@ static long kvmppc_tce_iommu_do_unmap(struct kvm *kvm,
 
 	ret = kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
 	if (ret != H_SUCCESS)
-		iommu_tce_xchg(tbl, entry, &hpa, &dir);
+		iommu_tce_xchg(kvm->mm, tbl, entry, &hpa, &dir);
 
 	return ret;
 }
@@ -487,7 +488,7 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 	if (mm_iommu_mapped_inc(mem))
 		return H_TOO_HARD;
 
-	ret = iommu_tce_xchg(tbl, entry, &hpa, &dir);
+	ret = iommu_tce_xchg(kvm->mm, tbl, entry, &hpa, &dir);
 	if (WARN_ON_ONCE(ret)) {
 		mm_iommu_mapped_dec(mem);
 		return H_TOO_HARD;
@@ -566,7 +567,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 					entry, ua, dir);
 
 		if (ret != H_SUCCESS) {
-			kvmppc_clear_tce(stit->tbl, entry);
+			kvmppc_clear_tce(vcpu->kvm->mm, stit->tbl, entry);
 			goto unlock_exit;
 		}
 	}
@@ -655,7 +656,8 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 					iommu_tce_direction(tce));
 
 			if (ret != H_SUCCESS) {
-				kvmppc_clear_tce(stit->tbl, entry);
+				kvmppc_clear_tce(vcpu->kvm->mm, stit->tbl,
+						entry);
 				goto unlock_exit;
 			}
 		}
@@ -704,7 +706,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 				return ret;
 
 			WARN_ON_ONCE(1);
-			kvmppc_clear_tce(stit->tbl, entry);
+			kvmppc_clear_tce(vcpu->kvm->mm, stit->tbl, entry);
 		}
 	}
 
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 25a4b7f7..06fdbd3 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -47,6 +47,8 @@ struct mm_iommu_table_group_mem_t {
 		struct page **hpages;	/* vmalloc'ed */
 		phys_addr_t *hpas;
 	};
+#define MM_IOMMU_TABLE_INVALID_HPA	((uint64_t)-1)
+	u64 dev_hpa;		/* Device memory base address */
 };
 
 static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
@@ -89,7 +91,8 @@ bool mm_iommu_preregistered(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
 
-long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
+static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
+		unsigned long entries, unsigned long dev_hpa,
 		struct mm_iommu_table_group_mem_t **pmem)
 {
 	struct mm_iommu_table_group_mem_t *mem;
@@ -110,11 +113,13 @@ long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 
 	}
 
-	ret = mm_iommu_adjust_locked_vm(mm, entries, true);
-	if (ret)
-		goto unlock_exit;
+	if (dev_hpa == MM_IOMMU_TABLE_INVALID_HPA) {
+		ret = mm_iommu_adjust_locked_vm(mm, entries, true);
+		if (ret)
+			goto unlock_exit;
 
-	locked_entries = entries;
+		locked_entries = entries;
+	}
 
 	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 	if (!mem) {
@@ -122,6 +127,13 @@ long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 		goto unlock_exit;
 	}
 
+	if (dev_hpa != MM_IOMMU_TABLE_INVALID_HPA) {
+		mem->pageshift = __ffs(dev_hpa | (entries << PAGE_SHIFT));
+		mem->dev_hpa = dev_hpa;
+		goto good_exit;
+	}
+	mem->dev_hpa = MM_IOMMU_TABLE_INVALID_HPA;
+
 	/*
 	 * For a starting point for a maximum page size calculation
 	 * we use @ua and @entries natural alignment to allow IOMMU pages
@@ -170,6 +182,7 @@ long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 
 	}
 
+good_exit:
 	atomic64_set(&mem->mapped, 1);
 	mem->used = 1;
 	mem->ua = ua;
@@ -186,13 +199,31 @@ long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 
 	return ret;
 }
+
+long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
+		struct mm_iommu_table_group_mem_t **pmem)
+{
+	return mm_iommu_do_alloc(mm, ua, entries, MM_IOMMU_TABLE_INVALID_HPA,
+			pmem);
+}
 EXPORT_SYMBOL_GPL(mm_iommu_new);
 
+long mm_iommu_newdev(struct mm_struct *mm, unsigned long ua,
+		unsigned long entries, unsigned long dev_hpa,
+		struct mm_iommu_table_group_mem_t **pmem)
+{
+	return mm_iommu_do_alloc(mm, ua, entries, dev_hpa, pmem);
+}
+EXPORT_SYMBOL_GPL(mm_iommu_newdev);
+
 static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
 {
 	long i;
 	struct page *page = NULL;
 
+	if (!mem->hpas)
+		return;
+
 	for (i = 0; i < mem->entries; ++i) {
 		if (!mem->hpas[i])
 			continue;
@@ -234,6 +265,7 @@ static void mm_iommu_release(struct mm_iommu_table_group_mem_t *mem)
 long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_t *mem)
 {
 	long ret = 0;
+	unsigned long entries, dev_hpa;
 
 	mutex_lock(&mem_list_mutex);
 
@@ -255,9 +287,12 @@ long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_t *mem)
 	}
 
 	/* @mapped became 0 so now mappings are disabled, release the region */
+	entries = mem->entries;
+	dev_hpa = mem->dev_hpa;
 	mm_iommu_release(mem);
 
-	mm_iommu_adjust_locked_vm(mm, mem->entries, false);
+	if (dev_hpa == MM_IOMMU_TABLE_INVALID_HPA)
+		mm_iommu_adjust_locked_vm(mm, entries, false);
 
 unlock_exit:
 	mutex_unlock(&mem_list_mutex);
@@ -327,7 +362,7 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
 {
 	const long entry = (ua - mem->ua) >> PAGE_SHIFT;
-	u64 *va = &mem->hpas[entry];
+	u64 *va;
 
 	if (entry >= mem->entries)
 		return -EFAULT;
@@ -335,6 +370,12 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 	if (pageshift > mem->pageshift)
 		return -EFAULT;
 
+	if (!mem->hpas) {
+		*hpa = mem->dev_hpa + (ua - mem->ua);
+		return 0;
+	}
+
+	va = &mem->hpas[entry];
 	*hpa = (*va & MM_IOMMU_TABLE_GROUP_PAGE_MASK) | (ua & ~PAGE_MASK);
 
 	return 0;
@@ -345,7 +386,6 @@ long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
 {
 	const long entry = (ua - mem->ua) >> PAGE_SHIFT;
-	void *va = &mem->hpas[entry];
 	unsigned long *pa;
 
 	if (entry >= mem->entries)
@@ -354,7 +394,12 @@ long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
 	if (pageshift > mem->pageshift)
 		return -EFAULT;
 
-	pa = (void *) vmalloc_to_phys(va);
+	if (!mem->hpas) {
+		*hpa = mem->dev_hpa + (ua - mem->ua);
+		return 0;
+	}
+
+	pa = (void *) vmalloc_to_phys(&mem->hpas[entry]);
 	if (!pa)
 		return -EFAULT;
 
@@ -374,6 +419,9 @@ extern void mm_iommu_ua_mark_dirty_rm(struct mm_struct *mm, unsigned long ua)
 	if (!mem)
 		return;
 
+	if (mem->dev_hpa != MM_IOMMU_TABLE_INVALID_HPA)
+		return;
+
 	entry = (ua - mem->ua) >> PAGE_SHIFT;
 	va = &mem->hpas[entry];
 
@@ -384,6 +432,33 @@ extern void mm_iommu_ua_mark_dirty_rm(struct mm_struct *mm, unsigned long ua)
 	*pa |= MM_IOMMU_TABLE_GROUP_PAGE_DIRTY;
 }
 
+extern bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
+		unsigned int pageshift, unsigned long *size)
+{
+	struct mm_iommu_table_group_mem_t *mem;
+	unsigned long end;
+
+	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
+		if (mem->dev_hpa == MM_IOMMU_TABLE_INVALID_HPA)
+			continue;
+
+		end = mem->dev_hpa + (mem->entries << PAGE_SHIFT);
+		if ((mem->dev_hpa <= hpa) && (hpa < end)) {
+			/*
+			 * Since the IOMMU page size might be bigger than
+			 * PAGE_SIZE, the amount of preregistered memory
+			 * starting from @hpa might be smaller than 1<<pageshift
+			 * and the caller needs to distinguish this situation.
+			 */
+			*size = min(1UL << pageshift, end - hpa);
+			return true;
+		}
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_is_devmem);
+
 long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem)
 {
 	if (atomic64_inc_not_zero(&mem->mapped))
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 1d8b889..c424913 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -222,8 +222,16 @@ static long tce_iommu_register_pages(struct tce_container *container,
 	return ret;
 }
 
-static bool tce_page_is_contained(struct page *page, unsigned page_shift)
+static bool tce_page_is_contained(struct mm_struct *mm, unsigned long hpa,
+		unsigned int page_shift)
 {
+	struct page *page;
+	unsigned long size = 0;
+
+	if (mm_iommu_is_devmem(mm, hpa, page_shift, &size))
+		return size == (1UL << page_shift);
+
+	page = pfn_to_page(hpa >> PAGE_SHIFT);
 	/*
 	 * Check that the TCE table granularity is not bigger than the size of
 	 * a page we just found. Otherwise the hardware can get access to
@@ -499,7 +507,8 @@ static int tce_iommu_clear(struct tce_container *container,
 
 		direction = DMA_NONE;
 		oldhpa = 0;
-		ret = iommu_tce_xchg(tbl, entry, &oldhpa, &direction);
+		ret = iommu_tce_xchg(container->mm, tbl, entry, &oldhpa,
+				&direction);
 		if (ret)
 			continue;
 
@@ -537,7 +546,6 @@ static long tce_iommu_build(struct tce_container *container,
 		enum dma_data_direction direction)
 {
 	long i, ret = 0;
-	struct page *page;
 	unsigned long hpa;
 	enum dma_data_direction dirtmp;
 
@@ -548,15 +556,16 @@ static long tce_iommu_build(struct tce_container *container,
 		if (ret)
 			break;
 
-		page = pfn_to_page(hpa >> PAGE_SHIFT);
-		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
+		if (!tce_page_is_contained(container->mm, hpa,
+				tbl->it_page_shift)) {
 			ret = -EPERM;
 			break;
 		}
 
 		hpa |= offset;
 		dirtmp = direction;
-		ret = iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
+		ret = iommu_tce_xchg(container->mm, tbl, entry + i, &hpa,
+				&dirtmp);
 		if (ret) {
 			tce_iommu_unuse_page(container, hpa);
 			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
@@ -583,7 +592,6 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		enum dma_data_direction direction)
 {
 	long i, ret = 0;
-	struct page *page;
 	unsigned long hpa;
 	enum dma_data_direction dirtmp;
 
@@ -596,8 +604,8 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		if (ret)
 			break;
 
-		page = pfn_to_page(hpa >> PAGE_SHIFT);
-		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
+		if (!tce_page_is_contained(container->mm, hpa,
+				tbl->it_page_shift)) {
 			ret = -EPERM;
 			break;
 		}
@@ -610,7 +618,8 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		if (mm_iommu_mapped_inc(mem))
 			break;
 
-		ret = iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
+		ret = iommu_tce_xchg(container->mm, tbl, entry + i, &hpa,
+				&dirtmp);
 		if (ret) {
 			/* dirtmp cannot be DMA_NONE here */
 			tce_iommu_unuse_page_v2(container, tbl, entry + i);
-- 
2.17.1

