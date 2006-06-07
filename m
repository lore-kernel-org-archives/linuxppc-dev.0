Return-Path: <mel@csn.ul.ie>
Received: from calculon.skynet.ie (calculon.skynet.ie [193.1.99.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9EEF67B4C
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 20:12:02 +1000 (EST)
Date: Wed, 7 Jun 2006 11:11:57 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 0/5] Sizing zones and holes in an architecture independent
	manner V7
In-Reply-To: <200606071145.04938.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0606071059480.20653@skynet.skynet.ie>
References: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie>
	<20060606164311.27d4af98.akpm@osdl.org>
	<Pine.LNX.4.64.0606071030100.20653@skynet.skynet.ie>
	<200606071145.04938.ak@suse.de>
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

>> Spanned pages and holes will be different on
>> x86_64 because I don't account the kernel image and memmap as holes.
>
> That's a significant inaccuracy and may give worse VM results.
>

Right now, x86_64 seems to be the only arch that accounts for the kernel 
image and memmap as holes so I would consider it to be unusual. For memory 
hot-add, new memmaps are allocated using kmalloc() and are not accounted 
for as holes. So, on x86_64, some memmaps are holes and others are not.

Why is it a performance regression if the image and memmap is accounted 
for as holes? How are those regions different from any other kernel 
allocation or bootmem allocations for example which are not accounted as 
holes? Bear in mind that when I said "I don't account the kernel image and 
memmap as holes", the spanned_pages value remains the same, the value of 
present_pages is greater but the starting number of free pages should be 
more or less the same.

If you are sure that it makes a measurable difference to performance, I 
can work on adding a new call unregister_active_region() that allows an 
arch to account for arbitrary pfn ranges as holes. This could be used for 
kernel images, memmaps and probably the first contiguous allocated block 
used by the bootmem allocator. However, I'm not sure it is worth the 
effort. That said, if it *is* worth the effort, all architectures using 
the arch-independent zone-sizing would benefit, not just x86_64.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
