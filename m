Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B43F9B70D1
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Oct 2010 17:21:22 +1100 (EST)
Subject: Re: [patch 1/1] powerpc: enable ARCH_DMA_ADDR_T_64BIT with
	ARCH_PHYS_ADDR_T_64BIT
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20101002190634E.fujita.tomonori@lab.ntt.co.jp>
References: <201010012112.o91LCtEk020866@imap1.linux-foundation.org>
	<AANLkTikrgu5LrYfveax_EavObThNw2M4ukVB3ka1y0Hj@mail.gmail.com>
	<1285989654.2463.286.camel@pasglop>
	<20101002190634E.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 03 Oct 2010 17:20:58 +1100
Message-ID: <1286086858.2463.289.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Really?
> 
> The current dma_addr_t is:
> 
> #if defined(__powerpc64__) || defined(CONFIG_PHYS_64BIT)
> typedef u64 dma_addr_t;
> #else
> typedef u32 dma_addr_t;
> #endif
> typedef u64 dma64_addr_t;

-EBRAINFAI ... either I wasn't looking when we changed it or I just
forgot :-) We -used-, I'm pretty sure, to have it always 32-bit :-)

Anyways, doesn't matter. Patch looks good. We can always tweak the
config option if we want to later.

Cheers,
Ben.

> 
> I think that this patch doesn't change anything. Or I miss something?
> 
> @@ -22,6 +22,9 @@ config WORD_SIZE
>  config ARCH_PHYS_ADDR_T_64BIT
>         def_bool PPC64 || PHYS_64BIT
> 
> +config ARCH_DMA_ADDR_T_64BIT
> +       def_bool ARCH_PHYS_ADDR_T_64BIT
> +
>  config MMU
>         bool
>         default y
