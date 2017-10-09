Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9bYk0w8zzDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 21:08:57 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v99A8ok8096915
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 06:08:54 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dg4cdy8yr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 06:08:53 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 9 Oct 2017 11:08:43 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: [PATCH v4 12/20] mm: Introduce __vm_normal_page()
Date: Mon,  9 Oct 2017 12:07:44 +0200
In-Reply-To: <1507543672-25821-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1507543672-25821-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-Id: <1507543672-25821-13-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When dealing with the speculative fault path we should use the VMA's field
cached value stored in the vm_fault structure.

Currently vm_normal_page() is using the pointer to the VMA to fetch the
vm_flags value. This patch provides a new __vm_normal_page() which is
receiving the vm_flags flags value as parameter.

Note: The speculative path is turned on for architecture providing support
for special PTE flag. So only the first block of vm_normal_page is used
during the speculative path.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/linux/mm.h |  7 +++++--
 mm/memory.c        | 18 ++++++++++--------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cdccee815227..fe464c01d651 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1246,8 +1246,11 @@ struct zap_details {
 	pgoff_t last_index;			/* Highest page->index to unmap */
 };
 
-struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
-			     pte_t pte, bool with_public_device);
+struct page *__vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
+			      pte_t pte, bool with_public_device,
+			      unsigned long vma_flags);
+#define _vm_normal_page(vma, addr, pte, with_public_device) \
+	__vm_normal_page(vma, addr, pte, with_public_device, (vma)->vm_flags)
 #define vm_normal_page(vma, addr, pte) _vm_normal_page(vma, addr, pte, false)
 
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index d91418708845..3ea1bbe6cb03 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -823,8 +823,9 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 #else
 # define HAVE_PTE_SPECIAL 0
 #endif
-struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
-			     pte_t pte, bool with_public_device)
+struct page *__vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
+			      pte_t pte, bool with_public_device,
+			      unsigned long vma_flags)
 {
 	unsigned long pfn = pte_pfn(pte);
 
@@ -833,7 +834,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			goto check_pfn;
 		if (vma->vm_ops && vma->vm_ops->find_special_page)
 			return vma->vm_ops->find_special_page(vma, addr);
-		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
+		if (vma_flags & (VM_PFNMAP | VM_MIXEDMAP))
 			return NULL;
 		if (pte_devmap(pte))
 			return NULL;
@@ -867,8 +868,8 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 
 	/* !HAVE_PTE_SPECIAL case follows: */
 
-	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
-		if (vma->vm_flags & VM_MIXEDMAP) {
+	if (unlikely(vma_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
+		if (vma_flags & VM_MIXEDMAP) {
 			if (!pfn_valid(pfn))
 				return NULL;
 			goto out;
@@ -877,7 +878,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			off = (addr - vma->vm_start) >> PAGE_SHIFT;
 			if (pfn == vma->vm_pgoff + off)
 				return NULL;
-			if (!is_cow_mapping(vma->vm_flags))
+			if (!is_cow_mapping(vma_flags))
 				return NULL;
 		}
 	}
@@ -2730,7 +2731,8 @@ static int do_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
-	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
+	vmf->page = __vm_normal_page(vma, vmf->address, vmf->orig_pte, false,
+				     vmf->vma_flags);
 	if (!vmf->page) {
 		/*
 		 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
@@ -3820,7 +3822,7 @@ static int do_numa_page(struct vm_fault *vmf)
 	ptep_modify_prot_commit(vma->vm_mm, vmf->address, vmf->pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 
-	page = vm_normal_page(vma, vmf->address, pte);
+	page = __vm_normal_page(vma, vmf->address, pte, false, vmf->vma_flags);
 	if (!page) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return 0;
-- 
2.7.4
