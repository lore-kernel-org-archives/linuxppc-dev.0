From: Peter De Schrijver <p2@medelec.uia.ac.be>
Message-Id: <199812141913.UAA18494@medelec.uia.ac.be>
Subject: Re: Restructure of arch/ppc/kernel and include/asm-ppc
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
Date: Mon, 14 Dec 1998 20:13:10 +0100 (MET)
Cc: minyard@acm.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.02.9812131538310.871-100000@cassiopeia.home> from "Geert Uytterhoeven" at Dec 13, 98 06:59:59 pm
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 
> 
> On 12 Dec 1998, Corey Minyard wrote:
> > This is a patch relative to 2.1.131 that significantly restructures
> > the Linux PPC stuff.  It is the first step in making the code more
> > modular and separating the machine-specific from the
> > machine-independant stuff.  This currently works on my MVME2700
> > board.
> 
> I haven't tested it yet on my CHRP box, but it looks fine!
> 
> > Significantly, the following have been done:
> >   * Most machine-dependencies have been removed from include/asm-ppc.
> >     However, there is a lot of stuff with CONFIG_APUS that has
> >     dependencies on the include/asm-m68k directory.  I'm not sure
> >     what to do with that.
> 
> Ideally these should use an Amiga specific include directory. But that's 2.3
> business. Then we can add separate subdirectories for machine types that span
> multiple architectures (Amiga, Mac, `PC', Sun, ...), just like the current
> asm-* stuff.
> 
> 
> Another thing I've been thinking about, related to unified kernels. Although we
> can create one common vmlinux image, the real boot image (arch/ppc/*boot/*)
> still differs among the different machine types.
> 
> Now I also have an AXP box (UDB), I came in contact with MILO, and I like it.
> MILO is a boot loader that gets loaded by the SRM or ARC firmware on AXP. It
> contains drivers for the most important parts of the hardware (including PCI
> fixup code), some filesystem code (ext2/msdos/iso9660), and a command line. All
> driver code is borrowed from the Linux kernel. In fact MILO is a small and
> limited Linux kernel.
> 
> The nice thing is that you can upgrade your kernel without upgrading MILO (my
> MILO is still at the 2.0.34 level, from the Debian boot disks). Just put the
> kernel in /boot, and since MILO knows ext2, it can boot from it.
> 
> For PPC, we would need different MILO images for the different machine types.
> The kernel can be ELF on all machine types, since we put an ELF loader in MILO.
> MILO doesn't need much fancy driver stuff, just SCSI/IDE, floppy, keyboard and
> a simple console (serial, VGA text, offb). And BootX can become some special
> variant of MILO :-)
> 
> Depending on the smartness of the system firmware for a specific machine, MILO
> has to be more or less complex in setting up the machine. If you would design
> your own box, you can put a dumb disk block loader in FlashROM, and all other
> hardware support in MILO. Or put MILO in FlashROM, as can be done on AXP too
> (haven't tried that yet).
> 

I have an AXP board with milo in ROM. Works fine. MILO also has an x86 emulator,
so it is possible to use a normal PC video board. 
The machine also has a very nice boot sequence. In fact there are 2 EPROM banks.
The first EPROM bank contains all hardware specific initialization (eg: memory,
cache). When the system is initialized far enough, the software in
the second EPROM bank is started. This is were milo (or SRM, or ARC) lives.
The first EPROM bank is implemented with a 27c512 EPROM. The second one with
two AMD 28F020 flash proms. The image in the first EPROM is only 64Kbit. The
extra space is used to store alternate images which can be selected using 
jumpers on the board. One of these alternate images allows you to load the
2nd image from a floppy instead of jumping to the EPROM bank. This can be used
to recover from a bad image in the 2nd EPROM bank. As the functionality in the
1st bank is very limited, it is very unlikely you want to upgrade this image.

Peter.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
