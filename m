Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 401xgd31mDzDrFN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 16:18:05 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel] powerpc/npu: Do not try invalidating 32bit table
 when 64bit table is enabled
Date: Thu, 15 Mar 2018 16:18:02 +1100
Message-ID: <1946633.GlQphcvEDT@new-mexico>
In-Reply-To: <20180213055135.25639-1-aik@ozlabs.ru>
References: <20180213055135.25639-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I must admit I haven't really looked at the iommu_table_group code in depth so
don't fully understand it, but I was wondering why we don't hit this for NVLink1
as well?

The error that Skiboot is printing is because the requested page size doesn't
match expected so I guess there is a possibility the address might not meet the
required alignment (I don't know we don't just check that directly).

The reason you don't see this on NVLink1 is that we rely on the kernel to do the
TCE invalidate directly rather than via an OPAL call, and the kernel seems to do
less checking. So I wonder if there is a bug there as well (invalidate for a
mismatched page size/address alignment)? And wether this would also fix that?

- Alistair

On Tuesday, 13 February 2018 4:51:35 PM AEDT Alexey Kardashevskiy wrote:
> GPUs and the corresponding NVLink bridges get different PEs as they have
> separate translation validation entries (TVEs). We put these PEs to
> the same IOMMU group so they cannot be passed through separately.
> So the iommu_table_group_ops::set_window/unset_window for GPUs do set
> tables to the NPU PEs as well which means that iommu_table's list of
> attached PEs (iommu_table_group_link) has both GPU and NPU PEs linked.
> This list is used for TCE cache invalidation.
> 
> The problem is that NPU PE has just a single TVE and can be programmed
> to point to 32bit or 64bit windows while GPU PE has two (as any other PCI
> device). So we end up having an 32bit iommu_table struct linked to both
> PEs even though only the 64bit TCE table cache can be invalidated on NPU.
> And a relatively recent skiboot detects this and prints errors.
> 
> This changes GPU's iommu_table_group_ops::set_window/unset_window to make
> sure that NPU PE is only linked to the table actually used by the hardware.
> If there are two tables used by an IOMMU group, the NPU PE will use
> the last programmed one which with the current use scenarios is expected
> to be a 64bit one.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> Do we need BUG_ON(IOMMU_TABLE_GROUP_MAX_TABLES != 2)?
> 
> 
> This is an example for:
> 
> 0004:04:00.0 3D: NVIDIA Corporation Device 1db1 (rev a1)
> 0006:00:00.0 Bridge: IBM Device 04ea (rev 01)
> 0006:00:00.1 Bridge: IBM Device 04ea (rev 01)
> 
> Before the patch (npu2_tce_kill messages are from skiboot):
> 
> pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff pg=1000
> pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff pg=1000
> pci 0004:04     : [PE# 00] Setting up window#1 800000000000000..8000000ffffffff pg=10000
> pci 0006:00:00.0: [PE# 0d] Setting up window 800000000000000..8000000ffffffff pg=10000
> NPU6: npu2_tce_kill: Unexpected TCE size (got 0x1000 expected 0x10000)
> NPU6: npu2_tce_kill: Unexpected TCE size (got 0x1000 expected 0x10000)
> NPU6: npu2_tce_kill: Unexpected TCE size (got 0x1000 expected 0x10000)
> NPU6: npu2_tce_kill: Unexpected TCE size (got 0x1000 expected 0x10000)
> NPU6: npu2_tce_kill: Unexpected TCE size (got 0x1000 expected 0x10000)
> ...
> pci 0004:04     : [PE# 00] Removing DMA window #0
> pci 0006:00:00.0: [PE# 0d] Removing DMA window
> pci 0004:04     : [PE# 00] Removing DMA window #1
> pci 0006:00:00.0: [PE# 0d] Removing DMA window
> pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff pg=1000
> pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff pg=1000
> pci 0004:04     : [PE# 00] Setting up window#1 800000000000000..8000000ffffffff pg=10000
> pci 0006:00:00.0: [PE# 0d] Setting up window 800000000000000..8000000ffffffff pg=10000
> 
> After the patch (no errors here):
> 
> pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff pg=1000
> pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff pg=1000
> pci 0004:04     : [PE# 00] Setting up window#1 800000000000000..8000000ffffffff pg=10000
> pci 0006:00:00.0: [PE# 0d] Removing DMA window
> pci 0006:00:00.0: [PE# 0d] Setting up window 800000000000000..8000000ffffffff pg=10000
> pci 0004:04     : [PE# 00] Removing DMA window #0
> pci 0004:04     : [PE# 00] Removing DMA window #1
> pci 0006:00:00.0: [PE# 0d] Removing DMA window
> pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff pg=1000
> pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff pg=1000
> pci 0004:04     : [PE# 00] Setting up window#1 800000000000000..8000000ffffffff pg=10000
> pci 0006:00:00.0: [PE# 0d] Removing DMA window
> pci 0006:00:00.0: [PE# 0d] Setting up window 800000000000000..8000000ffffffff pg=10000
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 496e476..2f91815 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2681,14 +2681,23 @@ static struct pnv_ioda_pe *gpe_table_group_to_npe(
>  static long pnv_pci_ioda2_npu_set_window(struct iommu_table_group *table_group,
>  		int num, struct iommu_table *tbl)
>  {
> +	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
> +	int num2 = (num == 0) ? 1 : 0;
>  	long ret = pnv_pci_ioda2_set_window(table_group, num, tbl);
>  
>  	if (ret)
>  		return ret;
>  
> -	ret = pnv_npu_set_window(gpe_table_group_to_npe(table_group), num, tbl);
> -	if (ret)
> +	if (table_group->tables[num2])
> +		pnv_npu_unset_window(npe, num2);
> +
> +	ret = pnv_npu_set_window(npe, num, tbl);
> +	if (ret) {
>  		pnv_pci_ioda2_unset_window(table_group, num);
> +		if (table_group->tables[num2])
> +			pnv_npu_set_window(npe, num2,
> +					table_group->tables[num2]);
> +	}
>  
>  	return ret;
>  }
> @@ -2697,12 +2706,24 @@ static long pnv_pci_ioda2_npu_unset_window(
>  		struct iommu_table_group *table_group,
>  		int num)
>  {
> +	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
> +	int num2 = (num == 0) ? 1 : 0;
>  	long ret = pnv_pci_ioda2_unset_window(table_group, num);
>  
>  	if (ret)
>  		return ret;
>  
> -	return pnv_npu_unset_window(gpe_table_group_to_npe(table_group), num);
> +	if (!npe->table_group.tables[num])
> +		return 0;
> +
> +	ret = pnv_npu_unset_window(npe, num);
> +	if (ret)
> +		return ret;
> +
> +	if (table_group->tables[num2])
> +		ret = pnv_npu_set_window(npe, num2, table_group->tables[num2]);
> +
> +	return ret;
>  }
>  
>  static void pnv_ioda2_npu_take_ownership(struct iommu_table_group *table_group)
> 
