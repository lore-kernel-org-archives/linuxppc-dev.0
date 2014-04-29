Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CCB8314015C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:35:56 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 29 Apr 2014 19:35:54 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 93F89357805D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:35:51 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3T9ZaLA8323466
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:35:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3T9Zn4B030526
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:35:51 +1000
Message-ID: <535F7271.2010504@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 15:05:45 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH V3 1/2] mm: move FAULT_AROUND_ORDER to arch/
References: <1398675690-16186-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1398675690-16186-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20140428093606.95B90E009B@blue.fi.intel.com>
In-Reply-To: <20140428093606.95B90E009B@blue.fi.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 dave.hansen@intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ak@linux.intel.com,
 paulus@samba.org, mgorman@suse.de, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 28 April 2014 03:06 PM, Kirill A. Shutemov wrote:
> Madhavan Srinivasan wrote:
>> Kirill A. Shutemov with 8c6e50b029 commit introduced
>> vm_ops->map_pages() for mapping easy accessible pages around
>> fault address in hope to reduce number of minor page faults.
>>
>> This patch creates infrastructure to modify the FAULT_AROUND_ORDER
>> value using mm/Kconfig. This will enable architecture maintainers
>> to decide on suitable FAULT_AROUND_ORDER value based on
>> performance data for that architecture. Patch also defaults
>> FAULT_AROUND_ORDER Kconfig element to 4.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>  mm/Kconfig  |    8 ++++++++
>>  mm/memory.c |   11 ++++-------
>>  2 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index ebe5880..c7fc4f1 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -176,6 +176,14 @@ config MOVABLE_NODE
>>  config HAVE_BOOTMEM_INFO_NODE
>>  	def_bool n
>>  
>> +#
>> +# Fault around order is a control knob to decide the fault around pages.
>> +# Default value is set to 4 , but the arch can override it as desired.
>> +#
>> +config FAULT_AROUND_ORDER
>> +	int
>> +	default	4
>> +
>>  # eventually, we can have this option just 'select SPARSEMEM'
>>  config MEMORY_HOTPLUG
>>  	bool "Allow for memory hot-add"
>> diff --git a/mm/memory.c b/mm/memory.c
>> index d0f0bef..457436d 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3382,11 +3382,9 @@ void do_set_pte(struct vm_area_struct *vma, unsigned long address,
>>  	update_mmu_cache(vma, address, pte);
>>  }
>>  
>> -#define FAULT_AROUND_ORDER 4
>> +unsigned int fault_around_order = CONFIG_FAULT_AROUND_ORDER;
>>  
>>  #ifdef CONFIG_DEBUG_FS
>> -static unsigned int fault_around_order = FAULT_AROUND_ORDER;
>> -
>>  static int fault_around_order_get(void *data, u64 *val)
>>  {
>>  	*val = fault_around_order;
>> @@ -3395,7 +3393,6 @@ static int fault_around_order_get(void *data, u64 *val)
>>  
>>  static int fault_around_order_set(void *data, u64 val)
>>  {
>> -	BUILD_BUG_ON((1UL << FAULT_AROUND_ORDER) > PTRS_PER_PTE);
>>  	if (1UL << val > PTRS_PER_PTE)
>>  		return -EINVAL;
>>  	fault_around_order = val;
>> @@ -3430,14 +3427,14 @@ static inline unsigned long fault_around_pages(void)
>>  {
>>  	unsigned long nr_pages;
>>  
>> -	nr_pages = 1UL << FAULT_AROUND_ORDER;
>> +	nr_pages = 1UL << fault_around_order;
>>  	BUILD_BUG_ON(nr_pages > PTRS_PER_PTE);
> 
> This BUILD_BUG_ON() doesn't make sense any more since compiler usually can't
> prove anything about extern variable.
> 
> Drop it or change to VM_BUG_ON() or something.
> 

Ok.

>>  	return nr_pages;
>>  }
>>  
>>  static inline unsigned long fault_around_mask(void)
>>  {
>> -	return ~((1UL << (PAGE_SHIFT + FAULT_AROUND_ORDER)) - 1);
>> +	return ~((1UL << (PAGE_SHIFT + fault_around_order)) - 1);
> 
> fault_around_pages() and fault_around_mask() should be moved outside of
> #ifdef CONFIG_DEBUG_FS and consolidated since they are practically identical
> both branches after the changes.
> 

Agreed. Will change it.

>>  }
>>  #endif
>>  
>> @@ -3495,7 +3492,7 @@ static int do_read_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>  	 * if page by the offset is not ready to be mapped (cold cache or
>>  	 * something).
>>  	 */
>> -	if (vma->vm_ops->map_pages) {
>> +	if ((vma->vm_ops->map_pages) && (fault_around_order)) {
> 
> Way too many parentheses.
> 

Sure. Will modify it.

Thanks for review
with regards
Maddy
>>  		pte = pte_offset_map_lock(mm, pmd, address, &ptl);
>>  		do_fault_around(vma, address, pte, pgoff, flags);
>>  		if (!pte_same(*pte, orig_pte))
