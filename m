Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711190851g3e1f2ef9k5f87c7c2dae929ef@mail.gmail.com>
Date: Mon, 19 Nov 2007 11:51:03 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <fa686aa40711190831s2e59ab05h63d10ec8a24eaad5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<4741A56D.9050808@freescale.com>
	<fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>
	<9e4733910711190800t5dc9bc40q1b58feae4ff364d0@mail.gmail.com>
	<fa686aa40711190831s2e59ab05h63d10ec8a24eaad5@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/19/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 11/19/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 11/19/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > > On 11/19/07, Timur Tabi <timur@freescale.com> wrote:
> > > > Jon Smirl wrote:
> > > >
> > > > > In the ALSA SOC model the i2s, codec and ac97 drivers are all generic.
> > > > > A fabric driver tells specifically how a generic codec is wired into
> > > > > the board. What I haven't been able figure out is how to load the
> > > > > right fabric driver.
> > > >
> > > > Do not use the device tree to load the fabric driver!
> > >
> > > Heh, technically you can't use the device tree to load any device
> > > drivers, it's just a data structure.  :-)
> > >
> > > You probably mean "don't use the of_platform bus to load the fabric
> > > driver".  He still needs to use the data in the device tree to decide
> > > what fabric drivers to use.  of_platform_bus would be awkward to use
> > > for this because the node describing the fabric doesn't cleanly sit on
> > > any particular bus (ie. it describes the board; it does not describe
> > > the device).
> > >
> > > In this case; it probably is appropriate to have the platform code
> > > instantiate a platform_device for the fabric (instead of an
> > > of_platform device) which the fabric driver can bind against.
> >
> > First, I have platform bus turned off in my builds. Platform bus is a
> > place where cruft accumulates that really belongs somewhere else. For
> > example when I turned it off I discovered that there was a PC speaker
> > driver in my kernel and well as several drivers from 82xx chips.
> >
> > ALSA creates it own bus like i2c. My fabric driver sits on this bus.,
> > Kconfig attributes control if it is built-in. I've altered the i2c
> > code to look for child device tree nodes and then load the appropriate
> > drivers.
>
> Can't you then instantiate the ALSA bus device in your board platform
> code?  Then when the driver is registered, the bus should call it's
> probe routine.

Yes, I can do that. I have just been resisting creating a code linkage
from arch/powerpc/platform/xx to sound/alsa/soc/powerpc. I also need
to create the fabric driver after alsa has made the bus,
subsys_initcall(asoc_bus_init);

> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>


-- 
Jon Smirl
jonsmirl@gmail.com
