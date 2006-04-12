Return-Path: <mel@skynet.ie>
Received: from holly.csn.ul.ie (holly.csn.ul.ie [193.1.99.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 436C667B42
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 10:02:26 +1000 (EST)
Date: Wed, 12 Apr 2006 01:02:10 +0100 (IST)
From: Mel Gorman <mel@skynet.ie>
To: Bob Picco <bob.picco@hp.com>
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
	independent manner
In-Reply-To: <20060411232944.GE23742@localhost>
Message-ID: <Pine.LNX.4.64.0604120053080.10268@skynet.skynet.ie>
References: <20060411103946.18153.83059.sendpatchset@skynet>
	<20060411222029.GA7743@agluck-lia64.sc.intel.com>
	<20060411232944.GE23742@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, ak@suse.de, "Luck, Tony" <tony.luck@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 11 Apr 2006, Bob Picco wrote:

> luck wrote:	[Tue Apr 11 2006, 06:20:29PM EDT]
>> On Tue, Apr 11, 2006 at 11:39:46AM +0100, Mel Gorman wrote:
>>
>>> The patches have only been *compile tested* for ia64 with a flatmem
>>> configuration. At attempt was made to boot test on an ancient RS/6000
>>> but the vanilla kernel does not boot so I have to investigate there.
>>
>> The good news: Compilation is clean on the ia64 config variants that
>> I usually build (all 10 of them).
>>
>> The bad (or at least consistent) news: It doesn't boot on an Intel
>> Tiger either (oops at kmem_cache_alloc+0x41).
>>
>> -Tony
> I had a reply queued to report the same failure with
> DISCONTIG+NUMA+VIRTUAL_MEM_MAP.  This was 2 CPU HP rx2600. I'll take a closer
> look at the code tomorrow.
>

hmm, ok, so discontig.c is in use which narrows things down. When 
build_node_maps() is called, I assumed that the start and end pfn passed 
in was for a valid page range. Was this a valid assumption? When I re-read 
the comment, it implies that memory holes could be within this range which 
would cause boot failures. If that is the case, the correct thing to do 
was to call add_active_range() in count_node_pages() instead of 
build_node_maps().

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
