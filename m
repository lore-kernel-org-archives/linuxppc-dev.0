Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vs71n51gqzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 19:47:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v11 02/10] powerpc/powernv/iommu: Add real mode
 version of iommu_table_ops::exchange()
In-Reply-To: <20170322042156.11756-3-aik@ozlabs.ru>
References: <20170322042156.11756-1-aik@ozlabs.ru>
 <20170322042156.11756-3-aik@ozlabs.ru>
Date: Mon, 27 Mar 2017 19:47:08 +1100
Message-ID: <877f3bf6nn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 5f202a566ec5..9bace5df05d5 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1004,6 +1004,29 @@ long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
>  }
>  EXPORT_SYMBOL_GPL(iommu_tce_xchg);
>  
> +long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
> +		unsigned long *hpa, enum dma_data_direction *direction)
> +{
> +	long ret;
> +
> +	ret = tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
> +
> +	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
> +			(*direction == DMA_BIDIRECTIONAL))) {
> +		struct page *pg = realmode_pfn_to_page(*hpa >> PAGE_SHIFT);

This breaks the corenet64_smp_defconfig build:

arch/powerpc/kernel/iommu.c:1037:21: error: implicit declaration of function 'realmode_pfn_to_page' [-Werror=implicit-function-declaration]


I think you can probably just put it inside #ifdef CONFIG_PPC_BOOK3S_64.

cheers
