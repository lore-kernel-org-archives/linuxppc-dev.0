To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Any restrictions on DMA address boundry?
References: <Pine.LNX.4.44.0309251306450.12966-100000@spider.ancor.com>
From: Roland Dreier <roland@topspin.com>
Date: 25 Sep 2003 11:26:12 -0700
In-Reply-To: <Pine.LNX.4.44.0309251306450.12966-100000@spider.ancor.com>
Message-ID: <52k77wk9mj.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Bret> What exactly is the issue?

    Bret> As I understand it, if there is a DMA to the same cache line
    Bret> as something that the CPU is referencing, you've got a cache
    Bret> problem.

The problem is the following.  Suppose for concreteness that we're
working on a system with 32-byte cache lines, and there is no
coherency between PCI and the CPU cache.  (This describes the IBM
PowerPC 440GP)

Now suppose you have a 16-byte DMA buffer, and some other unrelated
data in the same cache line.  Let's say you want to start a DMA from
an external PCI device into that buffer.  The first thing you do is
invalidate the cache line containing the DMA buffer, so that you get
the data the device is about to write and not any data that might
already be in the CPU cache.

You have to do this invalidate before you initiate the DMA, because
otherwise there is the risk of the CPU evicting that cache line and
writing it back to memory after the DMA has occurred, and stomping on
the data the device has written.

Then you tell the device to do the DMA, and go off and do other stuff
while waiting for the DMA to complete.  If that other stuff touches
the other 16 bytes of unrelated data that shares the cache line with
the DMA buffer, the CPU will bring it back into the cache.  But if you
do this before the DMA happens, you won't see the data the device
writes.

People often come up with complicated schemes like flushing and
invalidating the cache before and after the DMA transfer, but there's
always a scenario where the DMA buffer and/or the unrelated data get
corrupted.  The only solution is to make sure that you don't put
unrelated data in the same cache line as a DMA buffer.

    Bret> Does it matter what type of transfer the PCI device is
    Bret> doing? If it always does 32-bit burst memory write transfers
    Bret> instead of memory write & invalidate does that make a
    Bret> difference?

No.

 - Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
