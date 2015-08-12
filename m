Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F6A81A0034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 13:19:56 +1000 (AEST)
In-Reply-To: <1438917500-12100-3-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Daniel Axtens <dja@axtens.net>, imunsie@au.ibm.com
Subject: Re: [3/4] cxl: sparse: Flag iomem pointers properly
Message-Id: <20150812031955.EACBD1401CD@ozlabs.org>
Date: Wed, 12 Aug 2015 13:19:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-08 at 03:18:19 UTC, Daniel Axtens wrote:
> Sparse identifies the following address space issues:
> /scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:125:17: warning: incorrect type in assignment (different address spaces)
> /scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:125:17:    expected void volatile [noderef] <asn:2>*<noident>
> /scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:125:17:    got void *<noident>
> /scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:220:23: warning: incorrect type in assignment (different address spaces)
> /scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:220:23:    expected void [noderef] <asn:2>*cfg_data
> /scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:220:23:    got void *<noident>

Please trim these to just the sub-path under linux, and a two space indent is nice:

  drivers/misc/cxl/vphb.c:220:23:    got void *<noident>

> Fix those by flagging __iomem in the relevant casts.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Acked-by: Michael Neuling <mikey@neuling.org>
> ---
>  drivers/misc/cxl/vphb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> index 2eba002b580b..a7b55772a91c 100644
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -122,7 +122,7 @@ static int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>  	addr = cxl_pcie_cfg_addr(phb, bus->number, devfn, offset);
>  
> -	*ioaddr = (void *)(addr & ~0x3ULL);
> +	*ioaddr = (void __iomem *)(addr & ~0x3ULL);

But shouldn't cxl_pcie_cfg_addr() be returning something that is __iomem ?

> @@ -217,7 +217,7 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
>  	/* Setup the PHB using arch provided callback */
>  	phb->ops = &cxl_pcie_pci_ops;
>  	phb->cfg_addr = afu->afu_desc_mmio + afu->crs_offset;
> -	phb->cfg_data = (void *)(u64)afu->crs_len;
> +	phb->cfg_data = (void __iomem *)(u64)afu->crs_len;

crs_len is already a u64 so that u64 cast is pointless.

cheers
