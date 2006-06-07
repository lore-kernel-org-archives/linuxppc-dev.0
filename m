Return-Path: <mel@csn.ul.ie>
Received: from calculon.skynet.ie (calculon.skynet.ie [193.1.99.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D24E67B4E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 19:42:26 +1000 (EST)
Date: Wed, 7 Jun 2006 10:42:20 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/5] Sizing zones and holes in an architecture independent
	manner V7
In-Reply-To: <20060606164311.27d4af98.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606071030100.20653@skynet.skynet.ie>
References: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie>
	<20060606164311.27d4af98.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linux-mm@kvack.org,
	ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 6 Jun 2006, Andrew Morton wrote:

> On Tue,  6 Jun 2006 14:47:10 +0100 (IST)
> Mel Gorman <mel@csn.ul.ie> wrote:
>
>> This is V7 of the patchset to size zones and memory holes in an
>> architecture-independent manner.
>
> I hope this won't deprive me of my 4 kbyte highmem zone.
>

heh, I think I found the thread you are on about, including your 4kb 
zone.

For future reference, the memory present in zones should be the same 
before and after the patches. Spanned pages and holes will be different on 
x86_64 because I don't account the kernel image and memmap as holes. 
Spanned pages may be different on ia64 as I start nodes on the first real 
page frame, not pfn 0 there and end them at the last real pfn. However, 
present pages should be the same before and after the patch :)

> I won't merge these patches for rc6-mm1 - we already have a few problems in
> this area which I don't think anyone understands yet.
>

I can't argue with that logic as it makes sense with the current 
uncertainties. I'll keep it rebased and resubmit later. In the meantime, 
I'll keep an eye out for issues in -mm that I can hit a kick or two.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
