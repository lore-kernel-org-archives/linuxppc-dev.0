Return-Path: <l.stach@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 639041A0069
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 18:38:37 +1000 (EST)
Message-ID: <1411979850.2625.7.camel@pengutronix.de>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
From: Lucas Stach <l.stach@pengutronix.de>
To: Yijing Wang <wangyijing@huawei.com>
Date: Mon, 29 Sep 2014 10:37:30 +0200
In-Reply-To: <5427A6A0.5040703@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo> <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo> <20140925171612.GC31157@bart.dudau.co.uk>
 <542505B3.7040208@huawei.com> <20140926085430.GG31106@ulmo>
 <20140926090537.GH31106@ulmo> <54277327.6070500@huawei.com>
 <5427A6A0.5040703@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 Thierry Reding <thierry.reding@gmail.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 Bharat.Bhushan@freescale.com, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, David Vrabel <david.vrabel@citrix.com>,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Sonntag, den 28.09.2014, 14:11 +0800 schrieb Yijing Wang:
> On 2014/9/28 10:32, Yijing Wang wrote:
> > On 2014/9/26 17:05, Thierry Reding wrote:
> >> On Fri, Sep 26, 2014 at 10:54:32AM +0200, Thierry Reding wrote:
> >> [...]
> >>> At least for Tegra it's trivial to just hook it up in tegra_pcie_scan_bus()
> >>> directly (patch attached).
> >>
> >> Really attached this time.
> >>
> >> Thierry
> >>
> > 
> > It looks good to me, so I will update the arm pci hostbridge driver to assign
> > pci root bus the msi chip instead of current pcibios_add_bus(). But for other
> > platforms which only have a one msi chip, I will kept the arch_find_msi_chip()
> > temporarily for more comments, especially from Bjorn.
> 
> Oh, sorry, I found designware and rcar use pci_scan_root_bus(), so we can not simply
> assign msi chip to root bus in all host drivers's scan functions.

Designware will switch away from pci_scan_root_bus() in the 3.18 cycle
and I would think it would be no problem to to the same with rcar.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
