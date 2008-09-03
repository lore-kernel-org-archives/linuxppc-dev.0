Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CB6ADDDDE
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 03:54:37 +1000 (EST)
Message-Id: <65A7E7F2-8106-44EC-BBF5-0CFBDA93462A@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1220018213-12959-2-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2 2/4] powerpc: Fixes for CONFIG_PTE_64BIT for SMP support
Date: Wed, 3 Sep 2008 12:54:29 -0500
References: <1220018213-12959-1-git-send-email-galak@kernel.crashing.org>
	<1220018213-12959-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 29, 2008, at 8:56 AM, Kumar Gala wrote:

> There are some minor issues with support 64-bit PTEs on a 32-bit  
> processor
> when dealing with SMP.
>
> * We need to order the stores in set_pte_at to make sure the flag word
>  is set second.
> * Change pte_clear to use pte_update so only the flag word is cleared
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/include/asm/pgtable-ppc32.h |   14 ++++++++++----
> 1 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/ 
> include/asm/pgtable-ppc32.h
> index 6fe39e3..db2e7bd 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc32.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc32.h
> @@ -517,7 +517,7 @@ extern unsigned long  
> bad_call_to_PMD_PAGE_SIZE(void);
>
> #define pte_none(pte)		((pte_val(pte) & ~_PTE_NONE_MASK) == 0)
> #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
> -#define pte_clear(mm,addr,ptep)	do { set_pte_at((mm), (addr),  
> (ptep), __pte(0)); } while (0)
> +#define pte_clear(mm,addr,ptep)	do { pte_update(ptep, ~0, 0); }  
> while (0)

This breaks classic... Need to avoid changing PAGE_HASHPTE.

Cheers,
-Becky
