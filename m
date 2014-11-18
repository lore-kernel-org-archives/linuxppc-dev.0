Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B51CE1A020A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 21:28:22 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id F28041400B7
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2014 21:28:21 +1100 (AEDT)
Message-ID: <1416306500.28359.1.camel@concordia>
Subject: Re: [PATCH] powerpc: Remove more traces of bootmem
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Date: Tue, 18 Nov 2014 21:28:20 +1100
In-Reply-To: <1416293575-1847-1-git-send-email-mpe@ellerman.id.au>
References: <1416293575-1847-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-11-18 at 17:52 +1100, Michael Ellerman wrote:
> diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
> index 009a2004b876..86ed156f468f 100644
> --- a/arch/powerpc/platforms/ps3/setup.c
> +++ b/arch/powerpc/platforms/ps3/setup.c
> @@ -125,12 +125,8 @@ static void __init prealloc(struct ps3_prealloc *p)
>  	if (!p->size)
>  		return;
>  
> -	p->address = __alloc_bootmem(p->size, p->align, __pa(MAX_DMA_ADDRESS));
> -	if (!p->address) {
> -		printk(KERN_ERR "%s: Cannot allocate %s\n", __func__,
> -		       p->name);
> -		return;
> -	}
> +	p->address = __va(memblock_alloc_base(p->size, p->align,
> +					      __pa(MAX_DMA_ADDRESS)));

This should be:

> +	p->address = __va(memblock_alloc(p->size, p->align));

And a comment in the change log pointing out that MAX_DMA_ADDRESS is ~0ull on
powerpc, so limiting allocations to that is pointless.

cheers
