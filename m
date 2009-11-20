Return-Path: <rcjenn@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 44649B6ED0
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Nov 2009 03:11:10 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAKG8lBX020717
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 09:08:47 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAKGAj2T100112
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 09:10:46 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAKGAgKP020594
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 09:10:44 -0700
Date: Fri, 20 Nov 2009 10:10:42 -0600
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/3] [v2] powerpc: make the CMM memory hotplug aware
Message-ID: <20091120161041.GB18138@austin.ibm.com>
References: <200911172240.nAHMeHgE021202@imap1.linux-foundation.org>
	<20091118185907.GA30950@austin.ibm.com>
	<20091119161403.93bd5756.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091119161403.93bd5756.akpm@linux-foundation.org>
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

* Andrew Morton (akpm@linux-foundation.org) wrote:
> On Wed, 18 Nov 2009 12:59:08 -0600
> Robert Jennings <rcj@linux.vnet.ibm.com> wrote:
> 
> > The Collaborative Memory Manager (CMM) module allocates individual pages
> > over time that are not migratable.  On a long running system this can
> > severely impact the ability to find enough pages to support a hotplug
> > memory remove operation.
> > 
> > This patch adds a memory isolation notifier and a memory hotplug notifier.
<snip>
> : @@ -563,6 +565,37 @@ static int cmm_mem_going_offline(void *a
> :  		}
> :  		pa_curr = pa_curr->next;
> :  	}
> : +
> : +	/* Search for page list structures in the range to be offlined */
> : +	pa_last = NULL;
> : +	pa_curr = cmm_page_list;
> : +	while (pa_curr) {
> : +		if (((unsigned long)pa_curr >= start_page) &&
> : +				((unsigned long)pa_curr < end_page)) {
> : +			npa = (struct cmm_page_array *)__get_free_page(
> : +					GFP_NOIO | __GFP_NOWARN |
> : +					__GFP_NORETRY | __GFP_NOMEMALLOC);
> : +			if (!npa) {
> : +				spin_unlock(&cmm_lock);
> : +				cmm_dbg("Failed to allocate memory for list "
> : +						"management. Memory hotplug "
> : +						"failed.\n");
> : +				return ENOMEM;
> : +			}
> : +			memcpy(npa, pa_curr, PAGE_SIZE);
> : +			if (pa_curr == cmm_page_list)
> : +				cmm_page_list = npa;
> : +			if (pa_last)
> : +				pa_last->next = npa;
> : +			free_page((unsigned long) pa_curr);
> : +			freed++;
> : +			pa_curr = npa;
> : +		}
> : +
> : +		pa_last = pa_curr;
> : +		pa_curr = pa_curr->next;
> : +	}
> : +
> :  	spin_unlock(&cmm_lock);
> :  	cmm_dbg("Released %ld pages in the search range.\n", freed);
> :  
> 
> I'm wondering what is the maximum hold time of cmm_lock.  Rounded to
> the nearest fortnight :)

I've optimized this for sub-fortnight performance, but the maximum
hold time is a function of the number of pages in the balloon and in the
infreqent case that we try to migrate a page array page it will attempt
a page allocation.  I'm calling __get_free_pages with __GFP_NORETRY and
the offline fails quickly if we don't get the page.  Additionally, the
cmm_lock could be held by either the balloon allocation or deallocation
functions when the hotplug handler is called; I've addressed this as well.

For the allocation path the locking granularity is quite good and
a hotplug event will cause the allocation function to exit early to
minimize memory pressure.

The balloon deallocation path was not altered, it will hold the lock
and free all of the pages it was attempting to free before releasing the
lock.  The thought here is that by allowing it to complete we reduce
memory pressure and reduce the number of list entries we'll need to
search for each memory segment being offlined.
