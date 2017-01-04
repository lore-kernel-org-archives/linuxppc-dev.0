Return-Path: <tuliom@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttrcV3DNpzDqHv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 00:04:26 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v04D4LBJ040965
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 08:04:24 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27ry40nqmk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 08:04:24 -0500
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tuliom@linux.vnet.ibm.com>;
 Wed, 4 Jan 2017 11:04:21 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 3C0BC1DC0074
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 08:04:20 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v04D4I4W32964634
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 11:04:18 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v04D4IFS027495
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 11:04:18 -0200
From: "Tulio Magno Quites Machado Filho" <tuliom@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Steven Munroe <munroesj@linux.vnet.ibm.com>
Cc: 
Subject: Re: [PATCH 9/9] powerpc: A new cache shape aux vectors
In-Reply-To: <20170104051535.9454-9-benh@kernel.crashing.org>
References: <20170104051535.9454-1-benh@kernel.crashing.org>
 <20170104051535.9454-9-benh@kernel.crashing.org>
Date: Wed, 04 Jan 2017 11:04:07 -0200
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgurkmd4.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:


> diff --git a/arch/powerpc/include/uapi/asm/auxvec.h b/arch/powerpc/include/uapi/asm/auxvec.h
> index ce17d2c..79183d2 100644
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
> +#define AT_L1I_CACHESHAPE	41
> +#define AT_L1D_CACHESIZE	42
> +#define AT_L1D_CACHESHAPE	43
> +#define AT_L2_CACHESIZE		44
> +#define AT_L2_CACHESHAPE	45
> +#define AT_L3_CACHESIZE		46
> +#define AT_L3_CACHESHAPE	47

These names will clash with the other ones defined by alpha and sh:

/* Shapes of the caches.  Bits 0-3 contains associativity; bits 4-7 contains
   log2 of line size; mask those to get cache size.  */
#define AT_L1I_CACHESHAPE	34
#define AT_L1D_CACHESHAPE	35
#define AT_L2_CACHESHAPE	36
#define AT_L3_CACHESHAPE	37

-- 
Tulio Magno
