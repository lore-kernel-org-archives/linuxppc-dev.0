Date: Thu, 28 Sep 2000 12:00:41 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: Benjamin Herrenschmidt <bh40@calva.net>, Matt Porter <mmporter@home.com>,
        Olaf Hering <olh@suse.de>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <Pine.LNX.4.21.0009272018090.9846-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.10009281200120.3468-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 27 Sep 2000, Kostas Gewrgiou wrote:
> On Wed, 27 Sep 2000, Geert Uytterhoeven wrote:
> > On Tue, 26 Sep 2000, Benjamin Herrenschmidt wrote:
> > > One thing: I'd be interested in figuring out what happens if you simply
> > > leave this nasty ATI BAR unassigned (write 0xffffffff and then 0 to it).
> > > Will the controller fail ?
> >
> > Well, according to Matt Porter, 0 is a valid address in PCI 2.2. So how do you
> > disable BARs for PCI 2.2-compliant devices?
> >
> > And I'm afraid what XFree86 4.x will do with BARs set to 0. Probably it will
> > try to relocate them. I guess that's how it crashes on my box with an
> > unitialized S3...
>
> Yeap unless i am wrong it will try to relocate them, for prep i fear that
> without correct BusAddrToHostAddr/HostAddrToBusAddr functions in the xserver
> this isn't going to work at all :(
>
> Don't expect it to initialize the S3 card in any case, the int10 module
> needs ISA IO/mem accesses and both don't work at the moment for linux/ppc
> you can imagine what the following code will do to your machine :(
>
>  #define V_RAM 0xA0000
>  INTPriv(pInt)->vRam = xf86MapVidMem(screen,VIDMEM_MMIO,V_RAM,size);

Yes, you have to know the ISA memory base address, which is machine dependent.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
