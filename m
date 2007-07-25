Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E33F1DDE30
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 12:09:18 +1000 (EST)
Subject: Re: [PATCH] Re: 2.6.22-git hangs during boot on PowerBook G3 in
	0.0 seconds
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20070724185946.722f34b5.kim.phillips@freescale.com>
References: <20070721192143.GA12144@nospam.com>
	<20070721212845.GA30977@nospam.com>
	<20070723172725.b1c14885.kim.phillips@freescale.com>
	<1185234923.5439.158.camel@localhost.localdomain>
	<20070724185946.722f34b5.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Wed, 25 Jul 2007 12:07:03 +1000
Message-Id: <1185329223.5439.304.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Rutger Nijlunsing <rutger@nospam.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> for the enumerated PHYs. As the original commit comment states, I was
> getting these messages:
> 
> prom_parse: Bad cell count for /qe@e0100000/mdio@2120/ethernet-phy@00
> prom_parse: Bad cell count for /qe@e0100000/mdio@2120/ethernet-phy@01

Well, I would say it's a bug to try to translate addresses accross such
a boundary. Thus the PHY enumeration code is bogus.

> > I also wonder why it hangs on the powerbook... Rutger, I would expect to
> > see that complaint warning with the reverted patch, what does it say ?
> > 
> > My Wallstreet (also based on Grackle) doesn't have the problem. Also can
> > you send me a tarball of /proc/device-tree ?
> 
> I don't have any of those machines, but it seems that older kernels
> running on the Lombard emitted:
> 
> device-tree: Duplicate name in /cpus/PowerPC,750@0, renamed to "l2-cache#1"

That's a different matter.

> messages*.  Experimenting with adding two chosen nodes (due to a prior
> thread on this list**) results in a hung kernel on the 8360 also, so
> perhaps they're related (and the kernel's tolerance to duplicate
> entries has changed, which explains where I had seen the chosen node
> being renamed).
> 
> but yeah, size-cells should be allowed to be 0 (even address-cells) and
> it may be the case that the Lombard needs some fixup code.

Ben.
