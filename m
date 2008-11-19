Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87EE9DDED4
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 02:53:28 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mAJFrOvj024598
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 09:53:25 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add a local_flush_tlb_page to handle kmap_atomic
	invalidates
Date: Wed, 19 Nov 2008 09:53:24 -0600
Message-Id: <1227110004-22219-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The tlb invalidates in kmap_atomic/kunmap_atomic can be called from
IRQ context, however they are only local invalidates (on the processor
that the kmap was called on).  In the future we want to use IPIs to
do tlb invalidates this causes issue since flush_tlb_page() is considered
a broadcast invalidate.

Add local_flush_tlb_page() as a non-broadcast invalidate and use it in
kmap_atomic() since we don't have enough information in the
flush_tlb_page() call to determine its local.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/highmem.h  |    4 ++--
 arch/powerpc/include/asm/tlbflush.h |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index 91c5895..7dc52ec 100644
--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -85,7 +85,7 @@ static inline void *kmap_atomic_prot(struct page *page, enum km_type type, pgpro
 	BUG_ON(!pte_none(*(kmap_pte-idx)));
 #endif
 	__set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot));
-	flush_tlb_page(NULL, vaddr);
+	local_flush_tlb_page(vaddr);
 
 	return (void*) vaddr;
 }
@@ -113,7 +113,7 @@ static inline void kunmap_atomic(void *kvaddr, enum km_type type)
 	 * this pte without first remap it
 	 */
 	pte_clear(&init_mm, vaddr, kmap_pte-idx);
-	flush_tlb_page(NULL, vaddr);
+	local_flush_tlb_page(vaddr);
 #endif
 	pagefault_enable();
 }
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index a2c6bfd..93716a9 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -6,6 +6,7 @@
  *
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
+ *  - local_flush_tlb_page(vmaddr) flushes one page on the local processor
  *  - flush_tlb_page_nohash(vma, vmaddr) flushes one page if SW loaded TLB
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
@@ -44,6 +45,11 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 	_tlbil_pid(mm->context.id);
 }
 
+static inline void local_flush_tlb_page(unsigned long vmaddr)
+{
+	_tlbil_va(vmaddr, 0);
+}
+
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long vmaddr)
 {
@@ -81,6 +87,10 @@ extern void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+static inline void local_flush_tlb_page(unsigned long vmaddr)
+{
+	flush_tlb_page(NULL, vmaddr);
+}
 
 #else
 /*
@@ -138,6 +148,10 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 {
 }
 
+static inline void local_flush_tlb_page(unsigned long vmaddr)
+{
+}
+
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long vmaddr)
 {
-- 
1.5.6.5
