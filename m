From: Benjamin Herrenschmidt <bh40@calva.net>
To: Ronald Wahl <rwa@peppercon.de>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: allocating uncachable memory
Date: Wed, 23 Aug 2000 16:03:27 +0200
Message-Id: <20000823140327.30773@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.21.0008231540530.12497-100000@goliath.issistance.de>
References: <Pine.LNX.4.21.0008231540530.12497-100000@goliath.issistance.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I'm writing a driver for a PCI controller in a PPC system. That driver
>"exports" a bit of local ram into the PCI space. Now if some PCI device is
>writing into this memory the local system won't notice it in all cases
>since this memory is cached. How can i allocate uncached memory in linux?
>Or if this does not work how can I remap it as non-cachable. I already
>tried ioremap_nocache but this does not work for real memory. It would be
>nice if someone could give me a short code fragment...

Depending on the host PCI controller, the machine will or will not be
cache-coherent. Most PPC machines out there (all PCI PPC machines) are,
AFAIK, cache coherents. PPC NuBus powermacs are not. That means that any
access done to memory from the PCI is "snooped" by the CPU and the cache
is kept up-to-date.

There are routines in 2.4 for allocating PCI "consistent" memory (will be
uncached on archs that are not coherent and normal on others). See
pci_alloc_consistent() or something like that (I don't have my kernel
sources with me).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
