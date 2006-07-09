Return-Path: <mel@csn.ul.ie>
Received: from calculon.skynet.ie (calculon.skynet.ie [193.1.99.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E560967B56
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 01:32:38 +1000 (EST)
Date: Sun, 9 Jul 2006 16:32:32 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 0/6] Sizing zones and holes in an architecture independent
	manner V8
In-Reply-To: <20060708114201.GA9419@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.64.0607091624560.28189@skynet.skynet.ie>
References: <20060708111042.28664.14732.sendpatchset@skynet.skynet.ie>
	<20060708114201.GA9419@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: akpm@osdl.org, davej@codemonkey.org.uk, tony.luck@intel.com,
	linux-mm@kvack.org, ak@suse.de, bob.picco@hp.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 8 Jul 2006, Heiko Carstens wrote:

> On Sat, Jul 08, 2006 at 12:10:42PM +0100, Mel Gorman wrote:
>> There are differences in the zone sizes for x86_64 as the arch-specific code
>> for x86_64 accounts the kernel image and the starting mem_maps as memory
>> holes but the architecture-independent code accounts the memory as present.
>
> Shouldn't this be the same for all architectures?

The comment in the mail is inaccurate because patch 6/6 will account for 
the kernel image and mem_map as holes for all architectures if it is 
merged. The patch could be submitted independent of arch-independent 
zone-sizing.

> Or to put it in other words:
> why does only x86_64 account the kernel image as memory hole?
>

>From Andi Kleen's mails in the thread "[PATCH 0/5] Sizing zones and holes 
in an architecture independent manner V7"

>>> Begin extract <<<

> Why is it a performance regression if the image and memmap is accounted
> for as holes? How are those regions different from any other kernel
> allocation or bootmem allocations for example which are not accounted as
> holes?

They are comparatively big and cannot be freed.

>If you are sure that it makes a measurable difference to performance,

There was at least one benchmark/use case where it made a significant
difference, can't remember the exact numbers though.

It affects the low/high water marks in the VM zone balancer.

Especially for the 16MB DMA zone it can make a difference if you
account 4MB kernel in there or not.

>>> End extract <<<

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
