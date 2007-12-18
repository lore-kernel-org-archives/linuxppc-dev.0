Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F462DDF53
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 06:51:05 +1100 (EST)
Subject: Re: [POWERPC 08/18] Have celleb use its own dma_direct_offset variable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: arnd@arndb.de
In-Reply-To: <20071218175105.049114000@arndb.de>
References: <20071218174852.112644000@arndb.de>
	<20071218175105.049114000@arndb.de>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 06:50:49 +1100
Message-Id: <1198007449.18908.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-12-18 at 18:49 +0100, arnd@arndb.de wrote:
> plain text document attachment
> (0018-Have-celleb-use-its-own-dma_direct_offset-variable.patch)
> Rather than using the global variable, have celleb use its own variable to
> store the direct DMA offset.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Ack.

>  arch/powerpc/platforms/celleb/iommu.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6-new/arch/powerpc/platforms/celleb/iommu.c
> ===================================================================
> --- linux-2.6-new.orig/arch/powerpc/platforms/celleb/iommu.c
> +++ linux-2.6-new/arch/powerpc/platforms/celleb/iommu.c
> @@ -52,6 +52,8 @@ static int __init find_dma_window(u64 *i
>  	return 0;
>  }
>  
> +static unsigned long celleb_dma_direct_offset;
> +
>  static void __init celleb_init_direct_mapping(void)
>  {
>  	u64 lpar_addr, io_addr;
> @@ -69,13 +71,13 @@ static void __init celleb_init_direct_ma
>  				     ioid, DMA_FLAGS);
>  	}
>  
> -	dma_direct_offset = dma_base;
> +	celleb_dma_direct_offset = dma_base;
>  }
>  
>  static void celleb_dma_dev_setup(struct device *dev)
>  {
>  	dev->archdata.dma_ops = get_pci_dma_ops();
> -	dev->archdata.dma_data = &dma_direct_offset;
> +	dev->archdata.dma_data = &celleb_dma_direct_offset;
>  }
>  
>  static void celleb_pci_dma_dev_setup(struct pci_dev *pdev)
> 
