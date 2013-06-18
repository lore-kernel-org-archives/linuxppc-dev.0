Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3054C2C02B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 03:54:39 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 23:17:51 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8E6611258043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 23:23:29 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5IHsRun26542314
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 23:24:27 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5IHsVue014775
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 03:54:31 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH -V10 00/15] THP support for PPC64
In-Reply-To: <1371348007.21896.62.camel@pasglop>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1371348007.21896.62.camel@pasglop>
Date: Tue, 18 Jun 2013 23:24:30 +0530
Message-ID: <8761xbi9t5.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Andrea Arcangeli <aarcange@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@au1.ibm.com> writes:

> On Wed, 2013-06-05 at 20:58 +0530, Aneesh Kumar K.V wrote:
>> This is the second patchset needed to support THP on ppc64. Some of
>> the changes
>> included in this series are tricky in that it changes the powerpc
>> linux page table
>> walk subtly. We also overload few of the pte flags for ptes at PMD
>> level (huge
>> page PTEs).
>> 
>> The related mm/ changes are already merged to Andrew's -mm tree.
>
> [Andrea, question for you near the end ]
>
> So I'm trying to understand how you handle races between hash_page
> and collapse.
>
> The generic collapse code does:
>
> 	_pmd = pmdp_clear_flush(vma, address, pmd);
>
> Which expects the architecture to essentially have stopped any
> concurrent walk by the time it returns.
>
> Your implementation of the above does this:
>
> 		pmd = *pmdp;
> 		pmd_clear(pmdp);
> 		/*
> 		 * Now invalidate the hpte entries in the range
> 		 * covered by pmd. This make sure we take a
> 		 * fault and will find the pmd as none, which will
> 		 * result in a major fault which takes mmap_sem and
> 		 * hence wait for collapse to complete. Without this
> 		 * the __collapse_huge_page_copy can result in copying
> 		 * the old content.
> 		 */
> 		flush_tlb_pmd_range(vma->vm_mm, &pmd, address);
>
> So we clear the pmd after making a copy of it. This will eventually
> prevent a tablewalk but only eventually, once that store becomes visible
> to other processors, which may take a while. Then you proceed to flush
> the hash table for all the underlying PTEs.
>
> So at this point, hash_page might *still* see the old pmd. Unless I
> missed something, you did nothing that will prevent that (the only way
> to lock against hash_page is really an IPI & wait or to take the PTE's
> busy and make them !present or something). So as far as I can tell,
> a concurrent hash_page can still sneak into the hash some "small"
> entries after you have supposedly flushed them.
>

We are depending on the pmd being none. But as you said that doesn't
take care of an already undergoing hash_page. As per the discussion I
am listing below the option that use synchronize_sched. The other option
that we have is to clear _PAGE_USER.

commit f69f11ba6a957aac81ea8096b244005c450a2059
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Tue Jun 18 19:17:17 2013 +0530

    powerpc/THP: Wait for all hash_page calls to finish before invalidating HPTE entries
    
    When we collapse normal pages to hugepage, we first clear the pmd, then invalidate all
    the PTE entries. The assumption here is that any low level page fault will see pmd as
    none and take the slow path that will wait on mmap_sem. But we could very well be in
    a hash_page with local ptep pointer value. Such a hash page can result in adding new
    HPTE entries for normal subpages/small page. That means we could be modifying the
    page content as we copy them to a huge page. Fix this by waiting on hash_page to finish
    after marking the pmd none and bfore invalidating HPTE entries. We use the heavy
    synchronize_sched(). This should be ok as we do this in the background khugepaged thread
    and not in application context. Also if we find collapse slow we can ideally increase
    the scan rate.
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index bbecac4..92b733e 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -532,6 +532,7 @@ pmd_t pmdp_clear_flush(struct vm_area_struct *vma, unsigned long address,
 		       pmd_t *pmdp)
 {
 	pmd_t pmd;
+	struct mm_struct *mm = vma->vm_mm;
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	if (pmd_trans_huge(*pmdp)) {
@@ -542,6 +543,16 @@ pmd_t pmdp_clear_flush(struct vm_area_struct *vma, unsigned long address,
 		 */
 		pmd = *pmdp;
 		pmd_clear(pmdp);
+		spin_unlock(&mm->page_table_lock);
+		/*
+		 * Wait for all pending hash_page to finish
+		 * We can do this by waiting for a context switch to happen on
+		 * the cpus. Any new hash_page after this will see pmd none
+		 * and fallback to code that takes mmap_sem and hence will block
+		 * for collapse to finish.
+		 */
+		synchronize_sched();
+		spin_lock(&mm->page_table_lock);
 		/*
 		 * Now invalidate the hpte entries in the range
 		 * covered by pmd. This make sure we take a
