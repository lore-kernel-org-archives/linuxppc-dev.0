Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8AE6DDDD5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 04:35:29 +1100 (EST)
Date: Wed, 21 Nov 2007 11:35:40 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [POWERPC] Add docs for Freescale DMA & DMA channel
	device tree nodes
Message-ID: <20071121173540.GC4413@loki.buserror.net>
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>
	<474447EF.8080405@freescale.com>
	<E9CED991-4E10-44AE-A446-B6CB151FB9EE@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E9CED991-4E10-44AE-A446-B6CB151FB9EE@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 21, 2007 at 09:33:05AM -0600, Kumar Gala wrote:
> On Nov 21, 2007, at 8:59 AM, Timur Tabi wrote:
> >> +  Example:
> >> +	dma@21000 {
> >
> > Shouldn't this be dma@21300?
> 
> its an example that has not basis is reality :)

But it should at least be internally consistent with this:

> >> +		reg = <21300 4>;

[snip]
> > The DMA controller and the DMA channels need a "device-id", so that  
> > they can be identified by number.  Some peripherals, like the SSI,  
> > can only use the controller and channel number.  This is what I have  
> > in my 8610 DTS:
> 
> Why not use reg for this?  I don't see any reason to add another  
> "unique id" when there is already one.

A cell-index property would be useful here for indexing into the summary
status register.

> 
> >                dma@21300 {
> >                        #address-cells = <1>;
> >                        #size-cells = <1>;
> >                        compatible = "fsl,mpc8610-dma", "fsl,mpc8540- 
> > dma";
> >        -->             device-id = <0>;

I don't see any justification for having such a property in the parent node,
though.

-Scott
