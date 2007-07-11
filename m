Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3C14DDE49
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 12:44:21 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6B2iFlO021847
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 19:44:16 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6B2iEOT004540
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 21:44:15 -0500 (CDT)
Subject: Re: [patch 3/6] Add 8548 CDS PCI express controller node and PCI-X
	device node
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <963D5B48-F1E5-4930-9F29-98D7F0E33C0A@kernel.crashing.org>
References: <1184082728.20129.187.camel@localhost.localdomain>
	<963D5B48-F1E5-4930-9F29-98D7F0E33C0A@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1184121840.22066.24.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 11 Jul 2007 10:44:01 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-11 at 04:25, Segher Boessenkool wrote:
> >               pci1: pci@8000 {
> >                       interrupt-map-mask = <1f800 0 0 7>;
> 
> Set the mask to <1800 0 0 7>, and you need only 16
> entries to encode the swizzle.  Except...
> 
> > +                             /* bus 1 , idsel 0x2 Tsi310 bridge
> secondary */
> 
> ...interrupts on bus 1 should be swizzled on bus 1, not
> at the PHB.  Really.  It is a horrible workaround for a
> non-existing problem to do it here, and I promise you
> it _will_ come back to hurt you later.  Not a threat,
> just a promise :-)

I just want to make it as a temporary workaround now.
Extra patches will be provided to fix it.


> > -                     compatible = "85xx";
> > +                     compatible = "fsl,mpc85xx-pci","85xx";
> 
> No more "xx" please...
> 
> > +             pci@a000 {
> > +                     interrupt-map-mask = <f800 0 0 7>;
> > +                     interrupt-map = <
> > +
> > +                             /* IDSEL 0x0 (PEX) */
> > +                             00000 0 0 1 &mpic 0 1
> > +                             00000 0 0 2 &mpic 1 0
> > +                             00000 0 0 3 &mpic 2 0
> > +                             00000 0 0 4 &mpic 3 0>;
> 
> Why sense 0 for all but the first entry in this map?
Now, only the first entry is used.
> 
> > +                     compatible = "fsl,mpc86xx-pciex","86xx";
> 
> And "xx" again.  Aren't the 85- and 86- PCIe controllers
> compatible, btw?
