Date: Thu, 26 Dec 2002 14:18:05 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gabriel Paubert <paubert@iram.es>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] IDE on CHRP LongTrail
In-Reply-To: <Pine.GSO.4.21.0212241005370.1821-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.4.21.0212261416460.15030-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Dec 2002, Geert Uytterhoeven wrote:
> On 24 Dec 2002, Benjamin Herrenschmidt wrote:
> > On Mon, 2002-12-23 at 23:13, Geert Uytterhoeven wrote:
> > > This patch enables the SL82C105 IDE interface in the W83C553 PCI/ISA bridge on
> > > my CHRP LongTrail.
> > >
> > > There are 2 ways to configure the IDE interface:
> > >   - Legacy mode, using IRQ 14 for the primary channel, and IRQ 15 for the
> > >     secondary channel
> > >   - Native mode, using IRQ 32 (OpenPIC IRQ 16) for both channels
> > >
> > > Apparently Open Firmware left the IDE interface in legacy mode, while the
> > > interrupt property of the device pointed to the OpenPIC interrupt. Of course
> > > this mix of legacy and native mode didn't work well and no interrupts came
> > > through.
> > >
> > > With the patch below, the SL82C105 is configured for native mode and both IDE
> > > channels work. The patch applies to 2.4.21-pre2 as well, but there IDE seems to
> > > be broken on PPC in general.
> >
> > I'd rather use a pci quirk here... also, why not make this generic to
> > all PPCs with a W83c553 ? I know the briQ at least will need something
> > similar.
>
> I did not want to touch non-LongTrail code.
>
> How is the interrupt routing done on the BriQ? On the LongTrail both legacy
> mode (ISA IRQ 14/15) and PCI native mode (PCI IRQ connected to OpenPIC) are
> possible for IDE.

Anyone with a BriQ (and preferably working IDE) who can tell us the output of
`lspci -v' and of `cat /proc/interrupts'?

There are other boards with a W83C553 out there. Gabriel?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
