Return-Path: <dgibson@ozlabs.org>
Date: Tue, 16 Oct 2007 13:20:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
Message-ID: <20071016032041.GN26787@localhost.localdomain>
References: <200710151529.11485.sr@denx.de>
	<20071015163216.GA8127@gate.ebshome.net>
	<fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>
	<20071015185340.GB4474@loki.buserror.net>
	<fa686aa40710151213r670bea49i63fa5f5402aa150d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710151213r670bea49i63fa5f5402aa150d@mail.gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Stefan Roese <sr@denx.de>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 15, 2007 at 01:13:14PM -0600, Grant Likely wrote:
> On 10/15/07, Scott Wood <scottwood@freescale.com> wrote:
> > On Mon, Oct 15, 2007 at 10:57:48AM -0600, Grant Likely wrote:
> > > Segher is recommending that we use an aliases node as per the open
> > > firmware example for this.  I think in this case it would look
> > > something like this (but I'm not the expert):
> > >
> > > aliases {
> > >      IIC0 = "/path/to/bus/iic@0x2000";
> > >      IIC1 = "/path/to/bus/iic@0x2000";
> > > };
> >
> > I think this is overly complicated; something like linux,i2c-index in the
> > i2c adapter node would be simpler.
> 
> But not perhaps better.  Enumeration is a system-wide thing.  It does
> make sense to group all the device enumerations in one place.  It
> eliminates two nodes trying to enumerate to the same device number and
> since device numbers are something that the user will potentially want
> to modify, it separates enumeration from hardware description.
> 
> As per your point below; if all the i2c devices are children of the
> adapter, then yes you are right that the bus number doesn't matter to
> the user.  But it *does* matter for things like serial and ethernet
> ports.

As the inventor of "linux,network-index", please don't invent
"linux,i2c-index".  linux,network-index was and is a hack - it's
badness is limited by the fact that it's essentially local to the
bootwrapper.  It's only used in the bootwrapper, and I only really
intended it for use in bootwrappers which provide their own device
tree, so as to match the device nodes against whatever order the MAC
addresses were supplied by the firmware.

I plan to replace the linux,network-index thing with aliases
(including some dtc support to make that easy) just as soon as I get
around to it... don't hold your breath.

Using a similar property from an actual kernel driver would be much
uglier, and harder to clean up later.

Using aliases would be.. less bad, but it would still require that
the device tree always supply an alias for the iic driver to work
which is kind of nasty.

In fact I think it may be acceptle to do the idx++ thing in this
situation.  Bus numbers are ugly, but it's not the worst ugliness in
the horrible mess that is the Linux i2c subsystem.  It means that bus
numbers are theoretically unstable, but that's increasingly true of
devices of all sorts - it's up to udev to assign meaningful labels at
the user level.

> > Though, I don't see what the problem with the original approach is, as long
> > as the numbers are chosen in the same way when registering i2c clients based
> > on the children of the adapter node.  There's no concept in the hardware
> > itself of a bus number.
> 
> Even if you take this approach, the driver still need to know what bus
> number to use (as per the i2c infrastructure).  It is not sane for an
> i2c bus driver to attempt to assign the bus number itself because it
> could conflict with another arbitrarily chosen bus number from another
> driver.
> 
> Cheers,
> g.
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
