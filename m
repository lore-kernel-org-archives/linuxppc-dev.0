Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 25 Dec 2001 20:27:57 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200112260427.fBQ4Rvi00224@dave.home>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8260 + cache/dma issues
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm running into repeated problems related to cache problems on
ppc 8260 based hardware. The kernel is based on Montevista's 2.4.2.
The same problem keeps coming up again and again. Here it is:

If some external device, such as the pci usb device, writes into system
ram, the 8260 doesn't get the changes--instead when the 8260 reads the
ram it uses the data in the cache, defeating the whole purpose. We're
using the usb-ohci.c driver. In order to get it to work I've had to hack
the driver to instead of using pci_alloc_consistent, allocate memory
out of a section of local bus ram, which is non-cacheable. The burden
of doing this for every driver is just too great.

The original driver itself assumes that the dma works properly, meaning it
does nothing to invalidate the cache or cause a refresh/flush/update or
whatever. The driver initiates a transfer, the usb writes into ram, an
interrupt occurs, the driver examines the buffer--and crashes and generally
doesn't work because the data it sees isn't in ram, it is what was in the
cache.

My belief is there is something misconfigured on the hardware level. Meaning
the cache should work properly. In studying the 8260 docs I read hints at
snooping, but no details. My understanding is that snooping is when the
8260 watches the bus to see what activity there is, and if there is a write
to something the 8260 holds in a cache, the cache is updated accordingly.
Perhaps this snooping is turned off?

Also there is talk of C + R bits in the page tables (C = changed, R =
referenced). Possibly is the external dma mechanism supposed to update the
C + R bits in the page tables itself, causing the 8260 to realize something
has been done to the page and so it needs to be updated?

The driver doesn't ask for any special non-cacheable memory, just dma
capable. Following this through in the code that means in the case of
the ppc, all of dram because there is no limit on the dma range. On the
i386 tree dma appears limited to the first 16 megabytes. But nothing appears
to be demanding non-cacheable memory.

I guess I have several questions:
1) How is the system supposed to work so that the cpu and other pci devices
   have the same concept of the contents of memory?
2) What is missing in our system that is causing this not to work?
3) What is snooping, and can it be turned on or off by the 8260, or is it
   fixed in the hardware?
4) Am I misunderstanding how the linux drivers where, such that when they
   allocate memory for dma transfers, it is automatically marked as
   non-cacheable?
5) While I'm at it, I'm getting lock ups related to the external pci device
   writing into dram. I've heard mention of cache deadlocks, but I don't know
   details. Any pointers to documentation will be helpful.

Thanks very much for any ideas/advice.

-Dave
dash@xdr.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
