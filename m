Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3BD5DE9F.17679D05@midrivers.com>
Date: Tue, 23 Oct 2001 15:18:23 -0600
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: debugging, kernel port status update
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You might remember that I've been working on porting the hhl kernel
for the walnut (hardhat 2.0 release) to a new processor w/ a 405
core, larger caches, sundry peripherals and a FPU.  I'm debugging
w/ an abatron bdi2000 and wanted to get some notes out on what's worked
for me so far.

the executive summary is that I've gotten the kernel to come
up and attempt to mount a root filesystem, which fails as there's
none there.  The good news in this is that I've gotten the kernel
to come up and can see a dim light at the end of the tunnel.

the picky details for anyone attempting to do something like this:

0) I built a generic binutils/gcc/glibc for the PPC -- notes
available.  what I found on the web got me close, but I wanted
to be able to work under my user ID w/o installing in /usr/local ...

I may have to tweak this compiler if I get FPU support along w/
instructions which aren't a part of this uP's instruction set.

1) in order to debug a mercury -based controller (the only name
I've heard for this chip -- anyone know what the 'real' ID designation
is?) -- I had to upgrade to the latest abatron firmware:
Loader   : V1.04
Firmware : V1.07 bdiGDB for PPC400
Logic    : V1.02 PPC400

-- I believe this package is called v.1.07.

the following were added to my board .cnf file for the bdi debugger:

[INIT]
.
.
.
; zero out the page table base
WM32    0x000000f0  0x00000000

this location is where a pointer to the page tables gets stuffed by
suitably modified kernels.  the modification in
linux/arch/ppc/kernel/head_4xx.S didn't work, so I patched it from
code in head.S:

#if 0
	/* Add helper information for the Abatron bdiGDB debugger.
	*/
	lis	r5, abatron_pteptrs@ha
	ori	r5, r5, abatron_pteptrs@l
	stw	r5, 0xf0(r0)	/* This much match your Abatron config */
	lis	r6, swapper_pg_dir@h
	ori	r6, r6, swapper_pg_dir@l
	tophys(r5, r5)
	stw	r6, 0(r5)
#else
	/* Provide a page table pointer for Abatron. Ensure your PTBASE
	 * in the bdiGDB configuration file reflects this address.
	 */
	lis	r6, swapper_pg_dir@h
	ori	r6, r6, swapper_pg_dir@l
	stw	r6, 0xf0(r0)
#endif

-- the #if 0 portion was what was already in head_4xx.S (w/o the if 0)
but didn't work. the #else case was taken from head.S and seemed to
work.

I ended up using default mapping which eliminated the need for this
patch.

other .cnf entries:
[TARGET]
CPUTYPE     405 FP		;the used target CPU type
[ the 'FP' indicates floating point present ]
BREAKMODE   HARD        ;SOFT or HARD, HARD uses PPC hardware breakpoint
STEPMODE    HWBP
MMU         XLAT        ; enable mmu translation, page table base @ 0xf0
;PTBASE      0x000000f0
[ this last is commented out as I used default abatron translation which
  seemed to work fine. ]

2) the memory addresses for the on-chip peripherals (and some DCRs) have
moved from the 405GP to the 405M, resulting in several bad access faults.

these were difficult to debug w/ optimization turned on (the stack trace
made little sense and lied outright in several places).  I wasn't able
to build a kernel w/o optimization ... but -O1 seemed to be the most
benign and actually produced a vmlinux I could step/next through which
made some sense.

I also added -g -ggdb to CFLAGS in linux's top-level Makefile.

the point is that simply examining the stack trace wasn't useful
for debugging these cases.  stepping up to the offending lines and
examining the code @ $pc really helped.

3) even w/ -O1 there were cases in which I'd attempt to step into a function
and have the debugger hang or the board take a fatal fault w/ the
gdb 'step' command -- apparently enough was optimized out that some of the
first line of that func was executed and caused this fault w/o getting
me into the function.

sticking debug printf()s in the code to show entry into the func would
fix this -- I wrote a debug printf w/ vsprintf() and a write-the-string-
to-a-uart func to do this w/o printk -- I was hitting these problems before
printk's buffered lines would be dumped.

4) I disabled PCI and the RTC (real-time-clock), as these will have to
be revisited and I didn't want to make them work yet.  there are
some IO remaps for PCI and the uarts to be done and these addresses
had to be fixed up for the new uP.

and they're a bit scattered ... anyone have any ideas how to support
multiple flavors of PPC405 w/ different DCRs and different IOaddrs
for the peripherals?  this issue isn't going to go away any time soon.

5) The only cache size mention I could find was CACHE_NLINES in
arch/ppc/kernel/misc.S -- there may be others and I probably won't
find them until they bite me.  cache line size matters more but
seems well handled and I didn't have to do anything for that.

6) ppc4xx_gdb_init() -- I had to patch this to test for external
debugging -- if externally debugging (w/ a Jtag debugger) then
don't set internal debug mode ... the func caused a fault when
the DBDR0 was updated if already debugging -- I don't know if this
was because of the rev of my mercury silicon or if the PPC405GP
wouldn't like this either.

that's where I'm at -- now on to the finer details of getting
the rest of the kernel functional on this card ...

Mark

--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
