Return-Path: <paubert@iram.es>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2980B1A127A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 20:48:38 +1100 (AEDT)
Received: from rudy.puc.rediris.es (rudy.puc.rediris.es
 [IPv6:2001:720:418:ca01::132])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 93E6E140291
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 20:48:37 +1100 (AEDT)
Date: Thu, 17 Dec 2015 10:19:06 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@ozlabs.org, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v3 2/3] powerpc: Add __raw_rm_writeq() function
Message-ID: <20151217091906.GA24014@visitor2.iram.es>
References: <1450320193-20116-1-git-send-email-alistair@popple.id.au>
 <1450320193-20116-3-git-send-email-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450320193-20116-3-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 17, 2015 at 01:43:12PM +1100, Alistair Popple wrote:
> Move __raw_rw_writeq() from platforms/powernv/pci-ioda.c to
              ^
Typo?
(not a big deal)

    Gabriel

> include/asm/io.h so that it can be used by other code.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>  arch/powerpc/include/asm/io.h             | 11 +++++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ----------
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index 5879fde..6c1297e 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -385,6 +385,17 @@ static inline void __raw_writeq(unsigned long v, volatile void __iomem *addr)
>  {
>  	*(volatile unsigned long __force *)PCI_FIX_ADDR(addr) = v;
>  }
> +
> +/*
> + * Real mode version of the above. stdcix is only supposed to be used
> + * in hypervisor real mode as per the architecture spec.
> + */
> +static inline void __raw_rm_writeq(u64 val, volatile void __iomem *paddr)
> +{
> +	__asm__ __volatile__("stdcix %0,0,%1"
> +		: : "r" (val), "r" (paddr) : "memory");
> +}
> +
>  #endif /* __powerpc64__ */
>  
>  /*
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 42b4bb2..cb04642 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -116,16 +116,6 @@ static int __init iommu_setup(char *str)
>  }
>  early_param("iommu", iommu_setup);
>  
> -/*
> - * stdcix is only supposed to be used in hypervisor real mode as per
> - * the architecture spec
> - */
> -static inline void __raw_rm_writeq(u64 val, volatile void __iomem *paddr)
> -{
> -	__asm__ __volatile__("stdcix %0,0,%1"
> -		: : "r" (val), "r" (paddr) : "memory");
> -}
> -
>  static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
>  {
>  	return ((flags & (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH)) ==
> -- 
> 2.1.4
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
