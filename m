Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20F391A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Feb 2016 16:33:00 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 14 Feb 2016 00:32:57 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CFE5E38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Feb 2016 00:32:54 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1E5WsdD28115160
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Feb 2016 05:32:54 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1E5Wr1k008819
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Feb 2016 00:32:54 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org, akpm@linux-foundation.org,
 Mel Gorman <mgorman@techsingularity.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [V3] powerpc/mm: Fix Multi hit ERAT cause by recent THP update
In-Reply-To: <20160209121606.EA46C140B97@ozlabs.org>
References: <20160209121606.EA46C140B97@ozlabs.org>
Date: Sun, 14 Feb 2016 11:02:47 +0530
Message-ID: <877fi7ambk.fsf@linux.vnet.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Tue, 2016-09-02 at 01:20:31 UTC, "Aneesh Kumar K.V" wrote:
>> With ppc64 we use the deposited pgtable_t to store the hash pte slot
>> information. We should not withdraw the deposited pgtable_t without
>> marking the pmd none. This ensure that low level hash fault handling
>> will skip this huge pte and we will handle them at upper levels.
>> 
>> Recent change to pmd splitting changed the above in order to handle the
>> race between pmd split and exit_mmap. The race is explained below.
>> 
>> Consider following race:
>> 
>> 		CPU0				CPU1
>> shrink_page_list()
>>   add_to_swap()
>>     split_huge_page_to_list()
>>       __split_huge_pmd_locked()
>>         pmdp_huge_clear_flush_notify()
>> 	// pmd_none() == true
>> 					exit_mmap()
>> 					  unmap_vmas()
>> 					    zap_pmd_range()
>> 					      // no action on pmd since pmd_none() == true
>> 	pmd_populate()
>> 
>> As result the THP will not be freed. The leak is detected by check_mm():
>> 
>> 	BUG: Bad rss-counter state mm:ffff880058d2e580 idx:1 val:512
>> 
>> The above required us to not mark pmd none during a pmd split.
>> 
>> The fix for ppc is to clear the huge pte of _PAGE_USER, so that low
>> level fault handling code skip this pte. At higher level we do take ptl
>> lock. That should serialze us against the pmd split. Once the lock is
>> acquired we do check the pmd again using pmd_same. That should always
>> return false for us and hence we should retry the access. We do the
>> pmd_same check in all case after taking plt with
>> THP (do_huge_pmd_wp_page, do_huge_pmd_numa_page and
>> huge_pmd_set_accessed)
>> 
>> Also make sure we wait for irq disable section in other cpus to finish
>> before flipping a huge pte entry with a regular pmd entry. Code paths
>> like find_linux_pte_or_hugepte depend on irq disable to get
>> a stable pte_t pointer. A parallel thp split need to make sure we
>> don't convert a pmd pte to a regular pmd entry without waiting for the
>> irq disable section to finish.
>> 
>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Applied to powerpc fixes, thanks.
>
> https://git.kernel.org/powerpc/c/9db4cd6c21535a4846b38808f3
>

Can we apply the below hunk ?. The reason for marking pmd none was to
avoid clearing both _PAGE_USER and _PAGE_PRESENT on the pte. At pmd
level that used to mean a hugepd pointer before. We did fix that earlier
by introducing _PAGE_PTE. But then I was thinking it was harmless to
mark pmd none. Now marking it one will still result in the race I
explained above, eventhough the window is much smaller now.

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index c8a00da39969..03f6e72697d0 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -694,7 +694,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
-	pmd_hugepage_update(vma->vm_mm, address, pmdp, ~0UL, 0);
+	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
 	/*
 	 * This ensures that generic code that rely on IRQ disabling
 	 * to prevent a parallel THP split work as expected.
