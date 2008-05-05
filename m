Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90BD6DDF65
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 18:55:40 +1000 (EST)
Subject: Re: on the topic of of_device resources...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080505.014405.179523103.davem@davemloft.net>
References: <20080505.005958.186160264.davem@davemloft.net>
	<1209975971.21644.58.camel@pasglop>
	<20080505.014405.179523103.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 05 May 2008 18:55:32 +1000
Message-Id: <1209977732.21644.65.camel@pasglop>
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


On Mon, 2008-05-05 at 01:44 -0700, David Miller wrote:
> 
> My plan on the sparc side is to remove the SBUS device type and bus
> entirely, as well as the EBUS layer I have.  All of it can use
> of_device nodes on of_platform_bus.  Even the DMA stuff just falls out
> of everything transparently because even that's all done via
> dev_archdata.
> 
> If you look at the SBUS layer, it's simply replicating OF device
> node objects for things that sit underneath SBUS bus nodes.  And
> it's like this because 32-bit sparc doesn't do the DMA stuff
> transparently like 64-bit sparc does.
>
> The of_platform_bus probing layer is extremely clean and I like
> how simple it is to write drivers using it.  The drivers look
> like normal PCI device drivers, both in terms of matching
> and in terms of resource/irq fetching.
> 
> I even use this for the core timeofday clock probing on sparc64.

Well, I agree it's nice and sleek for bus types you have complete
control on. The problem is when you start sharing with other
architecture :-) (well, other than powerpc & sparc !).

Which is why I might just stick to macio_device the way it is since
that's a totally local bus type, despite moving toward the different
approach I exposed for other things.

I think we need to continue supporting both approaches in the long run,
but that also means that low level parsers should as much as possible
remain based stictly on device node.

Now regarding using some kind of device for the timeofday clock probing,
well that's a different issue :-) We do need to get rid of our ppc_md.
stuff for that and move toward the new RTC infrastructure, which means
that our TODs will be proved like other devices.

Now, how so will depend on what TOD we have... i2c TODs (very common in
embedded) already have the necessary bits to be probed via the OF/i2c
bindings, creating i2c_device objects. Platform custom things like
PowerMac CUDA or PMU could be of_platform_devices. Etc...

Cheers,
Ben.
 
