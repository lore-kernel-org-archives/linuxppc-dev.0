Date: Fri, 19 Mar 1999 10:31:09 +1100
Message-Id: <199903182331.KAA23199@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: bh40@calva.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990319001614.001351@mail.mipsys.com> (message from Benjamin
	Herrenschmidt on Fri, 19 Mar 1999 00:16:14 +0100)
Subject: Re: Thoughts about DBDMA and cache coherency
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19990319001614.001351@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <bh40@calva.net> wrote:

> It appears that Apple's Darwin drivers use to flushe the cache of the
> memory occupied by a DBDMA descriptor bloc before using it. This would

The NuBus powermacs don't maintain cache coherency between memory and
the nubus AFAIK, but the PCI powermacs do.

> mean that the memory is not cache coherent when seen from the PCI bus,
> and when you think about it, it looks logical: Writes issued from the PCI
> to memory are coherent since snooped by the CPU and will force it to
> reload the cache (I'm thinking about the 750 with backside cache, but
> this may apply to other implementations depending on the bridge), but
> when a device reads a piece of memory, i don't see the bridge asking the
> CPU to flush this cache range before the read completes. I didn't see any

No, what happens (on the 60x bus) is that the read is snooped by the
cache controller, which asserts a `backoff and retry' signal.  The
PCI bridge then terminates the transaction, the cache controller gets
the 60x bus and writes the cache line out to memory, then the PCI
bridge retries the read and gets the right data from memory.

One small wrinkle is that for all this to work, the bridge has to
assert the GBL (global) signal for all its accesses.  On some
Starmaxes, we weren't getting the cache coherency maintained, but
someone (Harry Eaton, from memory) found a bit to set in the bridge's
configuration space which turned on the cache coherency - most likely
this bit controlled whether the GBL signal was asserted or not.

> That would mean that we need to flush the range occupied by DBDMA
> descriptors, but also any buffers used by DBDMA when outputing via a
> DBDMA channel.

Fortunately we don't need to, on PCI powermacs at least.  As I said,
nubus powermacs are a whole 'nother can of worms, as are 68k macs.

> Either I missed something big, either linux fails to do so and may have
> unreliable writes to DBDMA devices all the time (looks like it would
> crash a lot more often than it does, I must be wrong somewhere).

It would crash a lot more often.  Things just basically wouldn't work.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
