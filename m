Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5AC87DDE05
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 18:03:39 +1100 (EST)
Subject: Re: [PATCH 19/25] powerpc: Wire up PCI on Bamboo board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071206211906.2e1c099f@zod.rchland.ibm.com>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080130.2B29FDE0BA@ozlabs.org>
	<20071206211906.2e1c099f@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sun, 09 Dec 2007 18:03:25 +1100
Message-Id: <1197183805.6572.11.camel@pasglop>
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


> > +			/* Walnut has all 4 IRQ pins tied together per slot */
> 
> Not a Walnut board.

Right, though the IRQ routing is similar (the comment is correct)

> > +			interrupt-map-mask = <f800 0 0 0>;
> > +			interrupt-map = <
> > +				/* IDSEL 1 */
> > +				0800 0 0 0 &UIC0 1c 8
> > +
> > +				/* IDSEL 2 */
> > +				1000 0 0 0 &UIC0 1b 8
> > +
> > +				/* IDSEL 3 */
> > +				1800 0 0 0 &UIC0 1a 8
> > +
> > +				/* IDSEL 4 */
> > +				2000 0 0 0 &UIC0 19 8
> > +			>;
> > +		};
> >  	};
> > 
> >  	chosen {
> >  		linux,stdout-path = "/plb/opb/serial@ef600300";
> > -		bootargs = "console=ttyS0,115200";
> 
> Did you remove that for a reason?

Yes, and I want to do a pass removing all the occurences of bootargs in
the .dts file, it has absolutely nothing to do there (in theory nothing
in /chosen though linux,stdout-path can probably be argued and happens
to be handy but not bootargs).

Ben.
