Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69AD3DDE02
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 07:47:41 +1000 (EST)
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 07:47:26 +1000
Message-Id: <1184622446.25235.89.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-16 at 16:34 +0200, Segher Boessenkool wrote:
> >>> +		#address-cells = <0>;
> >>> +		#size-cells = <0>;
> >>
> >> No need for these.
> >
> > Isn't a good practice to put #address-cells in interrupt controller
> > nodes?
> 
> It is not.

Well, that's debatable... but yes, a strict reading of the spec would
say that you should put neither #address-cells nor #size-cells in a leaf
interrupt controller.

> > If the device tree has an interrupt map defined the interrupt
> > parent 'unit interrupt specifier' has to be interpreted according
> > to the #address-cells of the interrupt parent.
> 
> And "#address-cells" is defaulted to 0 if it is absent,
> for the purpose of interrupt mapping (but not for its
> other purposes). 

This is a bit confusing though, which is why I tend to prefer having it
explicitely in the interrupt controller node :-) I tend to dislike
"magic" defaults, we've had problems with them in the past and will have
in the future, I much prefer having things explicit whenever possible.

> Typically, such interrupt controllers
> don't have device tree children so it doesn't make sense
> to give them an "#address-cells" anyway.

Somewhat...

> > It seems like
> > typical practice in the current DTS files to explicitly define this
> > in the interrupt controller.
> 
> That "typical practice" is inspired by the need to explicitly
> put #address-cells and #size-cells into the device tree if you
> want Linux to properly parse the device tree, even if the default
> values would work perfectly (if Linux would work correctly,
> that is).

Linux does handle default values in some areas. The problem with default
values is that they are badly defined and the spec contains gray areas
and contradictions as to what the default values should be in some
circumstances. As a general matter, I dislike default values because
they somewhat require background knowledge of what default values should
be in different contexts to "read" a device-tree. To be simple, I
believe default values are a bad idea.

> There are no child nodes, and no binding that says there can
> be any; neither #address-cells not #size-cells should be there.

You are being way too pedantic here. The interrupt-tree uses those two
properties, thus "there is no child node" is open to interpretation.
There is no child device node, but there are child interrupt nodes, and
since the interrupt-tree uses #address/size-cells, it does make some
sense to specify them.

Yes, there is a default value when absent, but the simple fact that the
default is different depending if you are doing a device walk or an
interrupt tree walk is very confusing. As I said above, the default
values are a source of more problem than anything else and I tend to
think they should be banned.

I would personally be inclined to define that whatever spec we come up
with always require #address-cells/#size-cells for any node that can
have either device children or interrupt children, and ban default
values alltogether.

Cheers,
Ben. 
