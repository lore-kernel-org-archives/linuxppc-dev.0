Subject: Re: [PATCH] Workaround for 745x data corruption bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian Waite <linwoes@gmail.com>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	Adrian Cox <adrian@humboldt.co.uk>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <36b714c8040804103826917da1@mail.gmail.com>
References: <1091291276.987.57.camel@localhost>
	 <410E85EE.8050707@mvista.com>  <36b714c804080306175c5dc3f6@mail.gmail.com>
	 <1091580331.1922.42.camel@gaston>
	 <36b714c8040804103826917da1@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1091659414.1862.148.camel@gaston>
Mime-Version: 1.0
Date: Thu, 05 Aug 2004 08:43:34 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-08-05 at 03:38, Brian Waite wrote:
> Ben,
>
> So what kind of aliasing issues do you forsee uner 2.4?

The problem is that the kernel maps all RAM (or as much as it can fit
into 2 BATs) using BATs for the linear mapping at c0000000. This mapping
is cacheable.

If you map, even temporarily, part of your RAM as uncacheable (for DMA
purposes), you end up having 2 different mappings of the same physical
addresses, one cacheable, one non cacheable. The problem is that you may
have

  1) stale data for these physical addresses from before the mapping
     (you have to take care of that by flushing the cache over the area
     when creating the non-cacheable mapping)

  2) CPU speculative load or HW prefetch (most likely speculative load)
     can bring some of those data into the cache via the cacheable
     mapping even though you are not actually reading from the affected
     pages, but only from one nearby (like the one just before).

In both cases, you end up with the possibility that you try to do a non
cacheable access to some space that is also aliased in your cache
somewhere.

This is an undefined behaviour as far as the CPU is concerned. For
example, I think a POWER4 or a G5 will checkstop. I'm not sure what will
happen with the various 74xx but it's definitely not something you can
rely on working properly.

You can of course try to completely avoid non-cacheable mappings and
only do explicit cache invalidate/flushes around DMA operations, but
that would prevent proper implementation of dma_alloc_coherent(), and
I wish you good luck trying to get something like a USB OHCI driver
working with such a scheme.

The solution would be to get rid of the BAT mapping, at least for the
D-BAT, at the expense of kernel performances (possibly significant here)
. The I-BAT must remain though, which can be an issue, I'm not sure how
things will work out at the L2 and L3 caches level...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
