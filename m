Date: Wed, 9 Jan 2002 07:47:56 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200201091547.g09Fluq08445@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Lockup problem with 8260
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've found out a lot more about the problems we're having, and gotten
some workarounds in place.

Three things have to be true in order for there to be the lockups we were
seeing:

1) 8260 is accessing cacheable region of 60x bus
2) CPM is accessing cacheable region of 60x bus
3) External device (in this case a pci bridge) is accessing
   cacheable region of 60x bus

I believe #1 and #2 have to both be accessing the same area of
memory. #3 can be accessing a completely separate area. I don't
know if all the attempts to access the bus have to be close together
in time.

What happens when it fails is bogus addresses start coming out of the
CPM (we think the CPM is the source, not the 8260). Then a series of bus
faults and eventually a check stop state are entered. Frequently the
system might crash where the CP (of the CPM) appears to be dead but the
8260 itself is alive and well--until inside the linux kernel it has to
busy wait for the CPM, say for outputting a character to the serial console.

The cache problem we were having was because the ESE bit in the SIUMCR
register was always off. Set that bit to 1, and suddenly the L1 cache
becomes coherent. The lockups occured whether that bit is 0 or 1.

The CPM's parameter blocks have bits telling whether the BD's and
buffers themselves are on the 60x bus or the local bus. There is a
bit GBL which is supposed to inform snooping devices to snoop this
address. I believe in the case of the CPM and 8260 accessing the bus,
the 8260 will always snoop CPM's accesses even if GBL isn't asserted
and even if ESE is 0 (disabling snooping). I think those bits only
effect devices outside the 8260, such as the pci bridge, mastering the
bus.

The workaround that is effective (rock solid operation) is to use
the local bus for all CPM's operations, meaning BD's and buffers. The dual
port ram is taboo also, it is equivalent to the 60x bus. Then in the
FCRx field descriptions the DTB and BDB bits have to be set to 1, to
tell the CPM the buffers and BD's are on the local bus. This keeps the
CPM off of the 60x bus and prevents the lockup from occuring.

If the local bus memory is used but the DTB/BDB bits aren't set the system
still operates, but the lockups still occur. GBL has always been irrelevant.
ESE in the SIUMCR has to be set to 1 for a coherent cache between the
8260 and the outside world, say a pci bus master accessing the 60x bus.
I'm really shocked that no one on this newsgroup ever mentioned the ESE
bit, that seems to be an obvious first thing to look at for the cache
incoherency problems we were having.

Our chip is using the A.1 mask. This seems to be working perfectly well
with the dcache enabled. We have only the L1 cache, no L2 cache.
We have a small amount of dram hung off the local bus. This local bus
ram is not cacheable.

Other solutions have been to reserve a region of the 60x bus's dram as
non-cacheable, and use that for CPM operations. We're not going that route.
The pci bus masters are accessing cacheable memory of the 60x bus and it
appears to be working perfectly.

Short answer: Keep the CPM off the 60x bus. And the dual port ram counts
as the 60x bus. I haven't tried using dual port ram for BD's and buffers yet
keeping DTB and BDB's to 1, I would think that might not work.

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
