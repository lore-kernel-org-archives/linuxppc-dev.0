Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0136.outbound.protection.outlook.com [157.56.110.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E29A1A0014
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 09:53:36 +1000 (AEST)
Date: Mon, 28 Sep 2015 18:53:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 08/25] powerpc/8xx: Map IMMR area with 512k page at a
 fixed address
Message-ID: <20150928235317.GE6161@home.buserror.net>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <bfa8400abd8b5174942616aae5876a55242f5468.1442939410.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <bfa8400abd8b5174942616aae5876a55242f5468.1442939410.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 06:50:44PM +0200, Christophe Leroy wrote:

> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 3fd9083..1f2fdbc 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -49,6 +49,10 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
>  #define HAVE_TLBCAM	1
>  #endif
>  
> +#if CONFIG_PPC_8xx
> +#define HAVE_LTLB	1
> +#endif
> +
>  extern char etext[], _stext[];
>  
>  #ifdef HAVE_BATS
> @@ -67,6 +71,14 @@ extern unsigned long p_mapped_by_tlbcam(phys_addr_t pa);
>  #define p_mapped_by_tlbcam(x)	(0UL)
>  #endif /* HAVE_TLBCAM */
>  
> +#ifdef HAVE_LTLB
> +phys_addr_t v_mapped_by_ltlb(unsigned long va);
> +unsigned long p_mapped_by_ltlb(phys_addr_t pa);
> +#else /* !HAVE_LTLB */
> +#define v_mapped_by_ltlb(x)	(0UL)
> +#define p_mapped_by_ltlb(x)	(0UL)
> +#endif /* HAVE_LTLB */
> +
>  static inline unsigned long p_mapped_by_other(phys_addr_t pa)
>  {
>  	unsigned long v;
> @@ -75,6 +87,10 @@ static inline unsigned long p_mapped_by_other(phys_addr_t pa)
>  	if (v /*&& p_mapped_by_bats(p+size-1)*/)
>  		return v;
>  
> +	v = p_mapped_by_ltlb(pa);
> +	if (v)
> +		return v;
> +
>  	return p_mapped_by_tlbcam(pa);
>  }
>  
> @@ -86,6 +102,10 @@ static inline phys_addr_t v_mapped_by_other(unsigned long va)
>  	if (p)
>  		return p;
>  
> +	p = v_mapped_by_ltlb(va);
> +	if (p)
> +		return p;
> +
>  	return v_mapped_by_tlbcam(va);
>  }

Since there is no kernel with more than one of {bats,ltlb,tlbcam} can we
just call it *_block_mapped() and have each subarch provide its
implementation (or stub) thereof?

-Scott
