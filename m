Return-Path: <SRS0=Nfrs=QZ=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 8CA04DDE29
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 23:35:05 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 24/24] powerpc: Base support for 440SPe "Katmai" eval board
Date: Sun, 2 Dec 2007 13:35:33 +0100
References: <20071130061209.497F3DE03A@ozlabs.org>
	<200712021323.17821.sr@denx.de>
In-Reply-To: <200712021323.17821.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712021335.33715.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 02 December 2007, Stefan Roese wrote:
> > +		PCIE0: pciex@d00000000 {
> > +			device_type = "pci";
> > +			#interrupt-cells = <1>;
> > +			#size-cells = <2>;
> > +			#address-cells = <3>;
> > +			compatible = "ibm,plb-pciex-440speB", "ibm,plb-pciex";
> > +			primary;
> > +			port = <0>; /* port number */
>
> port = <1>;

Ups, sorry. <0> is correct here of course. "PCIE1" and "PCIE2" need different 
numbers though.

> > +			reg = <d 00000000 20000000	/* Config space access */
> > +			       c 10000000 00001000>;	/* Registers */
> > +			dcr-reg = <100 020>;
> > +			sdr-base = <300>;
> > +
> > +			/* Outbound ranges, one memory and one IO,
> > +			 * later cannot be changed
> > +			 */
> > +			ranges = <02000000 0 80000000 0000000e 00000000 0 80000000
> > +				  01000000 0 00000000 0000000f 80000000 0 00010000>;
> > +
> > +			/* Inbound 2GB range starting at 0 */
> > +			dma-ranges = <42000000 0 0 0 0 0 80000000>;
> > +
> > +			/* This drives busses 10 to 0x1f */
> > +			bus-range = <10 1f>;
> > +
> > +			/* Legacy interrupts (note the weird polarity). We are
> > +			 * de-swizzling here because the numbers are actually for
> > +			 * port of the root complex virtual P2P bridge. But I want
> > +			 * to avoid putting a node for it in the tree, so the numbers
> > +			 * below are basically de-swizzled numbers. The real slot is
> > +			 * on idsel 1, so the swizzling is new_pin = (pin % 4) + 1
> > +			 */
> > +			interrupt-map-mask = <0000 0 0 7>;
> > +			interrupt-map = <
> > +				0000 0 0 2 &UIC3 0 4 /* swizzled int A */
> > +				0000 0 0 3 &UIC3 1 4 /* swizzled int B */
> > +				0000 0 0 4 &UIC3 2 4 /* swizzled int C */
> > +				0000 0 0 1 &UIC3 3 4 /* swizzled int D */>;
> > +		};
> > +
> > +		PCIE1: pciex@d20000000 {
> > +			device_type = "pci";
> > +			#interrupt-cells = <1>;
> > +			#size-cells = <2>;
> > +			#address-cells = <3>;
> > +			compatible = "ibm,plb-pciex-440speB", "ibm,plb-pciex";
> > +			primary;
> > +			port = <0>; /* port number */
>
> port = <2>;

That should be <1> now. And PCIE2 has this problem too.

Best regards,
Stefan
