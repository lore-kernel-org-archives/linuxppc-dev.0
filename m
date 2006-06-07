Return-Path: <mel@csn.ul.ie>
Received: from calculon.skynet.ie (calculon.skynet.ie [193.1.99.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0939467B44
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 02:25:39 +1000 (EST)
Date: Wed, 7 Jun 2006 17:25:33 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 0/5] Sizing zones and holes in an architecture independent
	manner V7
In-Reply-To: <200606071720.22242.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0606071718380.31410@skynet.skynet.ie>
References: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie>
	<200606071216.24640.ak@suse.de>
	<Pine.LNX.4.64.0606071118230.20653@skynet.skynet.ie>
	<200606071720.22242.ak@suse.de>
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
>> Ok, while true, I'm not sure how it affects performance. The only "real"
>> value affected by present_pages is the number of patches that are
>> allocated in batches to the per-cpu allocator.
>
> It affects the low/high water marks in the VM zone balancer.
>

ok, that's true. The watermarks would be higher if memmap and the kernel 
image is not taken into account. Arguably, the same applies to bootmem 
allocations. This hits all architectures *except* x86_64.

> Especially for the 16MB DMA zone it can make a difference if you
> account 4MB kernel in there or not.
>

I'm guessing it's a difficult-to-trigger problem or it would have been 
reported for other arches. Assuming it can be triggered and that is what 
was causing your problems, it's still worth fixing in the arch-independent 
code rather than burying it in arch/somewhere, right?

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
