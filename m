Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D32ADDDE02
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 00:58:17 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 03 Sep 2007 16:58:14 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20070903013431.GG31499@localhost.localdomain>
Message-ID: <20070903145814.101070@gmx.net>
MIME-Version: 1.0
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
Subject: Re: [RFC] AmigaOne device tree source v2
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

-------- Original-Nachricht --------
> Datum: Mon, 3 Sep 2007 11:34:31 +1000
> Von: David Gibson <david@gibson.dropbear.id.au>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: [RFC] AmigaOne device tree source v2

> Interrupt routing information is really necessary.  If it differs
> between the models then either you will need different device tree
> source for each of them, or you will need to fill in the correct
> interrupt routing information from the bootwrapper, whichever approach
> is easier.
Okay, I could probe the southbridge's PCI interrupt registers to fill in
some of the interrupt routing information from the bootwrapper.

> I believe that's handled by the bridge's compatible and reg
> properties.  The platform or bridge code will have to know that this
> type of bridge (as encoded in compatible) uses indirect addressing,
> and which resource (from the reg property) has the indirect access
> registers.
Well, then I'll copy and paste from the CHRP/Pegasos PCI setup code,
which should exactly do that. :-)

> I don't know enough about PCI to answer most of the above questions,
> but I spotted a bunch of problems with the device tree anyway...
> >   	pci@80000000 {
> > 		device_type = "pci";
> > 		bus-frequency = <01fca055>;		// 33.3MHz
> > 		bus-range = <0 1>;
> > 		reg = <80000000 7f000000>;				//
> >Whole PCI space.
> 
> 'reg' and 'ranges' should not typically overlap.  'reg' should only
> encode control registers for the bridge, not the whole PCI space (not
> that I'm even entirely sure what you mean by that).
Hmm, strange. I'm sure I found this in another device tree. I define
"whole PCI space" as PCI (prefetchable) memory and PCI I/O space.

> > 		host@0 {
> 
> The unit address (after the @) should be derived from the first range
> listed in the 'reg' property.  It's a bus address, not a slot number.
AFAIK it's the device number, which is 0 for this host/PCI bridge.

> > 			vendor-id = 0x000010cc;
> 
> Um.. evidentally you have never even tried compiling this device tree,
> since this is invalid syntax.  That would need to be:
> 			vendor-id = <000010cc>;
> and likewise all the others below.
Uh, yeah! I thought I fixed all these typos. You're right, I didn't try
to compile the device tree yet.

> > 			#interrupt-cells = <2>;
> > 			#address-cells = <2>;
> > 			#size-cells = <1>;
> > 
> > 			dma-controller {
> 
> All these devices should have unit addresses.
Okay, that would be dma-controller@0, interrupt-controller@20 and so.
Will be fixed!

> > 		ide@7,1 {
> 
> This will need a compatible property, at least.
I hoped the class-code property is enough for a PCI device, as it
clearly identifies this device as a PCI IDE conroller with primary and
secondary master functionality.

Thanks!

regards,

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
