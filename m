Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D746B67CBF
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 10:57:44 +1100 (EST)
Subject: Re: [PATCH 15/16] TLB insersion for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200611151000.kAFA0Fxs012318@toshiba.co.jp>
References: <200611151000.kAFA0Fxs012318@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 10:57:40 +1100
Message-Id: <1163635060.5940.295.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-15 at 19:00 +0900, Ishizaki Kou wrote:
> This patch changes handling return value of ppc_md.hpte_insert() to 
> the same way as __hash_page_*().
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> Index: linux-2.6.19/arch/powerpc/mm/hugetlbpage.c
> diff -u linux-2.6.19/arch/powerpc/mm/hugetlbpage.c:1.1.1.1 linux-2.6.19/arch/powerpc/mm/hugetlbpage.c:1.2
> --- linux-2.6.19/arch/powerpc/mm/hugetlbpage.c:1.1.1.1	Fri Oct  6 10:40:06 2006
> +++ linux-2.6.19/arch/powerpc/mm/hugetlbpage.c	Wed Oct 11 20:45:10 2006
> @@ -1008,7 +1008,6 @@
>  
>  		/* Primary is full, try the secondary */
>  		if (unlikely(slot == -1)) {
> -			new_pte |= _PAGE_F_SECOND;
>  			hpte_group = ((~hash & htab_hash_mask) *
>  				      HPTES_PER_GROUP) & ~0x7UL; 
>  			slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags,
> @@ -1027,7 +1026,7 @@
>  		if (unlikely(slot == -2))
>  			panic("hash_huge_page: pte_insert failed\n");
>  
> -		new_pte |= (slot << 12) & _PAGE_F_GIX;
> +		new_pte |= (slot << 12) & (_PAGE_F_SECOND | _PAGE_F_GIX);
>  	}
>  
>  	/*
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
