Message-ID: <38C862A6.224DBDF3@embeddededge.com>
Date: Thu, 09 Mar 2000 21:49:10 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Greg Johnson <gjohnson@research.canon.com.au>
CC: Linux PPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: User buffers and cache flushing.
References: <20000310010235.6B0D3355C8@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greg Johnson wrote:

> ....Since I
> am not wanting to be double handling this data, and the data will
> most likely be fragmented in memory,

That's no problem, CPM buffer descriptors are made for that.


> ....and call flush_dcache_range on each of these fragments.

Depends upon how the data is handled.  In some cases I find it is
faster to just map the pages uncached and skip the cache push.  Do
some system design and analysis to determine what works best.

> Have I overlooked anything? (other than the lack of support for IDMA
> currently in the MPC8xx kernel)

This is pretty trivial, considering all CPM devices use the same DMA
engine as IDMA.  Take an existing driver, rip the guts of data comm
out of it, and you nearly have the IDMA driver.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
