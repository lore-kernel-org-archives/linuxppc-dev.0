Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8610BB7C8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 13:59:58 +1100 (EST)
Subject: Re: [RFC PATCH] PCI-E broken on PPC (regression)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <20100125175025.4c74f412@jbarnes-piketon>
References: <4B5D9FC5.5070600@linux.vnet.ibm.com>
	<20100125123849.111fa2d1@jbarnes-piketon>
	<20100125175025.4c74f412@jbarnes-piketon>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 26 Jan 2010 13:59:31 +1100
Message-ID: <1264474771.3601.110.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jay Vosburgh <fubar@us.ibm.com>,
	Ron Mercer <ron.mercer@qlogic.com>,
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

On Mon, 2010-01-25 at 17:50 -0800, Jesse Barnes wrote:
> > You mean dev->is_pcie?
> > 
> > Why isn't pci_scan_device calling pci_setup_device for you?  That
> > should do the proper PCIe init depending on the device, along with
> > extracting other device info...
> 
> Cc'ing Ben for PPC.  Ben, should PPC use pci_scan_device when probing
> its root busses?  Sounds like it just uses pci_device_add for each one
> it finds instead?
> 
> If you don't actually need scanning (though what about hotplug?) we can
> move the call to device_add instead...

I need to give it more brain cells than I have available today :-) I'll
have a look tomorrow. In some case we build the PCI stuff up from the
firmware device-tree without actually doing any config space scanning,
so the root busses are treated a bit special.

Cheers,
Ben.
