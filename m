Date: Tue, 12 Dec 2000 09:26:47 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: Graham Stoney <greyham@research.canon.com.au>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
In-Reply-To: <20001212133658.C1773@brixi.research.canon.com.au>
Message-ID: <Pine.GSO.4.21.0012120915570.24199-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 12 Dec 2000, Graham Stoney wrote:

> Also, doesn't the 8260 have seperate memory subsystems to help get
> around this?
>
I assume you are referring to the local bus?  Well yes, but there are large
tradeoffs.

If you use the local bus for the receive buffers then you can have
simultaneous CPM to local bus and CPU to 60x bus transactions.  The catch
is that the local bus can not be cached.  So, you trade off bus contention
for caching/bursting.  The CPU must go across the 60x to local bus bridge
for those transactions.  The DMA engine can burst between the 60x and
local busses.

If the data has to end up in user space, it ends up being about a
wash, given the checksum and user space copy.  I need more testing to
confirm this, though.  If the user space copy was not needed, like for
routing, then it might help some.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
