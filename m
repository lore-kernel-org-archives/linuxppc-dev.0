Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5611CDDEDA
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 15:44:10 +1100 (EST)
Subject: Re: [PATCH] powerpc: rework dma-noncoherent to use generic
	vmap/vunmap functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ilya Yanok <yanok@emcraft.com>
In-Reply-To: <1231505915-16082-1-git-send-email-yanok@emcraft.com>
References: <1231505915-16082-1-git-send-email-yanok@emcraft.com>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 15:43:45 +1100
Message-Id: <1233722625.16867.249.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-01-09 at 15:58 +0300, Ilya Yanok wrote:
> This patch rewrites consistent dma allocations support to use vmalloc
> layer to allocate virtual memory space from vmalloc pool and get rid
> of CONFIG_CONSISTENT_{START,SIZE}.

So as commented before, please drop the defconfig updates.

I'm happy with the idea but I have a few nits with the implementation:

> -/*
>   * Allocate DMA-coherent memory space and return both the kernel remapped
>   * virtual and bus address for that space.
>   */
> @@ -151,19 +41,17 @@ void *
>  __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
>  {
>  	struct page *page;
> -	struct vm_region *c;
>  	unsigned long order;
> +	void *v;
> +	int i;
> +	struct page *pages[PAGE_ALIGN(size)>>PAGE_SHIFT];

I'm not -too- fan of that page list one the stack up there.

I understand why you don't wantto kmalloc something here etc... but
that's what __vmalloc_area() does and it's somewhat useful to keep track
of the page array that way, it might prove handy in the future.

Might even be worth adding a generic patch to add a VM_COHERENT_DMA flag
so they can be listed as such and make sure you set the "caller" field
yourself with your own caller.

(Hint: look at the output of /proc/vmallocinfo)

Also, the mucking around with PG_Reserved shouldn't be of any use
anymore.

Cheers,
Ben.
