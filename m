Message-ID: <3CF51E31.6000302@embeddededge.com>
Date: Wed, 29 May 2002 14:30:09 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Neil Wilson <nwilson@airspan.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pci_consistent_alloc & mpc107 snoop
References: <002101c20736$bb52f640$7c99883e@m5axc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Wilson wrote:

> I hope someone can enlighten me .....

Heh :-)

> Am I right in thinking that pci_consistent_alloc gets me
> uncached memory ?, if not is there an easy way to modify the pages allocated
> ?

It's gets memory for you that is dma consistent, not necessarily uncached.
It will be uncached on processors that don't have cache snooping, but
it will be cached on processors that are known to snoop the bus.


> Our hardware designer therefore wants the pci ethernet to use uncached
> buffers &
> also to have the 107 pci snoop disabled.

Linux usually assumes major hardware features work :-)  There are working
boards with 7450/107 combinations.  I don't know what your fpga may be
doing that causes problems.

> ....  I have disabled snoop in the boot
> code (ppcboot) and the ethernet card still works, but now it does not work
> under Linux (it used to be fine with snoop enabled, nfs etc all worked).

You need to tell Linux the processor doesn't support snooping.  There is
a configuration option CONFIG_NOT_COHERENT_CACHE that we use on processors
that don't have cache snooping, but I don't know how well it will work
in your case.  I know the cache management functions are not designed to
work with L2 and L3 caches, so there will be lots of work needed to keep
the caches on a 74xx consistent.


> Any ideas ....?

I would certainly verify this "errata" is causing the trouble before making
the software changes necessary to support a non-snooping 74xx processor.
I'm not sure how much of an "errata" this is or simply the desire to eliminate
some backward compatibility to improve bus performance.  I would also find
a way to measure the performance impact of such a system design, as the
multiple level caches and bus snooping appear to be a significant part of
the system performance.  It seems weird to invest in the power of the 7450 and
then cripple it by not using these features.

Good luck.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
