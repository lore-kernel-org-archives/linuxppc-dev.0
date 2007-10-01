Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 07E3DDDE3C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 08:54:12 +1000 (EST)
Subject: Re: Problem with OF interrupt parsing code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <d3eb2341d21ed1f9f7e71f097878731f@kernel.crashing.org>
References: <20071001210025.314240@gmx.net> <20071001211120.156280@gmx.net>
	<d3eb2341d21ed1f9f7e71f097878731f@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 08:54:04 +1000
Message-Id: <1191279244.6310.32.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-02 at 00:33 +0200, Segher Boessenkool wrote:
> > 		  	i8259: interrupt-controller@20 {
> > 				device_type = "interrupt-controller";
> > 				compatible = "pnpPNP,000";
> > 				interrupt-controller;
> > 				reg = <00000001 00000020 00000002
> > 				       00000001 000000a0 00000002
> > 				       00000001 000004d0 00000002>;
> > 				reserved-interrupts = <2>;
> > 			};
> 
> This is an interrupt controller (it has an "interrupt-controller"
> property, and it has no interrupt parent (there is no "interrupt-parent"
> property, for interrupt controllers you do not follow the "normal" tree
> parent), so it is the root interrupt controller and there is no loop.
> 
> It seems from your description that the Linux code is using the tree
> parent as interrupt parent even for interrupt controller nodes.  This
> is wrong behaviour.

It shoudn't normally happen. The reason it -does- happen in fact is that
the above node is also missing the #interrupt-cells property, which
cause the parent-lookup routine to skip it before it gets a chance to
see that there's an "interrupt-controller" property in there.

I'm not sure whether linux behaviour is a bug or not since I believe we
are clearly in undefined-land as an interrupt controller should always
have a #interrupt-cells property.

Ben.
