Date: Sun, 9 Jul 2000 22:29:43 -0700
From: Matt Porter <mmporter@home.com>
To: Michael Lundkvist <ml@epact.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
Message-ID: <20000709222943.A19611@cx258813-a.chnd1.az.home.com>
References: <Pine.HPX.4.10.10007061912350.21326-100000@gra-ux1.iram.es> <qp66qji2pq.fsf@erbium.epact.se> <20000708162915.A11060@cx258813-a.chnd1.az.home.com> <qpu2dz6ddh.fsf@erbium.epact.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <qpu2dz6ddh.fsf@erbium.epact.se>; from ml@epact.se on Sun, Jul 09, 2000 at 08:12:26AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 09, 2000 at 08:12:26AM +0200, Michael Lundkvist wrote:
>
> Matt Porter <mmporter@home.com> writes:
>
> >
> > > Nope. I think I'll go for Bugboot. Ramix also talked about the
> > > possibility of modifying PPCBug to add support for the Ramix 233.
> >
> > I really have to recommend against that.  Once Ramix sees the icky PPCBUG
> > code they will hate as much as I do.  I gave well documented changes to
> > the PPCBUG guys so that BUGBOOT wasn't needed to boot a kernel from
> > FLASH on a PowerPlus board but they haven't incorporated those changes
> > after a full year now. :)
> >
>
> Getting those changes into PPCBUG would be great.

All you need is a big customer of MCG's to push them to do it.  Money
is a powerful motivator.

> How board specific is the residual data that Bugboot needs?

For the single processor boards, the only thing used for the prep port
is the memory sizing information.  You can always hack that or fix
the kernel to get memory size from the board registers or VPD (in the
case of the MVME2400 and later boards).

> Would it be possible to make one image for 2300 cards and one for 2400
> cards or does memory size affect the residual data?

See above, you could make a lowest common denominator version of the
data and lose some memory.  Honestly, I'd just hack the kernel...PPCBUG
and residual data are a horrible burden.  Look through prep_* and
mm/init.c for every place residual data is used and hardcode for your
MCG boards.  In init.c, prep_find_end_of_memory() can detect a Raven
bridge then use the documented board registers to identify memory size
(see online user manual).  A 2400 puts memory size across the I2C bus
in a EEPROM containing all sorts of useful information.  Bug MCG to get
specs on the layout of these VPD records.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
