Date: Mon, 12 Nov 2001 14:51:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jun Sun <jsun@mvista.com>
Cc: Pete Popov <ppopov@mvista.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
Message-ID: <20011112145114.A16216@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.GSO.3.96.1011112142501.24771K-100000@delta.ds2.pg.gda.pl> <1005581679.459.4.camel@zeus> <3BF0145C.9795C8CC@mvista.com> <3BF01B6C.496179@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BF01B6C.496179@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 12, 2001 at 10:56:44AM -0800, Jun Sun wrote:

> Jun Sun wrote:
> >
> > Pete Popov wrote:
> > >
> > > On Mon, 2001-11-12 at 05:29, Maciej W. Rozycki wrote:
> > > > On Mon, 12 Nov 2001, Geert Uytterhoeven wrote:
> > > >
> > > > > >  Unless you use a non-MC146818 RTC, which you need to write a separate
> > > > > > driver for anyway.
> > > > >
> > > > > Yep, so that's why both m68k and PPC have common routines to read/write the
> > > > > RTC, with a /dev/rtc-compatible abstraction on top of it.
> > > >
> > > >  OK, then you need an RTC chipset-specific driver and not a CPU
> > > > architecture-specific one.  Otherwise we'll end with a zillion of similar
> > > > RTC drivers like we already have for LANCE and SCC chips.
> > >
> > > I agree.  We don't have arch specific network drivers so why have arch
> > > specific rtc drivers.
> > >
> >
> > Because we can have a free RTC driver working once you get kernel working.
> >
>
> Actually there is a longer answer with a little bit of the background info.
>
> Kernel needs to know about the real calendar time when it boots up.  And
> optionally it may write to RTC (based on the assumption that kernel timer is
> more accurate than RTC clock).  So it already has abstraction, one form or
> another, to do RTC read/write.
>
> Based on these abstractons you can provide a hardware-independent RTC driver,
> with RTC read/write operations.

Right.

> Before CONFIG_NEW_TIME_C is introduced, each MIPS board has its own time
> service routine, which means, even if RTC driver wants to utilize the
> abstraction, it will be only for that board only.
>
> After CONFIG_NEW_TIME_C is introduced, that RTC abstract becomes MIPS-common.
> Therefore, we can afford a MIPS-common generic RTC driver.

No.  This sounds _exactly_ like the PPC driver. What we need to do, and
what I intend to do in 2.5 is make this a bit more generic so thatr any
arch can fill out some infos and say we read like this, we write like
that and that's that.

> If that abstraction ever becomes Linux-common code, then the generic RTC
> driver will essentially be a Linux-common, device-indpendent driver.

Yeap.  I wanna do this in 2.5.

> For most MIPS machine, we need /dev/rtc to merely set time and read time.  The
> generic driver should suffice.  Otherwire, you can wirte a complete one for a
> specific board or a specific chip.

The 'rtc' driver in drivers/char does read, write, some ioctls and a
/proc bit.  We can make this a bit more 'generic'

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
