Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81189DE1F7
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 15:44:34 +1100 (EST)
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070128.201938.102578509.davem@davemloft.net>
References: <1170032301.26655.140.camel@localhost.localdomain>
	<20070128.171309.11624572.davem@davemloft.net>
	<1170040622.26655.187.camel@localhost.localdomain>
	<20070128.201938.102578509.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 15:44:07 +1100
Message-Id: <1170045847.26655.200.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: greg@kroah.com, kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	brice@myri.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, ebiederm@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You can't implement isolation unless you 1) strictly control what
> devices can do to other devices on the PCI domain or 2) filter
> transactions in the PCI bridges so that PCI devices cannot send
> arbitrary junk to each other.
> 
> #2 is prohibitively expensive and complicated because it requires
> specialized hardware.  #1 is low cost in that all you need to do is
> make PCI config space accesses and MSI setup go through the
> hypervisor.  That's why systems implement #1 to give full isolation.

Well, on IBM machines, they do #2 :-) Or rather, they have a P2P bridge
for every slot pretty much ... but then, those are expensive
machinces :-)

Now, #1 is an acceptable solution up to a certain point... MSIs being
just normal upstream stores, while you can try to prevent the OS from
programming the config space for a device to use somebody else MSI
target address or values, you can't prevent the OS to program some
random device DMA engine to issue those same bogus cycles, unless you
have an iommu per slot, which is what IBM has :-)

So yes, #1 is probably the "easy" solution but is definitely not 100%
robust.

> That's why I think the whole MSI hypervisor thing done by RTAS is
> absolutely reasonable and something we should support.  It's NOT like
> TCP Offload Engines and the like, not at all, and it's quite upsetting
> to see Eric characterize it in that way.  It's a protection and
> isolation facility, not a way to hide hardware behind binary blobs.

I tend myself to go for a simpler reason which is that unlike TOE which
is a supposed performance improvement on already working hardware with a
huge impact on the linux TCP stack, MSIs "a-la-rtas" are a fairly low
impact on an overall small piece of code to support, and not doing so
means basically totally unuseable machines as soon as MSI-only PCIe
stuff shows up (and it does exist already).

Ben. 
