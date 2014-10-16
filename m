Return-Path: <sebott@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C26FE1A02BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 23:13:40 +1100 (AEDT)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sebott@linux.vnet.ibm.com>;
 Thu, 16 Oct 2014 13:13:36 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 918041B08023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 13:14:52 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9GCDXXt15663506
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 12:13:33 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9GCDNmM023917
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 06:13:33 -0600
Date: Thu, 16 Oct 2014 14:13:20 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v3 22/27] s390/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
In-Reply-To: <1413342435-7876-23-git-send-email-wangyijing@huawei.com>
Message-ID: <alpine.LFD.2.11.1410161411340.1575@denkbrett>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-23-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Thierry Reding <thierry.reding@gmail.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Liviu Dudau <liviu@dudau.co.uk>, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
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

On Wed, 15 Oct 2014, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
> Hi Sebastian,
>    I dropped the Acked-by , because this version has a
> lot changes compared to last. So, I guess you may want to check it again.

I did and I agree with that one too.

Regards,
Sebastian

> ---
>  arch/s390/include/asm/pci.h |    9 +++++++++
>  arch/s390/pci/pci.c         |   12 ++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index c030900..4d41f08 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -88,6 +88,8 @@ struct zpci_dev {
>  	u32 uid;			/* user defined id */
>  	u8 util_str[CLP_UTIL_STR_LEN];	/* utility string */
> 
> +	struct msi_chip *msi_chip;
> +
>  	/* IRQ stuff */
>  	u64		msi_addr;	/* MSI address */
>  	struct airq_iv *aibv;		/* adapter interrupt bit vector */
> @@ -121,6 +123,13 @@ struct zpci_dev {
>  	struct dentry	*debugfs_perf;
>  };
> 
> +static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
> +{
> +	struct zpci_dev *zpci = bus->sysdata;
> +
> +	return zpci->msi_chip;
> +}
> +
>  static inline bool zdev_enabled(struct zpci_dev *zdev)
>  {
>  	return (zdev->fh & (1UL << 31)) ? true : false;
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 552b990..bf6732f 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -358,7 +358,8 @@ static void zpci_irq_handler(struct airq_struct *airq)
>  	}
>  }
> 
> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> +static int zpci_setup_msi_irqs(struct msi_chip *chip,
> +		struct pci_dev *pdev, int nvec, int type)
>  {
>  	struct zpci_dev *zdev = get_zdev(pdev);
>  	unsigned int hwirq, msi_vecs;
> @@ -434,7 +435,8 @@ out:
>  	return rc;
>  }
> 
> -void arch_teardown_msi_irqs(struct pci_dev *pdev)
> +static void zpci_teardown_msi_irqs(struct msi_chip *chip,
> +		struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev = get_zdev(pdev);
>  	struct msi_desc *msi;
> @@ -464,6 +466,11 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
>  	airq_iv_free_bit(zpci_aisb_iv, zdev->aisb);
>  }
> 
> +static struct msi_chip zpci_msi_chip = {
> +	.setup_irqs = zpci_setup_msi_irqs,
> +	.teardown_irqs = zpci_teardown_msi_irqs,
> +};
> +
>  static void zpci_map_resources(struct zpci_dev *zdev)
>  {
>  	struct pci_dev *pdev = zdev->pdev;
> @@ -749,6 +756,7 @@ static int zpci_scan_bus(struct zpci_dev *zdev)
>  	if (ret)
>  		return ret;
> 
> +	zdev->msi_chip = &zpci_msi_chip;
>  	zdev->bus = pci_scan_root_bus(NULL, ZPCI_BUS_NR, &pci_root_ops,
>  				      zdev, &resources);
>  	if (!zdev->bus) {
> -- 
> 1.7.1
> 
> 
