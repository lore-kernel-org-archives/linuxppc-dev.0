Message-ID: <C08678384BE7D311B4D70004ACA371050B7632AC@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: FW: Linux on 857T?
Date: Tue, 22 Jan 2002 13:13:59 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry, forgot to cc the mailing list.

-----Original Message-----
From: Kerl, John
Sent: Tuesday, January 22, 2002 12:44 PM
To: 'Dan Malek'
Subject: RE: Linux on 857T?


Dan:

Thanks for the reply.

I wasn't very specific in my original message, for two
reasons:

1.	Due to some tool problems I do not have as clear a view
	of what's really going on as I would like;

2.	There are actually several different symptoms, all
	puzzling.

OK, if you want details, here they are.  Again, please be
aware that this information is sketchy (that's the reason I
was reluctant to say too much in public.)

---------------------------------------------------------

Disclaimers:

Until yesterday I did not have an ICE.  I had been told
that our visionICE, which works on our 860 FADS board,
wouldn't work on our 857T board since the visionICE isn't
new enough to know about new parts such at the 857T.  Also,
we have a Macraigor probe, but it too wouldn't work.  So,
most of what I know -- as of today -- comes from using
printk's and the logic analyzer.  And this is of course
incomplete information; if the I-cache is on, you won't see
all instruction fetches in the logic analyzer, etc.  Also,
you only get to see bus activity; using the logic analyzer,
you can't view registers etc.

Yesterday, a co-worker (they are all hardware people)
informed me that, oops, we needed to remove an rpack & add
a jumper and then, voila, we could use the debug port after
all.  So I've been using the Macraigor for about a day now,
which isn't long enough to say very much.  (The visionICE
still is not able to control the 857T; a shame since the
visionICE is a much nicer probe than the Macraigor.)

Having made those disclaimers:

I've been told that 857 silicon errata parallel 860 silicon
errata.  So, I was not certain whether or not to include
CPU6 support in my .config.  So I tried it both ways.

With or without CPU6 support: My debug monitor (with which
we've tested the bejeebers out of the SRAM & SDRAM [with
and without cache enabled], SMC1 and FEC before ever
attempting an OS port) runs fine.  Then I TFTP up
zvmlinux.initrd.  (I modified mbxboot, customizing it for
our purposes, e.g. I want the bd as well as the command
line to be passed in from the debug monitor.)  This
"secondary boot loader", as I call it (the modified
mbxboot) also runs fine, prints out status to the screen,
prints out copies of the bd struct and command line which
match what the debug monitor passed in, decompresses the
kernel and jumps to it.  No apparent problems with the
debug monitor or the secondary boot loader.

The kernel runs for a while and then seems to "stop" -- and
when I say that, what I mean is I stop seeing print
statements in the terminal window.

How far does it get?  The kernel might not print anything
to the console at all.  This is the earliest "hang" -- e.g.
the last thing I see on my terminal window is the secondary
boot loader saying "Now booting the kernel." Or, the kernel
might successfully find the initrd but "stop" somewhere in
spawning /linuxrc.  In no case does it ever stop before
entering the kernel, and in no case does it ever get as far
as printing a shell prompt.  (And always, the message
"Freeing unused kernel memory: 36k init" gets something
greeked on the "ni" in the "init".  E.g. maybe the "ni"
becomes a theta.  This is the one oddity which is
consistent.)

(Note:  One might cast doubt on the initrd.  However,
printk's inside do_execve(), the ELF loader, etc. convince
me that the kernel is finding /linuxrc, seeing that it starts
with "#! /bin/sh", then loading /bin/sh, seeing that /bin/sh
starts with 0x7f ELF, etc. etc.)

Now, I wanted to see *why* the kernel stopped printing
things to the screen, so first I inserted printk's
(starting with execve() from init() in init/main.c) hoping
to narrow in on "the" problem.  Well, as I added or removed
printk's, the "hang" would move around (!) as follows:
E.g. I put half a dozen printk's in function a, in which it
calls b, c, d, e, f and g.  Printk's stop appearing on the
terminal screen after a calls d, so I put another
half-dozen printk's inside function d.  Then, perhaps, when
I run that, I start getting the printk's for e and f, but
not g.  Etc.

