Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EA661DDDEB
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 01:24:58 +1000 (EST)
Subject: Re: [PATCH 3/3] First cut at PReP support for arch/powerpc
From: Jon Loeliger <jdl@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070803063532.GB14456@localhost.localdomain>
References: <20070627065335.GD11191@localhost.localdomain>
	<20070627071008.GA30648@localhost.localdomain>
	<b1bc50e84cd3f8009eca2b470bea026f@kernel.crashing.org>
	<20070628100020.GA24215@iram.es>
	<20070803063532.GB14456@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1186154678.9004.22.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 03 Aug 2007 10:24:38 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-08-03 at 01:35, David Gibson wrote:


> > > +			PIC8259: interrupt-controller {
> > > +				device_type = "i8259";
> > > 
> > > device_type = "interrupt-controller".
> 
> Is that really right?  The MPIC binding, at least, has device_type =
> "open-pic" rather than "interrupt-controller".
> 
> > > +				compatible = "prep,iic";
> > > +				reg = <	00000001 00000020  00000002
> > > +					00000001 000000a0  00000002
> > > +					00000001 000004d0  00000002>;
> > > +				interrupts = <00000000 00000003
> > > +					      00000002 00000003>;
> > > +				interrupt-parent = <&MPIC>;
> > > +			};
> > > +		};
> > > +
> > > +		MPIC: interrupt-controller@d {
> > > +			device_type = "open-pic";
> > > 
> > > device_type = "interrupt-controller".
> 
> Not according to the binding in booting-without-of.txt

My understanding here, though possibly flawed, is that the current
implementation has "open-pic" but _should_ have "interrupt-controller"
as that is the officially correct name.

I _think_ this means we need a transitional period where we update
the code to look for "interrupt-controller", and obsoletedly, looks
for the "open-pic", while we transition to the new, correct name.

I'm just betting that if I'm wrong Segher will tell me! :-)

jdl
