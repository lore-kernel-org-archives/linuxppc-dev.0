Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4zTK5vsnzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 13:47:33 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id gh9so4980409pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 20:47:33 -0700 (PDT)
Date: Thu, 12 May 2016 13:47:22 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2] powerpc/tm: Clean up duplication of code
Message-ID: <20160512134722.1433311d@cotter.ozlabs.ibm.com>
In-Reply-To: <1463024342-16130-1-git-send-email-rashmicy@gmail.com>
References: <1463024342-16130-1-git-send-email-rashmicy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 12 May 2016 13:39:02 +1000
Rashmica Gupta <rashmicy@gmail.com> wrote:

> The same logic for tm_abort appears twice, so pull it out into a
> function.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> ---
> v2: Removed some #ifdefs from inside C code and changed the formatting of the
> comment.
> 
>  arch/powerpc/mm/hash_utils_64.c | 56 +++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 7635b1c6b5da..b92cca033131 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1318,6 +1318,30 @@ out_exit:
>  	local_irq_restore(flags);
>  }
>  
> +	/*
> +	 * Transactions are not aborted by tlbiel, only tlbie.
> +	 * Without, syncing a page back to a block device w/ PIO could pick up
> +	 * transactional data (bad!) so we force an abort here.  Before the
> +	 * sync the page will be made read-only, which will flush_hash_page.
> +	 * BIG ISSUE here: if the kernel uses a page from userspace without
> +	 * unmapping it first, it may see the speculated version.
> +	 */

The comments are not properly aligned to the start of the first column
which it should be for the function

> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +static inline void tlb_flush_abort_tm(int local)
> +{
> +	if (local && cpu_has_feature(CPU_FTR_TM) &&
> +	    current->thread.regs &&
> +	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
> +		tm_enable();
> +		tm_abort(TM_CAUSE_TLBI);
> +	}
> +}
> +#else
> +static inline void tlb_flush_abort_tm(int local)
> +{
> +}

static inline void tlb_flish_abort_tm(int local) {}

But its a personal choice

Other than that

Reviewed-by: Balbir Singh <bsingharora@gmail.com>

> +#endif
> +
>  /* WARNING: This is called from hash_low_64.S, if you change this prototype,
>   *          do not forget to update the assembly call site !
>   */
> @@ -1343,21 +1367,7 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
>  		ppc_md.hpte_invalidate(slot, vpn, psize, psize, ssize, local);
>  	} pte_iterate_hashed_end();
>  
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -	/* Transactions are not aborted by tlbiel, only tlbie.
> -	 * Without, syncing a page back to a block device w/ PIO could pick up
> -	 * transactional data (bad!) so we force an abort here.  Before the
> -	 * sync the page will be made read-only, which will flush_hash_page.
> -	 * BIG ISSUE here: if the kernel uses a page from userspace without
> -	 * unmapping it first, it may see the speculated version.
> -	 */
> -	if (local && cpu_has_feature(CPU_FTR_TM) &&
> -	    current->thread.regs &&
> -	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
> -		tm_enable();
> -		tm_abort(TM_CAUSE_TLBI);
> -	}
> -#endif
> +	tlb_flush_abort_tm(local);
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -1414,21 +1424,7 @@ void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
>  				       MMU_PAGE_16M, ssize, local);
>  	}
>  tm_abort:
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -	/* Transactions are not aborted by tlbiel, only tlbie.
> -	 * Without, syncing a page back to a block device w/ PIO could pick up
> -	 * transactional data (bad!) so we force an abort here.  Before the
> -	 * sync the page will be made read-only, which will flush_hash_page.
> -	 * BIG ISSUE here: if the kernel uses a page from userspace without
> -	 * unmapping it first, it may see the speculated version.
> -	 */
> -	if (local && cpu_has_feature(CPU_FTR_TM) &&
> -	    current->thread.regs &&
> -	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
> -		tm_enable();
> -		tm_abort(TM_CAUSE_TLBI);
> -	}
> -#endif
> +	tlb_flush_abort_tm(local);
>  	return;
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
