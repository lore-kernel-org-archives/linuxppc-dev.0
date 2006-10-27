Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF47467CF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 20:24:58 +1000 (EST)
Subject: Re: [POWERPC] MPC52xx is a 6xx variant, remove PPC_52xx config option
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrey Volkov <avolkov@varma-el.com>
In-Reply-To: <4541D7D5.7090001@varma-el.com>
References: <11618347593934-git-send-email-grant.likely@secretlab.ca>
	<4541D7D5.7090001@varma-el.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 20:24:53 +1000
Message-Id: <1161944693.25682.70.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-27 at 13:56 +0400, Andrey Volkov wrote:
> Grant Likely wrote:
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >  arch/powerpc/Kconfig |    5 -----
> >  1 files changed, 0 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index f9b11c1..6bff8b7 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -126,11 +126,6 @@ config CLASSIC32
> >  	  systems, 64 bit IBM RS/6000 or an Apple G5, choose 6xx.
> >  	  Note that the kernel runs in 32-bit mode even on 64-bit chips.
> >  
> > -config PPC_52xx
> > -	bool "Freescale 52xx"
> > -	select 6xx
> > -	select PPC_FPU
> > -	
> >  config PPC_82xx
> >  	bool "Freescale 82xx"
> >  	select 6xx

> Please _don't_ do it, since mpc5200 platform drivers depend from this
> option.

And that should be fixed. We are yet discussing the proper way of
integrating 52xx in arch/powerpc, but that definitely doesn't involve
making it an exclusive processor type. Besides, there will probably be
enough changes in the drivers to adapt them to of_platform_device type
probing that we might just well fork them all anyway.

Ben.
