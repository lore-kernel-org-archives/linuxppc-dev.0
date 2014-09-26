Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 101171A0026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 13:43:15 +1000 (EST)
Message-ID: <5424E09F.50701@huawei.com>
Date: Fri, 26 Sep 2014 11:42:23 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>, Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo> <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo>
In-Reply-To: <20140925164937.GB30382@ulmo>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>, Sergei
 Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 David Vrabel <david.vrabel@citrix.com>, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> I am actually in disagreement with you, Thierry. I don't like the general direction
>> of the patches, or at least I don't like the fact that we don't have a portable
>> way of setting up the msi_chip without having to rely on weak architectural hooks.
> 
> Oh, good. That's actually one of the things I said I wasn't happy with
> either. =)

Hm, I decide to drop weak arch_find_msi_chip(), no one likes it.
Let's find a better solution :)

> 
>> I'm surprised no one considers the case of a platform having more than one host
>> bridge and possibly more than one MSI unit. With the current proposed patchset I
>> can't see how that would work.
> 
> The PCI core can already deal with that. An MSI chip can be set per bus
> and the weak pcibios_add_bus() can be used to set that. Often it might
> not even be necessary to do it via pcibios_add_bus() if you create the
> root bus directly, since you can attach the MSI chip at that time.

Yes, PCI hostbridge driver find the matched msi chip during its initialization,
and assign the msi chip to PCI bus in pcibios_add_bus().

> 
>> What I would like to see is a way of creating the pci_host_bridge structure outside
>> the pci_create_root_bus(). That would then allow us to pass this sort of platform
>> details like associated msi_chip into the host bridge and the child busses will
>> have an easy way of finding the information needed by finding the root bus and then
>> the host bridge structure. Then the generic pci_scan_root_bus() can be used by (mostly)
>> everyone and the drivers can remove their kludges that try to work around the
>> current limitations.

So I think maybe save msi chip in PCI arch sysdata is a good candidate.

> 
> I think both issues are orthogonal. Last time I checked a lot of work
> was still necessary to unify host bridges enough so that it could be
> shared across architectures. But perhaps some of that work has
> happened in the meantime.
> 
> But like I said, when you create the root bus, you can easily attach the
> MSI chip to it.
> 
> Thierry
> 


-- 
Thanks!
Yijing
