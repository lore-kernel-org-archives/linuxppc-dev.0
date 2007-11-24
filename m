Return-Path: <david-b@pacbell.net>
Received: from smtp120.sbc.mail.sp1.yahoo.com (smtp120.sbc.mail.sp1.yahoo.com
	[69.147.64.93]) by ozlabs.org (Postfix) with SMTP id B18AFDDF59
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 08:03:34 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/5] USB: Add Cypress c67x00 OTG controller driver to
	Kconfig and Makefiles
Date: Sat, 24 Nov 2007 13:03:31 -0800
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
	<200711241212.27787.david-b@pacbell.net>
	<fa686aa40711241220r4e808ad8obb27ae8bf5890048@mail.gmail.com>
In-Reply-To: <fa686aa40711241220r4e808ad8obb27ae8bf5890048@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711241303.31700.david-b@pacbell.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 24 November 2007, Grant Likely wrote:
> On 11/24/07, David Brownell <david-b@pacbell.net> wrote:
> > On Friday 23 November 2007, Grant Likely wrote:
> > > +config USB_C67X00_DRV
> > > +tristate "Cypress C67x00 support"
> > > +# only allowed to be =y if both USB!=m and USB_GADGET!=m
> >
> > This is wrong.  Remember that since this is a dual-role driver,
> > there are exactly three possible driver modes ... and the driver
> > must support only one of them at a time:
> 
> Actually, this part has 2 serial in interface engines; either of which
> can be in host, peripheral or OTG mode.  So; it is entirely relevant
> for the driver to be doing both host and peripheral at the same time
> with a single device.

While conforming with USB specs?  Has that changed recently?

In the not-too-distant past I know there was explicit language
saying that such configurations are not allowed.  (At least,
in terms of external connectors.  A board using USB for internal
peripheral connections would be OK.)

Those issues can be deferred until peripheral support exists.
At that point you'll need to get better solutions to those config
issues...


> > Hmmm ... your patches don't include peripheral mode support yet.
> 
> No, nobody has written it yet.

Then what's it doing in that GIT tree you pointed me at?  :)


> > Either all these gadget hooks should vanish, or you should try
> > to get the controller mode stuff right from the beginning.
> >
> > I've appended the relevant Kconfig bits from the musb_hdrc
> > driver, which (despite some glitches) are pretty much correct.
> 
> I'll drop the gadget hooks for now.  Most likely gadget and OTG
> support will require more changes to this driver regardless, so it's
> not a big deal.

OK.  Then the first incaration of this will be as a host-only
driver, in its own directory, and adding peripheral support will
cause minor lunacy.  :)

- Dave
