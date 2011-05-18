Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89A18100827
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:36:27 +1000 (EST)
Subject: Re: [PATCH 5/7] powerpc/mm: 64-bit: don't handle non-standard page
	sizes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110518210535.GD29524@schlenkerla.am.freescale.net>
References: <20110518210535.GD29524@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 07:36:04 +1000
Message-ID: <1305754564.7481.4.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-18 at 16:05 -0500, Scott Wood wrote:
> I don't see where any non-standard page size will be set in the
> kernel page tables, so don't waste time checking for it.  It wouldn't
> work with TLB0 on an FSL MMU anyway, so if there's something I missed
> (or which is out-of-tree), it's relying on implementation-specific
> behavior.  If there's an out-of-tree need for occasional 4K mappings
> with CONFIG_PPC_64K_PAGES, perhaps this check could only be done when
> that is defined.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---

Do you use that in the hugetlbfs code ? Can you publish that code ? It's
long overdue...

Cheers,
Ben.

>  arch/powerpc/mm/tlb_low_64e.S |   13 -------------
>  1 files changed, 0 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
> index 922fece..e782023 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -232,19 +232,6 @@ finish_normal_tlb_miss:
>  	rlwimi	r11,r14,32-19,27,31	/* Insert WIMGE */
>  	mtspr	SPRN_MAS2,r11
>  
> -	/* Check page size, if not standard, update MAS1 */
> -	rldicl	r11,r14,64-8,64-8
> -#ifdef CONFIG_PPC_64K_PAGES
> -	cmpldi	cr0,r11,BOOK3E_PAGESZ_64K
> -#else
> -	cmpldi	cr0,r11,BOOK3E_PAGESZ_4K
> -#endif
> -	beq-	1f
> -	mfspr	r11,SPRN_MAS1
> -	rlwimi	r11,r14,31,21,24
> -	rlwinm	r11,r11,0,21,19
> -	mtspr	SPRN_MAS1,r11
> -1:
>  	/* Move RPN in position */
>  	rldicr	r11,r14,64-(PTE_RPN_SHIFT-PAGE_SHIFT),63-PAGE_SHIFT
>  	clrldi	r15,r11,12		/* Clear crap at the top */
