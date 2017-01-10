Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tycbb3ynTzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 03:16:43 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0AGF4AZ110173
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 11:16:40 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27w0ma7hpq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 11:16:40 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Tue, 10 Jan 2017 09:16:38 -0700
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH 9/9] powerpc: A new cache geometry aux vectors
References: <20170108233150.15353-1-benh@kernel.crashing.org>
 <20170108233150.15353-9-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Steven Munroe <munroesj@linux.vnet.ibm.com>
From: Paul Clarke <pc@us.ibm.com>
Date: Tue, 10 Jan 2017 10:16:32 -0600
MIME-Version: 1.0
In-Reply-To: <20170108233150.15353-9-benh@kernel.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <507dbb0e-9286-8135-c957-316a2a42e1b0@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/08/2017 05:31 PM, Benjamin Herrenschmidt wrote:
> This adds AUX vectors for the L1I,D, L2 and L3 cache levels
> providing for each cache level the size of the cache in bytes
> and the geometry (line size and number of ways).
>
> We chose to not use the existing alpha/sh definition which
> packs all the information in a single entry per cache level as
> it is too restricted to represent some of the geometries used
> on POWER.

> diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
> index 3987bd9..1557d26 100644
> --- a/arch/powerpc/include/asm/cache.h
> +++ b/arch/powerpc/include/asm/cache.h
> @@ -35,6 +35,7 @@ struct ppc_cache_info {
>  	u32 log_block_size;
>  	u32 blocks_per_page;
>  	u32 sets;
> +	u32 assoc;

Associativity is defined as u32...

>  };
>
>  struct ppc64_caches {
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
> index 730c27e..a128836 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h

> +extern long il1cache_shape;
> +extern long dl1cache_shape;
> +extern long l2cache_shape;
> +extern long l3cache_shape;

shapes are "long"...

> @@ -136,6 +140,9 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>
>  #endif /* CONFIG_SPU_BASE */
>
> +#define get_cache_shape(level) \
> +	(ppc64_caches.level.assoc << 16 | ppc64_caches.level.line_size)

Now we stuff u32 assoc into 16 bits.

What's the reason behind combining associativity and cache line size into a single field?

Likely the most requested values will be cache line size and (maybe) cache size.  The latter is a simple query with these changes, but the former is now a query and some awkward mask/shift.  I don't think we're currently providing accessor macros, although I guess those can be added to glibc.  Would it not be simpler, though, to just add independent queries for each of cache line size and associativity?
- AT_L1I_CACHESIZE
- AT_L1I_CACHE_LINE_SIZE
- AT_L1I_CACHE_ASSOC
etc.

Is there a big "con" to having a few more AUXV entries?

Regards,
PC

> @@ -156,6 +163,14 @@ do {									\
>  	NEW_AUX_ENT(AT_ICACHEBSIZE, icache_bsize);			\
>  	NEW_AUX_ENT(AT_UCACHEBSIZE, ucache_bsize);			\
>  	VDSO_AUX_ENT(AT_SYSINFO_EHDR, current->mm->context.vdso_base);	\
> +	NEW_AUX_ENT(AT_L1I_CACHESIZE, ppc64_caches.l1i.size);		\
> +	NEW_AUX_ENT(AT_L1I_CACHEGEOMETRY, get_cache_shape(l1i));	\
> +	NEW_AUX_ENT(AT_L1D_CACHESIZE, ppc64_caches.l1i.size);		\
> +	NEW_AUX_ENT(AT_L1D_CACHEGEOMETRY, get_cache_shape(l1i));	\
> +	NEW_AUX_ENT(AT_L2_CACHESIZE, ppc64_caches.l2.size);		\
> +	NEW_AUX_ENT(AT_L2_CACHEGEOMETRY, get_cache_shape(l2));		\
> +	NEW_AUX_ENT(AT_L3_CACHESIZE, ppc64_caches.l3.size);		\
> +	NEW_AUX_ENT(AT_L3_CACHEGEOMETRY, get_cache_shape(l3));		\
>  } while (0)
>
>  #endif /* _ASM_POWERPC_ELF_H */
> diff --git a/arch/powerpc/include/uapi/asm/auxvec.h b/arch/powerpc/include/uapi/asm/auxvec.h
> index ce17d2c..be6e94e 100644
> --- a/arch/powerpc/include/uapi/asm/auxvec.h
> +++ b/arch/powerpc/include/uapi/asm/auxvec.h
> @@ -16,6 +16,37 @@
>   */
>  #define AT_SYSINFO_EHDR		33
>
> -#define AT_VECTOR_SIZE_ARCH 6 /* entries in ARCH_DLINFO */
> +/*
> + * AT_*CACHEBSIZE above represent the cache *block* size which is
> + * the size that is affected by the cache management instructions.
> + *
> + * It doesn't nececssarily matches the cache *line* size which is
> + * more of a performance tuning hint. Additionally the latter can
> + * be different for the different cache levels.
> + *
> + * The set of entries below represent more extensive information
> + * about the caches, in the form of two entry per cache type,
> + * one entry containing the cache size in bytes, and the other
> + * containing the cache line size in bytes in the bottom 16 bits
> + * and the cache associativity in the next 16 bits.
> + *
> + * The associativity is such that if N is the 16-bit value, the
> + * cache is N way set associative. A value if 0xffff means fully
> + * associative, a value of 1 means directly mapped.
> + *
> + * For all these fields, a value of 0 means that the information
> + * is not known.
> + */
> +
> +#define AT_L1I_CACHESIZE	40
> +#define AT_L1I_CACHEGEOMETRY	41
> +#define AT_L1D_CACHESIZE	42
> +#define AT_L1D_CACHEGEOMETRY	43
> +#define AT_L2_CACHESIZE		44
> +#define AT_L2_CACHEGEOMETRY	45
> +#define AT_L3_CACHESIZE		46
> +#define AT_L3_CACHEGEOMETRY	47
> +
> +#define AT_VECTOR_SIZE_ARCH	14 /* entries in ARCH_DLINFO */
>
>  #endif
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index e0eeed4..cfa2a06 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -94,7 +94,10 @@ EXPORT_SYMBOL_GPL(boot_cpuid);
>  int dcache_bsize;
>  int icache_bsize;
>  int ucache_bsize;
> -
> +long il1cache_shape = -1;
> +long dl1cache_shape = -1;
> +long l2cache_shape = -1;
> +long l3cache_shape = -1;
>
>  unsigned long klimit = (unsigned long) _end;
>
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index b3c93d8..16cb0b7 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -451,6 +451,10 @@ static bool __init parse_cache_info(struct device_node *np,
>  	info->block_size = bsize;
>  	info->log_block_size = __ilog2(bsize);
>  	info->blocks_per_page = PAGE_SIZE / bsize;
> +	if (sets == 0)
> +		info->assoc = 0xffff;
> +	else
> +		info->assoc = size / (sets * lsize);
>
>  	return success;
>  }
>
