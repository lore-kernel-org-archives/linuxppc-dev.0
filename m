Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CBF48B7B79
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 14:24:49 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2ADD6DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 14:24:48 +1000 (EST)
Subject: Re: [PATCH 1/3 v3] powerpc/32: Always order writes to halves of
	64-bit PTEs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 18 Aug 2009 14:24:42 +1000
Message-Id: <1250569482.19007.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-08-18 at 09:00 +1000, Paul Mackerras wrote:
> On 32-bit systems with 64-bit PTEs, the PTEs have to be written in two
> 32-bit halves.  On SMP we write the higher-order half and then the
> lower-order half, with a write barrier between the two halves, but on
> UP there was no particular ordering of the writes to the two halves.
> 
> This extends the ordering that we already do on SMP to the UP case as
> well.  The reason is that with the perf_counter subsystem potentially
> accessing user memory at interrupt time to get stack traces, we have
> to be careful not to create an incorrect but apparently valid PTE even
> on UP.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
> ---
>  arch/powerpc/include/asm/pgtable.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index eb17da7..2a5da06 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -104,8 +104,8 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  	else
>  		pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte));
>  
> -#elif defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP)
> -	/* Second case is 32-bit with 64-bit PTE in SMP mode. In this case, we
> +#elif defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
> +	/* Second case is 32-bit with 64-bit PTE.  In this case, we
>  	 * can just store as long as we do the two halves in the right order
>  	 * with a barrier in between. This is possible because we take care,
>  	 * in the hash code, to pre-invalidate if the PTE was already hashed,
> @@ -140,7 +140,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  
>  #else
>  	/* Anything else just stores the PTE normally. That covers all 64-bit
> -	 * cases, and 32-bit non-hash with 64-bit PTEs in UP mode
> +	 * cases, and 32-bit non-hash with 32-bit PTEs.
>  	 */
>  	*ptep = pte;
>  #endif
