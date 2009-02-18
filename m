Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 94AC9DDDA1
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 20:19:43 +1100 (EST)
Date: Wed, 18 Feb 2009 01:19:24 -0800 (PST)
Message-Id: <20090218.011924.07030610.davem@davemloft.net>
To: anton@samba.org
Subject: Re: [PATCH] Enable hashdist by default on PowerPC
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090218051112.GA32195@kryten>
References: <20090218051112.GA32195@kryten>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>
Date: Wed, 18 Feb 2009 16:11:12 +1100

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

I should probably do this on sparc64 too.

Why don't we just change this thing to CONFIG_64BIT?
