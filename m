Date: Wed, 23 Aug 2000 16:11:11 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Ronald Wahl <rwa@peppercon.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
In-Reply-To: <Pine.LNX.4.21.0008231540530.12497-100000@goliath.issistance.de>
Message-ID: <Pine.HPX.4.10.10008231558250.29062-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 23 Aug 2000, Ronald Wahl wrote:

>
> Hi,
>
> I'm writing a driver for a PCI controller in a PPC system. That driver
> "exports" a bit of local ram into the PCI space. Now if some PCI device is
> writing into this memory the local system won't notice it in all cases

Yes, it will notice, unless there is a _serious_ bug in the host bridge.
Accesses from the bridge to memory are snooped by the processor and the
relevant cache lines are invalidated if necessary.

The sequence is the following:

- the PCI device requests the bus,

- the PCI device becomes the master on the bus,

- it puts an address and then data onto the (multiplexed) PCI bus,

- the host bridge writes the data to system RAM at the specified address
(beware of the difference between kernel, physical and PCI bus addresses),
but before doing this the bridge signals the processor to invalidate or
push to memory the corresponding cache lines.

There is still a race with this kind of protocol: you need to read a
register of you device in order to flush the buffers which might hold
data on its way to memory in the host bridge.

Note that many devices (network and disk interfaces to start with) just do
this, they write directly to system RAM through the host bridge.

> since this memory is cached. How can i allocate uncached memory in linux?

You don't need to, note that on some architectures you would have to flush
the cache to avoid stale data. It's not the case on PPC.

> Or if this does not work how can I remap it as non-cachable. I already
> tried ioremap_nocache but this does not work for real memory. It would be
> nice if someone could give me a short code fragment...

Here is the code, guaranteed 100% bug-free ;-):

========================== CUT here ======================================

========================== CUT here ======================================


	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
