Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id AC7CFDDE3D
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 21:22:16 +1000 (EST)
Date: Wed, 17 Oct 2007 04:22:29 -0700 (PDT)
Message-Id: <20071017.042229.95059231.davem@davemloft.net>
To: michael@ellerman.id.au
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, sfr@canb.auug.org.au, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 17 Oct 2007 17:12:27 +1000 (EST)

> Use of_get_pci_dev_node() in axon_msi.c. Switch to including <linux/of.h>
> so we get the prototype.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

I find it ironic that you add of_get_pci_dev_node() as a function
which gets the node and grabs a reference to it, and then the very
first usage you make of it doesn't drop the reference at all.

That reference grabbing aspect of the new interface is obviously very
useful! :-)

Kidding aside (I realize that in this case probably the driver never
unregisters and therefore the reference never needs to be released)
it's really much nicer to add facilities when you have patches in hand
that actually use them.
