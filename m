Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93B8CDDF1E
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 22:42:25 +1000 (EST)
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070619054232.GB32039@localhost.localdomain>
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 22:42:13 +1000
Message-Id: <1182429733.24740.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-06-19 at 15:42 +1000, David Gibson wrote:
> 
> Is there a device binding defined somewhere for "chrp,iic"?

Yes, it's the standard for 8259 on chrp and chrp-like platforms.

> >               interrupt-controller;
> >               reg = <20 2 a0 2 4d0 2>;
> >               reserved-interrupts = <2>;

I'm currious about the above though, what is it ?

> >               #address-cells = <1>;

Why #address-cells set to 1 ? In a PIC node, in fact, I would expect it
to be 0 to avoid any spurrious "reg" matching for interrupts.

> >               #size-cells = <0>;
> >               #interrupt-cells = <2>;
> >       };
> 
> >       8042@60 {
> >               device_type = "8042";
> >               compatible = "chrp,8042";
> >               reg = <60 10>;
> >               interrupts = <1 3 c 3>;                 // IRQ1, IRQ12
> (rising edge)
> >               interrupt-parent = <&interrupt-controller>;

Just put the interrupt-parent pointer once in the isa bridge and all isa
devices below the bridge.

> This should cause a dtc error.  Either you want &/interrupt-controller
> or give the interrupt-controller node a label and refer to that.  It's
> either '&/some/full/path' or '&label'.
> 
> >               #address-cells = <1>;
> >               #size-cells = <0>;                      // No physical
> address.
> 
> Comment is arguably incorrect.

Yeah, not sure what that is supposed to be.

Ben.
