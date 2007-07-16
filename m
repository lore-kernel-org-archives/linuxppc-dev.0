Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A862DDE04
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 08:11:56 +1000 (EST)
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <469BE93E.1070702@freescale.com>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
	<1184622446.25235.89.camel@localhost.localdomain>
	<469BE93E.1070702@freescale.com>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 08:11:38 +1000
Message-Id: <1184623898.25235.96.camel@localhost.localdomain>
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

On Mon, 2007-07-16 at 16:55 -0500, Scott Wood wrote:
> Benjamin Herrenschmidt wrote:
> > I would personally be inclined to define that whatever spec we come up
> > with always require #address-cells/#size-cells for any node that can
> > have either device children or interrupt children, and ban default
> > values alltogether.
> 
> When is #size-cells used in the interrupt tree at all?

It's not, sorry, my fingers typed a bit too fast :-)

> And given the odd behavior of using an interrupt map in an interrupt 
> parent that is not the device parent (you're potentially using keys from 
> different domains that could clash, be a different sizes, etc), if we 
> make any changes in that regard, I'd forbid interrupt maps in interrupt 
> controllers with no device children, and thus #address-cells has no 
> meaning there.

No, interrupt maps are useful in devices with no children in some corner
cases. Remember that a map doesnt need to use the address part of the
source specifier, thus it can be used to do a pure domain->domain
conversion of the irq numbers, what sort of thing. The map has the added
advantage that today, it's the only mechanism that allows you to specify
different interrupt-parents through the same nexus, which is useful for
4xx.

Ben.
