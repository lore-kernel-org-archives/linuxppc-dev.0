Return-Path: <konrad.wilk@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FC0E1A018F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 05:29:09 +1000 (EST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 s7CJBhGs029483
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 19:11:43 GMT
Date: Tue, 12 Aug 2014 15:09:47 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [RFC PATCH 07/20] x86/MSI: Use msi_chip instead of arch func to
 configure MSI/MSI-X
Message-ID: <20140812190947.GD13996@laptop.dumpdata.com>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
 <1407828373-24322-8-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407828373-24322-8-git-send-email-wangyijing@huawei.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <marc.zyngier@arm.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 12, 2014 at 03:26:00PM +0800, Yijing Wang wrote:
> Introduce a new struct msi_chip apic_msi_chip instead of weak arch
> functions to configure MSI/MSI-X in x86.

Why not 'x86_msi_ops' (see  arch/x86/kernel/x86_init.c)
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/x86/include/asm/pci.h     |    1 +
>  arch/x86/kernel/apic/io_apic.c |   20 ++++++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 0892ea0..878a06d 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -101,6 +101,7 @@ void native_teardown_msi_irq(unsigned int irq);
>  void native_restore_msi_irqs(struct pci_dev *dev);
>  int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
>  		  unsigned int irq_base, unsigned int irq_offset);
> +extern struct msi_chip *x86_msi_chip;
>  #else
>  #define native_setup_msi_irqs		NULL
>  #define native_teardown_msi_irq		NULL
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 2609dcd..eb8ab7c 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -3077,24 +3077,25 @@ int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
>  	return 0;
>  }
>  
> -int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +int native_setup_msi_irqs(struct device *dev, int nvec, int type)
>  {
>  	struct msi_desc *msidesc;
>  	unsigned int irq;
>  	int node, ret;
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  
>  	/* Multiple MSI vectors only supported with interrupt remapping */
>  	if (type == PCI_CAP_ID_MSI && nvec > 1)
>  		return 1;
>  
> -	node = dev_to_node(&dev->dev);
> +	node = dev_to_node(dev);
>  
> -	list_for_each_entry(msidesc, &dev->msi_list, list) {
> +	list_for_each_entry(msidesc, &pdev->msi_list, list) {
>  		irq = irq_alloc_hwirq(node);
>  		if (!irq)
>  			return -ENOSPC;
>  
> -		ret = setup_msi_irq(dev, msidesc, irq, 0);
> +		ret = setup_msi_irq(pdev, msidesc, irq, 0);
>  		if (ret < 0) {
>  			irq_free_hwirq(irq);
>  			return ret;
> @@ -3214,6 +3215,17 @@ int default_setup_hpet_msi(unsigned int irq, unsigned int id)
>  }
>  #endif
>  
> +struct msi_chip apic_msi_chip = {
> +	.setup_irqs = native_setup_msi_irqs,
> +	.teardown_irq = native_teardown_msi_irq,
> +};
> +
> +struct msi_chip *arch_get_match_msi_chip(struct device *dev)
> +{
> +	return x86_msi_chip;
> +}
> +
> +struct msi_chip *x86_msi_chip = &apic_msi_chip;
>  #endif /* CONFIG_PCI_MSI */
>  /*
>   * Hypertransport interrupt support
> -- 
> 1.7.1
> 
