Date: Fri, 13 Oct 2000 18:21:27 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: Michel Dänzer <daenzerm@student.ethz.ch>,
        "Hendricks, Kevin" <khendricks@ivey.uwo.ca>,
        Josh Huber <huber@mclx.com>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <Pine.LNX.4.21.0010122029001.1217-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.10010131819430.381-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Kostas Gewrgiou wrote:
> On Thu, 12 Oct 2000, Michel [iso-8859-1] Dänzer wrote:
> > So this code from the current X CVS:
> >
> >     R128ReadBIOS(0x0000, info->VBIOS, R128_VBIOS_SIZE);
> >     if (info->VBIOS[0] != 0x55 || info->VBIOS[1] != 0xaa) {
> >         xf86DrvMsg(pScrn->scrnIndex, X_WARNING,
> >                    "Video BIOS not detected in PCI space!\n");
> >
> > only checks if there is a ROM, not if it's a BIOS?
>
> Right, from the pci spec the table is something like this
> Offset    Length    Value    Description
> 0h          1        55h    ROM Signature, byte 1
> 1h          1        AAh    ROM Signature, byte 2
> ...
> 18h-19h     2        xx     Pointer to PCI Data Structure
>
> PCI Data Structure
> Offset    Length  Description
> ...
> 14           1    Code Type
> ..
>
> Code Type is 0 for bios and 1 for OF
>
> So you'll have to add one more test to check for BIOS/OF

IIRC, it's also possible to have one ROM that contains both x86 BIOS and
F-Code Open Firmware stuff. It may require compression to achieve this due to
the limited size to the ROM. I think I saw this on the Firmworks website, an
eon ago.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
