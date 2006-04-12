Return-Path: <mel@skynet.ie>
Received: from holly.csn.ul.ie (holly.csn.ul.ie [193.1.99.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E36B367C48
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 03:32:49 +1000 (EST)
Date: Wed, 12 Apr 2006 18:32:42 +0100 (IST)
From: Mel Gorman <mel@skynet.ie>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
	independent manner
In-Reply-To: <20060412170726.GA11143@agluck-lia64.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0604121818200.7697@skynet.skynet.ie>
References: <20060411103946.18153.83059.sendpatchset@skynet>
	<20060411222029.GA7743@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie>
	<20060412000500.GA8532@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
	<20060412154633.GA10589@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604121657380.24819@skynet.skynet.ie>
	<20060412170726.GA11143@agluck-lia64.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, ak@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bob.picco@hp.com, davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 12 Apr 2006, Luck, Tony wrote:

> On Wed, Apr 12, 2006 at 05:00:32PM +0100, Mel Gorman wrote:
>> Patch is attached as 105-ia64_use_init_nodes.patch until I beat sense into
>> my mail setup. I've added Bob Picco to the cc list as he will hit the same
>> issue with whitespace corruption.
>
> Next I tried building a "generic" kernel (using arch/ia64/defconfig). This
> has NUMA=y and DISCONTIG=y).  This crashes with the following console log.
>
>
> <snipped>
> add_active_range(0, 0, 4096): New
> add_active_range(0, 0, 131072): New
> add_active_range(0, 0, 131072): New
> add_active_range(0, 393216, 523264): New
> add_active_range(0, 393216, 523264): New
> add_active_range(0, 393216, 524288): New
> add_active_range(0, 393216, 524288): New

This is where it started going wrong. I did not expect add_active_range() 
to be called with overlapping PFNs so they were not getting merged. If 
they were getting merged correctly, I'd expect the output to be

add_active_range(0, 0, 4096): New
add_active_range(0, 0, 131072): Merging forward
add_active_range(0, 0, 131072): Merging forward
add_active_range(0, 393216, 523264): New
add_active_range(0, 393216, 523264): Merging forward
add_active_range(0, 393216, 524288): Merging forward
add_active_range(0, 393216, 524288): Merging forward

> Virtual mem_map starts at 0xa0007ffffe400000
> Dumping sorted node map
> entry 0: 0  0 -> 131072
> entry 1: 0  0 -> 4096
> entry 2: 0  0 -> 131072
> entry 3: 0  393216 -> 523264
> entry 4: 0  393216 -> 524288
> entry 5: 0  393216 -> 524288
> entry 6: 0  393216 -> 523264
> Hole found index 0: 0 -> 0
> prev_end > start_pfn : 131072 > 0

And here is where it goes BLAM. Without the debugging patch, the check is 
just;

BUG_ON(prev_end_pfn > start_pfn);

The error I was *expecting* to catch was an unsorted node map. It's just 
nice it caught this situation as well. It'll take a while to fix this up 
properly.

Thanks

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
