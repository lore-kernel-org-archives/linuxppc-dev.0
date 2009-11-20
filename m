Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C62751007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 11:14:58 +1100 (EST)
Date: Thu, 19 Nov 2009 16:14:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [patch 3/3] [v2] powerpc: make the CMM memory hotplug aware
Message-Id: <20091119161403.93bd5756.akpm@linux-foundation.org>
In-Reply-To: <20091118185907.GA30950@austin.ibm.com>
References: <200911172240.nAHMeHgE021202@imap1.linux-foundation.org>
	<20091118185907.GA30950@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mel@csn.ul.ie, geralds@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, brking@linux.vnet.ibm.com, mingo@elte.hu,
	schwidefsky@de.ibm.com, kamezawa.hiroyu@jp.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 18 Nov 2009 12:59:08 -0600
Robert Jennings <rcj@linux.vnet.ibm.com> wrote:

> The Collaborative Memory Manager (CMM) module allocates individual pages
> over time that are not migratable.  On a long running system this can
> severely impact the ability to find enough pages to support a hotplug
> memory remove operation.
> 
> This patch adds a memory isolation notifier and a memory hotplug notifier.
> The memory isolation notifier will return the number of pages found
> in the range specified.  This is used to determine if all of the used
> pages in a pageblock are owned by the balloon (or other entities in
> the notifier chain).  The hotplug notifier will free pages in the range
> which is to be removed.  The priority of this hotplug notifier is low
> so that it will be called near last, this helps avoids removing loaned
> pages in operations that fail due to other handlers.
> 
> CMM activity will be halted when hotplug remove operations are active
> and resume activity after a delay period to allow the hypervisor time
> to adjust.
> 
> Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
> Cc: Mel Gorman <mel@csn.ul.ie>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Brian King <brking@linux.vnet.ibm.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Gerald Schaefer <geralds@linux.vnet.ibm.com>
> Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> ---
> The pages used to track loaned pages should not be marked as MOVABLE, so
> they need to be handled during a memory offline event.
> 
> Changes:
>  * The structures for recording loaned pages are not allocated as MOVABLE
>  * The structures for recording loaned pages are removed from sections
>    being taken offline by moving their contents to a newly allocated page.
> 
>  arch/powerpc/platforms/pseries/cmm.c |  254 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 248 insertions(+), 6 deletions(-)

Incremental patch is:

: --- a/arch/powerpc/platforms/pseries/cmm.c~powerpc-make-the-cmm-memory-hotplug-aware-update
: +++ a/arch/powerpc/platforms/pseries/cmm.c
: @@ -148,8 +148,7 @@ static long cmm_alloc_pages(long nr)
:  			spin_unlock(&cmm_lock);
:  			npa = (struct cmm_page_array *)__get_free_page(
:  					GFP_NOIO | __GFP_NOWARN |
: -					__GFP_NORETRY | __GFP_NOMEMALLOC |
: -					__GFP_MOVABLE);
: +					__GFP_NORETRY | __GFP_NOMEMALLOC);
:  			if (!npa) {
:  				pr_info("%s: Can not allocate new page list\n", __func__);
:  				free_page(addr);
: @@ -480,6 +479,8 @@ static unsigned long cmm_count_pages(voi
:  	spin_lock(&cmm_lock);
:  	pa = cmm_page_list;
:  	while (pa) {
: +		if ((unsigned long)pa >= start && (unsigned long)pa < end)
: +			marg->pages_found++;
:  		for (idx = 0; idx < pa->index; idx++)
:  			if (pa->page[idx] >= start && pa->page[idx] < end)
:  				marg->pages_found++;
: @@ -531,7 +532,7 @@ static int cmm_mem_going_offline(void *a
:  	struct memory_notify *marg = arg;
:  	unsigned long start_page = (unsigned long)pfn_to_kaddr(marg->start_pfn);
:  	unsigned long end_page = start_page + (marg->nr_pages << PAGE_SHIFT);
: -	struct cmm_page_array *pa_curr, *pa_last;
: +	struct cmm_page_array *pa_curr, *pa_last, *npa;
:  	unsigned long idx;
:  	unsigned long freed = 0;
:  
: @@ -539,6 +540,7 @@ static int cmm_mem_going_offline(void *a
:  			start_page, marg->nr_pages);
:  	spin_lock(&cmm_lock);
:  
: +	/* Search the page list for pages in the range to be offlined */
:  	pa_last = pa_curr = cmm_page_list;
:  	while (pa_curr) {
:  		for (idx = (pa_curr->index - 1); (idx + 1) > 0; idx--) {
: @@ -563,6 +565,37 @@ static int cmm_mem_going_offline(void *a
:  		}
:  		pa_curr = pa_curr->next;
:  	}
: +
: +	/* Search for page list structures in the range to be offlined */
: +	pa_last = NULL;
: +	pa_curr = cmm_page_list;
: +	while (pa_curr) {
: +		if (((unsigned long)pa_curr >= start_page) &&
: +				((unsigned long)pa_curr < end_page)) {
: +			npa = (struct cmm_page_array *)__get_free_page(
: +					GFP_NOIO | __GFP_NOWARN |
: +					__GFP_NORETRY | __GFP_NOMEMALLOC);
: +			if (!npa) {
: +				spin_unlock(&cmm_lock);
: +				cmm_dbg("Failed to allocate memory for list "
: +						"management. Memory hotplug "
: +						"failed.\n");
: +				return ENOMEM;
: +			}
: +			memcpy(npa, pa_curr, PAGE_SIZE);
: +			if (pa_curr == cmm_page_list)
: +				cmm_page_list = npa;
: +			if (pa_last)
: +				pa_last->next = npa;
: +			free_page((unsigned long) pa_curr);
: +			freed++;
: +			pa_curr = npa;
: +		}
: +
: +		pa_last = pa_curr;
: +		pa_curr = pa_curr->next;
: +	}
: +
:  	spin_unlock(&cmm_lock);
:  	cmm_dbg("Released %ld pages in the search range.\n", freed);
:  

I'm wondering what is the maximum hold time of cmm_lock.  Rounded to
the nearest fortnight :)
