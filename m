Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CAAD1DDE2E
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 06:48:53 +1100 (EST)
Subject: Re: [POWERPC 04/18] Set archdata.dma_data for direct DMA in
	cell_dma_dev_setup()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: arnd@arndb.de
In-Reply-To: <20071218175104.219782000@arndb.de>
References: <20071218174852.112644000@arndb.de>
	<20071218175104.219782000@arndb.de>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 06:48:34 +1100
Message-Id: <1198007314.18908.0.camel@pasglop>
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


On Tue, 2007-12-18 at 18:48 +0100, arnd@arndb.de wrote:
> plain text document attachment
> (0014-Set-archdata.dma_data-for-direct-DMA-in-cell_dma_dev.patch)
> Store a pointer to the direct_dma_offset in each device's dma_data
> in the case where we're using the direct DMA ops.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Ack.

> ---
>  arch/powerpc/platforms/cell/iommu.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6-new/arch/powerpc/platforms/cell/iommu.c
> ===================================================================
> --- linux-2.6-new.orig/arch/powerpc/platforms/cell/iommu.c
> +++ linux-2.6-new/arch/powerpc/platforms/cell/iommu.c
> @@ -496,9 +496,10 @@ static void cell_dma_dev_setup(struct de
>  	struct cbe_iommu *iommu;
>  	struct dev_archdata *archdata = &dev->archdata;
>  
> -	/* If we run without iommu, no need to do anything */
> -	if (get_pci_dma_ops() == &dma_direct_ops)
> +	if (get_pci_dma_ops() == &dma_direct_ops) {
> +		archdata->dma_data = &dma_direct_offset;
>  		return;
> +	}
>  
>  	/* Current implementation uses the first window available in that
>  	 * node's iommu. We -might- do something smarter later though it may
> 
