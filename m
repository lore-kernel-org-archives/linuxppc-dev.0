Message-Id: <4.3.2.20001106073311.00b8b8c0@falcon.si.com>
Date: Mon, 06 Nov 2000 08:06:17 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Debugger Problems
In-Reply-To: <3A069BD6.9F63FF6C@dspace.de>
References: <200011060939.eA69dBS30762@denx.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 12:53 PM 11/6/00 +0100, Andreas Schreckenberg wrote:

>Wolfgang Denk wrote:
> >
> > In message <3A06703F.6D5DBB23@dspace.de> you wrote:
> > Which firmware are you running on your board? Do you know  about  the
> > PPCBoot project (http://ppcboot.sourceforge.net)?
>
>Our board contains a MPC750-466 MHz CPU, it's no embedded system in the
>normal way. There's no way to boot via nfs. (no ethernet availible)
>There is no firmware. The board has flash memory and jumps directly to
>ram after reset.
>Can I use ppcboot for my board ?
>I thought it's only for special TQM8xx boards.
>Perhaps I have read not enough about ppcboot... :-)
>I want to build a kernel and boot via ramdisk support, the board
>communicates
>with a serial port.
>
> > Did you check the Embedded PowerPC HOWTO at
> > http://members.nbci.com/greyhams/linux/PowerPC-Embedded-HOWTO.html ?
>
>Yes, there are some people who evaluate the EST debugger.
>I want to download my code via JTAG/BDM as a raw binary or elf file in
>the ram memory.
>(there are problems with elf and EST, because the EST debugger handles
>the kernel and ramdisk sections not correct, bin2bin which I found in
>the mailinglist seems to fix this for .bin files.)
>Finally all the stuff should be burned into flash.
>
> > Can you explain what "some problems" means?
>
>My startupcode first turnoff the cpu and initializes the bat registers.
>I turn on the MMU and jump via an rfi instruction.
>(first init the srr0/srr1 registers) then the debugger confuses this
>situation
>and shows wrong code in the disassemby window.
>
>Is there any workaround availible ?
>Or is there no chance to use the EST Debugger with virtual memory ?
>Are there any linux-ppc projects with EST experience ?

The EST debugger doesn't understand virtual memory and that is very
problematic.

We are prototyping on the EST SBC8260 board.  This board has RAM on
both the 60x bus and the local bus (point being, there are two banks of
RAM).  We had success stepping through the initial linux boot process
(after switching to virtual memory) by remapping the local bus RAM to
location 0xC0000000 and copying the "real" memory (0x00000000) to the
0xC0000000 space.  The EST debugger looks at the PC (in 0xC land) and
fetches that memory for its disassembly.  Using this trick, we were
able to single-step through virtual memory.  Note that breakpoints
don't work since they will be set in 0xC land, not 0x0 land.  This is
_really_ crude but allowed us to find enough of our screwups to get
linux running.

If you only have one bank of memory, this technique won't work.  Your
best bet in that case is to adjust your MMU initialization code to
remap your physical memory so that virtual==physical (i.e. remap
physical to 0xC0000000) and you will be able to step (and set
breakpoints) through more code.  Of course, this will only work for a
while and then linux will start trying to make userland tasks in 0x0
land and break horribly.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
