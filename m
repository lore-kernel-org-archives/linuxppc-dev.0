Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDkFL1JlhzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 16:20:06 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id v20so1352576pgn.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 23:20:06 -0700 (PDT)
Date: Fri, 28 Apr 2017 16:19:56 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras
 <paulus@samba.org>
Subject: Re: [PATCH kernel] powerpc/powernv: Fix iommu table size
 calculation hook for small tables
Message-ID: <20170428161956.402c2148@aik.ozlabs.ibm.com>
In-Reply-To: <20170413070527.16989-1-aik@ozlabs.ru>
References: <20170413070527.16989-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 13 Apr 2017 17:05:27 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> When the userspace requests a small TCE table (which takes less than
> the system page size) and more than 1 TCE level, the existing code
> returns a single page size which is a bug as each additional TCE level
> requires at least one page and this is what
> pnv_pci_ioda2_table_alloc_pages() does. And we end up seeing
> WARN_ON(!ret && ((*ptbl)->it_allocated_size != table_size))
> in drivers/vfio/vfio_iommu_spapr_tce.c.
> 
> This replaces incorrect _ALIGN_UP() (which aligns zero up to zero) with
> max_t() to fix the bug.
> 
> Besides removing WARN_ON(), there should be no other changes in
> behaviour.

Ping?


> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 6d0da5dfc955..a0d046adcf45 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2538,7 +2538,8 @@ static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
>  
>  		tce_table_size /= direct_table_size;
>  		tce_table_size <<= 3;
> -		tce_table_size = _ALIGN_UP(tce_table_size, direct_table_size);
> +		tce_table_size = max_t(unsigned long,
> +				tce_table_size, direct_table_size);
>  	}
>  
>  	return bytes;



--
Alexey