One very, very odd thing is as follows:  I tried this
printk business (also tried inserting some LED statements,
for the same purpose) many times before I gave up on it.
And in many circumstances, I would include a printk or LED
immediately before a calls function b, and also first thing
in b.  Or, a printk/LED as the very last thing in b, before
returning from a, and also first thing in a on return from
b.

For example, something like:

void a(void)
{
	printk/LED #1
	b();
	printk/LED #4
	c();
	d();
	e();
	f();
	g();
}

void b(void)
{
	printk/LED #2
	x();
	y();
	z();
	printk/LED #3
}


My thinking was that the only stuff that executes between
pairs of printk/LEDs is saving/restoring context between
functions.  And lo and behold, very often, I'd see one
printk but not the other -- e.g. in the above pseudocode
snippet, I'd see printk/LED #1 but not #2, or #3 but not #4
(!).  And yet calling or returning from a function should
be the easiest thing in the world; after all, we do it all
the time.  Some other things that I saw were also related
to ITLB misses, so I am going out on a limb and hypothesizing
that there is an ITLB miss when a calls b, or when b returns
to a.  Certainly, function calls are one way in which one
loses locality of reference.

(Note:  My debug monitor is small (~256K) & uses some
Motorola-provided sample code to set up the MMU before
jumping into Linux.  I have about 21 DTLB entries and 11
ITLB entries, which is not enough to fill up either TLB,
since they have 32 entries each.  So, my debug-monitor code
never needs to handle an ITLB miss.  Also, the secondary
boot loader disables cache & MMU before jumping into the
kernel.  As well, I've tried having my debug monitor never
initialize the cache & MMU at all.)

Since printk's weren't helping me, I next turned to the
logic analyzer.

With CPU6 support compiled in:  At some point (early or
late) the kernel takes an instruction TLB miss (surely not
the first one -- I don't know what makes this ITLB miss
different from any other), but after a few dozen
instructions I see the same instruction on the bus forever
-- which is what I meant by the CPU "parking".  It may be
the case that the processor is going into debug mode; can't
tell from the logic analyzer.  (Certainly, it shouldn't be
*in* debug mode since I set my DER to 0!)  But the CPU is
clearly halted on the fifth or sixth of 10 consecutive lis
instructions.

Without CPU6 support compiled in:  The kernel again stops
printing stuff to the terminal window, but the logic
analyzer shows that the CPU keeps running.  Tracing back
from the LA to the source code is tedious, but from what I
could tell yesterday, it appeared to be in do_signal(),
collect_signal(), kmem_cache_free(), et al., going back
around to do_signal() again.

Debug option 1 is printk's, which is not too useful for
this particular problem as I mentioned; debug option 2 is
the logic analyzer, which gives one limited information as
I mentioned; debug option 3 is the Macraigor.  Well, when I
hook up the Macraigor (changing *no* code), I get different
results (!) -- a panic as follows:

Kernel command line at :1001e2e4
Relocated to:  00200000
Contents:
  	root=/dev/ram0 init=/linuxrc rw
zimage at:     02017000 0207b2d2
initrd at:     0207b2d2 0215979d
Relocated to:  03f21000 03fff4cb
Available RAM: 0207c000 03f21000

