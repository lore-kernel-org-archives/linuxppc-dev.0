Date: Fri, 22 Sep 2000 13:58:45 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dan Malek <dan@mvista.com>
cc: paulus@linuxcare.com.au,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <39CAD7BC.7AF0E42D@mvista.com>
Message-ID: <Pine.LNX.4.10.10009221356470.377-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 21 Sep 2000, Dan Malek wrote:
> Geert Uytterhoeven wrote:
> > And how to access PCI I/O space from user space? There the MMU doesn't help,
>
> Sure.  I do it all of the time.  I have an 860 with a Tundra PCI
> bridge (any system but x86 will do this too).  I just open /dev/mem,
> and map the physical address of the device on the bus.  In this
> case the Tundra maps physical 0x80000000 to the PCI/ISA I/O space,
> and 0xc0000000 to PCI memory.  I even have an ISA bridge downstream
> that I access ISA boards in the user application.  Piece of cake.
>
> In the user application I get some virtual address like 0x34010000
> or whatever, and that is mapped through the MMU to the 0x80000000
> physical address.  You can do this on any processor but the x86.
> The virtual address is likely to be different every time, but I
> don't care...

I know about that one, I use it on my LongTrail as well.

But you suggested the use of the MMU to map all I/O spaces from all bridges
into one merged and consecutive universal I/O space. That works fine in kernel
space, but not in user space, because you still need the correct _physical_
address when mmap'ing /dev/mem.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
