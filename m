Date: Sun, 13 Dec 1998 18:59:59 +0100 (MET)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Corey Minyard <minyard@acm.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructure of arch/ppc/kernel and include/asm-ppc
In-Reply-To: <m2zp8te2rh.fsf@wf-rch.cirr.com>
Message-ID: <Pine.LNX.4.02.9812131538310.871-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 12 Dec 1998, Corey Minyard wrote:
> This is a patch relative to 2.1.131 that significantly restructures
> the Linux PPC stuff.  It is the first step in making the code more
> modular and separating the machine-specific from the
> machine-independant stuff.  This currently works on my MVME2700
> board.

I haven't tested it yet on my CHRP box, but it looks fine!

> Significantly, the following have been done:
>   * Most machine-dependencies have been removed from include/asm-ppc.
>     However, there is a lot of stuff with CONFIG_APUS that has
>     dependencies on the include/asm-m68k directory.  I'm not sure
>     what to do with that.

Ideally these should use an Amiga specific include directory. But that's 2.3
business. Then we can add separate subdirectories for machine types that span
multiple architectures (Amiga, Mac, `PC', Sun, ...), just like the current
asm-* stuff.


Another thing I've been thinking about, related to unified kernels. Although we
can create one common vmlinux image, the real boot image (arch/ppc/*boot/*)
still differs among the different machine types.

Now I also have an AXP box (UDB), I came in contact with MILO, and I like it.
MILO is a boot loader that gets loaded by the SRM or ARC firmware on AXP. It
contains drivers for the most important parts of the hardware (including PCI
fixup code), some filesystem code (ext2/msdos/iso9660), and a command line. All
driver code is borrowed from the Linux kernel. In fact MILO is a small and
limited Linux kernel.

The nice thing is that you can upgrade your kernel without upgrading MILO (my
MILO is still at the 2.0.34 level, from the Debian boot disks). Just put the
kernel in /boot, and since MILO knows ext2, it can boot from it.

For PPC, we would need different MILO images for the different machine types.
The kernel can be ELF on all machine types, since we put an ELF loader in MILO.
MILO doesn't need much fancy driver stuff, just SCSI/IDE, floppy, keyboard and
a simple console (serial, VGA text, offb). And BootX can become some special
variant of MILO :-)

Depending on the smartness of the system firmware for a specific machine, MILO
has to be more or less complex in setting up the machine. If you would design
your own box, you can put a dumb disk block loader in FlashROM, and all other
hardware support in MILO. Or put MILO in FlashROM, as can be done on AXP too
(haven't tried that yet).

Comments?

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
