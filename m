Message-ID: <38570544.476D42C9@ctam.com.au>
Date: Wed, 15 Dec 1999 14:04:37 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc embedded boot problems.
References: <3856C0D7.4E1404C9@ctam.com.au> <385703C2.AA4298E7@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Brendan Simon wrote:
>
> > I have HAD linuxppc (embedded-2.2.5) working on a custom MPC860 board.
> > By working I mean booting to the bash prompt and being able to view the
> > initrd filesystem with ls.
>
> Debug-101.....Back out the changes until you get to the
> original working version.  That usually helps uncover information
> necessary to solve the problem.

Yep.  Did that but still the same result.  I think I am back to the same
spot but nothing is in revision control at this stage so I can't garauntee
it.


> > .......  I decided to put a whole lot of
> > printk statements in the enet.c code to see what was happening.
>
> Bad idea.  Maybe one or two that you keep moving around as you
> discover information.

Why is it a bad idea.  I just put a few at the entry of each function to see
what was happening.  I prefix every thing with my initials so that I can
delete them later.  Is there a limit to printk statements ?


> Well, the output above doesn't match this set of headers.  The
> VMA/LMA are not supposed to be the Flash ROM offsets, they are
> supposed to be the 0x00100000 addresses where the code
> really belongs in RAM.  The first stage of the Linux boot will
> discover it is running at some address other than RAM, and
> relocate itself to the linked address.

Sorry for the misleading information.  The screen output was from last night
and I had made some more modifications and compiled the kernel since.


> Do not ever change the load/offset addresses in Makefiles.
> Use or write a program that will take the exact bits and place
> them into a flash rom.  It couldn't be easier.  The zImage is
> a perfect bag of bits that can be loaded (almost) anywhere
> into memory or a flash rom without any modification.

I haven't touched the makefile.  I use a script to massage the zImage and
zImage.initrd outputs.  It basically is a few powerpc-linux-objcopy commands
to move sections around to where the image expects them to be and also to
convert to a hex file so I can program the linear flash SIMMs.

I think the problems I am seeing are more fundamental to the 860 setup.  I
have a bootloader which essentially initialises the chip selects for ROM and
DRAM and sets up the UPMA for the DRAM.  There is also some port
initialisation for SMC1(console) and SCC4(ethernet).  Apart from that the
bootloader just jumps the start of the application code (the kernel image in
this case).

What I don't understand is why it starts to boot (ie. uncompresses into
memory) but then nothing happens.  Are there things that the kernel expects
to be setup besides the flash/dram memory ?  eg. Interrupt vectors, timers,
etc.  I'll have a look through the fadsrom code to see if this will shed any
light on my problems.

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
