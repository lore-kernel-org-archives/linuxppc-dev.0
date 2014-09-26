Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06B321A009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 11:55:58 +1000 (EST)
Message-ID: <5424C77B.2060807@huawei.com>
Date: Fri, 26 Sep 2014 09:55:07 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 02/22] PCI/MSI: Remove useless bus->msi assignment
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-3-git-send-email-wangyijing@huawei.com>
 <20140925070601.GF12423@ulmo>
In-Reply-To: <20140925070601.GF12423@ulmo>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>,
 Bharat.Bhushan@freescale.com, sparclinux@vger.kernel.org,
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

On 2014/9/25 15:06, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 11:14:12AM +0800, Yijing Wang wrote:
>> Currently, PCI drivers will initialize bus->msi in
>> pcibios_add_bus(). pcibios_add_bus() will be called
>> in every pci bus initialization. So the bus->msi
>> assignment in pci_alloc_child_bus() is useless.
> 
> I think this should be the other way around. The default should be to
> inherit bus->msi from the parent. That way drivers don't typically have
> to do it, yet they can still opt to override it if they need to.
> 
> For Tegra for example I think it would work if we assigned the MSI chip
> to the root bus (in tegra_pcie_scan_bus()) and then have it propagated
> to child busses in pci_alloc_child_bus() so that tegra_pcie_add_bus()
> can be removed altogether.

Hi Thierry, thanks very much for your review and comments!

Because pcibios_add_bus() and "child->msi = parent->msi;" in pci_alloc_child_bus()
do the same thing. So I think we should use one and remove another. I like
the latter.

In addition, I consider several solutions to associate msi chip and PCI device.

1. Add a msi_chip member in PCI arch sysdata to store the msi_chip pointer. Because
all PCI devices under a PCI hostbridge always share the same msi chip, so every PCI device
can find the msi chip by pci_bus->sysdata, but in this solution, we also need to add
ARCH specific functions to extract msi chip from PCI arch sysdata, like pci_domain_nr().
Then we can remove .add_bus() like tegra_pcie_add_bus() and the msi assignment in  pci_alloc_child_bus().

2. Remove .add_bus() functions, associate PCI root bus and msi chip after PCI root bus created,
as you mentioned above. In this solution we need to associate PCI root bus and msi chip in all PCI
hostbridge drivers, like in tegra_pcie_scan_bus().


3. Introduce a global msi chip list, currently, only in arm, there maybe more than one type MSI chip,
but in arm, we can find msi chip by PCI hostbridge platform device's of_node, Eg. use "msi-parent" property
to find it. Or msi chip is integrated into PCI hostbridge, we can find msi chip by compare msi_chip->dev and
PCI hostbridge's platform device's struct device *dev pointer. And because PCI hostbridge platform device pass
to pci_create_root_bus() as the parent device, so every PCI devices can first find the platform device, then
to find the msi chip, this solution looks a bit ugly, but we only associate pci hostbridge and msi chip, PCI child
buses and devices do not have to know the msi chip details.

4. Last, in this series, introduced weak arch function arch_find_msi_chip(), it's the simplest one, because all platforms
except arm, only one msi chip will exist in system.

What do you think about this ?

Thanks!
Yijing.

> 
> Thierry
> 


-- 
Thanks!
Yijing
