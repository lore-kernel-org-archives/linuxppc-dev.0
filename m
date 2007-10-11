Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0EF7BDDFCB
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:20:20 +1000 (EST)
Date: Thu, 11 Oct 2007 00:25:35 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/7] [POWERPC] remove iSeries_vio_dev
Message-ID: <20071011052535.GA578@lixom.net>
References: <20071011144824.a5e3de59.sfr@canb.auug.org.au>
	<20071011145055.1de13742.sfr@canb.auug.org.au>
	<20071011145332.e3638c2e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071011145332.e3638c2e.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stephen,

On Thu, Oct 11, 2007 at 02:53:32PM +1000, Stephen Rothwell wrote:
> It was only being used to carry around dma_iommu_ops and vio_iommu_table
> which we can use directly instead.  This also means that vio_bus_device
> doesn't need to refer to them either.
> 
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index fd631d4..eaf7f69 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -49,11 +49,8 @@ static struct vio_dev vio_bus_device  = { /* fake "parent" device */
>  };
>  
>  #ifdef CONFIG_PPC_ISERIES
> -struct device *iSeries_vio_dev = &vio_bus_device.dev;
> -EXPORT_SYMBOL(iSeries_vio_dev);
> -
>  static struct iommu_table veth_iommu_table;
> -static struct iommu_table vio_iommu_table;
> +struct iommu_table vio_iommu_table;
>  
>  static void __init iommu_vio_init(void)
>  {
> @@ -66,8 +63,6 @@ static void __init iommu_vio_init(void)
>  		printk("Virtual Bus VETH TCE table failed.\n");
>  	if (!iommu_init_table(&vio_iommu_table, -1))
>  		printk("Virtual Bus VIO TCE table failed.\n");
> -	vio_bus_device.dev.archdata.dma_ops = &dma_iommu_ops;
> -	vio_bus_device.dev.archdata.dma_data = &vio_iommu_table;
>  }
>  #else
>  static void __init iommu_vio_init(void)
> diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
> index 3b6a966..3281f10 100644
> --- a/arch/powerpc/platforms/iseries/iommu.c
> +++ b/arch/powerpc/platforms/iseries/iommu.c
> @@ -28,6 +28,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/list.h>
>  #include <linux/pci.h>
> +#include <linux/module.h>
>  
>  #include <asm/iommu.h>
>  #include <asm/tce.h>
> @@ -36,6 +37,7 @@
>  #include <asm/prom.h>
>  #include <asm/pci-bridge.h>
>  #include <asm/iseries/hv_call_xm.h>
> +#include <asm/iseries/hv_call_event.h>
>  #include <asm/iseries/iommu.h>
>  
>  static void tce_build_iSeries(struct iommu_table *tbl, long index, long npages,
> @@ -189,6 +191,34 @@ void iommu_devnode_init_iSeries(struct pci_dev *pdev, struct device_node *dn)
>  }
>  #endif
>  
> +extern struct iommu_table vio_iommu_table;

This looks like it really should go in a header file
instead. include/asm-powerpc/vio.h perhaps?



-Olof
