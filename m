Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F4F82C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 17:53:58 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 10 Apr 2013 17:44:51 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 348902CE8053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 17:53:40 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3A7eMpw26280118
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 17:40:22 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3A7rd2r018847
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 17:53:40 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH -V5 06/25] powerpc: Reduce PTE table memory wastage
In-Reply-To: <20130410070403.GH8165@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130410044611.GF8165@truffula.fritz.box>
 <8738uyq4om.fsf@linux.vnet.ibm.com>
 <20130410070403.GH8165@truffula.fritz.box>
Date: Wed, 10 Apr 2013 13:23:25 +0530
Message-ID: <87r4iiom8a.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <dwg@au1.ibm.com> writes:

> On Wed, Apr 10, 2013 at 11:59:29AM +0530, Aneesh Kumar K.V wrote:
>> David Gibson <dwg@au1.ibm.com> writes:
>> > On Thu, Apr 04, 2013 at 11:27:44AM +0530, Aneesh Kumar K.V wrote:
> [snip]
>> >> @@ -97,13 +100,45 @@ void __destroy_context(int context_id)
>> >>  }
>> >>  EXPORT_SYMBOL_GPL(__destroy_context);
>> >>  
>> >> +#ifdef CONFIG_PPC_64K_PAGES
>> >> +static void destroy_pagetable_page(struct mm_struct *mm)
>> >> +{
>> >> +	int count;
>> >> +	struct page *page;
>> >> +
>> >> +	page = mm->context.pgtable_page;
>> >> +	if (!page)
>> >> +		return;
>> >> +
>> >> +	/* drop all the pending references */
>> >> +	count = atomic_read(&page->_mapcount) + 1;
>> >> +	/* We allow PTE_FRAG_NR(16) fragments from a PTE page */
>> >> +	count = atomic_sub_return(16 - count, &page->_count);
>> >
>> > You should really move PTE_FRAG_NR to a header so you can actually use
>> > it here rather than hard coding 16.
>> >
>> > It took me a fair while to convince myself that there is no race here
>> > with something altering mapcount and count between the atomic_read()
>> > and the atomic_sub_return().  It could do with a comment to explain
>> > why that is safe.
>> >
>> > Re-using the mapcount field for your index also seems odd, and it took
>> > me a while to convince myself that that's safe too.  Wouldn't it be
>> > simpler to store a pointer to the next sub-page in the mm_context
>> > instead? You can get from that to the struct page easily enough with a
>> > shift and pfn_to_page().
>> 
>> I found using _mapcount simpler in this case. I was looking at it not
>> as an index, but rather how may fragments are mapped/used already.
>
> Except that it's actually (#fragments - 1).  Using subpage pointer
> makes the fragments calculation (very slightly) harder, but the
> calculation of the table address easier.  More importantly it avoids
> adding effectively an extra variable - which is then shoehorned into a
> structure not really designed to hold it.

Even with subpage pointer we would need mm->context.pgtable_page or
something similar. We don't add any other extra variable right ?. Let me
try what you are suggesting here and see if that make it simpler.


>> Using
>> subpage pointer in mm->context.xyz means, we have to calculate the
>> number of fragments used/mapped via the pointer. We need the fragment
>> count so that we can drop page reference count correctly here.
>> 
>> 
>> >
>> >> +	if (!count) {
>> >> +		pgtable_page_dtor(page);
>> >> +		reset_page_mapcount(page);
>> >> +		free_hot_cold_page(page, 0);
>> >
>> > It would be nice to use put_page() somehow instead of duplicating its
>> > logic, though I realise the sparc code you've based this on does the
>> > same thing.
>> 
>> That is not exactly put_page. We can avoid lots of check in this
>> specific case.
>
> [snip]
>> >> +static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
>> >> +{
>> >> +	pte_t *ret = NULL;
>> >> +	struct page *page = alloc_page(GFP_KERNEL | __GFP_NOTRACK |
>> >> +				       __GFP_REPEAT | __GFP_ZERO);
>> >> +	if (!page)
>> >> +		return NULL;
>> >> +
>> >> +	spin_lock(&mm->page_table_lock);
>> >> +	/*
>> >> +	 * If we find pgtable_page set, we return
>> >> +	 * the allocated page with single fragement
>> >> +	 * count.
>> >> +	 */
>> >> +	if (likely(!mm->context.pgtable_page)) {
>> >> +		atomic_set(&page->_count, PTE_FRAG_NR);
>> >> +		atomic_set(&page->_mapcount, 0);
>> >> +		mm->context.pgtable_page = page;
>> >> +	}
>> >
>> > .. and in the unlikely case where there *is* a pgtable_page already
>> > set, what then?  Seems like you should BUG_ON, or at least return NULL
>> > - as it is you will return the first sub-page of that page again,
>> > which is very likely in use.
>> 
>> 
>> As explained in the comment above, we return with the allocated page
>> with fragment count set to 1. So we end up having only one fragment. The
>> other option I had was to to free the allocated page and do a
>> get_from_cache under the page_table_lock. But since we already allocated
>> the page, why not use that ?. It also keep the code similar to
>> sparc.
>
> My point is that I can't see any circumstance under which we should
> ever hit this case.  Which means if we do something is badly messed up
> and we should BUG() (or at least WARN()).

A multi threaded test would easily hit that. stream is the test I used.

-aneesh
