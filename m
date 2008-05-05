Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id F32CEDDEE8
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 18:44:06 +1000 (EST)
Date: Mon, 05 May 2008 01:44:05 -0700 (PDT)
Message-Id: <20080505.014405.179523103.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: on the topic of of_device resources...
From: David Miller <davem@davemloft.net>
In-Reply-To: <1209975971.21644.58.camel@pasglop>
References: <20080505.005958.186160264.davem@davemloft.net>
	<1209975971.21644.58.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 05 May 2008 18:26:11 +1000

> Well, we aren't totally clear as to whether we'll use of_device much or
> not in the long term. For bus types that already have their own
> descendant of struct device (such as PCI, but also i2c, USB, etc...) it
> makes little sense to create a "special" version with OF device...
> 
> That leaves platform devices, and there, experience has shown that it's
> not very practical neither when a driver is shared between powerpc and
> some other non-OF arch.
> 
> So we are trying to move toward a slightly different approach: Any
> device can optionally be linked to a device_node (via dev_archdata), and
> we provide "constructors" to build the various kind of struct device
> descendants based on the device nodes.

I see, thanks for the info.

> This is in no way something done though. As you may have noticed,
> macio_device is still around, though on the other hand, we have code to
> build the PCI tree from the ground up straight off the OF nodes (that
> you may want to use too at one point ...) though it's not using the
> "constructor" approach. Some work hsa been done in the i2c layer to
> create i2c devices based on device nodes, and there are other areas like
> that.

I already build the PCI device tree on sparc64 strictly using
the OF device tree. :-)

My plan on the sparc side is to remove the SBUS device type and bus
entirely, as well as the EBUS layer I have.  All of it can use
of_device nodes on of_platform_bus.  Even the DMA stuff just falls out
of everything transparently because even that's all done via
dev_archdata.

If you look at the SBUS layer, it's simply replicating OF device
node objects for things that sit underneath SBUS bus nodes.  And
it's like this because 32-bit sparc doesn't do the DMA stuff
transparently like 64-bit sparc does.

The of_platform_bus probing layer is extremely clean and I like
how simple it is to write drivers using it.  The drivers look
like normal PCI device drivers, both in terms of matching
and in terms of resource/irq fetching.

I even use this for the core timeofday clock probing on sparc64.
