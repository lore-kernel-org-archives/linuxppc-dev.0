Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.0.14.2.20020422102923.00af7550@carts.com>
Date: Mon, 22 Apr 2002 11:42:28 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Mike Mager <mike@carts.com>
Subject: MPC8260 + L2 Cache: ever been done?
Mime-Version: 1.0
Content-Type: multipart/mixed; x-avg-checked=avg-ok-4AAC5B42; boundary="=======3FB258B6======="
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=======3FB258B6=======
Content-Type: text/plain; x-avg-checked=avg-ok-4AAC5B42; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Has anyone ever seen an MPC8260-based design with L2
cache run Linux (or any OS) with some semblance of stability?
I know there are several designs out there with an 8260 and
L2, but they usually also have a 750 or some other CPU, and
the L2 is hooked up to that CPU, not the 8260. I've checked the
archives and searched online, but have been unable to find
any information on these two devices working together.

We have an 8260 design running in 60X-compatible mode with
1 to 4 MPC2605 L2 cache devices, and cache size is jumper-
selectable. Also on the 60X bus are a DIMM and a 16-bit flash.
When L2 is turned off, Linux runs fine (we're using 2.4.18).
When 256kB of L2 is enabled, Linux boots partially and then
crashes, either freezing or getting infinite machine checks.
When 512kB or 1MB are enabled, I never see any output from
Linux. We're using PPCBoot 1.1.2 for booting, and the L2 is
turned on in Linux (arch/ppc/kernel/head.S).

Our first concern was the fact that two of the cache control pins
(/WT and /CI) are muxed with BADDR pins that are required on
the flash device. These pins are controlled by the L2CPC bits in
the BCR, and there is an errata for the 8260's user manual that
specifies that these bits (any many others in the BCR) cannot
change after reset. At first we thought we were SOL, so we
called Motorola to see if they had a solution other than going to
a 64-bit flash device. It turns out their ADS board also has L2
cache and a 16-bit flash, and they assured us that their system
works. So they sent us the initialization code and test code they
used to verify that "their system works". It included setting up a
chip select, turning on the L2, initializing the MMU, and then
turning on L1 caches. The test code simply did reads to fill up
the L1 and L2 caches, followed by a flush of the L1. It then did a
read from an address that would still be in the L2. We modified
their init and test code to work with our board (since the 2605
control lines were hooked up differently) and it seems like the L2
works OK. However, this is a simple test that only goes to one
location in memory in an infinite loop. It is not doing instruction
fetches and accessing data from all over memory like Linux does.

So the issue now is that our board seems to behave like
Motorola's board when running some very basic code and
enabling L2. But under Linux, our board hangs. (We placed the
init code for the L2 that Motorola provided us in head.S) The
difficult part about debugging this problem is that Linux crashes
in different ways at different times, so I've been unable to trigger
on the condition that causes this problem. It seems to me that
the L2 is simply returning bad data, which sends the OS into
the weeds.For what it's worth, we've also ported OS-9 to this
board, and it eventually crashes as well if the L2 is enabled.

Also, in the 8260's user manual it says (on page 11-7) "For
systems that use copy-back mode, all cachable memory regions
must be marked as global in the CPU's MMU and the CPM's
RBA." Since we are using copy-back mode, I believe this infers
that the M bit in the BATs and PTEs must be set, enforcing
coherency. However, from what I've seen, the only way to get
Linux to do this (without hacking it) is to enable SMP. I did so
but that did not appear to solve the problem. But is that the right
thing to do?

Some other info: We've tried running the system in write-through
mode with the same results. We've done this test with two
versions of the 8260, mask A.1 and the new HiP4 (2k25a). And
the CPM fifos are all either in local bus RAM or DPRAM in order
to keep the CPM off the 60X bus (which causes other problems).

If anyone has any answers, ideas, or insights into this problem,
they'd be greatly appreciated.

Thanks!

Mike Mager
Digital Design Engineer
CARTS, LLC

--=======3FB258B6=======
Content-Type: text/plain; charset=us-ascii; x-avg=cert; x-avg-checked=avg-ok-4AAC5B42
Content-Disposition: inline



--=======3FB258B6=======--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