Uncompressing Linux ... done.
Now booting the kernel.
Linux version 2.4.4 (a021502@u483wklnx001) (gcc version 2.95.3 20010315
(release
)) #263 Mon Jan 21 10:02:26 MST 2002
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram0 init=/linuxrc rw
Decrementer Frequency: 4125000
Calibrating delay loop... 65.12 BogoMIPS
Memory: 62328k available (788k kernel code, 316k data, 36k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
block: queued sectors max/low 41352kB/13784kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
RAMDISK: Compressed image found at block 0
Oops: kernel access of bad area, sig: 11
NIP: 00000400 XER: C000187F LR: 00000400 SP: C024B440 REGS: c024b390 TRAP:
0400
MSR: 08209032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c024a000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000400 C024B440 C024A000 FFFFFFFF 00000008 00000000 C0270BFC
00000000
GPR08: 00003C85 00003C85 000000FF C00EA4C8 00000800 10008F80 00000000
C024BD68
GPR16: 00000001 C024BD48 00007400 00000400 00000C00 00000000 00001000
C0268C00
GPR24: 00000100 00000003 00000000 00000000 00000000 00000400 C0265120
00000000
Call backtrace:
00000400
Kernel panic: Attempted to kill init!
Rebooting in 180 seconds..

I am still looking into this.  Still, the strange thing is
that only happens when the Macraigor is connected.  Maybe
that is due to theMacraigor itself; I don't know.

In the panic, the NIP is 0x400 -- making me think it's
happening on the branch *to* 0x400 (InstructionAccess in
head_8xx.S).  InstructionAccess, in turn, is branched to
from InstructionTLBError and InstructionTLBMiss.  I don't
know which one is the callee since the backtrace is short.

Ideas:

*	I know people have done Linux on 8xx's before, many a
	time.  And everything I've ever read has told me that
	most of the work in porting Linux is in the boot
	loader, passing parameters in correctly, etc.; besides
	customizing .config, the kernel code is already OK --
	if the kernel has already been ported to your processor.
	(In fact, I found porting the secondary boot loader to
	be pretty easy.)

*	I know people have done Linux on 860's; I also suspect
	that people have done it on 857's as well.  Honestly,
	although it would be nice if there were a silicon
	erratum, I don't expect there will be.

*	I've used three different source trees -- Denx 2.2.13
	and 2.4.4, and Lineo's 2.4.15-pre1.  & I am told that
	all three are reliable sources.  And all three trees
	have been used for 8xx designs.

*	I've used two different cross-tool suites -- one that
	I downloaded from gnu.org and compiled from scratch;
	the other that I got from Lineo.  I really don't think
	I'm dealing with a compiler bug ... .

*	I've done a very thorough memory test on our boards, and
	this is far from our first PowerPC design.  In fact, we
	think we're pretty good at doing PowerPCs.

	(In the last few years we've done an 823 board, an 8260
	and a 755.  In those previous cases, we wrote the debug
	monitor / hardware-validation code; then, our customer
	would contract with a third-party vendor to port VxWorks,
	OS/9, etc.  Doing an OS port here is a first for us;
	a business we want to get into since our customers'
	feedback regarding Wind River and Microware has been
	uniformly negative.)

	Every test I throw at our board, from inside my debug
	montior, passes.

	Now, what could my debug monitor be *not* testing? One,
	for simplicity, the debug monitor uses no interrupts;
	it polls all devices.  For example (hypothetically) an
	interrupt pin could be completely unconnected and my
	debug monitor wouldn't catch it.

	Second, for simplicity, the debug monitor is
	single-threaded and uses a 1-1 address translation
	mechanism -- the TLBs are populated at reset time, and
	are just left that way.  So, hypothetically, there is
	something there I could be missing too.  But I don't
	know what.

*	This is not only my first Linux port, but my first OS
	port.  I consider myself to be good at embedded
	programming and hardware verification, but it's
	entirely possible that all my problems are caused by my
	naivete when it comes to OSs.

	We do have a FADS 860 board, which I would have liked
	to have ported Linux to first, before trying our board.
	However, the FADS has only 4MB DRAM, and I could not
	find a larger.

So, I know the 8xx port of Linux is not broken, I don't
believe the compiler is broken, I don't believe the 857T is
broken, and I don't think our board is defective.  I can
only imagine that I as a software person have screwed
something up, or that one of my coworkers has made some
mistake in the board design.

So what, what, what ... the only things this leaves are the
way in which I'm initializing the processor -- which I
don't believe is rocket science, by the way, but maybe
there's some special register which one needs to set on the
857 that I just don't know about.  In particular, I got the
processor-reset code from www.mot.com and customized it to
my own purposes -- just as we always have done on previous
projects.  However, I could not find any 857 sample code at
Motorola, so I used their sample 860 reset code.  But as
you say, and as I've heard from my co-workers, there
shouldn't *be* big differences between the 860 and 857,
except for UTOPIA and FEC.

As I mentioned, what I've said in this message is sketchy
and only half-coherent; I apologize for being so vague.

-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: Monday, January 21, 2002 10:14 PM
To: Kerl, John
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: Linux on 857T?


Kerl, John wrote:

> Hello,
>
> I am attempting a Linux port to a custom 857T board.  I've tried
> several different kernel trees, with the same results:  unhandled
> ITLB misses parking the CPU.

What do you mean "unhandled ITLB misses"?

The 857T _should_ work like an 860T with Ethernet either on the SCC or
the FEC (or both).  Of course, the reason to choose this part is you get
both
parallel UTOPIA and FEC, which will require some software changes to enable
both of these functions.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
