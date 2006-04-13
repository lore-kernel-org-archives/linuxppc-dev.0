Return-Path: <mel@skynet.ie>
Received: from holly.csn.ul.ie (holly.csn.ul.ie [193.1.99.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9688D67CD2
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 10:22:55 +1000 (EST)
Date: Thu, 13 Apr 2006 01:22:47 +0100 (IST)
From: Mel Gorman <mel@skynet.ie>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture
	independent manner V2
In-Reply-To: <200604130153.08604.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0604130058210.18950@skynet.skynet.ie>
References: <20060412232036.18862.84118.sendpatchset@skynet>
	<200604130153.08604.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bob.picco@hp.com,
	Linux Memory Management List <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 13 Apr 2006, Andi Kleen wrote:

> On Thursday 13 April 2006 01:20, Mel Gorman wrote:
>> This is V2 of the patchset. They have been boot tested on x86, ppc64
>> and x86_64 but I still need to do a double check that zones are the
>> same size before and after the patch on all arches. IA64 passed a
>> basic compile-test. a driver program that fed in the values generated
>> by IA64 to add_active_range(), zone_present_pages_in_node() and
>> zone_absent_pages_in_node() seemed to generate expected values.
>
> For x86-64  the new code seems far more complicated than the old one and keeps
> the same information in two places now.

I experimented with the idea of all architectures sharing the struct 
node_active_region rather than storing the information twice. It got very 
messy, particularly for x86 because it needs to store more than nid, 
start_pfn and end_pfn for a range of page frames (see node_memory_chunk_s 
in arch/i386/kernel/srat.c). Worse, some architecture-specific code 
remembers the ranges of active memory as addresses and others as pfn's. In 
the end, I was not too worried about having the information in two places, 
because the active ranges are kept in __initdata and gets freed.

I'll admit that for x86_64, the entire code path for initialisation (i.e. 
architecture specific and architecture independent paths) is now more 
complex. The architecture independent code needed to be able to handle 
every variety of node layout which is overkill for x86_64. Nevertheless, 
without size_zones(), I thought the architecture-specific code for x86_64 
memory initialisation was a bit easier to read. With 
architecture-independent zone size and hole calculation, you only have to 
understand the relevant code once, not once for each architecture.

> I have my doubts that is really a improvement over the old state.
>

For x86_64 in isolation or the entire set of patches?

> I think it would be better if you just defined some simple "library functions"
> that can be called from the architecture specific code instead of adding
> all this new high level code.
>

What sort of library functions would you recommend? x86_64 uses 
add_active_range() and free_area_init_nodes() from this patchset which 
seemed fairly straight-forward.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
