Message-ID: <C08678384BE7D311B4D70004ACA37105111946B4@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: What Does a Linux Image Expect From U-boot?
Date: Tue, 11 Feb 2003 11:54:32 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Charles:

> Thanks for your reply.  Although I have a lot of experience with low-level
> embedded system programming, embedded hardware design, and using Linux on
> an Intel box, I'm a raw newbie at mixing Linux with the embedded stuff.

Small world -- I've described myself identically.  (Except that I now have
one
embedded Linux port under my belt.)

> First, I'm not sure if your question about the "simple part" is facious or
> serious.  If it's facious, I agree.  None of this is "simple."  If it's
> serious, "simple" is one of the four low-level boot methods in the
> "linux/arch/ppc/boot" directory: chrp, pmac, prep, and simple.

I meant the latter -- arch/ppc/*simple*, which my tree lacks.

> As I understand it, you use one of these boot methods to pull the vmlinux
> and the root filesystem images together into a single, compressed,
> executable image.  Execution then starts at the beginning of
> linux/arch/ppc/boot/simple/head.S.

See below.

> I've been using Craig Hollabaugh's book on Embedded Linux as a resource
(it
> seems to be quite good).  Per his book (p. 96, step 4), I have been
> building the image I'm trying to boot using the command "make
> zImage.initrd".

I don't know about Hollabaugh's book, but have heard excellent reviews.
When I was starting my port (Nov. 2001), his book wasn't yet published.
Also, Denx's ELDK/SELF either weren't done yet, or I wasn't fully aware
of them.  So I rolled my own.  Older and wiser, I'll be using ELDK for my
next Linux port; still haven't gotten around to buying Craig's book, but
should.

> As I said, I've made my own additions to the start of "head.S" to try to
> setup the bd_info structure.  When I load the image, it crashes.  Any help
> here (such as: Am I on the right track at all?) would be appreciated.

Here is what I do, for however much it helps -- it may serve as a starting
point for where you want to go.  First, though, for the mailing list:

----------------------------------------------------------------------------
CAVEAT CAVEAT CAVEAT: If you just want some firmware to load Linux, you're
probably much better off if you just use U-Boot.  The following applies for
when you have firmware of your own that you want to use instead of U-Boot.
It describes what the firmware must do in order to load the kernel.
----------------------------------------------------------------------------

Anyway:

----------------------------------------------------------------
There are three main pieces of code:

1.	The firmware.  This initializes the processor, setting up
	the physical memory map (BR/OR stuff), initializes the SDRAM
	controller, etc.

2.	What I call the "secondary boot loader", which is
	arch/ppc/mbxboot, etc.

	I started with arch/ppc/mbxboot, but there were so many #ifdefs
	(and I was adding more) that I found it simpler to just make a
	copy which had just what I wanted.  This goes in
	arch/ppc/mebboot ("meb" is for the "MPC857T Evaluation Board"
	which we made for Motorola).

3.	The kernel per se.

The kernel must be placed at address 0; the locations of the rest
don't matter *but* you must make sure not to overwrite things.  This
amounts to writing down a little map of who uses what region & being
careful about it.  (My SDRAM is 64MB, from 0x00000000 to 0x04000000.)

----------------------------------------------------------------
The run-time sequence of events is:

-	My firmware runs out of SDRAM at 0x00400000 - 0x00500000
	(megs 4-5).

-	zvmlinux.initrd is already in flash, or TFTP'ed to the board
	in RAM (my firmware has a TFTP server as well as flash-write
	logic).  This file really consists of three parts:

	*	Secondary boot loader code, e.g. head.S & misc.c
	*	zvmlinux
	*	initrd

	All three are concatenated together into zvmlinux.initrd, which
	is an ELF file.  It can be stored anywhere in RAM or flash.
	Suppose for the sake of argument that zvmlinux.initrd has been
	stored into flash at 0xff000000.

-	At the command line in my firmware, the user types "linux"
	with no arguments for a default load, or with some optional
	arguments specifying where in memory zvmlinux.initrd is,
	if not at 0xff000000.

-	The firmware computes a bd_info structure and the kernel command
	line.

-	The firmware jumps to zvmlinux.initrd address + 0x10000, e.g.
	jump to 0xff010000, with the following arguments:

	*	address of the bd_info in r3.
	*	address of the kernel command line in r4.  (This is
		"root=/dev/ram rw ... " etc.).

	(The + 0x10000 is because zvmlinux.initrd is an ELF file, with
	64 KB header.)

-	The secondary boot loader now has control, in
	arch/ppc/{xxx}/head.S.  It was linked to run at a certain
	address, but isn't necessarily there yet.  (In
	arch/ppc/mebboot/Makefile, the secondary boot
	loader is linked with -Ttext 0x00180000.) So the first thing it
	does is copy itself to where it belongs, in this case,
	0x00180000.  What it copies is just its own code (head.o, misc.o
	etc. -- a few dozen KB).

-	The start and end addresses of the zvmlinux part and the
	initrd part are remembered, and C code is entered.  This
	is misc.c.

-	misc.c decompresses the kernel to address 0, and moves the
	initrd to the end of RAM.

-	misc.c returns control to head.S, which jumps to the kernel
	(arch/ppc/kernel/head_8xx.S) at address 0, with the following
	arguments:

	*	r3: address of bd_info
	*	r4: initrd start address
	*	r5: initrd end   address
	*	r6: command line start address
	*	r7: command line end   address

-	The kernel now has control.  These 5 registers are preserved
	and then passed into m8xx_init() in m8xx_setup.c, also in
	arch/ppc/kernel.

----------------------------------------------------------------
The secondary boot loader must pass the bd_info and the kernel command line
to the kernel.  Where does it get them from?

*	You can hard-code a bd_info structure into the secondary boot loader
	in head.S, or misc.c.

*	Or, you can make it more flexible by having the firmware set up the
	bd_info and pass it to the secondary boot loader in head.S.

The bd_info structure is likely not to change for a given board; the kernel
command line certainly *can* change for different invocations of the OS.
So,
you probably want to allow the firmware to pass the kernel command line to
head.S, or you should have misc.c prompt for a command line.  The mbxboot
code,
as I got it, did the latter; mine does the former.  My code has the
firmware compute both the bd_info and the command line, passing both of them
to
the secondary boot loader.

----------------------------------------------------------------
The sequence of events at build time is:

*	Have the RAM disk image, ramdisk.image.gz, made in arch/ppc/{xxx}.
	See the mkdramdisk script (e-mail me if interested) for an example
of how
	to make one.

*	make zImage.initrd:  this builds the kernel per se.

*	This then invokes the arch/ppc/{xxx} Makefile which
assembles/compiles
	head.S, misc.c etc.  It then concatenates that code, zvmlinux and
	ramdisk.image.gz into zvmlinux.initrd.

----------------------------------------------------------------
The code involved is:

*	Firmware code.

*	Secondary boot loader code.  This is arch/ppc/mebboot

*	Mods to arch/ppc/Makefile, config.in, etc. in order to get
	arch/ppc/mebboot invoked at build time, rather than arch/ppc/mbxboot
	or whatever else.

These are all small things (a few dozen KB each).  I don't have an FTP
site to host these, so please e-mail me if interested.

----------------------------------------------------------------
Note that even if you don't use U-Boot, this kind of boot loader can still
work with Denxware.  For example, recently I used my firmware to load and
run an ELDK kernel with Denx's root filesystem.

U-Boot does something like the above, but it combines the role of firmware
and
secondary boot loader -- i.e. U-Boot initializes the processor, *and*
uncompresses the kernel and jumps directly into the kernel.  If you're using
your own firmware, you could keep the separation of firmware & secondary
boot
loader, as I did, or put them into a single program, as U-Boot does.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
