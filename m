Message-ID: <3ABA441C.6261BC52@mvista.com>
Date: Thu, 22 Mar 2001 13:27:40 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rblach@intrex.net>
Cc: linuxppc-embedded@lists.linuxppc.org,
	David Blythe <blythe@routefree.com>
Subject: Re: Proposed new kernel noncaching memory allocator for the 405gp
References: <3ABA1B6A.87C5FE9B@intrex.net> <3ABA291D.A7A82D8A@mvista.com> <3ABA3A5B.2EFA8D6D@intrex.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:

> Using these in the OHCI driver would greatly simply the driver because the
> TD would not be cached.

I'm not sure that is for us to decide.  I don't really want to
know that much detail about USB, and the experts that ported these
drivers to processors without cache coherent DMA requested the
functions as you see them now.  If they decide they want something
different, we'll provide those.  The IBM4xx is a late-comer to
the issues of ensuring cache coherency, and all we are doing is
adopting existing functions that standard Linux software has been
using on other platforms.


> Where are these functions that you say you have implemented?

arch/ppc/8xx_io/commproc.c allocates one (or more) pages of memory
during early initialization, marks them uncached, and will allocate
a few bytes for some drivers.  I think only the uart driver uses
this right now for allocating its DMA FIFOs.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
