Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EA271A05AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 14:18:09 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 19 Oct 2015 13:18:07 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D92AB2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 14:18:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9J3HuNS7405624
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 14:18:05 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9J3HUp7003749
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 14:17:30 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 00/31] powerpc/mm: Update page table format for book3s
 64
In-Reply-To: <1445088167.24309.58.camel@kernel.crashing.org>
References: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1445088167.24309.58.camel@kernel.crashing.org>
Date: Mon, 19 Oct 2015 08:47:10 +0530
Message-ID: <87lhaz4keh.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sat, 2015-10-17 at 15:38 +0530, Aneesh Kumar K.V wrote:
>> Hi All,
>> 
>> This patch series attempt to update book3s 64 linux page table format to
>> make it more flexible. Our current pte format is very restrictive and we
>> overload multiple pte bits. This is due to the non-availability of free bits
>> in pte_t. We use pte_t to track the validity of 4K subpages. This patch
>> series free up pte_t of 11 bits by moving 4K subpage tracking to the
>> lower half of PTE page. The pte format is updated such that we have a
>> better method for identifying a pte entry at pmd level. This will also enable
>> us to implement hugetlb migration(not yet done in this series). 
>
> I still have serious concerns about the fact that we now use 4 times
> more memory for page tables than strictly necessary. We were using
> twice as much before.
>
> We need to find a way to not allocate all those "other halves" when not
> needed.
>
> I understand it's tricky, we tend to notice we need the second half too
> late...
>
> Maybe if we could escalate the hash miss into a minor fault when the
> second half is needed and not present, we can then allocate it from the
>
> For demotion of the vmap space, we might have to be a bit smarter,
> maybe detect at ioremap/vmap time and flag the mm as needed second
> halves for everything (and allocate them).
>
> Of course if the machine doesn't do hw 64k, we would always allocate
> the second half.
>
> The question then becomes how to reference it from the first half.
>
> A completely parallel tree means a lot more walks for each PTE, is
> there something in the PTE page's struct page we can use maybe ?
>

We could use page->index. I have an early patch (it still find wrong
ptes ) which increase fragment count to 32. IMHO, we should
get this series merged and not depend on increasing fragment
count to 32 now. I was planning to get that merged in the next
merge window. We get sufficient time to test and also won't push
all the changes in one merge window. This will allow us to easily
isolate issues if they arise. 

    powerpc/mm: Move subpage tracking allocation out of pgtable
    
    This is the first part of the attempt to reduce pagetable usage for 64k.
    The goal is to allocate 4k subpage tracking memory only if we need to
    
    Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index 4f1cc6c46728..f4243d9264c4 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -166,13 +166,24 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 /*
  * we support 8 fragments per PTE page.
  */
-#define PTE_FRAG_NR	8
+#define PTE_FRAG_NR	32
 /*
  * We use a 2K PTE page fragment and another 4K for storing
  * real_pte_t hash index. Rounding the entire thing to 8K
  */
-#define PTE_FRAG_SIZE_SHIFT  13
+#define PTE_FRAG_SIZE_SHIFT  11
 #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
+/*
+ * Size of array used to track the respective 4K subpage details
+ * Total entries in a pte page:
+ * (PTE_FRAG_NR * PTE_FRAG_SIZE) / 8
+ * Space needed per 64K pte:
+ * 16 bytes (One byte per 4K hpte)
+ * Total space for 4K PTE frag size
+ * (PTE_FRAG_NR * PTE_FRAG_SIZE) * 2
+ * ie, order 1 pages.
+ */
+#define PTE_4K_FRAG_SIZE (PTE_FRAG_SIZE << 1)
 
 extern pte_t *page_table_alloc(struct mm_struct *, unsigned long, int);
 extern void page_table_free(struct mm_struct *, unsigned long *, int);
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 84867a1491a2..08c141a844ca 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -15,24 +15,40 @@
 #include <linux/mm.h>
 #include <asm/machdep.h>
 #include <asm/mmu.h>
