Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 309B3DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 13:09:34 +1100 (EST)
Subject: Re: [PATCH] powerpc: remove WARN_ON() from dma-noncoherent.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <2094bb9371fc6b6c228b.1226363616@localhost.localdomain>
References: <2094bb9371fc6b6c228b.1226363616@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Nov 2008 13:09:04 +1100
Message-Id: <1226369344.7530.51.camel@pasglop>
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

On Mon, 2008-11-10 at 18:33 -0600, Hollis Blanchard wrote:
> I can't tell why this WARN_ON exists, and there's no comment explaining it.
> Whether the pmd is present or not, pte_alloc_kernel() seems to handle both
> cases.
> 
> Booting a 440 kernel with 64K PAGE_SIZE triggers the warning, but boot
> successfully completes and I see no problems beyond that.
> 
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

I can't see any reason neither off hand, so

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ben.
> ---
> 
> Large page support is critical for improving KVM performance, so I'd like this
> apparently unnecessary warning to be removed to make way for Ilya's patch.
> 
> Vitaly, this code was added by you in Feb 2007. Any thoughts?
> 
> diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-noncoherent.c
> --- a/arch/powerpc/lib/dma-noncoherent.c
> +++ b/arch/powerpc/lib/dma-noncoherent.c
> @@ -320,7 +320,6 @@ static int __init dma_alloc_init(void)
>  			ret = -ENOMEM;
>  			break;
>  		}
> -		WARN_ON(!pmd_none(*pmd));
>  
>  		pte = pte_alloc_kernel(pmd, CONSISTENT_BASE);
>  		if (!pte) {
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
