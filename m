Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1DDA5DDE37
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 22:24:45 +1100 (EST)
In-Reply-To: <1172299259.1902.22.camel@localhost.localdomain>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
	<20070222011811.GA18364@localhost.localdomain>
	<45b623f395654fc4f4920b9553794def@kernel.crashing.org>
	<20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
	<1172299259.1902.22.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <643831cd4d45f0dd0d4fbd8f5893f9bd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Sat, 24 Feb 2007 12:24:36 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Examples exists where one property tells you how to interpret
>> or decode another (e.g. #address-cells), but your proposal we
>> have two distinct properties each with values that together
>> provide the complete 'value' (interrupt parent + interrupt
>> specifier).  Is there any precedent for this approach?
>
> Somewhat... interrupt-map and interrupt-map-mask... that sort of thing.

Those are not _arrays_ parsed in concert; finding examples
of that is pretty hard (unless you look at PAPR or Apple
trees ;-) ), there are a few though.  Examples where a scalar
property is used to interpret an array property are plenty,
look no further than "interrupt-parent".

>> I think I'd rather see all the information encoded in
>> one value.
>
> On the other hand, I do quite like keeping with the old principle that
> having interrupts == having an "interrupts" node.

Yes, it's a very important principle in OF that any certain
piece of information is encoded in one place, and one possible
place only.

This does mean that you should be very careful when defining
new bindings, think things through a lot to future-proof it,
do a whole lot of peer review, etc.; but in the end you'll end
up with much better bindings.


Segher
