Date: Fri, 10 Dec 1999 21:48:26 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Jens Ch. Restemeier" <jrestemeier@currantbun.com>
cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Open Sourced Glide on Linux PPC
In-Reply-To: <384D993C.46D0D76F@currantbun.com>
Message-ID: <Pine.LNX.4.05.9912102142410.388-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 7 Dec 1999, Jens Ch. Restemeier wrote:
> maybe you already know that Glide is Open Sourced, so I gave it a shot
> compiling it on Linux/PPC, before disassembling my PC to get out the
> VooDoo 1 and move it into the PMac.
> 
> There are some obvious problems, like -m486 compiler switches, or an
> undefined P6FENCE macro. But now I'm stuck: in fxlinux.c are references
> to inb() & Co. , and they expand to something using isa_io_base, which
> is undefined on my machine. Even funnier because I don't have ISA slots
> at all (PMac). 
> I'm using a 2.2.3 kernel, and it's quite possible that I messed up some
> headers while building other stuff.
> 
> Questions:
> - Has anybody had any success compiling Glide/Linux/PPC/VooDoo1 ?
> - Is this isa_io_base thingy changed in newer kernels, or did I just mix
> up my configuration ? I don't really like downloading kernels/patches
> through my slow connections, so I'd like to be sure...

`ISA I/O space' is the same as `PCI I/O space'. Before you can access it on PPC
using inb() and friends, you have to mmap() it, like

    unsigned long isa_io_base;
    int io_fd;

    if ((io_fd = open("/dev/mem", O_RDWR)) == -1) {
	perror("open /dev/mem");
	exit(1);
    }
    isa_io_base = mmap(0, 0x10000, PROT_WRITE|PROT_EXEC|PROT_READ, MAP_SHARED,
    		       io_fd, MB_ISA_IO_BASE);
    if ((long)isa_io_base == -1) {
	perror("mmaping io space");
	exit(1);
    }

The bad thing is that MB_ISA_IO_BASE depends on the machine type. Look at
linux/include/asm-ppc/io.h for the different values for different machines.
On Pmac, isa_io_base seems to be set up in arch/ppc/kernel/pmac_pci.c.

And if the original code contains iopl() calls, you have to protect them inside
#ifdef __i386__/#endif pairs.

Good luck!

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
