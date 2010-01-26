Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-01.bluehost.com (outbound-mail-01.bluehost.com
	[69.89.21.11]) by ozlabs.org (Postfix) with SMTP id 5DEF8B7C09
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 12:57:16 +1100 (EST)
Date: Mon, 25 Jan 2010 17:50:25 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC PATCH] PCI-E broken on PPC (regression)
Message-ID: <20100125175025.4c74f412@jbarnes-piketon>
In-Reply-To: <20100125123849.111fa2d1@jbarnes-piketon>
References: <4B5D9FC5.5070600@linux.vnet.ibm.com>
	<20100125123849.111fa2d1@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 25 Jan 2010 12:38:49 -0800
Jesse Barnes <jbarnes@virtuousgeek.org> wrote:

> On Mon, 25 Jan 2010 11:42:29 -0200
> Breno Leitao <leitao@linux.vnet.ibm.com> wrote:
> 
> > Hello, 
> > 
> > I found that qlge is broken on PPC, and it got broken after commit 
> > 06a1cbafb253c4c60d6a54a994887f5fbceabcc0. It happens because
> > dev->pcie is not set on PPC, because the function
> > set_pcie_port_type(), who sets dev->pcie, is not being called on PPC
> > PCI code.
> 
> You mean dev->is_pcie?
> 
> Why isn't pci_scan_device calling pci_setup_device for you?  That
> should do the proper PCIe init depending on the device, along with
> extracting other device info...

Cc'ing Ben for PPC.  Ben, should PPC use pci_scan_device when probing
its root busses?  Sounds like it just uses pci_device_add for each one
it finds instead?

If you don't actually need scanning (though what about hotplug?) we can
move the call to device_add instead...

-- 
Jesse Barnes, Intel Open Source Technology Center
