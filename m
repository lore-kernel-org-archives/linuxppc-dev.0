Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id B36A5DDEE1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 16:54:47 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] Added support for PRTLVT based boards (MPC5121)
Date: Thu, 12 Jun 2008 08:54:27 +0200
References: <200806111143.08905.david.jander@protonic.nl>
	<48501248.8010104@freescale.com>
In-Reply-To: <48501248.8010104@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200806120854.27334.david.jander@protonic.nl>
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

On Wednesday 11 June 2008 19:58:32 Scott Wood wrote:
> Pass -B -M -C to git-format-patch to detect renames, copies, etc.

Thanks for the hint. I am still a git-noob ;-)

>[...]
> This is an old flash binding.  Please use the one currently described in
> Documentation/booting-without-of.txt.

Thanks again, I was searching for documentation about dts, and couldn't find 
much.

> > +		//axe@2000 {
> > +		//	compatible = "mpc512x-axe";
> > +		//	reg = <2000 100>;
> > +		//	interrupts = <2a 8>;
> > +		//	interrupt-parent = < &ipic >;
> > +		//};
>
> Why is this here, but commented out?

Hmm, I know we are going to use it, but there are no drivers still...
I'll leave it out, and add it again later when axe-support has arrived.

> > +		dma2@14000 {
> > +			compatible = "fsl,mpc5121-dma2";
>
> Is this DMA controller compatible with drivers/dma/fsldma.c?  If so,
> follow the established binding.

No, it's not compatible with any other dma controller AFAIK. It special for 
this chip. John Rigby is writing the driver for it right now.

> > +config MPC5121_GENERIC
> > +	bool
> > +	default n
> > +
> >  config MPC5121_ADS
> >  	bool "Freescale MPC5121E ADS"
> >  	depends on PPC_MULTIPLATFORM && PPC32
> >  	select DEFAULT_UIMAGE
> >  	select PPC_MPC5121
> > +	select MPC5121_GENERIC
> >  	help
> >  	  This option enables support for the MPC5121E ADS board.
> >  	default n
> > +
> > +config PRTLVT
> > +	bool "Protonic LVT family of MPC5121 based boards"
> > +	depends on PPC_MULTIPLATFORM && PPC32
> > +	select DEFAULT_UIMAGE
> > +	select PPC_MPC5121
> > +	select MPC5121_GENERIC
> > +	help
> > +	  This option enables support for the Protonic LVT family (ZANMCU and
> > VICVT2). +	default n
>
> Can we leave out the "default n" lines?  They're no-ops.

Ok, I removed also several others (all of them in this file). I hope that it 
is not a problem not making this a separate patch?

> I don't think these configs should depend on an option
> (PPC_MULTIPLATFORM) that is described as "Generic desktop/server/laptop"...

I think right now they need to. That's the way someone broke...err changed 
platform selection.

We should fix that later, but I don't really know what would be the right way 
to fix this right now. I'll think about it after this...

Btw, is it ok I just re-submit the fixed patches (with cc to linuxppc-dev)?

Thanks.

Greetings,

-- 
David Jander
Protonic Holland.
