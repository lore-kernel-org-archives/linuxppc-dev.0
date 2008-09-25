Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id B9D20DE521
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 02:54:26 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id k40so524689rvb.1
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 09:54:25 -0700 (PDT)
Date: Thu, 25 Sep 2008 10:54:23 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: MPC5200 PCI interrupt routing
Message-ID: <20080925165423.GA16018@secretlab.ca>
References: <200809221556.34353.jbe@pengutronix.de>
	<48D807C5.4070002@genesi-usa.com>
	<200809231334.19175.jbe@pengutronix.de>
	<200809241716.35285.jbe@pengutronix.de>
	<20080924181542.GA9690@secretlab.ca>
	<1222291345.8277.92.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1222291345.8277.92.camel@pasglop>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 07:22:25AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2008-09-24 at 12:15 -0600, Grant Likely wrote:
> > On Wed, Sep 24, 2008 at 05:16:34PM +0200, Juergen Beisert wrote:
> > > On Dienstag, 23. September 2008, Juergen Beisert wrote:
> > > > What Kernel do you run on your target? On my hardware a 2.6.23 still work
> > > > as expected, but a 2.6.26 fails all the time.
> > > 
> > > One should enable the internal USB clock. If done, it works... In 2.6.23 is 
> > > was done in mpc52xx_common.c. It was removed in 2.6.24.
> > 
> > It was removed because some 5200 platform do not use USB and should not
> > enable the internal clock.  In general, it is not the kernel's job to configure
> > clocking and pin usage on the chip.  Instead, it should be set correctly
> > at power up by U-Boot.
> 
> Or by the USB host driver :-)

I hadn't really wanted to go down this route because the calculation of
the clock, or the decision to use an external clock or calculate an
internal clock is very board specific.  I'll need to take another look
to decide if it is reasonable to encode it into the device tree.

> I tend to thing that drivers should deal with their own clocks. In fact
> it would be nice if one could stop the clocks while the host port is in
> suspend no ?

Yeah, but in this case the clock can't actually be turned off.  It's
just a select bit between internal or external clock and a calculation
value on the divider.  Since it's a one-time board level setup
config in a big block of shared chip level registers I'd rather just
leave it in the domain of firmware.

g.
