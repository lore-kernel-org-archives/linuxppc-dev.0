Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2568DDDE33
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 07:33:47 +1100 (EST)
Subject: Re: [PATCH 11/20] [POWERPC] Wire up PCI on Bamboo board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <47691DE6.8050901@ru.mvista.com>
References: <20071213073845.1D311DE053@ozlabs.org>
	<47691DE6.8050901@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 20 Dec 2007 07:26:07 +1100
Message-Id: <1198095967.18908.33.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-12-19 at 16:34 +0300, Valentine Barshak wrote:

> > --- linux-work.orig/arch/powerpc/boot/dts/bamboo.dts	2007-12-10 15:56:59.000000000 +1100
> > +++ linux-work/arch/powerpc/boot/dts/bamboo.dts	2007-12-10 16:39:51.000000000 +1100
> > @@ -239,10 +239,48 @@
> >  				zmii-channel = <1>;
> >  			};
> >  		};
> > +
> > +		PCI0: pci@ec000000 {
> > +			device_type = "pci";
> > +			#interrupt-cells = <1>;
> > +			#size-cells = <2>;
> > +			#address-cells = <3>;
> > +			compatible = "ibm,plb440ep-pci", "ibm,plb-pci";
> > +			primary;
> > +			reg = <0 eec00000 8	/* Config space access */
> > +			       0 eed80000 4	/* IACK */
> > +			       0 eed80000 4	/* Special cycle */
> > +			       0 ef480000 40>;	/* Internal registers */
> 
> Why ef480000 here? IIRC, the docs say it should be ef400000, while 
> ef400040 - ef4fffff are reserved and can mirror local registers.

Dunno... probably a typo, though it worked :-) I'll fix it up.

Ben.
