Subject: Re: Proposed changes to io.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Whitney <johnw@sands-edge.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <43B0E668-84BC-11D8-9FF0-000A95A07384@sands-edge.com>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com>
	 <1080787943.1434.47.camel@gaston>
	 <209F76E4-838B-11D8-9FF0-000A95A07384@sands-edge.com>
	 <1080790433.1433.59.camel@gaston>
	 <43B0E668-84BC-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain
Message-Id: <1080961463.1426.82.camel@gaston>
Mime-Version: 1.0
Date: Sat, 03 Apr 2004 13:04:24 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-04-03 at 01:41, John Whitney wrote:
> > No, you are not supposed to pass an address coming from
> > pci_alloc_consistent() to pci_map_single(), period.
> >
>
> Why take that stance, when a simple change to virt_to_phys() makes all
> virtual addresses coming from any routine work correctly?  Would that
> be far simpler system under which to implement code, with less prone to
> error (no need to worry about making sure you have the "correct"
> virtual memory type for a given routine - all virtual memory addresses
> would work).  This just sounds entirely political, and very little
> practical.

No. virt_to_phys() operates on the linear mapping only, that has
always been the case, doing otherwise would be non portable anyway.

I think we should deprecate virt_to_phys() anyway and use __pa in
the arch code, that would avoid people trying to use it for what it
is not.

Regarding pci_map_single(), it's semantics are clear regarding the
kind of memory it can map. Doing a ppc only hack to make the nonsense
work (passing it memory obtained by pci_alloc_consistent) would be
letting drivers writers do the wrong thing on ppc and break whenever
they port the driver to a platform that enforce that limitation.

We could add a runtime check to pci_map_single() to verify it gets
passed an address within the linear mapping though. That would catch
the bugs you are afraid of.

(Oh, and let's keep those discussions on-list).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
