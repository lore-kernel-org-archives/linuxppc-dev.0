Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE4831A03C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 17:02:26 +1100 (AEDT)
Received: by pacfv9 with SMTP id fv9so221262561pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:02:25 -0700 (PDT)
Subject: Re: [PATCH 2/7 v2] powerpc/dma-mapping: override dma_get_page_shift
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205718.GC10197@linux.vnet.ibm.com>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Gibson
 <david@gibson.dropbear.id.au>, Christoph Hellwig <hch@infradead.org>,
 "David S. Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <562F1368.1030204@ozlabs.ru>
Date: Tue, 27 Oct 2015 17:02:16 +1100
MIME-Version: 1.0
In-Reply-To: <20151023205718.GC10197@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/24/2015 07:57 AM, Nishanth Aravamudan wrote:
> On Power, the kernel's page size can differ from the IOMMU's page size,
> so we need to override the generic implementation, which always returns
> the kernel's page size. Lookup the IOMMU's page size from struct
> iommu_table, if available. Fallback to the kernel's page size,
> otherwise.
>
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/dma-mapping.h | 3 +++
>   arch/powerpc/kernel/dma.c              | 9 +++++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index 7f522c0..c5638f4 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -125,6 +125,9 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
>   #define HAVE_ARCH_DMA_SET_MASK 1
>   extern int dma_set_mask(struct device *dev, u64 dma_mask);
>
> +#define HAVE_ARCH_DMA_GET_PAGE_SHIFT 1
> +extern unsigned long dma_get_page_shift(struct device *dev);
> +
>   #include <asm-generic/dma-mapping-common.h>
>
>   extern int __dma_set_mask(struct device *dev, u64 dma_mask);
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index 59503ed..e805af2 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -335,6 +335,15 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
>   }
>   EXPORT_SYMBOL(dma_set_mask);
>
> +unsigned long dma_get_page_shift(struct device *dev)
> +{
> +	struct iommu_table *tbl = get_iommu_table_base(dev);
> +	if (tbl)
> +		return tbl->it_page_shift;


All PCI devices have this initialized on POWER (at least, our, IBM's POWER) 
so 4K will always be returned here while in the case of 
(get_dma_ops(dev)==&dma_direct_ops) it could actually return PAGE_SHIFT. Is 
4K still preferred value to return here?



> +	return PAGE_SHIFT;
> +}
> +EXPORT_SYMBOL(dma_get_page_shift);
> +
>   u64 __dma_get_required_mask(struct device *dev)
>   {
>   	struct dma_map_ops *dma_ops = get_dma_ops(dev);
>


-- 
Alexey
