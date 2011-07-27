Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: pseries: Fix kexec on machines with more than
	4TB of RAM
In-reply-to: <20110727141503.3faa93f5@kryten>
References: <20110727141503.3faa93f5@kryten>
Date: Wed, 27 Jul 2011 14:26:10 +1000
Message-ID: <2294.1311740770@neuling.org>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On a box with 8TB of RAM the MMU hashtable is 64GB in size. That
> means we have 4G PTEs. pSeries_lpar_hptab_clear was using a signed
> int to store the index which will overflow at 2G.

Wow, I hear... "Anton Blanchard's machine has more memory in it's MMU
than you have in total".

Acked-by: Michael Neuling <mikey@neuling.org>

> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: <stable@kernel.org>
> ---
> 
> Index: linux-powerpc/arch/powerpc/platforms/pseries/lpar.c
> ===================================================================
> --- linux-powerpc.orig/arch/powerpc/platforms/pseries/lpar.c	2011-07-27 13:5
0:18.408091576 +1000
> +++ linux-powerpc/arch/powerpc/platforms/pseries/lpar.c	2011-07-27 13:5
1:19.359196131 +1000
> @@ -203,7 +203,7 @@ static void pSeries_lpar_hptab_clear(voi
>  		unsigned long ptel;
>  	} ptes[4];
>  	long lpar_rc;
> -	int i, j;
> +	unsigned long i, j;
>  
>  	/* Read in batches of 4,
>  	 * invalidate only valid entries not in the VRMA
> 
