Message-Id: <4.3.2.20001212120541.00bcbe70@falcon.si.com>
Date: Tue, 12 Dec 2000 12:12:49 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: 2.5 or 2.4 kernel profiling
In-Reply-To: <Pine.GSO.4.21.0012120915570.24199-100000@eos>
References: <20001212133658.C1773@brixi.research.canon.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:26 AM 12/12/00 -0600, Brian Ford wrote:

>On Tue, 12 Dec 2000, Graham Stoney wrote:
>
> > Also, doesn't the 8260 have seperate memory subsystems to help get
> > around this?
> >
>I assume you are referring to the local bus?  Well yes, but there are
>large
>tradeoffs.
>
>If you use the local bus for the receive buffers then you can have
>simultaneous CPM to local bus and CPU to 60x bus transactions.  The catch
>is that the local bus can not be cached.  So, you trade off bus contention
>for caching/bursting.  The CPU must go across the 60x to local bus bridge
>for those transactions.  The DMA engine can burst between the 60x and
>local busses.
>
>If the data has to end up in user space, it ends up being about a
>wash, given the checksum and user space copy.  I need more testing to
>confirm this, though.  If the user space copy was not needed, like for
>routing, then it might help some.
>
>--
>Brian Ford
>Software Engineer
>Vital Visual Simulation Systems
>FlightSafety International
>Phone: 314-551-8460
>Fax:   314-551-8444

I've been known to be wrong in the past, and I could be missing an
assumption, but local bus memory is cachable, it just isn't
snoopable.  If you need snooping as a prerequisite for enabling cache,
that would make the local bus effectively uncachable.  It also is 32
bits wide (max) rather than 64 which will affect your bus bandwidth.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
