Return-Path: <mgorman@techsingularity.net>
Received: from outbound-smtp05.blacknight.com (outbound-smtp05.blacknight.com
 [81.17.249.38])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5N1Q4Fx0zDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 20:13:30 +1000 (AEST)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
 by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id EFD5A98DD0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 10:06:10 +0000 (UTC)
Date: Fri, 5 Aug 2016 11:06:09 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Dave Hansen <dave.hansen@intel.com>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] fadump: Register the memory reserved by fadump
Message-ID: <20160805100609.GP2799@techsingularity.net>
References: <1470318165-2521-1-git-send-email-srikar@linux.vnet.ibm.com>
 <87mvkritii.fsf@concordia.ellerman.id.au>
 <20160805072838.GF11268@linux.vnet.ibm.com>
 <87h9azin4g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <87h9azin4g.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 05, 2016 at 07:25:03PM +1000, Michael Ellerman wrote:
> > One way to do that would be to walk through the different memory
> > reserved blocks and calculate the size. But Mel feels thats an
> > overhead (from his reply to the other thread) esp for just one use
> > case.
> 
> OK. I think you're referring to this:
> 
>   If fadump is reserving memory and alloc_large_system_hash(HASH_EARLY)
>   does not know about then then would an arch-specific callback for
>   arch_reserved_kernel_pages() be more appropriate?
>   ...
>   
>   That approach would limit the impact to ppc64 and would be less costly than
>   doing a memblock walk instead of using nr_kernel_pages for everyone else.
> 
> That sounds more robust to me than this solution.
> 

It would be the fastest with the least impact but not necessarily the
best. Ultimately that dma_reserve/memory_reserve is used for the sizing
calculation of the large system hashes but only the e820 map and fadump
is taken into account. That's a bit filthy even if it happens to work out ok.

Conceptually it would be cleaner, if expensive, to calculate the real
memblock reserves if HASH_EARLY and ditch the dma_reserve, memory_reserve
and nr_kernel_pages entirely. Unfortuantely, aside from the calculation,
there is a potential cost due to a smaller hash table that affects everyone,
not just ppc64. However, if the hash table is meant to be sized on the
number of available pages then it really should be based on that and not
just a made-up number.

-- 
Mel Gorman
SUSE Labs
