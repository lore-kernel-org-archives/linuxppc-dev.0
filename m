Message-ID: <3F4ACF31.9010506@laurelnetworks.com>
Date: Mon, 25 Aug 2003 23:08:33 -0400
From: "Michael J. Accetta" <mja@laurelnetworks.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: pciauto_setup_bars() allocation algorithm tweak
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We recently had to bring up linuxppc on a new custom board with a PCI
device providing a 512Mb BAR region.
This appeared to run into some resource exhaustion issue when the
allocated addresses dropped below 0x80000000 (which I don't purport to
understand, not being that familar with the ppc address layout).
 However, the 512Mb BAR was clearly our culprit, since its alignment
requirement forced the current allocator to waste much of the address
space aligning the 512Mb BAR.  We implemented a relatively minor tweak
to  arch/ppc/kernel/pci_auto.c which while not a completely general
allocator handles cases like this much better. The change is described
below and I can supply a patch against MVL 2.4.18 if this might be of
any general interest.

/*
 * tweak to reduce fragmentation of the BAR address space.
 *
 * Previously, pciauto_setup_bars() simply allocated BAR addresses by
 * subtracting from these two upper limits, wasting any intervening
space left
 * unused due to the alignment required by the BAR size.  This can be fatal
 * with very large alignments that can exhaust the available address space.
 * To mitigate this a bit, we now also record the size and lower bound
of any
 * hole in the address space created by an allocation from either of these
 * upper limits.  Each setup will now try first to allocate space in the
 * hole "above" the previous allocation.  If it succeeds, the hole is
reduced
 * by the allocation size.  If it fails, allocation proceeds as before and a
 * new (possibly empty) hole is created.
 */

Mike Accetta


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
