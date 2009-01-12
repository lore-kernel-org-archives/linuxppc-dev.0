Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6FEFDE014
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 16:15:16 +1100 (EST)
Subject: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20090107225048.23020@gmx.net>
References: <20090107135457.234150@gmx.net>
	<20090107190718.GA17427@ld0162-tx32.am.freescale.net>
	<20090107225048.23020@gmx.net>
Content-Type: text/plain
Date: Mon, 12 Jan 2009 16:12:18 +1100
Message-Id: <1231737138.22571.22.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yes, all AmigaOne boards have physical PCI slots (at least 1). The different
> interrupt routing wasn't a problem so far, as the firmware writes the IRQ number
> to the interrupt line register of every PCI device.

The code in the kernel that retreives the interrupt that way is clearly
marked as a fishy workaround for bogus firmwares :-)

But I'm not going to reject things based on that, it will work for
simple board using really only legacy interrupts like yours...

> Currently the kernel reads the IRQ number from this register, if there is no
> interrupt mapping property. I know that it's not a good idea to rely on kernel
> fallback behavior, but it makes a lot of things easier in this case.

Sort-of. As long as it's really 8259 interrupts, I suppose it's
acceptable.

> > For the flattened device tree, I think we've settled on the convention
> > that every node with an IRQ connection should have both the
> > interrupt-parent and interrupts properties.  (ie. don't rely on the
> > parent node's interrupt-parent property.)
> Even for ISA devices?

I disagree with Grant here. Especially in simple ISA cases like that,
there's really no point in bloating the device-tree.

> > Can this PCI device be probed?  Typically PCI devices don't get added
> > to the flattened device tree because PCI is a probeable bus.
> Yes, it can be probed. I thought it would be a good idea to include it,
> because the IDE controller operates in legacy mode. I planned to specify the
> two legacy interrupts in this node (as you can see), but the kernel didn't like
> them.

Well, the kernel just didn't make use of them I'd say :-) But that can
probably be fixed with the appropriate hacks. 

Cheers,
Ben.
