Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7103DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 16:41:44 +1100 (EST)
Subject: Re: Re[2]: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuri Tikhonov <yur@emcraft.com>
In-Reply-To: <1102187680.20081114074513@emcraft.com>
References: <200811131149.14715.yur@emcraft.com>
	<1226568352.7178.44.camel@pasglop>
	<1102187680.20081114074513@emcraft.com>
Content-Type: text/plain
Date: Fri, 14 Nov 2008 16:41:29 +1100
Message-Id: <1226641289.7178.117.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Wolfgang Denk <wd@denx.de>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  My understanding was that the dma-ranges property is responsible for 
> setting up the inbound ranges of RAM's physical addresses, where PCI 
> could DMA to/from. As regarding the outbound property, this patch 
> doesn't change this, and there we have the PCI space split (2 GB of 
> memory, and 64K of I/O spaces mapped from the 64-bit physical 
> addresses into 32-bit PCI address space). Am I missing something ?

The PCI memory space doesn't differenciate inbound and outbound.

For example, if you take the example of a PCI 2.0 or PCI-X setup (I'm
leaving PCI-E alone in the discussion because it's a bit special in that
area, but the problem is fundamentally the same), and you have on the
PCI bus of that thing a device X configured to respond to MMIO at
address, for example, 0x80000000.

Now, what happens if another device, let's call it Y, tries to DMA to
that same address ? Who will pick up the memory write at address
0x80000000 ? The host controller or device X ? 

There is no concept of "inbound" here.. it's just a memory cycle to
address A that gets decoded by whoever tries to decode it on that bus
segment.

Thus DMA ranges must -not- overlap areas of memory used for MMIO, it
just won't work.

>  With the default 2GB dma-ranges we just get the following on Katmai 
> with 4GB of SDRAM installed:

Because that is simply not supported at the moment unless we add what
I've talked about earlier, ie basically, swiotlb support (which Becky is
working on at the moment).

You might be able to work around it somewhat if your PCI device supports
64-bit BARs in which case you can set your outbound regions above the
32-bit space. Note that I haven't verified whether the 32-bit linux
kernel supports that tho. There used to be issues with >32-bit PCI BARs
on 32-bit kernel, at least it wouldn't assign them but that may have
been fixed.

Another option you can try if you device only does 32-bit BARs but
supports 64-bit DMA, is to move the DMA window away from the 32-bit MMIO
space. Stick it at 1T or so in PCI space. You might need a little bit of
kernel tweaking to make the dma-ops pick that up properly but that
shouldnt be too hard.

If you really need 32-bit DMA support, you'll have to wait for swiotlb
from Becky or work with her in bringing it to powerpc so that we can do
bounce buffering for those devices.

Ben.
