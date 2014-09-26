Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB9A21A0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 12:11:24 +1000 (EST)
Message-ID: <5424CB0F.2030406@huawei.com>
Date: Fri, 26 Sep 2014 10:10:23 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 06/22] PCI/MSI: Introduce weak arch_find_msi_chip()
 to find MSI chip
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-7-git-send-email-wangyijing@huawei.com>
 <20140925072619.GI12423@ulmo>
In-Reply-To: <20140925072619.GI12423@ulmo>
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

On 2014/9/25 15:26, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 11:14:16AM +0800, Yijing Wang wrote:
>> Introduce weak arch_find_msi_chip() to find the match msi_chip.
>> Currently, MSI chip associates pci bus to msi_chip. Because in
>> ARM platform, there may be more than one MSI controller in system.
>> Associate pci bus to msi_chip help pci device to find the match
>> msi_chip and setup MSI/MSI-X irq correctly. But in other platform,
>> like in x86. we only need one MSI chip, because all device use
>> the same MSI address/data and irq etc. So it's no need to associate
>> pci bus to MSI chip, just use a arch function, arch_find_msi_chip()
>> to return the MSI chip for simplicity. The default weak
>> arch_find_msi_chip() used in ARM platform, find the MSI chip
>> by pci bus.
> 
> Can't x86 simply set the bus' .msi field anyway? It would seem to be
> easy to do and unifies the code rather than driving it further apart
> using even more of the __weak functions.

As mentioned in the first reply, I will rework this one when we find a better solution.

Thanks!
Yijing.

> 
> Thierry
> 


-- 
Thanks!
Yijing
