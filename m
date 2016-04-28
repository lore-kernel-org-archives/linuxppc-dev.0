Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwPgg27m5zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 14:56:47 +1000 (AEST)
In-Reply-To: <1460182444-2468-67-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2,
 66/68] powerpc/mm/radix: Add THP support for 4k linux page size
Message-Id: <3qwPgg104tz9t50@ozlabs.org>
Date: Thu, 28 Apr 2016 14:56:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-09-04 at 06:14:02 UTC, "Aneesh Kumar K.V" wrote:

Missing change log.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> index bb3d8539bb1b..d915788d5074 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -50,6 +50,65 @@ static inline int hl_hugepd_ok(hugepd_t hpd)
>  }
>  #endif
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +
> +static inline char *get_hpte_slot_array(pmd_t *pmdp)
> +{
> +	BUG();
> +	return NULL;
> +}

...

> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 53299182dba9..ad9c77399aab 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -72,7 +72,7 @@ config PPC_BOOK3S_64
>  	select PPC_FPU
>  	select PPC_HAVE_PMU_SUPPORT
>  	select SYS_SUPPORTS_HUGETLBFS
> -	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if PPC_64K_PAGES
> +	select HAVE_ARCH_TRANSPARENT_HUGEPAGE


How is this meant to work?

It appears to allow me to build a 4K kernel with THP which will then BUG() as
soon as I run it on hash?

I assume you'll tell me there's some mechanism somewhere that prevents that from
happening, but what is it?

cheers
