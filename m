Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8259DB70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 15 Aug 2010 06:00:14 +1000 (EST)
Date: Sat, 14 Aug 2010 21:15:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andre Prendel <andre.prendel@gmx.de>
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp421) Add nfactor support (2nd
	attempt)
Message-ID: <20100814211549.1df1dc7e@hyperion.delvare>
In-Reply-To: <20100721194650.GA2271@andre-laptop>
References: <4BF1A760.2010707@theptrgroup.com>
	<20100518113838.GA2052@andre-laptop>
	<4BF2A5A9.6010907@theptrgroup.com>
	<20100519072659.GA2069@andre-laptop>
	<4BF41C20.60502@theptrgroup.com>
	<20100520185035.GA2153@andre-laptop>
	<4BF58859.3090702@theptrgroup.com>
	<20100520193556.GB2153@andre-laptop>
	<20100720150953.GA9810@andre-laptop>
	<20100720155952.GA27093@ericsson.com>
	<20100721194650.GA2271@andre-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Guenter Roeck <guenter.roeck@ericsson.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andre, Guenter, Jeff,

On Wed, 21 Jul 2010 21:46:50 +0200, Andre Prendel wrote:
> On Tue, Jul 20, 2010 at 08:59:52AM -0700, Guenter Roeck wrote:
> > On Tue, Jul 20, 2010 at 11:09:53AM -0400, Andre Prendel wrote:
> > > On Thu, May 20, 2010 at 09:35:56PM +0200, Andre Prendel wrote:
> > > > On Thu, May 20, 2010 at 03:07:05PM -0400, Jeff Angielski wrote:
> > > > > In any event, here it is again:
> > > > 
> > > > Acked-by: Andre Prendel <andre.prendel@gmx.de>
> > > 
> > > Hi Jeff,
> > > 
> > > I'de suggest to resend the patch with my acked-by to the lm-sensors list and
> > > Andrew Morton. It looks like Jean is too busy at the moment.
> > > 
> > > Regards,
> > > Andre
> > >  
> > > > > >From 9acd29ff48c64e58a7f5cdb888c86e737c56281c Mon Sep 17 00:00:00 2001
> > > > > From: Jeff Angielski <jeff@theptrgroup.com>
> > > > > Date: Mon, 10 May 2010 10:26:34 -0400
> > > > > Subject: [PATCH] hwmon: (tmp421) Add nfactor support
> > > > > 
> > > > > Add support for reading and writing the n-factor correction
> > > > > registers.  This is needed to compensate for the characteristics
> > > > > of a particular sensor hanging off of the remote channels.
> > > > > 
> > 
> > My concerns with this approach are 
> > 
> > 1) It changes the sysfs abi. libsensors won't support it. It opens up
> >    a can of worms with everyone starting to put chip-specific extensions
> >    into the ABI. If such an extension has to be made, it should be a) really necessary
> >    and b) a generic extension which applies to all chips.
> 
> A chip-specific extension can't be also generic. So we have to decide whether weaccept chip-specific extensions or not.

libsensors 3 will never support chip-specific extensions. We've been
there with libsensors 2, it was a nightmare, never again please.

This doesn't mean we can't have chip-specific extensions, and actually
some drivers have such extensions already. But as they are often
undocumented and bound to be replaced by standard implementations in
the future, nobody should rely on them. Which makes their usefulness
dubious.

This is the reason why I always insist on trying to define a standard
suitable for all chips before you think of adding a not-yet-supported
feature to a given driver.

> > 2) My understanding is that value adjustments are supposed to be made via sensors.conf,
> >    and that values reported by the chip should always be 'raw', ie unadjusted
> >    values.
> > 
> > Instead of exporting n_adjust to the user via sysfs, it might make more sense 
> > to reset the correction factor to its default (if it was changed), and handle
> > required adjustments in sensors.conf.
> 
> Jeff, what do you think?

I'm not Jeff, but resetting the factors is a bad idea. The
BIOS/firmware might have set them up properly, so the default should be
to leave them untouched (as we do with every other setting.)

> > Even if Jean doesn't have time to handle the patch, you should at least get his Ack
> > for the ABI changes.
> 
> That was the intention of resending the patch to the lm-sensors list. It would
> be a pity to lose Jeff's effort.

I'm not giving my ack for any non-standard feature, sorry.

-- 
Jean Delvare
