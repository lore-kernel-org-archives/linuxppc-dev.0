Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5854DDEFC
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 08:59:01 +1000 (EST)
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20070717222507.GA4682@ld0162-tx32.am.freescale.net>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
	<1184622446.25235.89.camel@localhost.localdomain>
	<C2D29334-489F-49B0-8220-0D94E89FEAC3@kernel.crashing.org>
	<1184707558.25235.159.camel@localhost.localdomain>
	<20070717222507.GA4682@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 08:58:48 +1000
Message-Id: <1184713128.25235.167.camel@localhost.localdomain>
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


> It could lead someone to the erroneous conclusion that an #address-cells
> other than zero in an interrupt controller that is not a device parent is
> in any way a sane or supported thing to do.

I fail why anyone would ever want to do it though :-)

> It could lead people to write code that doesn't handle the absence of
> #address-cells in such a node properly.

We just need to make mention that it can be absent in the spec, there
shouldn't be that many parsers out there.

> It could lead to flamewars. :-)

Yeah well.

> If there's only one value that could possibly make sense, it *not* being
> the default is crap.

Only for leaf nodes. Other values do make sense for non-leaf nodes.

> The obvious way (which indeed isn't what the suggested algorithm does --
> but the suggested algorithm doesn't do anything sensible) is that if you
> got to the node via an interrupt-parent or interrupt-map, it doesn't use
> #address-cells, and if you got to it by going to the regular device tree
> parent, it does.

Yeah well, that's also somewhat debatable too. You need a #address-cells
to be able to parse an interrupt-map. You can imagine cross-links and
special maps used to handle things like the multiple UICs as David did
in the past. I wouldn't get rid of that flexibility to handle corner
cases that aren't easily represented by the "standard" stuff.

> Pretty much any time you use the unit address in a context other than the
> bus parent, things cease making sense.

I tend to agree.

> There is the ePAPR working group, though.

Yup, true.

Ben.