+#include <asm/pgalloc.h>
+
+static inline int pte_frag_index(unsigned long ptep, unsigned long pte_page)
+{
+	return  (ptep - pte_page)/ PTE_FRAG_SIZE;
+
+}
+
+static inline int pte_4k_track_index(int frag_index, int pte_index)
+{
+	return (PTE_4K_FRAG_SIZE * frag_index) + (pte_index * 16);
+
+}
 
 real_pte_t __real_pte(unsigned long addr, pte_t pte, pte_t *ptep)
 {
 	int indx;
 	real_pte_t rpte;
-	pte_t *pte_headp;
+	struct page *pte_page = virt_to_page(ptep);
 
 	rpte.pte = pte;
 	rpte.hidx = NULL;
 	if (pte_val(pte) & _PAGE_COMBO) {
+		int frag_index = pte_frag_index((unsigned long) ptep,
+					(unsigned long)page_address(pte_page));
+
 		indx = pte_index(addr);
-		pte_headp = ptep - indx;
 		/*
 		 * Make sure we order the hidx load against the _PAGE_COMBO
 		 * check. The store side ordering is done in __hash_page_4K
 		 */
 		smp_rmb();
-		rpte.hidx = (unsigned char *)(pte_headp + PTRS_PER_PTE) + (16 * indx);
+		rpte.hidx = ((unsigned char *)pte_page->index) +
+				pte_4k_track_index(frag_index, indx);
 	}
 	return rpte;
 }
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index 4e4efbc2658e..e25cba47febb 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -121,6 +121,7 @@ static void destroy_pagetable_page(struct mm_struct *mm)
 	count = atomic_sub_return(PTE_FRAG_NR - count, &page->_count);
 	if (!count) {
 		pgtable_page_dtor(page);
+		free_pages((unsigned long)page->index, 1);
 		free_hot_cold_page(page, 0);
 	}
 }
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index ea6bc31debb0..e6fe21af45ab 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -386,10 +386,18 @@ static pte_t *get_from_cache(struct mm_struct *mm)
 static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
 {
 	void *ret = NULL;
+	struct page *subpage_pte;
 	struct page *page = alloc_page(GFP_KERNEL | __GFP_NOTRACK |
 				       __GFP_REPEAT | __GFP_ZERO);
 	if (!page)
 		return NULL;
+
+	subpage_pte = alloc_pages(GFP_KERNEL | __GFP_NOTRACK |
+				  __GFP_REPEAT | __GFP_ZERO, 1);
+	WARN(page->index, "Page index is not null\n");
+	WARN(page->freelist, "Free list is not null\n");
+	page->index = (unsigned long)page_address(subpage_pte);
+
 	if (!kernel && !pgtable_page_ctor(page)) {
 		__free_page(page);
 		return NULL;
@@ -426,6 +434,8 @@ void page_table_free(struct mm_struct *mm, unsigned long *table, int kernel)
 {
 	struct page *page = virt_to_page(table);
 	if (put_page_testzero(page)) {
+		free_pages(page->index, 1);
+		page->index = 0;
 		if (!kernel)
 			pgtable_page_dtor(page);
 		free_hot_cold_page(page, 0);
@@ -437,6 +447,8 @@ static void page_table_free_rcu(void *table)
 {
 	struct page *page = virt_to_page(table);
 	if (put_page_testzero(page)) {
+		free_pages(page->index, 1);
+		page->index = 0;
 		pgtable_page_dtor(page);
 		free_hot_cold_page(page, 0);
 	}
@@ -471,6 +483,8 @@ void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 		/* PTE page needs special handling */
 		struct page *page = virt_to_page(table);
 		if (put_page_testzero(page)) {
+			free_pages(page->index, 1);
+			page->index = 0;
 			pgtable_page_dtor(page);
 			free_hot_cold_page(page, 0);
 		}
 
