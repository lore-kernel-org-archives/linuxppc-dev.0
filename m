Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB3851A09AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 20:39:13 +1000 (EST)
Date: Fri, 26 Sep 2014 12:38:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 06/22] PCI/MSI: Introduce weak arch_find_msi_chip()
 to find MSI chip
In-Reply-To: <5424D30A.6040900@huawei.com>
Message-ID: <alpine.DEB.2.11.1409261236160.4567@nanos>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-7-git-send-email-wangyijing@huawei.com>
 <alpine.DEB.2.10.1409251220570.4604@nanos> <5424D30A.6040900@huawei.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Thierry Reding <thierry.reding@gmail.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org,
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

On Fri, 26 Sep 2014, Yijing Wang wrote:
> On 2014/9/25 18:38, Thomas Gleixner wrote:
> > On Thu, 25 Sep 2014, Yijing Wang wrote:
> > 
> >> Introduce weak arch_find_msi_chip() to find the match msi_chip.
> >> Currently, MSI chip associates pci bus to msi_chip. Because in
> >> ARM platform, there may be more than one MSI controller in system.
> >> Associate pci bus to msi_chip help pci device to find the match
> >> msi_chip and setup MSI/MSI-X irq correctly. But in other platform,
> >> like in x86. we only need one MSI chip, because all device use
> >> the same MSI address/data and irq etc. So it's no need to associate
> >> pci bus to MSI chip, just use a arch function, arch_find_msi_chip()
> >> to return the MSI chip for simplicity. The default weak
> >> arch_find_msi_chip() used in ARM platform, find the MSI chip
> >> by pci bus.
> > 
> > This is really backwards. On one hand you try to get rid of the weak
> > arch functions zoo and then you invent new ones for no good
> > reason. Why can't x86 store the chip in the pci bus?
> > 
> > Looking deeper, I'm questioning the whole notion of different
> > msi_chips. Are this really different MSI controllers with a different
> > feature set or are this defacto multiple instances of the same
> > controller which just need a different data set?
> 
> MSI chip in this series is to setup MSI irq, including IRQ allocation, Map,
> compose MSI msg ..., in different platform, many arch specific MSI irq details in it.
> It's difficult to extract the common data and code.
> 
> I have a plan to rework MSI related irq_chips in kernel, PCI and Non-PCI, currently,
> HPET, DMAR and PCI have their own irq_chip and MSI related functions, write_msi_msg(),
> mask_msi_irq(), etc... I want to extract the common data set for that, so we can
> remove lots of unnecessary MSI code.

That makes sense. Can you please make sure that this does not conflict
with the ongoing work Jiang is doing in the x86 irq area with
hierarchical irqdomains to distangle layered levels like MSI from the
underlying vector/irqremap mechanics.

Thanks,

	tglx
