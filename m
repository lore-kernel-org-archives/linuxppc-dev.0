Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E13ACDDFB7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 23:15:23 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m5CDF73b028757 for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 06:15:08 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m5CDF6WW006837
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 08:15:07 -0500 (CDT)
Date: Thu, 12 Jun 2008 08:15:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH 1/2] Added support for PRTLVT based boards (MPC5121)
Message-ID: <20080612131506.GA21060@ld0162-tx32.am.freescale.net>
References: <200806111143.08905.david.jander@protonic.nl>
	<48501248.8010104@freescale.com>
	<200806120854.27334.david.jander@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200806120854.27334.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 08:54:27AM +0200, David Jander wrote:
> On Wednesday 11 June 2008 19:58:32 Scott Wood wrote:
> > > +		//axe@2000 {
> > > +		//	compatible = "mpc512x-axe";
> > > +		//	reg = <2000 100>;
> > > +		//	interrupts = <2a 8>;
> > > +		//	interrupt-parent = < &ipic >;
> > > +		//};
> >
> > Why is this here, but commented out?
> 
> Hmm, I know we are going to use it, but there are no drivers still...
> I'll leave it out, and add it again later when axe-support has arrived.

Just uncomment it -- there's no harm in a device node for which Linux has
no driver, and it avoids problems with old device trees being used once a
driver is added.

Compatible should have "fsl," prepended, though, and ideally a concrete
chip should be represented rather than "512x".

> > > +		dma2@14000 {
> > > +			compatible = "fsl,mpc5121-dma2";
> >
> > Is this DMA controller compatible with drivers/dma/fsldma.c?  If so,
> > follow the established binding.
> 
> No, it's not compatible with any other dma controller AFAIK. It special for 
> this chip. John Rigby is writing the driver for it right now.

OK.

> Btw, is it ok I just re-submit the fixed patches (with cc to linuxppc-dev)?

Yes.

-Scott
