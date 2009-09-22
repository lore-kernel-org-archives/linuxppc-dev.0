Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3F18B7B6F
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 17:23:59 +1000 (EST)
Subject: Re: MPC8536 PCI rescan to discover FPGA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Hawkins <dwh@ovro.caltech.edu>
In-Reply-To: <4AB7A411.3030406@ovro.caltech.edu>
References: <4AB79D41.60902@embedded-sol.com>
	<4AB7A411.3030406@ovro.caltech.edu>
Content-Type: text/plain
Date: Tue, 22 Sep 2009 17:23:03 +1000
Message-Id: <1253604183.7103.213.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Felix Radensky <felix@embedded-sol.com>, Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-09-21 at 09:04 -0700, David Hawkins wrote:
> This can be made to work using the kernel hot-swap
> interface. PCI devices have an ENUM# interrupt that
> they assert when inserted or extracted, and the host
> hot-swap driver can be hooked up to it. PCI-E may
> have a similar mechanism, if it does, then when your
> FPGA configures as a PCI-E device, it can assert that
> interrupt line (or send the appropriate PCI-E
> message to simulate that interrupt).
> 
> However, even if PCI-E does not have the concept of
> an ENUM# interrupt there is a way to generate a fake
> hot-swap event and generate a re-scan of the PCI bus.
> 
> I haven't tested the kernel hot-swap interface, but I
> know that Ira did, so I'll cc him on this mail, and he
> can let you know what he tested.

Right. However, in case it's a bit too much work to get
hotswap implemented on the machine, you may still be able
to do something simpler from your platform code, after you've
finished loading the FPGA. I assume the FPGA doesn't contain a
P2P bridge that would require probing further below the FPGA
itself.

The basic idea is to call pci_scan_slot() on the devfn where
the FPGA is supposed to respond.

Then you need to also do some fixup. First you need to call
pcibios_setup_bus_devices(). This will wire up the device
to an OF node if you have one, setup some default DMA ops,
etc...

Note that this function will walk over all devices on that bus
which is interesting since some of those may have already been
fully setup initially. Hopefully that isn't a problem. If it
was to become one, we would have to figure out a way to skip
devices that have already been "setup".

And finally you call pcibios_finish_adding_to_bus() which will
do the resource allocation pass on all new devices on the bus
and register them with the core device layer.

Cheers,
Ben.
