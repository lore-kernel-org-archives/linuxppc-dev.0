Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A81352C029E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2013 04:20:58 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 22 Feb 2013 22:48:21 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DE83B125804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 22:51:39 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1MHKjtG33095920
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 22:50:47 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1MHKnxi002736
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2013 04:20:50 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH -V2 05/21] powerpc: Reduce PTE table memory wastage
In-Reply-To: <20130222052351.GE6139@drongo>
References: <1361465248-10867-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1361465248-10867-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130222052351.GE6139@drongo>
Date: Fri, 22 Feb 2013 22:50:49 +0530
Message-ID: <87y5eguuxa.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

I will reply to the other parts in a seperate email, but the below

>> +static void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table)
>> +{
>> +	struct page *page;
>> +	struct mm_struct *mm;
>> +	unsigned int bit, mask;
>> +
>> +	mm = tlb->mm;
>> +	/* Free 2K page table fragment of a 64K page */
>> +	page = virt_to_page(table);
>> +	bit = 1 << ((__pa(table) & ~PAGE_MASK) / PTE_FRAG_SIZE);
>> +	spin_lock(&mm->page_table_lock);
>> +	/*
>> +	 * stash the actual mask in higher half, and clear the lower half
>> +	 * and selectively, add remove from pgtable list
>> +	 */
>> +	mask = atomic_xor_bits(&page->_mapcount, bit | (bit << FRAG_MASK_BITS));
>> +	if (!(mask & FRAG_MASK))
>> +		list_del(&page->lru);
>> +	else {
>> +		/*
>> +		 * Add the page table page to pgtable_list so that
>> +		 * the free fragment can be used by the next alloc
>> +		 */
>> +		list_del_init(&page->lru);
>> +		list_add_tail(&page->lru, &mm->context.pgtable_list);
>> +	}
>> +	spin_unlock(&mm->page_table_lock);
>> +	tlb_remove_table(tlb, table);
>> +}
>
> This looks like you're allowing a fragment that is being freed to be
> reallocated and used again during the grace period when we are waiting
> for any references to the fragment to disappear.  Doesn't that allow a
> race where one CPU traversing the page table and using the fragment in
> its old location in the tree could see a PTE created after the
> fragment was reallocated?  In other words, why is it safe to allow the
> fragment to be used during the grace period?  If it is safe, it at
> least needs a comment explaining why.
>

We don't allow it to be reallocated during the grace period. The trick
is in the below lines of page_table_alloc()

		/*
		 * Update with the higher order mask bits accumulated,
		 * added as a part of rcu free.
		 */
		mask = mask | (mask >> FRAG_MASK_BITS);

When checking for mask, we also look at the higher order bits.

The reason we add the page back to &mm->context.pgtable_list in
page_table_free_rcu is because we need to have access to struct
mm_struct. We don't have that in the rcu call back. So we add early and
make sure we don't reallocate them, until the grace period is over.

I will definitely add more comments around the code to clarify these details.

-aneesh
