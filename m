Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 050B5DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 17:51:31 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: benh@kernel.crashing.org
Date: Thu, 25 Sep 2008 09:51:14 +0200
References: <200809221556.34353.jbe@pengutronix.de>
	<20080924181542.GA9690@secretlab.ca>
	<1222291345.8277.92.camel@pasglop>
In-Reply-To: <1222291345.8277.92.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809250951.15941.jbe@pengutronix.de>
Subject: Re: MPC5200 PCI interrupt routing
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin,

On Mittwoch, 24. September 2008, Benjamin Herrenschmidt wrote:
> On Wed, 2008-09-24 at 12:15 -0600, Grant Likely wrote:
> > On Wed, Sep 24, 2008 at 05:16:34PM +0200, Juergen Beisert wrote:
> > > On Dienstag, 23. September 2008, Juergen Beisert wrote:
> > > > What Kernel do you run on your target? On my hardware a 2.6.23 still
> > > > work as expected, but a 2.6.26 fails all the time.
> > >
> > > One should enable the internal USB clock. If done, it works... In
> > > 2.6.23 is was done in mpc52xx_common.c. It was removed in 2.6.24.
> >
> > It was removed because some 5200 platform do not use USB and should not
> > enable the internal clock.  In general, it is not the kernel's job to
> > configure clocking and pin usage on the chip.  Instead, it should be set
> > correctly at power up by U-Boot.
>
> Or by the USB host driver :-)

But how to deal with platform specific things like (in this case) unknown=20
external clock or usage of the internal clock generator (=3D how to setup t=
he=20
frequency divider)?

> > However, if firmware *cannot* be changed, there is a workaround.
> > You can create a new platform specific board support file in
> > arch/powerpc/platforms/52xx/ that matches against your specific board
> > and performs the needed fixups.  An example of this is lite5200.c.  Many
> > lite5200 boards have older versions of U-Boot installed which does not
> > correctly configure clocks or port-config.  So, lite5200.c matches to
> > the board instead of mpc5200_simple.c so that the board specific fixups
> > can be performed easily.  You should do the same for your board.
>
> I tend to thing that drivers should deal with their own clocks.

ACK. But only to switch them on and off. Not to configure them.

> In fact it would be nice if one could stop the clocks while the host port=
 is
> in suspend no ?

ACK.

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
