Date: Mon, 10 Jul 2000 22:57:21 -0700
From: Matt Porter <mmporter@home.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Michael Lundkvist <ml@epact.se>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
Message-ID: <20000710225720.A23538@cx258813-a.chnd1.az.home.com>
References: <20000709222943.A19611@cx258813-a.chnd1.az.home.com> <Pine.HPX.4.10.10007101412580.9548-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10007101412580.9548-100000@gra-ux1.iram.es>; from paubert@iram.es on Mon, Jul 10, 2000 at 02:25:19PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 10, 2000 at 02:25:19PM +0200, Gabriel Paubert wrote:
>
> On Sun, 9 Jul 2000, Matt Porter wrote:
>
> > > Getting those changes into PPCBUG would be great.
> >
> > All you need is a big customer of MCG's to push them to do it.  Money
> > is a powerful motivator.
>
> Hopeless for me...

Yeah, it's a tough spot since their aren't really any serious competitors
for the PPC VMEbus business.  CPCI is another story though.

> > > Would it be possible to make one image for 2300 cards and one for 2400
> > > cards or does memory size affect the residual data?
> >
> > See above, you could make a lowest common denominator version of the
> > data and lose some memory.  Honestly, I'd just hack the kernel...PPCBUG
> > and residual data are a horrible burden.  Look through prep_* and
> > mm/init.c for every place residual data is used and hardcode for your
> > MCG boards.  In init.c, prep_find_end_of_memory() can detect a Raven
> > bridge then use the documented board registers to identify memory size
> > (see online user manual).  A 2400 puts memory size across the I2C bus
> > in a EEPROM containing all sorts of useful information.  Bug MCG to get
> > specs on the layout of these VPD records.
>
> I disagree, the residual data of the device/property tree of OF are great
> things. I want to boot _exactly_ the same kernel on machines with
> different amounts of memory... A lot of the initizalization should be
> moved to early boot or to a first stage bootloader (before uncompressing
> the kernel) and then the kernel should receive important information in a
> predigested form.

That would be fine in a perfect world, but the reality is that MCG
continually puts out buggy firmware with holes in the residual data.
Since residual data is a dead standard, they are patching in new packet
types as new board features are added to make so Frankensteinian
PReP residual data standard.  Again, the only useful thing being
garnered from residual data for the PReP port is memory size.  This
is almost as easily gathered from the board registers on boards
< MVME2400 and from the VPD on those boards >= MVME2400.

Back to original point, I'm not against using a residual data or
device tree if it doesn't have to have dozens of fixups applied.
I just don't see that coming out of the proprietary hardware/software
houses to use their broken data...

> For the VPD records, the information in the MVME2400 programmer's guide
> (mvme2400apg.pdf) looks sufficient (page 1-27 and appendix B).

The PrPMC750 and latter boards have define VPD packets a bit different
IIRC.  2400 was the first board to define VPD and it _almost_ was
standardized but not quite. :)

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
