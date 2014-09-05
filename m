Return-Path: <david.vrabel@citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34CB71A011C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 00:29:29 +1000 (EST)
Message-ID: <5409C8C0.8020200@citrix.com>
Date: Fri, 5 Sep 2014 15:29:20 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Xen-devel] [PATCH v1 08/21] x86/xen/MSI: Use MSI chip framework
 to configure MSI/MSI-X irq
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-9-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1409911806-10519-9-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Bharat.Bhushan@freescale.com,
 Tony Luck <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/09/14 11:09, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
[...]
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
[...]
> @@ -418,9 +430,9 @@ int __init pci_xen_init(void)
>  #endif
>  
>  #ifdef CONFIG_PCI_MSI
> -	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
> -	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
> -	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
> +	xen_msi_chip.setup_irqs = xen_setup_msi_irqs;
> +	xen_msi_chip.teardown_irqs = xen_teardown_msi_irqs;
> +	x86_msi_chip = &xen_msi_chip;
>  	msi_chip.irq_mask = xen_nop_msi_mask;
>  	msi_chip.irq_unmask = xen_nop_msi_mask;

Why have these not been changed to set the x86_msi_chip.mask/unmask
fields instead?

David
