Date: Tue, 8 Feb 2000 11:02:02 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-fbdev] Retrace
Message-ID: <Pine.LNX.4.05.10002081101510.27293-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


---------- Forwarded message ----------
Date: Mon, 7 Feb 2000 18:16:21 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Stefan Berndtsson <stefan@nocrew.org>, linux-fbdev@vuser.vu.union.edu,
     Linux/PPC Development <linuxppc-dev@cs.wisc.edu>
Subject: Re: [linux-fbdev] Retrace

On Tue, 1 Feb 2000, Petr Vandrovec wrote:
> On  1 Feb 00 at 13:14, Stefan Berndtsson wrote:
> > >   For now you have to do iopl(3); inb(0x3DA); iopl(0);... (you have to be
> > > root to do this. As alternative on matroxfb, you can mmap accelerator
> > > space and read register at offset 0x1FDA in this space. It contains
> > > same value as port 0x3DA does, but for mmapping /dev/fbX you do not
> > > need root rights.
> > You (or anyone really) wouldn't happen to know how to access 0x3da, or
> > whatever equivalent method there is, on an ATI Rage Pro LT, running
> > on PPC?
> I believe that on PReP it is byte in memory (/dev/mem) at physical address
> 0x800003DA, but Geert probably knows more details (maybe there is even

First you have to mmap() ISA I/O space using /dev/mem and put the mapped
address in isa_io_base. Then you can use inb() and friends (cfr.
include/asm-ppc/io.h).

And now the bad news: the address you have to mmap() depends on the machine
type :-(

> /dev/ioport on PPC).

Nope. But perhaps we should remove the #if !defined(CONFIG_PPC) around the
port operations in drivers/char/mem.c?

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
