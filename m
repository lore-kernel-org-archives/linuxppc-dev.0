Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id C7E33DDEED
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 04:15:45 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so33949rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 11:15:43 -0700 (PDT)
Date: Wed, 24 Sep 2008 12:15:42 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: MPC5200 PCI interrupt routing
Message-ID: <20080924181542.GA9690@secretlab.ca>
References: <200809221556.34353.jbe@pengutronix.de>
	<48D807C5.4070002@genesi-usa.com>
	<200809231334.19175.jbe@pengutronix.de>
	<200809241716.35285.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200809241716.35285.jbe@pengutronix.de>
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

On Wed, Sep 24, 2008 at 05:16:34PM +0200, Juergen Beisert wrote:
> On Dienstag, 23. September 2008, Juergen Beisert wrote:
> > What Kernel do you run on your target? On my hardware a 2.6.23 still work
> > as expected, but a 2.6.26 fails all the time.
> 
> One should enable the internal USB clock. If done, it works... In 2.6.23 is 
> was done in mpc52xx_common.c. It was removed in 2.6.24.

It was removed because some 5200 platform do not use USB and should not
enable the internal clock.  In general, it is not the kernel's job to configure
clocking and pin usage on the chip.  Instead, it should be set correctly
at power up by U-Boot.

However, if firmware *cannot* be changed, there is a workaround.
You can create a new platform specific board support file in
arch/powerpc/platforms/52xx/ that matches against your specific board
and performs the needed fixups.  An example of this is lite5200.c.  Many
lite5200 boards have older versions of U-Boot installed which does not
correctly configure clocks or port-config.  So, lite5200.c matches to
the board instead of mpc5200_simple.c so that the board specific fixups
can be performed easily.  You should do the same for your board.

g.
