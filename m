Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 402CC2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 10:36:08 +1100 (EST)
Received: by mail-ie0-f173.google.com with SMTP id to1so7805727ieb.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Nov 2013 15:36:05 -0800 (PST)
Date: Mon, 25 Nov 2013 16:36:02 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Bharat Bhushan <r65777@freescale.com>
Subject: Re: [PATCH 1/9 v2] pci:msi: add weak function for returning msi
 region info
Message-ID: <20131125233602.GA4066@google.com>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1384838233-24847-2-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384838233-24847-2-git-send-email-Bharat.Bhushan@freescale.com>
Cc: linux-pci@vger.kernel.org, joro@8bytes.org, stuart.yoder@freescale.com,
 iommu@lists.linux-foundation.org, agraf@suse.de,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>, alex.williamson@redhat.com,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 19, 2013 at 10:47:05AM +0530, Bharat Bhushan wrote:
> In Aperture type of IOMMU (like FSL PAMU), VFIO-iommu system need to know
> the MSI region to map its window in h/w. This patch just defines the
> required weak functions only and will be used by followup patches.
> 
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
> v1->v2
>  - Added description on "struct msi_region" 
> 
>  drivers/pci/msi.c   |   22 ++++++++++++++++++++++
>  include/linux/msi.h |   14 ++++++++++++++
>  2 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d5f90d6..2643a29 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -67,6 +67,28 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
>  	return chip->check_device(chip, dev, nvec, type);
>  }
>  
> +int __weak arch_msi_get_region_count(void)
> +{
> +	return 0;
> +}
> +
> +int __weak arch_msi_get_region(int region_num, struct msi_region *region)
> +{
> +	return 0;
> +}
> +
> +int msi_get_region_count(void)
> +{
> +	return arch_msi_get_region_count();
> +}
> +EXPORT_SYMBOL(msi_get_region_count);
> +
> +int msi_get_region(int region_num, struct msi_region *region)
> +{
> +	return arch_msi_get_region(region_num, region);
> +}
> +EXPORT_SYMBOL(msi_get_region);
> +
>  int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
>  	struct msi_desc *entry;
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index b17ead8..ade1480 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -51,6 +51,18 @@ struct msi_desc {
>  };
>  
>  /*
> + * This structure is used to get
> + * - physical address
> + * - size
> + * of a msi region
> + */
> +struct msi_region {
> +	int region_num; /* MSI region number */
> +	dma_addr_t addr; /* Address of MSI region */
> +	size_t size; /* Size of MSI region */
> +};
> +
> +/*
>   * The arch hooks to setup up msi irqs. Those functions are
>   * implemented as weak symbols so that they /can/ be overriden by
>   * architecture specific code if needed.
> @@ -64,6 +76,8 @@ void arch_restore_msi_irqs(struct pci_dev *dev, int irq);
>  
>  void default_teardown_msi_irqs(struct pci_dev *dev);
>  void default_restore_msi_irqs(struct pci_dev *dev, int irq);
> +int arch_msi_get_region_count(void);
> +int arch_msi_get_region(int region_num, struct msi_region *region);

It doesn't look like any of this (struct msi_region, msi_get_region(),
msi_get_region_count()) is actually used by drivers/pci/msi.c, so I don't
think it needs to be declared in generic code.  It looks like it's only
used in drivers/vfio/vfio_iommu_fsl_pamu.c, where you already know you have
an FSL IOMMU, and you can just call FSL-specific interfaces directly.

Bjorn

>  
>  struct msi_chip {
>  	struct module *owner;
> -- 
> 1.7.0.4
> 
> 
