Date: Wed, 18 Jul 2001 04:11:02 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Seg fault whenever NIP=c0006000
Message-ID: <Pine.LNX.3.95.1010718035902.16243A-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Late last week I started to get segfaults in the kernel. Initially I
thought the problem was in flush_Instruction_cache- I traced the crash
back to that code. I've been playing around with the cache code (disabling
the data cache), so this seemed possible. I added a couple of sync and
isync calls arond the instruction that looked to be failing as a way to
start debugging. I recomiled the kernel and ran it- it crashed again, in
the same function, at the same address (NIP=0xc0006000), but on a
different instruction (because I had added some before the first
instruction that crashed). This seemed odd to me. I next swapped the order
the order of a few functions defined in misc.s (flush_icache_range,
flush_dchache_icache, etc). The kernel was crashing in whichever function
coincided with 0xc0006000. I then put a branch instruction in the code
right before 0xc0006000 and leapfrogged that  address (padding with
nop's). Now things are working.

So- it appears that avoiding address 0xc0006000, and only that address, is
necessary for my kernel (true, I haven't tested every other byte of
memory, but the kernel does appear stable). Anyone have ideas a to what
could cause this?

Thanks,

-Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
