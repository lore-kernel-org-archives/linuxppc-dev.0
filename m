Date: Mon, 25 Mar 02 00:14:18 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203250814.AA27177@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Perhaps changing my mind on the wrapper...
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Folks,

I've got a surprise for you. I may be changing my mind on my earlier violent
objections to anything under arch/ppc/boot. Maybe. Some of the factors
determining whether this will happen or not are listed below.

First some background information. My desire to boot vmlinux directly was based
primarily on my dream of having one standard vmlinux image supporting all
standard non-embedded systems that happen to be not one of {CHRP,PMAC,PREP} and
thus not supported by the so-called CONFIG_ALL_PPC. (Yeah, right. *ALL* PPC.)
I'm talking about workstation systems like Adirondack and server systems like
K2.

If there was such a CONFIG_TRULY_ALL_PPC configuration, I could make it a pure
vmlinux without any wrappers directed by bi_recs, and for PPCStar systems (PPC
systems with StarMON) I could have a single PPCStar Linux bootloader binary
that senses the PPCStar machine ID (in a standardised location per the PPCStar
spec), uses it to make the right StarMON calls to get the needed hardware info,
constructs the needed bi_recs, and boots one common vmlinux kernel. Since there
would be only one common vmlinux kernel, there would not be multiple Linux boot
interfaces to deal with.

It's almost doable in 2_4_devel today. I was thinking along the lines of
renaming each platforms/<board>_setup.c:platform_init() into <board>_init(),
writing a top-level platform_init() that calls parse_bootinfo(r3 + KERNELBASE)
and then dispatches to the right <board>_init() routine based on BI_MACHTYPE.
This would almost work right now if only the include/asm-ppc/serial.h morass
wasn't a fly in the ointment...

Or alternatively a generic configuration that knows nothing about the specific
hardware implementation and takes info from bi_recs like you have a PCI here, a
UART there, such and such interrupt controller type and routing, etc. I thought
about this a lot, but couldn't make it a reality: in real life boards have some
things that I just can't describe in such a generic way. How would I describe
in such generic terms how to reset the board when the user types reboot so that
the firmware properly reboots it? How would I describe whatever magic is needed
to talk the specific firmware on a given SMP board to make it hand over the
secondary CPU(s) to Linux? I couldn't figure a way. (This is not meant to
discourage others from trying though.)

Not having success with either of the two approaches above, I'm about to give
up my dream of one kernel and live with having to put a bunch of kernel images
for different boards on the distribution CD.

But not having a common vmlinux kernel shatters my idea of a common PPCStar
Linux bootloader for all PPCStar systems. If the kernel is per-board anyway,
the bootloader can be per-board just as well. And then the two could be
combined in the same binary to make things easier...

Now this PPCStar-bootloader-turned-wrapper would have to be different from the
current ones under arch/ppc/boot. I don't want it to ask for the command line
or to contain a compiled-in one. I don't want it to have a compiled-in initrd
either. Instead I want it to have a standardised (and very simple) register
interface on entry telling it the command line and the location of initrd if
any. The image would be runable directly from StarMON without interposers like
my current ppc-linux-boot runlnx. Hackers would be able to run it directly
during development by stuffing the command line and initrd info into registers
with StarMON console commands like:

>>>LOAD/START:800000 "ETH0:10.1.1.1:stImage.bin"
>>>D/P/B 100000 "ip=blah nfsroot=10.1.1.1:/export/ppcroot" 0
>>>D R4 100000
>>>D R6 0	! no initrd
>>>S 800000	! Go!

or

>>>LOAD/START:800000 "ETH0:10.1.1.1:stImage.bin"
>>>LOAD/START:C00000 "ETH0:10.1.1.1:ramdisk.image.gz"
>>>D R4 0	! empty command line
>>>D R6 C00000	! initrd start
>>>D R7 <initrd_size>	! There's a way to make LOAD set this, don't want to
			! complicate the example.
>>>S 800000	! Go!

and normal users using a nice CD distribution would get a utility (common to
all systems) that does the above behind a nice user interface using StarMON
calls common to all board implementations.

This wrapper would also have to be fundamentally different from the current
arch/ppc/boot/simple one. The latter assumes a really raw board and immediately
seizes full control of the board right on startup (flushes caches, remaps some
things on some boards, etc). With StarMON this is unacceptable. In order to
make StarMON calls (like to retrieve MAC addresses) you have to preserve the
StarMON environment. The moment you invalidate and enable the L1 dcache the
umbilical cord to StarMON is cut off, as that's where it stores all its state.
The exact procedure for changing from StarMON environment to the environment in
which Linux should run is very StarMON-specific and different for different
chipset and board implementations of StarMON. Thus if this wrapper is going to
be in the public tree it would have to be in its own directory (I would like
arch/ppc/boot/ppcstar) that people who aren't intimately familiar with StarMON
must not mess with.

It would work like the current make pImage which is handled in
arch/ppc/boot/Makefile to unconditionally make a PPCBoot image instead of going
into simple or whatever regardless of which CONFIG_<PLATFORM> is selected. In
the same way one would have make stImage which regardless of which
CONFIG_<PLATFORM> is selected would make a standardised StarMON-bootable image
by going into the ppcstar subdir. (Inside there I could have logic based on
CONFIG_<PLATFORM> things to enable the making of special StarMON calls and
generation of special bi_recs for platforms that need them.)

Also if an arch/ppc/boot/ppcstar directory were created, I would need to be
given write access to it in order to maintain it.

So here is my question to Paulus: would you accept such an addition to the
public tree (2_4_devel for now) and let me maintain it once added?

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
