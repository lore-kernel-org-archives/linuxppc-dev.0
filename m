Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 45EBCDDDF9
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 21:58:13 +1100 (EST)
Subject: Re: Connecting to "PCI command write" interrupt on 4xx platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
In-Reply-To: <200811031010.33250.matthias.fuchs@esd-electronics.com>
References: <200810301158.46686.matthias.fuchs@esd-electronics.com>
	<1225397712.8004.173.camel@pasglop>
	<200811031010.33250.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain
Date: Mon, 03 Nov 2008 21:57:43 +1100
Message-Id: <1225709863.8004.252.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-11-03 at 10:10 +0100, Matthias Fuchs wrote:
> 
> Adding this interrupt to the PCI node would make (logical) sense. But
> on PCI adapter (add-in cards) designs we typically disable the PCI node
> of the DT to disable PCI PnP. This should not prevent us from adding the
> interrupt to the node but it looks a little bit weird to take an interrupt
> from a disabled node, right?

You can make a pci-endpoint node that isn't detected as a host bridge.
In fact, I think we have some way to even tell in the DT not to activate
host bridge function on 44x nowadays no ? I dont remember for sure but
it's easy enough to add.

> > the actual PCI bridge, then you can stick an interrupts property in the
> > PCI host bridge node in the DT just fine.
> The PCI node already contains the interrupt-map for the PCI interrupts.

Only relevant for master, not endpoint.

> Doesn't adding a further interrupt property cause some trouble with the PCI interrupts?

Not for endpoint.

Ben.
