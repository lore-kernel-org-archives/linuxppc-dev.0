Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7226B7BD7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2009 17:06:32 +1000 (EST)
Message-ID: <4AC30371.80509@embedded-sol.com>
Date: Wed, 30 Sep 2009 09:06:25 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: MPC8536 PCI rescan to discover FPGA
References: <4AB79D41.60902@embedded-sol.com>	
	<4AB7A411.3030406@ovro.caltech.edu>
	<1253604183.7103.213.camel@pasglop>
In-Reply-To: <1253604183.7103.213.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Benjamin

Benjamin Herrenschmidt wrote:
> Right. However, in case it's a bit too much work to get
> hotswap implemented on the machine, you may still be able
> to do something simpler from your platform code, after you've
> finished loading the FPGA. I assume the FPGA doesn't contain a
> P2P bridge that would require probing further below the FPGA
> itself.
>
> The basic idea is to call pci_scan_slot() on the devfn where
> the FPGA is supposed to respond.
>
> Then you need to also do some fixup. First you need to call
> pcibios_setup_bus_devices(). This will wire up the device
> to an OF node if you have one, setup some default DMA ops,
> etc...
>
> Note that this function will walk over all devices on that bus
> which is interesting since some of those may have already been
> fully setup initially. Hopefully that isn't a problem. If it
> was to become one, we would have to figure out a way to skip
> devices that have already been "setup".
>
> And finally you call pcibios_finish_adding_to_bus() which will
> do the resource allocation pass on all new devices on the bus
> and register them with the core device layer.
>
> Cheers,
> Ben.
>
>   
Thanks for the advice. This approach worked well for me, with some minor
modifications. First I had to clear PPC_INDIRECT_TYPE_NO_PCIE_LINK
in hose->indirect_type, otherwise reads from configuration space fail. And
second, I had to call pci_assign_resource() to complete the assignment 
of FPGA
memory. The memory range is 0x0 - 0x7fffff, and PCI code doesn't like 
resources
starting at 0.

Again, thanks a lot for your help, much appreciated.

Felix.
