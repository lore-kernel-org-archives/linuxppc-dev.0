Date: Sun, 3 Dec 2000 21:41:58 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Stefan Jeglinski <jeglin@4pi.com>
cc: linuxppc-dev@lists.linuxppc.org,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Subject: Re: dual IRQ 23 (was: USB?; 2.2.18 no boot?; aic7xxx?)
In-Reply-To: <p04330100b64a0cac23a1@[192.168.0.1]>
Message-ID: <Pine.GSO.4.10.10012032140410.7958-100000@rose.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 28 Nov 2000, Stefan Jeglinski wrote:
> >	usb-ohci.c: USB OHCI at membase 0xd0184000, IRQ 23
> >
> >already gives a clue. Question is, what else is at IRQ 23?
> >
> >	Michael
>
> In both 2.2.17 and 2.2.18pre23 (bk), 6-slot PTP (9500-ish), cards are
> as follows, top to bottom:
>
> Adaptec 2940UW
> Farallon ethernet 10/100
> OrangeLink firewire/usb combo
> Matrox Mystique card
> ixMicro TV card
> ixMicro Twin Turbo card [aka imstt]
>
>
> lspci -vv is attached at the end. The key point is that the entry for
> the Adaptec 2940UW card and the Orangelink USB card BOTH say:
>
> 	Interrupt: pin A routed to IRQ 23
>
> Hah. So, this might explain a lot. Obviously this is why my usb mouse
> only responds when there is some disk activity, and only for a
> moment. It ALSO may help explain why I was having trouble booting
> (kernel panic traced to aic7xxx and its call to ioremap). However,
> this boot issue is still suspicious for 2 reasons:
>
> 	1. 2.2.17 lspci -vv ALSO shows same shared IRQ 23, and 2.2.17
> 	   never had boot problem. But it also has no USB stuff compiled in.
>
> 	2. My boot "workaround" is simply to add printk statements at
> 	   strategic points in the source. Boot problem solved. Weird.
>
>
> At any rate, why are these 2 devices sharing an IRQ, and what can be
> done about it? Thanks Michael Schmitz for giving me the first
> concrete lead on this.

Shared interrupts are allowed by PCI. If it doesn't work, it means one of the
drivers (or both) can't cope with shared interrupts. The solution is to fix the
driver(s).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
