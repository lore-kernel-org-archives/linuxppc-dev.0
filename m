Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 593A61A054D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 20:43:05 +1000 (EST)
Received: by mail-lb0-f179.google.com with SMTP id p9so714474lbv.24
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Sep 2014 03:43:01 -0700 (PDT)
Message-ID: <540993B3.1000701@cogentembedded.com>
Date: Fri, 05 Sep 2014 14:42:59 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 09/21] Irq_remapping/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-10-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1409911806-10519-10-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Xinwei Hu <huxinwei@huawei.com>,
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

Hello.

On 9/5/2014 2:09 PM, Yijing Wang wrote:

> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>   drivers/iommu/irq_remapping.c |    8 +++++++-
>   1 files changed, 7 insertions(+), 1 deletions(-)

> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> index 33c4395..e75026e 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
[...]
> @@ -165,9 +170,10 @@ static void __init irq_remapping_modify_x86_ops(void)
>   	x86_io_apic_ops.set_affinity	= set_remapped_irq_affinity;
>   	x86_io_apic_ops.setup_entry	= setup_ioapic_remapped_entry;
>   	x86_io_apic_ops.eoi_ioapic_pin	= eoi_ioapic_pin_remapped;
> -	x86_msi.setup_msi_irqs		= irq_remapping_setup_msi_irqs;
> +	x86_msi.setup_msi_irqs          = irq_remapping_setup_msi_irqs;

    AFAICS, this change only converts tabs to spaces, so not needed at all.

>   	x86_msi.setup_hpet_msi		= setup_hpet_msi_remapped;
>   	x86_msi.compose_msi_msg		= compose_remapped_msi_msg;
> +	x86_msi_chip = &remap_msi_chip;

    Please align = with the rest of assignments.

WBR, Sergei
