From: "Ron Bianco" <ronb@junction.net>
To: "LinuxPPClist" <linuxppc-embedded@lists.linuxppc.org>
Cc: <tjroberts@lucent.com>
Subject: RE: query on ppc/kernel/head.S for generic 8240
Date: Tue, 25 Jul 2000 13:16:46 -0700
Message-ID: <000401bff675$418b7bd0$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3975C194.9C7DB393@lucent.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Tom, for the very interesting insights in this and other emails.  Sorry that you
got this msg twice, I don't know how often you check the mail list.

BTW, I summarized our board and my dev. env. in an email dated: 7/7/00.

> > And as I don't have a UART I'll have to do a special console driver at some
> >point, but for
> > now I modified printk() to just put the strings into a large buffer that I can monitor
> > with the JTAG debugger.
>
> Yes. My boards have no UART either, but they do have a PCI interface to
> a host, which can read/write memory. So I wrote a custom console driver
> using that. Note that there are really _TWO_ consoles -- you will need
> a console driver for printk-s and a serial I/O driver for /dev/console;
> I made them use the same buffer so they appear at the same device on
> the host. I don't think anything uses the input side of the console
> driver (but am not certain).

Good point. Similar situation on our board.
Our board has 32kWords (32bit) of dual port SRAM at the BootROM location FFF00000 as PCI
mem, for word access only.
Our host will deposit boot code in there before taking the 8240 board out of reset.  Other
than config register init, the boot code's main job will be to handle packetized xfer of
the Linux kernel code from the host to SDRAM, and then start the kernel.
Once the kernel's running, I'll of course be able to telnet via ethernet for a pseudo
linux console.

In the meantime, since after start_kernel(), and maybe before,  the VisionClick debugger
will be mostly useless, I'll be desparate for console I/O.   I did a crude hack to
printk.c that only seems to work until MMU is turned on.  I was wondering if you would be
able & willing to share your custom console source code as an example.
I am just starting to learn PPC assembly lang. in addition to Linux, and it would be a
huge help.

> > I'm concentrating on the kernel itself at the moment so I can use it to help me verify
> > that the PCI SCSI and Ethernet chips are working OK, so I can get the Rev B version of
> > the  board into the fabrication pipeline

> I personally would not be satisfied that the interfaces work without
> running diagnostics on them (read/write the disks, ping other Ethernet
> hosts, etc.) -- that will require the ability to run user programs in
> Linux. If Linux is to be the only OS running on your board, then your
> schedule should reflect the time it takes to port Linux to it. In my
> case we had our proprietary OS running on the boards long ago and know
> the hardware works....

Good point and yes that's the plan.

> > I'm ignoring the loader/decompressor and will have a custom loader,
>
> So do I. I simply load vmlinux, as I had some difficulty with the
> decompressor code; it only takes me 0.7 sec to download the uncompressed
> vmlinux anyway. My loader knows about ELF files, and it just loads the
> PROG section to physical address 0, puts the command-line at 0x00400000
> (an arbitrary choice), and constructs a short startup at 0xFFF00000 and
> each exception vector there. The short startup loads values into r3-r7
> and jumps to physical address 0; r3=board ID, r4&r5=initrd image,
> r6&r7=cmd line.

You put the same startup code at all the initial exception vectors in the 0xFFF00000
range?

> > I changed:
> > KERNELLOAD in file:  arch/ppc/Makefile from C0000000 to 00000000
> > PAGE_OFFSET and therefore KERNELBASE in file:  include/asm-ppc/page.h
> > from C0000000 to 00000000
>
> I don't think you want to do that -- virtual 0x00000000 is _USER_
> space. Note that KERNELBASE, KERNELLOAD, and PAGE_OFFSET are all
> virtual addresses. Linux/PPC implicitly assumes it is loaded at
> physical address 0x00000000 because it sets the MSR to use the
> exception vectors there (it expects some sort of boot ROM at
> physical 0xFFF00000).

An objdump of vmlinux, built unmodified, shows vaddr and paddr == 0cC0000000.  This forces
a conventional elf loader to try to load it to 0xC0000000.
With the EST debugger/elf converter, if I had built conventionally, I have to force the
load to 00000000 but then the debugger refuses to single step or run with PC == 0.   Don't
know why.  And changing KERNELLOAD only, causes copy_and_flush() to copy the kernel
needlessly, then crashola when MMU turned on.   So I did it that way, at least for the
time being, and it runs OK up to MMU_init().
If I don't use an elf format image then I lose debugging info.

I'm still confused by this issue.  i.e. what is the virtual map that linux expects/uses.
How a debugger with no table walk can't still be useful if it is always looking at
physical addresses.  Or does a JTAG request for data at an address also get translated by
the MMU if it is enabled?

> > Would this break anything?
>
> Yes. Moving the virtual address of the kernel to 0 can cause conflicts
> with user programs, especially if you have more than 256 MB of physical
> RAM (some of our boards do). It is possible that with less than that it
> will work, as the user programs I have looked at start above 0x10000000,
> but I would not want to count on that. I do not know if the BAT setup
> in mm_init() will work properly for this, but it probably does -- you'd
> better check.

Right, thanks.

> Here is the list of files I had to change to get Linux
> up on our boards:
> 	head.S		_LOTS_ of changes
> 	setup.c		_LOTS_ of changes to things like powerdown
> 	main.c		need to init the lsps console driver early
> 	mm_init.c	need to map memory for my drivers
> 	ppc_ksyms.c	need to remove some undefined symbols
> 	arch/ppc/kernel/Makefile  remove unused stuff
> 	drivers/Makefile  remove unused stuff
> 	main/Makefile	add a make in my LSPS directory
> Plus one new file:
> 	lsps_bd.c	console and network drivers for our LSPS board

Thanks, this is helpful.   At this point, I'm unsure of what I can safely remove in terms
of unused stuff.  I changed the ethernet and scsi drivers used at least, OK.   Trial and
error for the rest I guess.

> Note that for every file I needed to change, I moved it to
> /usr/local/src/linux/lsps and sym-linked it back where it belonged.
> This way all changed files are in one place, and I can back them up.
> All changes are #ifdef-ed with CONFIG_LSPS -- "lsps" is of course our
> product name.

Good idea.

> Note
> that Linux turns the memory-management on and off several times during
> its initialization.

Right.  Seems kind of hackish.  Confusing to follow.

> Note that everything I have learned about this came from reading the
> code and playing with it to make it work on our boards. It is possible
> that I have some details wrong, and likely that my style is different
> from that of other kernel developers. But Linux does run solidly on our
> boards.

Wow.  Seems like reading the code sometimes raises more questions for me.  I'm currently
struggling to understand/modify the irq setup.
After that I'm going over the MMU init stuff.  Then, hopefully,  the kernel will start up
OK.

Cheers, Ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
