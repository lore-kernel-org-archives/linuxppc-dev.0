Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7374DDDE32
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 21:54:22 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 05 Sep 2007 13:54:19 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20070905024805.GE17189@localhost.localdomain>
Message-ID: <20070905115419.321990@gmx.net>
MIME-Version: 1.0
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
	<20070904114945.303440@gmx.net>
	<20070905024805.GE17189@localhost.localdomain>
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


-------- Original-Nachricht --------
> Datum: Wed, 5 Sep 2007 12:48:05 +1000
> Von: David Gibson <david@gibson.dropbear.id.au>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: Segher Boessenkool <segher@kernel.crashing.org>, linuxppc-dev@ozlabs.org
> Betreff: Re: [RFC] AmigaOne device tree source v2

> That looks totally bogus.  Unlike Segher, I think there are a few
> cases where overlapping reg and ranges can make sense (PCI bridges
> where config space is accessed indirectly via MMIO registers which lie
> in the legacy ISA IO space is an example).  But this doesn't look like
> such a case - it just looks like whoever did the device tree
> misunderstood the distinction between reg and ranges.
AmigaOne's PCI bridge implements PCI config with indirect addressing, but
not within the ISA I/O space. I just wanted to clear up the meaning of
this reg entry, because it looks like everyone interprets the OF spec a
little bit differently.

> > > PCI legacy I/O is not direct mapped: there is no legacy I/O on a
> > > PowerPC system bus.  So, it can not be mentioned in the "ranges"
> > > property, but the PHB registers used to access it should be shown
> > > in the "reg" property.  It could be a simple linear window (it
> > > sounds like it is here?), but it could for example also be
> > > implemented via an address/data register pair.
> 
> Err... huh?  The legacy IO space is assigned a block of addresses in
> 3-word "OF-PCI-space by the PCI binding.  When that is translated into
> an MMIO range by the bridge, there's no reason that can't be encoded
> into the ranges property.
I defined the legacy I/O space together with the PCI I/O space in the
ranges property of the PCI node:
ranges = <01000000 0 00000000 fe000000 0 00c00000
The first 64k of this address space are mapped to ISA I/O in the PCI2ISA
bridge node.

> The whole damn point of the device tree is to avoid using this kind of
> non-local information "I know what the board type is over there, so it
> must be this PCI bridge over here".  The node should have a compatible
> property which is sufficient to select the right bridge driver.
Yeah, I defined a compatible = "mai,articias"; property in the pci node.
Are there any naming conventions (maybe lower case only)?

> I think this is typically badly done at the moment, simply because PCI
> has historically been set up by the platform code, rather than by a
> "host bridge driver" in the mould of other drivers.  I don't see that
> changing real soon, but that doesn't mean we shouldn't at least put
> enough information in the device tree to make it possible.
I agree (even if it means more work for me :-)

I'll post a revised version of the device tree.

Thanks!

Gerhard
-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
