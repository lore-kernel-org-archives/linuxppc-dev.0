Date: Fri, 27 Oct 2000 19:24:57 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Early PCI auto-configuration
In-Reply-To: <19340920165843.29028@192.168.1.10>
Message-ID: <Pine.LNX.4.10.10010271921050.390-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 27 Oct 2000, Benjamin Herrenschmidt wrote:
> >[The discussion below is based on the latest fsmlabs 5005 repository
> >code]
>
> You mean linuxppc_2_5, I guess ?
>
> >My problem:  The firmware on a couple platform I need to support do
> >absolutely _no_ PCI device initialization.


> But if I understand Geert code correctly, except for IDE devices & VGA

I copied that code from ia32, with some minor modifications to make it work
with the Open Firmware on my LongTrail.

> cards, the pcibios_assign_resources() function will assign bases
> addresses to unassigned devices. This is done by the call to
> pcibios_assign_resources(), and works if your bus resources & ranges have
> been setup properly.

Yep. If you set up the bus resources correctly, that code will assign all
unassigned resources automatically (and reassign conflicting resources) from
the ranges specified by the bus resources.

BTW, before I did this on PPC, I played with PCI resource assignment on a MIPS
board, where the firmware didn't do any PCI assignments (except for Ethernet,
to boot images using TFTP), which is exactly what you want. For reference, that
code is in arch/mips/ddb5074/pci.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
