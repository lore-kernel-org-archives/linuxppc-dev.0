Message-ID: <000801c06392$1ea9e680$490a10d0@stevebj>
From: "Stephen B. Johnson" <stevebj@inxpress.net>
To: "Brian Ford" <ford@vss.fsi.com>, "Gessner, Matt" <mattg@aiinet.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.GSO.4.21.0012110927360.24199-100000@eos>
Subject: Re: 66 Mhz bus clock for EST8260?
Date: Mon, 11 Dec 2000 10:47:58 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The Artesyn PM/3GT1 & PM/3GE1 have a 200MHz MPC8260 that works great...


----- Original Message -----
From: "Brian Ford" <ford@vss.fsi.com>
To: "Gessner, Matt" <mattg@aiinet.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, December 11, 2000 9:32 AM
Subject: RE: 66 Mhz bus clock for EST8260?


>
> How many people have actually done this on an EST board?  I don't doubt
> that the chip can do it, but I have my doubts about the EST PLL
> (clock) filter circuits being correct to begin with, let alone conforming
> to the errata.
>
> On Mon, 11 Dec 2000, Gessner, Matt wrote:
>
> > I had no problem at all getting this to work at 66MHz.
> > DO NOT RUN THE CPM FASTER THAN 133MHZ (at least on the chips I had,
> > it NEVER worked).
> >
> Yes.  I'd gladly settle for 200/133/66.
>
> > In fact, I clocked my 166/133/66 chip at 300MHz :-)
> > That baby RUNS!  Heh.
> >
> > > -----Original Message-----
> > > From: Brian Ford [mailto:ford@vss.fsi.com]
> > > Sent: Friday, December 08, 2000 1:47 PM
> > >
> > > Is there any magic in getting the EST8260 board to work with
> > > a 66 Mhz bus clock?  I haven't had good luck with a Linux or vxWorks
> > > image.
> > >
> > > My board has a 200/166/66 rev A.1 chip.
> > >
> > > I boot using a vxWorks bootrom.  I have made a few corrections to the
> > > bootrom so the decrementer frequency is set correctly from the user
> > > dip switches in addition to setting the core, cpm, and bus speeds.
> > >
> > > The scenerio is as follows:
> > >
> > > 1.) Burn configuration word to change MODCK_H from 0x0001 to 0x0101
> > > 2.) Swap oscillators 33.0 -> 66.0 Mhz
> > > 3.) Set MODCK[1-3] switches to 0x111 (200/133/66)
> > > 4.) Mirror 3.) on user switches for vxWorks bootrom to read
> > > 5.) Hack head_8260.S to put immr in place for Linux
> > > 6.) Set linux board info in embed_config.c to 200/133/66/66
> > > (core,cpm,bus,brg) making sure there is real space allocated for it
> > > instead or whatever was in r3 when vxWorks booted us.
> > > 6.) Reboot.
> > >
> > > vxWorks bootrom runs fine and downloads Linux or vxWorks.
> > >
> > > Linux pannics just before giving me a shell prompt somewhere
> > > in tty init.
> > >
> > > vxWorks appears to come up fine, but the muxDevBind fails for the Fast
> > > Ethernet and thus no network communications.  Even though the bootrom
> > > just downloaded us successfully over the same interface.
> > >
> > > Has anyone had any luck with the 66 Mhz bus clock?
> > >
>
> --
> Brian Ford
> Software Engineer
> Vital Visual Simulation Systems
> FlightSafety International
> Phone: 314-551-8460
> Fax:   314-551-8444
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
