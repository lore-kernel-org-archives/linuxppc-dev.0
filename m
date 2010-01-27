Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-01.bluehost.com (outbound-mail-01.bluehost.com
	[69.89.21.11]) by ozlabs.org (Postfix) with SMTP id E4C79B812C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Jan 2010 03:26:45 +1100 (EST)
Date: Wed, 27 Jan 2010 08:26:24 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] PCI-E broken on PPC (regression)
Message-ID: <20100127082624.4a91323a@jbarnes-piketon>
In-Reply-To: <1264558256.3601.153.camel@pasglop>
References: <4B5D9FC5.5070600@linux.vnet.ibm.com>
	<20100125123849.111fa2d1@jbarnes-piketon>
	<20100125175025.4c74f412@jbarnes-piketon>
	<1264558256.3601.153.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jay Vosburgh <fubar@us.ibm.com>,
	David Miller <davem@davemloft.net>, Ron Mercer <ron.mercer@qlogic.com>,
	kaneshige.kenji@jp.fujitsu.com, linuxppc-dev@lists.ozlabs.org,
	Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Jan 2010 13:10:56 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > Cc'ing Ben for PPC.  Ben, should PPC use pci_scan_device when probing
> > its root busses?  Sounds like it just uses pci_device_add for each one
> > it finds instead?
> > 
> > If you don't actually need scanning (though what about hotplug?) we can
> > move the call to device_add instead...
> 
> Ok so I looked at the code and the problem goes way beyond root busses.
> 
> Basically, powerpc can use the code in arch/powerpc/kernel/pci_of_scan.c
> to "generate" the pci_dev without using config space probing or at least
> using as little of it as possible, using the firmware device-tree
> information instead.
> 
> This is also probably going to be moved to a more generic place and
> extended to be used optionally by other architectures.
> 
> I think sparc does something similar in fact in arch/sparc/kernel/pci.c
> (of_create_pci_dev()) though it would be logical to have sparc and
> powerpc share the same implementation here in the long run and I believe
> Grant Likely is working on it.
> 
> That means that potentially, pci_dev will be created on those archs for
> which pci_setup_device() is never called. Thus we need to be very
> careful when adding initializations there that at least we (myself and
> davem) are notified of that so we can mirror them in our code, or even
> better, if people doing so put them there too...
> 
> So as far as I can tell, we are missing that set_pcie_port_type(), so we
> need to add it to sparc and powerpc (and so make the function non-static
> in drivers/pci/probe.c). We are also missing the manipulation of
> dev->slot in fact, so that will need to be fixed too.
> 
> set_pcie_hotplug_bridge() might be something we want to add too, it's
> not totally clear yet due to possible issues with our firmwares.
> pci_fixup_device(pci_fixup_early,...) as well in fact.
> 
> I'll try do make ppc catch up with some of that see how it goes.

Thanks Ben.  Any refactoring we need to handle this stuff better is
fine with me too.  I guess on some platforms calling pci_setup_device
may cause problems with special platform devices?

-- 
Jesse Barnes, Intel Open Source Technology Center
