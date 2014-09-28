Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (unknown [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 607691A007F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Sep 2014 12:17:26 +1000 (EST)
Message-ID: <54276F6C.5010705@huawei.com>
Date: Sun, 28 Sep 2014 10:16:12 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo> <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo> <5424E09F.50701@huawei.com>
 <20140926085030.GE31157@bart.dudau.co.uk>
In-Reply-To: <20140926085030.GE31157@bart.dudau.co.uk>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Thierry Reding <thierry.reding@gmail.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Arnd Bergmann <arnd@arndb.de>, Konrad
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

>>>> What I would like to see is a way of creating the pci_host_bridge structure outside
>>>> the pci_create_root_bus(). That would then allow us to pass this sort of platform
>>>> details like associated msi_chip into the host bridge and the child busses will
>>>> have an easy way of finding the information needed by finding the root bus and then
>>>> the host bridge structure. Then the generic pci_scan_root_bus() can be used by (mostly)
>>>> everyone and the drivers can remove their kludges that try to work around the
>>>> current limitations.
>>
>> So I think maybe save msi chip in PCI arch sysdata is a good candidate.
> 
> Except that arch sysdata at the moment is an opaque pointer. I am all in favour in
> changing the type of sysdata from void* into pci_host_bridge* and arches can wrap their old
> sysdata around the pci_host_bridge*.

I inspected every arch and found there are almost no common stuff, and generic data struct should
be created in generic PCI code. Another, I don't like associate msi chip and every PCI device, further more,
almost all platforms except arm have only one MSI controller, and currently, PCI enumerating code doesn't need
to know the MSI chip details, like for legacy IRQ, PCI device doesn't need to know which IRQ controller they
should deliver IRQ to. I would think more about it, and hope other PCI guys can give some comments, especially from Bjorn.

Thanks!
Yijing.

> 
> Best regards,
> Liviu
> 
>>
>>>
>>> I think both issues are orthogonal. Last time I checked a lot of work
>>> was still necessary to unify host bridges enough so that it could be
>>> shared across architectures. But perhaps some of that work has
>>> happened in the meantime.
>>>
>>> But like I said, when you create the root bus, you can easily attach the
>>> MSI chip to it.
>>>
>>> Thierry
>>>
>>
>>
>> -- 
>> Thanks!
>> Yijing
>>
>>
> 


-- 
Thanks!
Yijing
