Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8EC5DDDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 01:35:53 +1000 (EST)
Date: Mon, 30 Jun 2008 10:35:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] powerpc: Add dma nodes to 83xx, 85xx and 86xx boards
Message-ID: <20080630153513.GD13950@loki.buserror.net>
References: <Pine.LNX.4.64.0806271449540.9071@blarg.am.freescale.net>
	<48654D6D.1090309@freescale.com>
	<E57F448A-7217-4893-A77B-6367B0C3118A@kernel.crashing.org>
	<Pine.LNX.4.64.0806271609540.10625@blarg.am.freescale.net>
	<20080630041525.GD24012@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080630041525.GD24012@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 30, 2008 at 02:15:25PM +1000, David Gibson wrote:
> On Fri, Jun 27, 2008 at 04:10:17PM -0500, Kumar Gala wrote:
> > Added DMA nodes for the elo/elo-plus DMA engines.
> > 
> > Renamed the interrupt controller alias in mpc832x_rdb.dts to ipic so that
> > its the same as all the other boards.
> > 
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> 
> [snip]
> > diff --git a/arch/powerpc/boot/dts/asp834x-redboot.dts b/arch/powerpc/boot/dts/asp834x-redboot.dts
> > index 972cf78..8b1bb0e 100644
> > --- a/arch/powerpc/boot/dts/asp834x-redboot.dts
> > +++ b/arch/powerpc/boot/dts/asp834x-redboot.dts
> > @@ -118,6 +118,41 @@
> >  			mode = "cpu";
> >  		};
> > 
> > +		dma@82a8 {
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			compatible = "fsl,mpc8347-dma", "fsl,elo-dma";
> > +			reg = <0x82a8 4>;
> > +			ranges = <0 0x8100 0x1a8>;
> > +			interrupt-parent = <&ipic>;
> > +			interrupts = <71 8>;
> > +			cell-index = <0>;
> 
> What's the cell-index in these nodes used to index?  Given the
> confusion there's been about the proper use of this property, a
> comment indicating which shared registers this is used to index is
> probably a good idea.

There's supposed to be a cell-index in the *channels* to index into the
shared summary register (the "reg" of the dma node itself).  I don't see any
purpose for a cell-index in the main dma node, though.

-Scott
