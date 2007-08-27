Return-Path: <SRS0=QhAZ=NY=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 99D86DDE41
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 16:00:40 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] [POWERPC] Add pci node to sequoia dts
Date: Mon, 27 Aug 2007 08:07:17 +0200
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070825092954.4087.95333.stgit@localhost.localdomain>
	<20070827015417.GB12804@localhost.localdomain>
In-Reply-To: <20070827015417.GB12804@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708270807.17351.sr@denx.de>
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 27 August 2007, David Gibson wrote:
> On Sat, Aug 25, 2007 at 01:29:54PM +0400, Vitaly Bordug wrote:
> > Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> > Signed-off-by: Stefan Roese <sr@denx.de>
> >
> > ---
> >
> >  arch/powerpc/boot/dts/sequoia.dts |   26 ++++++++++++++++++++++++++
> >  1 files changed, 26 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/sequoia.dts
> > b/arch/powerpc/boot/dts/sequoia.dts index ef6f41c..8eb258f 100644
> > --- a/arch/powerpc/boot/dts/sequoia.dts
> > +++ b/arch/powerpc/boot/dts/sequoia.dts
> > @@ -92,6 +92,32 @@
> >  		#size-cells = <1>;
> >  		ranges;
> >  		clock-frequency = <0>; /* Filled in by zImage */
> > +
> > +		pci {
> > +			/* irqs are routed to irq67, dependless of devsel/PIRQx */
> > +			interrupt-map-mask = <0 0 0 0>;
> > +			interrupt-map = <0 0 0 0 &UIC2 3 8>;
> > +
> > +			interrupt-parent = <&UIC2>;
> > +			interrupts = <3 8>;
> > +
> > +			bus-range = <0 0>;
> > +
> > +			/*
> > +			 * mem is at 80000000 set up indirectly
> > +			 * io is at 0001_e800_0000
> > +			 */
> > +			ranges = <02000000 0 80000000 1 80000000 0 10000000
> > +				01000000 0 00000000 1 e8000000 0 00100000>;
> > +
> > +			#interrupt-cells = <1>;
> > +			#size-cells = <2>;
> > +			#address-cells = <3>;
> > +
> > +    			reg = <1 eec00000 40 1 ef400000 40>;  /* phb cfg, phb reg */
> > +			compatible = "ibm, 440epx";
> > +			device_type = "pci";
>
> I usually put device_type, compatible and reg at the top of the block,
> to announce what the node actually is before giving all the details.
>
> Also, apart from the stray space in the compatible, I'm guessing that
> the 440EPx bridge is actually more-or-less like the PCI bridges on
> other 4xx chips, so we should have a more general compatible string
> too.

Yes, it is "more-or-less" like any other 4xx PCI core. So it really would make 
sense to define it more generally. Something like:

			compatible = "ibm,pci-440epx", "ibm,pci4xx";

or even:

			compatible = "ibm,pci-440epx", "ibm,pci";

?

> Is the 440EPx a vanilla PCI or a PCI-X bridge?  If the later that
> should be reflected in the name and compatible as well.

It's a vanilla PCI bridge.

Best regards,
Stefan
