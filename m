Message-ID: <394E5F1F.7510B104@lucent.com>
Date: Mon, 19 Jun 2000 12:57:51 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: No RAM at 0 -- Suggestions?
References: <21F9768AF088D211BF1C0008C71E5786010F0C1F@ap-bang-m02.india.tek.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am about to port Linux to the other processors on our board. At
present I have Linux running fine on CPU A. The main difficulty is
that the other processors do not have any RAM of their own at
physical address 0. The memory layout of this board is:

	00000000 - 03FFFFFF	CPU A (200 MHz PPC750)
	04000000 - 07FFFFFF	CPU B (200 MHz PPC750)
	08000000 - 0BFFFFFF	CPU C (200 MHz PPC750)

	[Yes, this is not your typical embedded system -- it's really
	 an embedded supercomputer: more than a gigaflop and 192
	 MBytes of SDRAM.]

These CPUs do not and cannot snoop on each other, so an SMP Linux
cannot be used on this board. In our application the CPU memory
modeling we did showed that the bus occupancy was too high for
efficient SMP operation, so three independent CPU+memory subsystems
were built -- they can see each other's memory but there is a
significant performance penalty involved; all 3 run in parallel
and most of the time (~99%) there are no conflicts. We currently
run a proprietary OS with 3 independent kernels; the only inter-
CPU memory references are for infrequent message passing.

Note that there is no EPROM or flash either; the memory controller
for each CPU aliases its own memory at FC000000, so the powerup
vectors at FFF00100 (etc) are visible in the top megabyte of each
CPU's own SDRAM. Our current proprietary OS relies on this and
lives at FFF00000 (code+data+bss for its kernel is ~0.1 MByte --
Linux is too large to link within that 1 megabyte region).

	My boot program for CPU A Linux loads a simple startup at
	address FFF00100 which loads registers defining the board
	model, the initrd ramdisk, and the command line, and then
	issues a "ba 0" -- at this point this startup code is never
	needed again so Linux can use this RAM as usual. The Linux
	kernel I run is 2.2.15 with about a dozen minor modifications
	for our board, plus drivers for console and network (which
	use memory buffers to communicate with the host).


Has anybody ever successfully gotten Linux up on a system with no
RAM at 0? How?


I have thought of several basic approaches, and am interested in any
comments you might have:

1) Re-program the CPLD on the board so each CPU's own RAM appears
   at both FC000000 and 00000000 to it. The problem goes away.
   Unfortunately this causes us some rather serious inventory problems,
   and as we already have >1000 boards in the field this is a
   logistical nightmare. We need to exhaust other options before
   doing this.

2) Rely on the presence of a Linux at physical address 0, and let
   the CPU A Linux code handle the exceptions for CPUs B and C --
   when the vector's code enables memory mapping there will be an
   implicit jump into B or C space, but as long as I load identical
   Linux-s on all CPUs this shouldn't be a problem. I also need to
   make phys_to_virtual() and virtual_to_phys() work properly for all
   CPUs, and need to make each CPU's Linux know what memory it can
   use (done via declaring memory regions during the kernel starup).

3) Rely on the aliasing of FC000000 -- load Linux at the beginning of
   each CPU's memory, and arrange for it to know where its memory is
   as in (2); reserve the exception vector pages at FFF00000 and load
   short routines for each vector which just jump to the real exception-
   handling code at 04000X00 (B) and 08000X00 (C). Arrange for everytime
   Linux sets the MSR to turn the bit on for high exception vectors.

4) Rely on the aliasing of FC000000 -- skinny-down the Linux kernel to
   fit in just 1 megaByte (code+data+bss) and load it at FFF00000.
   Arrange for everytime Linux sets the MSR to turn the bit on for high
   exception vectors. Again I must deal with virt_to_phys() and friends.

Any suggestions or comments you have would be most welcome.

	Just in case you're wondering, our interest in Linux is not
	really for this board, but for the next board -- it will
	have newer processors with much better L2 and L3 cache
	algorithms which make an SMP architecture attractive; it
	will also have an ethernet interface on board. Our current
	proprietary OS cannot easily be extended to handle either
	SMP or a TCP/IP protocol stack. As Linux already does both,
	our interest in Linux is high. Being able to run Linux on
	our existing boards would be a big plus, even though it will
	not be the same as the new boards. There is also the obvious
	attraction of a standard, POSIX-compliant OS....


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
