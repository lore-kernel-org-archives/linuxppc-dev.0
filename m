Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 497DEDDE9B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 21:36:52 +1000 (EST)
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20071017.042229.95059231.davem@davemloft.net>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
	<20071017.042229.95059231.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 21:36:30 +1000
Message-Id: <1192620990.11899.168.camel@pasglop>
Mime-Version: 1.0
Cc: sparclinux@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
	sfr@canb.auug.org.au
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I find it ironic that you add of_get_pci_dev_node() as a function
> which gets the node and grabs a reference to it, and then the very
> first usage you make of it doesn't drop the reference at all.
> 
> That reference grabbing aspect of the new interface is obviously very
> useful! :-)
> 
> Kidding aside (I realize that in this case probably the driver never
> unregisters and therefore the reference never needs to be released)
> it's really much nicer to add facilities when you have patches in hand
> that actually use them.

I think in this case, it's mostly a matter of consistency... pretty much
everything that returns a device_node grabs a reference... except
pci_device_to_OF_node :-)

I think Michael is trying to address that, and axon-msi happens to be
something he wrote so a good candidate for an initial conversion :-)

Cheers,
Ben.
