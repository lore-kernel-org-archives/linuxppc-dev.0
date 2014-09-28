Return-Path: <liviu@dudau.co.uk>
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
 by lists.ozlabs.org (Postfix) with ESMTP id EE3551A011B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Sep 2014 21:22:19 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by smtp.dudau.co.uk (Postfix) with SMTP id 92E471002EC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Sep 2014 12:22:17 +0100 (BST)
Date: Sun, 28 Sep 2014 12:21:45 +0100
From: Liviu Dudau <liviu@dudau.co.uk>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
Message-ID: <20140928112144.GA4671@bart.dudau.co.uk>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo>
 <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo> <5424E09F.50701@huawei.com>
 <20140926085030.GE31157@bart.dudau.co.uk>
 <54276F6C.5010705@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <54276F6C.5010705@huawei.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Thierry Reding <thierry.reding@gmail.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, David Vrabel <david.vrabel@citrix.com>,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 28, 2014 at 10:16:12AM +0800, Yijing Wang wrote:
> >>>> What I would like to see is a way of creating the pci_host_bridge structure outside
> >>>> the pci_create_root_bus(). That would then allow us to pass this sort of platform
> >>>> details like associated msi_chip into the host bridge and the child busses will
> >>>> have an easy way of finding the information needed by finding the root bus and then
> >>>> the host bridge structure. Then the generic pci_scan_root_bus() can be used by (mostly)
> >>>> everyone and the drivers can remove their kludges that try to work around the
> >>>> current limitations.
> >>
> >> So I think maybe save msi chip in PCI arch sysdata is a good candidate.
> > 
> > Except that arch sysdata at the moment is an opaque pointer. I am all in favour in
> > changing the type of sysdata from void* into pci_host_bridge* and arches can wrap their old
> > sysdata around the pci_host_bridge*.
> 
> I inspected every arch and found there are almost no common stuff,

I will disagree here. Most (all?) of the structures that are passed as sysdata argument to
pci_create_root_bus() or pci_scan_root_bus() have a set of resources for storing the MEM and
IO ranges, which struct pci_host_bridge already has. So that can be factored out of the
arch code. Same for pci_domain_nr. Then there are some variables that are used for communication
with the platform code due to convoluted way(s) in which PCI code gets instantiated.

What I am arguing here is not that the arch equivalent of pci_host_bridge structure is already
common, but that by moving the members that are common out of arch sysdata into pci_host_bridge
we will have more commonality and it will be easier to re-factor the code.

> and generic data struct should
> be created in generic PCI code.

Not necessarily. What I have in mind is something like this:

 - drivers/pci/ exports pci_init_host_bridge() that does the initialisation of bridge->windows
   and anything else that is needed (like find_pci_host_bridge() function).
 - arch code does:

	struct pci_controller {
		struct pci_host_bridge bridge;
		.....
	};

	#define to_pci_controller(bridge)	container_of(bridge, struct pci_controller, bridge)

	static inline struct pci_controller *get_host_controller(const struct pci_bus *bus)
	{
		struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
		if (bridge)
			return to_pci_controller(bridge);

		return NULL;
	}

	int arch_pci_init(....)
	{
		struct pci_controller *hose;
		....
		hose = kzalloc(sizeof(*hose), GFP_KERNEL);
		pci_init_host_bridge(&hose->bridge);
		....
		pci_scan_root_bus(...., &hose->bridge, &resources);
		....
		return 0;
	}

Then finding the right structure will be easy.

> Another, I don't like associate msi chip and every PCI device, further more,
> almost all platforms except arm have only one MSI controller, and currently, PCI enumerating code doesn't need
> to know the MSI chip details, like for legacy IRQ, PCI device doesn't need to know which IRQ controller they
> should deliver IRQ to. I would think more about it, and hope other PCI guys can give some comments, especially from Bjorn.
>

I wasn't suggesing to associate an msi chip with every PCI device, but with the pci_host_bridge.
I don't expect a host bridge to have more than one msi chip, so that should be OK. Also, I'm
thinking that getting the associated msi chip should be some sort of pci_host_bridge ops function,
and for arches that don't care about MSI it doesn't get implemented.

Best regards,
Liviu

 
> Thanks!
> Yijing.
> 
> > 
> > Best regards,
> > Liviu
> > 
> >>
> >>>
> >>> I think both issues are orthogonal. Last time I checked a lot of work
> >>> was still necessary to unify host bridges enough so that it could be
> >>> shared across architectures. But perhaps some of that work has
> >>> happened in the meantime.
> >>>
> >>> But like I said, when you create the root bus, you can easily attach the
> >>> MSI chip to it.
> >>>
> >>> Thierry
> >>>
> >>
> >>
> >> -- 
> >> Thanks!
> >> Yijing
> >>
> >>
> > 
> 
> 
> -- 
> Thanks!
> Yijing
> 
> 

-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...
