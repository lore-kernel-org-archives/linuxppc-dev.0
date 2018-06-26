Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FDKF1rHNzF0wq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 14:56:31 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id a22-v6so7504133pfo.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 21:56:31 -0700 (PDT)
Date: Tue, 26 Jun 2018 14:56:22 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Reduce upper limit for
 DMA window size
Message-ID: <20180626145622.1c06531a@aik.ozlabs.ibm.com>
In-Reply-To: <20180601080616.29279-1-aik@ozlabs.ru>
References: <20180601080616.29279-1-aik@ozlabs.ru>
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

On Fri,  1 Jun 2018 18:06:16 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> We use PHB in mode1 which uses bit 59 to select a correct DMA window.
> However there is mode2 which uses bits 59:55 and allows up to 32 DMA
> windows per a PE.
> 
> Even though documentation does not clearly specify that, it seems that
> the actual hardware does not support bits 59:55 even in mode1, in other
> words we can create a window as big as 1<<58 but DMA simply won't work.
> 
> This reduces the upper limit from 59 to 55 bits to let the userspace know
> about the hardware limits.
> 
> Fixes: 7aafac11e3 "powerpc/powernv/ioda2: Gracefully fail if too many TCE levels requested"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Ping?


> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 92ca662..50e21d7 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2839,7 +2839,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>  	level_shift = entries_shift + 3;
>  	level_shift = max_t(unsigned, level_shift, PAGE_SHIFT);
>  
> -	if ((level_shift - 3) * levels + page_shift >= 60)
> +	if ((level_shift - 3) * levels + page_shift >= 55)
>  		return -EINVAL;
>  
>  	/* Allocate TCE table */
> -- 
> 2.11.0
> 



--
Alexey
