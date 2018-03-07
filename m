Return-Path: <aik@ozlabs.ru>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwztz1HCNzF1j7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 14:40:42 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id 93-v6so593744plc.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 19:40:42 -0800 (PST)
Subject: Re: [PATCH kernel] powerpc/npu: Do not try invalidating 32bit table
 when 64bit table is enabled
To: linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Alistair Popple <alistair@popple.id.au>, Russell Currey <ruscur@russell.cc>
References: <20180213055135.25639-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4191e3cb-9a94-ea6d-702b-49c10fc323fd@ozlabs.ru>
Date: Wed, 7 Mar 2018 14:40:36 +1100
MIME-Version: 1.0
In-Reply-To: <20180213055135.25639-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/02/18 16:51, Alexey Kardashevskiy wrote:
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
> --
> 
> Do we need BUG_ON(IOMMU_TABLE_GROUP_MAX_TABLES != 2)?



Ping?



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


-- 
Alexey
