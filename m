Date: Tue, 20 Jul 2004 15:08:32 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Hering <olh@suse.de>
Cc: Ben Collins <bcollins@debian.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	linux1394-devel@lists.sourceforge.net
Subject: Re: PCILynx driver on big-endian
In-Reply-To: <20040720114308.GA20521@suse.de>
Message-ID: <Pine.GSO.4.58.0407201507250.21539@waterleaf.sonytel.be>
References: <20040305235832.GA1082@phunnypharm.org> <20040306144215.GA23771@suse.de>
 <20040306171629.GC1082@phunnypharm.org> <20040720104708.GB11248@suse.de>
 <Pine.GSO.4.58.0407201327150.20387@waterleaf.sonytel.be> <20040720114308.GA20521@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Jul 2004, Olaf Hering wrote:
>  On Tue, Jul 20, Geert Uytterhoeven wrote:
> > On Tue, 20 Jul 2004, Olaf Hering wrote:
> > > Did the pcilynx driver ever work on ppc?
> > > The B&W G3 Macs have an onboard Opti chip, I doubt it ever worked.
> > >
> > > Its better to hide it.
> > >
> > >
> > > Index: Kconfig
> > > ===================================================================
> > > --- Kconfig	(revision 1233)
> > > +++ Kconfig	(working copy)
> > > @@ -72,7 +72,7 @@
> > >
> > >  config IEEE1394_PCILYNX
> > >  	tristate "Texas Instruments PCILynx support"
> > > -	depends on PCI && IEEE1394 && I2C
> > > +	depends on PCI && IEEE1394 && I2C && !PPC_PMAC
> >
> > Or to better show there's a problem: ... && (!PPC_PMAC || BROKEN)
>
> That will hide it everywhere? && (0 || 1)

Nope. It will be hidden on PowerMac only, unless you enabled BROKEN on
PowerMac.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
