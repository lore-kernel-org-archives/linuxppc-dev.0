Cc: LinuxPPClist <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3975C194.9C7DB393@lucent.com>
Date: Wed, 19 Jul 2000 09:56:20 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: Ron Bianco <ronb@junction.net>
Subject: Re: query on ppc/kernel/head.S for generic 8240
References: <000101bff0eb$84c50b30$4d012ac7@warp-speed>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ron Bianco wrote:
> And as I don't have a UART I'll have to do a special console driver at some point, but for
> now I modified printk() to just put the strings into a large buffer that I can monitor
> with the JTAG debugger.

Yes. My boards have no UART either, but they do have a PCI interface to
a host, which can read/write memory. So I wrote a custom console driver
using that. Note that there are really _TWO_ consoles -- you will need
a console driver for printk-s and a serial I/O driver for /dev/console;
I made them use the same buffer so they appear at the same device on
the host. I don't think anything uses the input side of the console
driver (but am not certain).


> I'm concentrating on the kernel itself at the moment so I can use it to help me verify
> that the PCI SCSI and Ethernet chips are working OK, so I can get the Rev B version of
> the
> board into the fabrication pipeline

I personally would not be satisfied that the interfaces work without
running diagnostics on them (read/write the disks, ping other Ethernet
hosts, etc.) -- that will require the ability to run user programs in
Linux. If Linux is to be the only OS running on your board, then your
schedule should reflect the time it takes to port Linux to it. In my
case we had our proprietary OS running on the boards long ago and know
the hardware works....


> I'm ignoring the loader/decompressor and will have a custom loader,

So do I. I simply load vmlinux, as I had some difficulty with the
decompressor code; it only takes me 0.7 sec to download the uncompressed
vmlinux anyway. My loader knows about ELF files, and it just loads the
PROG section to physical address 0, puts the command-line at 0x00400000
(an arbitrary choice), and constructs a short startup at 0xFFF00000 and
each exception vector there. The short startup loads values into r3-r7
and jumps to physical address 0; r3=board ID, r4&r5=initrd image,
r6&r7=cmd line.


> I changed:
> KERNELLOAD in file:  arch/ppc/Makefile from C0000000 to 00000000
> PAGE_OFFSET and therefore KERNELBASE in file:  include/asm-ppc/page.h
> from C0000000 to 00000000

I don't think you want to do that -- virtual 0x00000000 is _USER_
space. Note that KERNELBASE, KERNELLOAD, and PAGE_OFFSET are all
virtual addresses. Linux/PPC implicitly assumes it is loaded at
physical address 0x00000000 because it sets the MSR to use the
exception vectors there (it expects some sort of boot ROM at
physical 0xFFF00000).


> Would this break anything?

Yes. Moving the virtual address of the kernel to 0 can cause conflicts
with user programs, especially if you have more than 256 MB of physical
RAM (some of our boards do). It is possible that with less than that it
will work, as the user programs I have looked at start above 0x10000000,
but I would not want to count on that. I do not know if the BAT setup
in mm_init() will work properly for this, but it probably does -- you'd
better check.


> Is this sufficient?

Surely not. Here is the list of files I had to change to get Linux
up on our boards:
	head.S		_LOTS_ of changes
	setup.c		_LOTS_ of changes to things like powerdown
	main.c		need to init the lsps console driver early
	mm_init.c	need to map memory for my drivers
	ppc_ksyms.c	need to remove some undefined symbols
	arch/ppc/kernel/Makefile  remove unused stuff
	drivers/Makefile  remove unused stuff
	main/Makefile	add a make in my LSPS directory
Plus one new file:
	lsps_bd.c	console and network drivers for our LSPS board

Note that for every file I needed to change, I moved it to
/usr/local/src/linux/lsps and sym-linked it back where it belonged.
This way all changed files are in one place, and I can back them up.
All changes are #ifdef-ed with CONFIG_LSPS -- "lsps" is of course our
product name.


> In file:   arch/ppc/kernel/head.S,  I'm wondering if can branch directly to   start_here:
> as I don't see anything useful in the code before that for my purposes?

NO! the code to get to start_here uses the rfi instruction to enable
memory management synchronously, and there is a lot of code before that
to setup the BATs and SRs. You most definitely need all that. Note
that Linux turns the memory-management on and off several times during
its initialization.


> All I have to do
> is make sure the stack pointer is set to some innocuous place first?

It is _A_LOT_ more complicated than that. The stack is the least of
your worries....


> Is there an advantage to using the residual data mechanism?  i.e. to create a version that
> matches my hardware?
> Or is this strictly for the pmac or some specific BootROM?

I have never figured it out, and don't use it.


Note that everything I have learned about this came from reading the
code and playing with it to make it work on our boards. It is possible
that I have some details wrong, and likely that my style is different
from that of other kernel developers. But Linux does run solidly on our
boards.


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
