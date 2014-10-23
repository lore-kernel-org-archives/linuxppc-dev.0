Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com
 [IPv6:2607:f8b0:4001:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BA4D1A0064
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 16:18:37 +1100 (AEDT)
Received: by mail-ie0-f178.google.com with SMTP id rl12so293276iec.37
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 22:18:34 -0700 (PDT)
Date: Wed, 22 Oct 2014 23:18:31 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v3 05/27] PCI: tegra: Save msi chip in pci_sys_data
Message-ID: <20141023051831.GB11770@google.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-6-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413342435-7876-6-git-send-email-wangyijing@huawei.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Thierry Reding <thierry.reding@gmail.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Liviu Dudau <liviu@dudau.co.uk>, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Oct 15, 2014 at 11:06:53AM +0800, Yijing Wang wrote:
> Save msi chip in pci_sys_data instead of assign
> msi chip to every pci bus in .add_bus().
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/host/pci-tegra.c |   13 +++----------
>  1 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 3d43874..5af0525 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -694,15 +694,6 @@ static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  	return irq;
>  }
>  
> -static void tegra_pcie_add_bus(struct pci_bus *bus)
> -{
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
> -
> -		bus->msi = &pcie->msi.chip;
> -	}
> -}
> -
>  static struct pci_bus *tegra_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  {
>  	struct tegra_pcie *pcie = sys_to_pcie(sys);
> @@ -1881,11 +1872,13 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
>  
>  	memset(&hw, 0, sizeof(hw));
>  
> +#ifdef CONFIG_PCI_MSI
> +	hw.msi_chip = &pcie->msi.chip;
> +#endif

Why did you use "#ifdef CONFIG_PCI_MSI" instead of the
"IS_ENABLED(CONFIG_PCI_MSI)" used previously?

It's true that CONFIG_PCI_MSI will never be a tristate symbol, so we don't
really *need* the extra smarts of IS_ENABLED(), but I'm fairly sympathetic
to James' argument [1] that we should just use IS_ENABLED() all the time
because it's simpler overall.

If you want to change the #ifdef to IS_ENABLED(), that should be a separate
patch from your msi_chip change, and we can debate the merits of that by
itself.

[1] http://lkml.iu.edu//hypermail/linux/kernel/1204.3/00081.html

>  	hw.nr_controllers = 1;
>  	hw.private_data = (void **)&pcie;
>  	hw.setup = tegra_pcie_setup;
>  	hw.map_irq = tegra_pcie_map_irq;
> -	hw.add_bus = tegra_pcie_add_bus;
>  	hw.scan = tegra_pcie_scan_bus;
>  	hw.ops = &tegra_pcie_ops;
>  
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
