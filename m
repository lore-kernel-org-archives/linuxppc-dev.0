Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409wVn3PbXzF2DN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 15:53:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] powerpc/powernv: Fix sparse data type warnings in
 pci-ioda.c
In-Reply-To: <20180328004442.GA29865@fergus.ozlabs.ibm.com>
References: <20180328004442.GA29865@fergus.ozlabs.ibm.com>
Date: Wed, 28 Mar 2018 15:53:05 +1100
Message-ID: <87d0zo3ioe.fsf@concordia.ellerman.id.au>
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

Paul Mackerras <paulus@ozlabs.org> writes:
> From: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
> The value passed to __raw_rm_writeq() and __raw_writeq() should be "u64"
> and "unsigned long". This fixes warning reported by sparse:
>
>   gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
>                              arch/powerpc/platforms/powernv/pci-ioda.o
>   arch/powerpc/platforms/powernv/pci-ioda.c:1794:41: \
>   warning: incorrect type in argument 1 (different base types)
>   arch/powerpc/platforms/powernv/pci-ioda.c:1794:41: \
>   expected unsigned long long [unsigned] [usertype] val
>   arch/powerpc/platforms/powernv/pci-ioda.c:1794:41: \
>   got restricted __be64 [usertype] <noident>
>   arch/powerpc/platforms/powernv/pci-ioda.c:1796:38: \
>   warning: incorrect type in argument 1 (different base types)
>   arch/powerpc/platforms/powernv/pci-ioda.c:1796:38: \
>   expected unsigned long [unsigned] v
>   arch/powerpc/platforms/powernv/pci-ioda.c:1796:38: \
>   got restricted __be64 [usertype] <noident>
>
> This also fixes another warning reported by sparse:
>
>   gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
>                              arch/powerpc/platforms/powernv/pci-ioda.o
>         :
>   arch/powerpc/platforms/powernv/pci-ioda.c:2647:45: \
>   warning: cast to restricted __be64
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index a6c92c7..71de087 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1976,9 +1976,11 @@ static void pnv_pci_p7ioc_tce_invalidate(struct iommu_table *tbl,
>          mb(); /* Ensure above stores are visible */
>          while (start <= end) {
>  		if (rm)
> -			__raw_rm_writeq(cpu_to_be64(start), invalidate);
> +			__raw_rm_writeq((__force u64)cpu_to_be64(start),
> +					invalidate);
>  		else
> -			__raw_writeq(cpu_to_be64(start), invalidate);
> +			__raw_writeq((__force unsigned long)cpu_to_be64(start),
> +				     invalidate);

I didn't merge this when it was originally sent because sprinkling
__force casts everywhere is not a good strategy for producing
maintainable code IMHO.

There's a writeq_be() which does the byte swap, I think we should
probably just mirror that for these __raw versions.

I'll do a patch.

cheers
