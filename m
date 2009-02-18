Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E31C8DDD1C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 16:41:12 +1100 (EST)
Subject: Re: [PATCH] Enable hashdist by default on PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20090218051112.GA32195@kryten>
References: <20090218051112.GA32195@kryten>
Content-Type: text/plain
Date: Wed, 18 Feb 2009 16:41:07 +1100
Message-Id: <1234935667.14060.440.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> For many HPC applications we are limited by the free available memory on
> the smallest node, so even though the same amount of memory is used the
> better balancing helps.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---

You have numbers ? :-) I'm asking mostly because I've been wondering
whether it offsets the 16M pages vs. 4K or 64K pages in term of TLB/ERAT
impact.

Cheers,
Ben.

> diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
> index 95837bf..c0c63ee 100644
> --- a/include/linux/bootmem.h
> +++ b/include/linux/bootmem.h
> @@ -145,9 +145,10 @@ extern void *alloc_large_system_hash(const char *tablename,
>  #define HASH_EARLY	0x00000001	/* Allocating during early boot? */
>  
>  /* Only NUMA needs hash distribution.
> - * IA64 and x86_64 have sufficient vmalloc space.
> + * IA64, x86_64 and PowerPC have sufficient vmalloc space.
>   */
> -#if defined(CONFIG_NUMA) && (defined(CONFIG_IA64) || defined(CONFIG_X86_64))
> +#if defined(CONFIG_NUMA) && (defined(CONFIG_IA64) || defined(CONFIG_X86_64) || \
> +	defined(CONFIG_PPC64))
>  #define HASHDIST_DEFAULT 1
>  #else
>  #define HASHDIST_DEFAULT 0
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
