Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70782DDF6C
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 03:31:19 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l25GVwOJ020106
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2007 11:31:58 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l25GVDvr212370
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2007 11:31:13 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l25GVDMp011522
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2007 11:31:13 -0500
Subject: Re: [PATCH 2/6] [POWERPC] create and use get_pci_dma_ops(
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070304170241.816f9802.sfr@canb.auug.org.au>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<20070304170241.816f9802.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 05 Mar 2007 10:31:11 -0600
Message-Id: <1173112272.5877.5.camel@localhost>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-04-03 at 17:02 +1100, Stephen Rothwell wrote:
> This allows us to hide pci_dma_ops.
> 

<snippage>

> -EXPORT_SYMBOL(pci_dma_ops);

> +EXPORT_SYMBOL(get_pci_dma_ops);

should this one be EXPORT_SYMBOL_GPL(get_pci_dma_ops);
        
or is it grandfathered in because it is replacing and renaming
EXPORT_SYMBOL(pci_dma_ops);   ?
        
-Will
        
        
> +
>  static void fixup_broken_pcnet32(struct pci_dev* dev)
>  {
>  	if ((dev->class>>8 == PCI_CLASS_NETWORK_ETHERNET)) {
> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index d0e02ea..7c953cc 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -496,7 +496,7 @@ static void cell_dma_dev_setup(struct device *dev)
>  	struct dev_archdata *archdata = &dev->archdata;
> 
>  	/* If we run without iommu, no need to do anything */
> -	if (pci_dma_ops == &dma_direct_ops)
> +	if (get_pci_dma_ops() == &dma_direct_ops)
>  		return;
> 
>  	/* Current implementation uses the first window available in that
> @@ -530,7 +530,7 @@ static int cell_of_bus_notify(struct notifier_block *nb, unsigned long action,
>  		return 0;
> 
>  	/* We use the PCI DMA ops */
> -	dev->archdata.dma_ops = pci_dma_ops;
> +	dev->archdata.dma_ops = get_pci_dma_ops();
> 
>  	cell_dma_dev_setup(dev);
> 
> diff --git a/arch/powerpc/platforms/celleb/iommu.c b/arch/powerpc/platforms/celleb/iommu.c
> index fecc4ff..e94de6a 100644
> --- a/arch/powerpc/platforms/celleb/iommu.c
> +++ b/arch/powerpc/platforms/celleb/iommu.c
> @@ -80,7 +80,7 @@ static int celleb_of_bus_notify(struct notifier_block *nb,
>  	if (action != BUS_NOTIFY_ADD_DEVICE)
>  		return 0;
> 
> -	dev->archdata.dma_ops = pci_dma_ops;
> +	dev->archdata.dma_ops = get_pci_dma_ops();
> 
>  	return 0;
>  }
> diff --git a/include/asm-powerpc/pci.h b/include/asm-powerpc/pci.h
> index ebf31f1..ce0f13e 100644
> --- a/include/asm-powerpc/pci.h
> +++ b/include/asm-powerpc/pci.h
> @@ -71,17 +71,18 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>  #define PCI_DISABLE_MWI
> 
>  #ifdef CONFIG_PCI
> -extern struct dma_mapping_ops *pci_dma_ops;
> -
>  extern void set_pci_dma_ops(struct dma_mapping_ops *dma_ops);
> +extern struct dma_mapping_ops *get_pci_dma_ops(void);
> 
>  /* For DAC DMA, we currently don't support it by default, but
>   * we let 64-bit platforms override this.
>   */
>  static inline int pci_dac_dma_supported(struct pci_dev *hwdev,u64 mask)
>  {
> -	if (pci_dma_ops && pci_dma_ops->dac_dma_supported)
> -		return pci_dma_ops->dac_dma_supported(&hwdev->dev, mask);
> +	struct dma_mapping_ops *d = get_pci_dma_ops();
> +
> +	if (d && d->dac_dma_supported)
> +		return d->dac_dma_supported(&hwdev->dev, mask);
>  	return 0;
>  }
> 
> @@ -103,6 +104,7 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
>  }
>  #else	/* CONFIG_PCI */
>  #define set_pci_dma_ops(d)
> +#define get_pci_dma_ops()	NULL
>  #endif
> 
>  extern int pci_domain_nr(struct pci_bus *bus);
