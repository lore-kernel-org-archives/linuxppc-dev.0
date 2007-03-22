Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4D389DDF7A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 02:37:35 +1100 (EST)
Date: Thu, 22 Mar 2007 10:51:55 -0500
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [Fwd: [PATCH Resend 01/02] Add Linux ASMP support for MPC8641D]
Message-ID: <20070322155155.GA19903@lixom.net>
References: <1174573524.6595.509.camel@ld0161-tx32>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97F7C@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302B97F7C@az33exm25.fsl.freescale.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2007 at 08:32:33AM -0700, Yoder Stuart-B08248 wrote:
> 
> > +		mpic: pic@40000 {
> > +			clock-frequency = <0>;
> > +			interrupt-controller;
> > +			#address-cells = <0>;
> > +			#interrupt-cells = <2>;
> > +			reg = <40000 40000>;
> > +			built-in;
> > +			compatible = "chrp,open-pic";
> > +			device_type = "open-pic";
> > +			big-endian;
> > +			interrupts = <
> > +			18 2 49 2 19 2
> > +			2a 2 2b 2 4a 1
> > +			1d 2 1e 2 22 2
> > +			23 2 24 2 28 2
> > +			>;
> > +		};
> > +	};
> > +};
> 
> I think using the 'interrupts' property in this way is bad.  It's 
> being used to tell the pic which interrupts belong to it. 
> 
> The problem is that the interrupts property is being overloaded
> and used for a completely different purpose than that which
> it was originally intended and documented.  Interrupt controllers
> should not have an interrupts property.
> 
> The only reason I can see to do this is as a convenience to avoid
> walking the device tree.   The pic code should walk the device tree
> to determine the irq numbers the running core.

Not speaking for the case of the freescale boards here, but not all
interrupts are in the device tree, nor do they have to. Especially for
PCI devices, etc.

This is quite a special case. Having a brand new property for it might
be a good idea. It's a pretty big hack anyway, so adding another one to
the device tree isn't that big a deal.


-Olof
