Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Lxd1FQDzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 19:25:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Dave Hansen <dave.hansen@intel.com>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] fadump: Register the memory reserved by fadump
In-Reply-To: <20160805072838.GF11268@linux.vnet.ibm.com>
References: <1470318165-2521-1-git-send-email-srikar@linux.vnet.ibm.com>
 <87mvkritii.fsf@concordia.ellerman.id.au>
 <20160805072838.GF11268@linux.vnet.ibm.com>
Date: Fri, 05 Aug 2016 19:25:03 +1000
Message-ID: <87h9azin4g.fsf@concordia.ellerman.id.au>
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

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:

> * Michael Ellerman <mpe@ellerman.id.au> [2016-08-05 17:07:01]:
>
>> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> 
>> > Fadump kernel reserves large chunks of memory even before the pages are
>> > initialized. This could mean memory that corresponds to several nodes might
>> > fall in memblock reserved regions.
>> >
>> ...
>> > Register the memory reserved by fadump, so that the cache sizes are
>> > calculated based on the free memory (i.e Total memory - reserved
>> > memory).
>> 
>> The memory is reserved, with memblock_reserve(). Why is that not sufficient?
>
> Because at page initialization time, the kernel doesnt know how many
> pages are reserved.

The kernel does know, the fadump code that does the memblock reserve
runs before start_kernel(). AFAIK all calls to alloc_large_system_hash()
are after that.

So the problem seems to be just that alloc_large_system_hash() doesn't
know about reserved memory.

> One way to do that would be to walk through the different memory
> reserved blocks and calculate the size. But Mel feels thats an
> overhead (from his reply to the other thread) esp for just one use
> case.

OK. I think you're referring to this:

  If fadump is reserving memory and alloc_large_system_hash(HASH_EARLY)
  does not know about then then would an arch-specific callback for
  arch_reserved_kernel_pages() be more appropriate?
  ...
  
  That approach would limit the impact to ppc64 and would be less costly than
  doing a memblock walk instead of using nr_kernel_pages for everyone else.

That sounds more robust to me than this solution.

cheers
