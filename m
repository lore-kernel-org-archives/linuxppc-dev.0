Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <3B70104B.C1E6F8EC@lucent.com>
Date: Tue, 07 Aug 2001 10:59:07 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Subject: Re: Non-cacheable memory
References: <Pine.LNX.4.33.0108071444530.16835-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Justin (Gus) Hurwitz" wrote:
> Does the current 2_4_devel tree have support for allocating regions of
> non-cachable memory? And, if so, what is the proper (or preferred) way of
> doing this?

What I did in 2.2.15 was to edit the main startup routine to call my driver
directly so it could "eat up" a region of memory before Linux started its
memory management. I then used a BAT to reference it uncached. Yes, this
is ugly, and requires care in making sure the BAT effective address is
otherwise unused by the kernel, but it works. This is on a MPC7400, and
other PowerPC CPUs might not have BATs available....

Note also that my driver uses unchached accesses only for buffer pointers.
For the buffer data I used cached references, with cache-flushes
appropriately sprinkled throughout the code -- the MAJOR bandwidth gain
was important.

Note that if your hardware does bus snooping, you might not need uncached
memory references or explicit flushes to read DMA data. But embedded and
non-SMP systems are unlikely to do it.


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
