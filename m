Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B668FDDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 09:55:12 +1000 (EST)
In-Reply-To: <1180047084.32247.1070.camel@localhost.localdomain>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
	<1179960728.32247.953.camel@localhost.localdomain>
	<396FEEDC-99AB-4E25-9C80-A901923429B0@freescale.com>
	<1180047084.32247.1070.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2994f78d2591e45517247003d613bb98@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: TSI ethernet PHY question
Date: Fri, 25 May 2007 01:54:35 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> For powerpc, I have a solution at hand, it's the device-tree :-)
>
> Any struct device in the system can have a device node pointer via the
> dev_sysdata thingy I added recently. So we can have some code for
> powerpc that properly hooks up the PHY to an (optional) device-node
> which can then contains properties describing what kind of workarounds
> need to be applied.
>
> For example, we can have a txc-rxc-delay-disable property on Holly.

This is equivalent to the ethernet driver passing this information
to phylib via the init arguments.

You still have the same problems as Andy described where the
necessary workaround is not something local to phylib, but
needs cooperation of the ethernet code or the soc code or
some other platform code.

Since the specific bug we're talking about here is not a
problem with the PHY, but a miswiring on the board, I wouldn't
put a flag for the workaround in the phy node in the device
tree.  It certainly is an option though.

> The problem is that of course the PHY driver will need some powerpc
> specific code to go fetch that.

The ethernet driver can handle it, instead.

> An option would be to instead use flags
> and have a piece of powerpc specific code that translates those
> device-tree properties into flags so that other archs can use the flags
> using their own ways of passing them in.

It really shouldn't ever be needed on any other board, but
sure.

> I'm not too hot with the flag stuff tho since those really need to be
> defined per PHY model/family. But I suppose that's fair enough.

Divide the flags arg into a generic and a chip-specific part?


Segher
