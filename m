Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id DDD83DDF8E
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 02:57:58 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so470072rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 09:57:57 -0700 (PDT)
Date: Thu, 25 Sep 2008 10:57:55 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: MPC5200 PCI interrupt routing
Message-ID: <20080925165755.GB16018@secretlab.ca>
References: <200809221556.34353.jbe@pengutronix.de>
	<20080924181542.GA9690@secretlab.ca>
	<1222291345.8277.92.camel@pasglop>
	<200809250951.15941.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200809250951.15941.jbe@pengutronix.de>
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

On Thu, Sep 25, 2008 at 09:51:14AM +0200, Juergen Beisert wrote:
> Benjamin,
> 
> On Mittwoch, 24. September 2008, Benjamin Herrenschmidt wrote:
> > On Wed, 2008-09-24 at 12:15 -0600, Grant Likely wrote:
> > > On Wed, Sep 24, 2008 at 05:16:34PM +0200, Juergen Beisert wrote:
> > > > On Dienstag, 23. September 2008, Juergen Beisert wrote:
> > > > > What Kernel do you run on your target? On my hardware a 2.6.23 still
> > > > > work as expected, but a 2.6.26 fails all the time.
> > > >
> > > > One should enable the internal USB clock. If done, it works... In
> > > > 2.6.23 is was done in mpc52xx_common.c. It was removed in 2.6.24.
> > >
> > > It was removed because some 5200 platform do not use USB and should not
> > > enable the internal clock.  In general, it is not the kernel's job to
> > > configure clocking and pin usage on the chip.  Instead, it should be set
> > > correctly at power up by U-Boot.
> >
> > Or by the USB host driver :-)
> 
> But how to deal with platform specific things like (in this case) unknown 
> external clock or usage of the internal clock generator (= how to setup the 
> frequency divider)?

The external clock would need to be encoded in the device tree.

Internal clock would need to read/detect the CDM config and make a
decision based on that.  Certainly possible, but I just don't think that
it is really important.  (And even if it is, I think it should be done
in common platform setup code, not the driver, because it is very
MPC5200 SoC specific).

g.
