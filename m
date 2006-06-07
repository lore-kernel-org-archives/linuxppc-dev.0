Return-Path: <mel@csn.ul.ie>
Received: from calculon.skynet.ie (calculon.skynet.ie [193.1.99.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DBE81679FD
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 20:54:19 +1000 (EST)
Date: Wed, 7 Jun 2006 11:54:14 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 0/5] Sizing zones and holes in an architecture independent
	manner V7
In-Reply-To: <200606071216.24640.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0606071118230.20653@skynet.skynet.ie>
References: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie>
	<200606071145.04938.ak@suse.de>
	<Pine.LNX.4.64.0606071059480.20653@skynet.skynet.ie>
	<200606071216.24640.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk, tony.luck@intel.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	bob.picco@hp.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 7 Jun 2006, Andi Kleen wrote:

>
>> Right now, x86_64 seems to be the only arch that accounts for the kernel
>> image and memmap as holes so I would consider it to be unusual.
>
> s/unusual/more advanced/
>

Ok, debatable, but lets assume that to be true. On the same assumption, it 
would be desirable for all other architectures.

>> For memory
>> hot-add, new memmaps are allocated using kmalloc() and are not accounted
>> for as holes.
>
> At least in the standard (non sparsemem) hotadd they are accounted afaik.
>

Indirectly, yes, and again only on x86_64 I *think*. On x86_64, I believe 
what you do is setup a memmap for a region that will be later used for 
hotplug but is not backed by real memory at boottime. In that case, you 
have extra memmap that is not backed by real pages and the spare memmap 
gets accounted for as a hole.

>> So, on x86_64, some memmaps are holes and others are not.
>>
>> Why is it a performance regression if the image and memmap is accounted
>> for as holes? How are those regions different from any other kernel
>> allocation or bootmem allocations for example which are not accounted as
>> holes?
>
> They are comparatively big and cannot be freed.
>

Ok, while true, I'm not sure how it affects performance. The only "real" 
value affected by present_pages is the number of patches that are 
allocated in batches to the per-cpu allocator. If the following held true;

1. Many CPUs are using one one node
2. The node was mainly consumed by memmap
3. ((present_pages - pages_in_memmap) / 1024) < (NUM_CPUS)

Then we would probably see free pages been left on per-cpu lists and 
remote nodes been used that accounting for memmap as holes might have 
helped. But in that case, there are so few free pages on the node anyway, 
you are going to see regressions unless the workload is fairly small.

page reclaim *used* to use present_pages for some decisions but it was 
really concerned with present_pages == 0. Not sure how I would trigger a 
regression there.

>> If you are sure that it makes a measurable difference to performance,
>
> There was at least one benchmark/use case where it made a significant
> difference, can't remember the exact numbers though.
>

If this case can be resurrected, I will check it out and report if the 
difference can be measured. If it is, I will write support for 
unregister_active_range() which will be used during boot to account for 
PFN ranges as holes. alloc_node_mem_map() could use it to account for 
memmaps and architectures can account for the kernel image if they want. 
Then the benefit will be for many architectures, not just a poorly 
understood feature buried in x86_64.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
