Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7sMX1wv9zDqJs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 18:23:36 +1000 (AEST)
Date: Thu, 20 Apr 2017 18:23:15 +1000
From: Anton Blanchard <anton@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, Madhavan
 Srinivasan <masriniv@in.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/mm/radix: Optimize tlbiel flush
Message-ID: <20170420182315.4fce69b0@kryten>
In-Reply-To: <1492673305-29526-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1492673305-29526-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Hi Aneesh,

> For a page walk cache flush, we don't need to loop with set number.
> The set number is ignored with RIC=1 (pwc flush).
> 
> For RIC=2 (flush all), inorder to flush implementation dependent
> caches, we can ignore the set number. Hence we do a RIC=2 flush with
> set no: 0, so we do both the tlb flush for set 0 and the
> implementation dependent cache flushes. This is then followed with
> tbl flush for set 1-127

I've applied your two previous radix tlbiel optimisations as my
baseline, and using the simple exec microbenchmark in a7a9dcd882a6 I
see:

HPT:            100%
Radix baseline: 248%
Radix patched:   95%

So this patch fixes the large regression we see with radix, and is even
faster than our HPT number now. Nice work!

Acked-by: Anton Blanchard <anton@samba.org>

Anton

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> Note: not yet tested.
> 
>  arch/powerpc/mm/tlb-radix.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index b68b5219cf45..b827aef38b90 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -43,12 +43,30 @@ static inline void __tlbiel_pid(unsigned long
> pid, int set, */
>  static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
>  {
> -	int set;
> +	int set = 0;
>  
>  	asm volatile("ptesync": : :"memory");
> -	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
> -		__tlbiel_pid(pid, set, ric);
> +	if (ric == RIC_FLUSH_ALL) {
> +		ric = RIC_FLUSH_TLB;
> +		set = 1;
> +		/* Use set 0 to flush all */
> +		__tlbiel_pid(pid, 0, RIC_FLUSH_ALL);
>  	}
> +
> +	for (; set < POWER9_TLB_SETS_RADIX ; set++)
> +		__tlbiel_pid(pid, set, ric);
> +
> +	asm volatile("ptesync": : :"memory");
> +	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
> +}
> +
> +static inline void _tlbiel_pwc(unsigned long pid)
> +{
> +	asm volatile("ptesync": : :"memory");
> +	/*
> +	 * for PWC flush, we don't look at set number
> +	 */
> +	__tlbiel_pid(pid, 0, RIC_FLUSH_PWC);
>  	asm volatile("ptesync": : :"memory");
>  	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
>  }
> @@ -140,7 +158,7 @@ void radix__local_flush_tlb_pwc(struct mmu_gather
> *tlb, unsigned long addr) 
>  	pid = mm->context.id;
>  	if (pid != MMU_NO_CONTEXT)
> -		_tlbiel_pid(pid, RIC_FLUSH_PWC);
> +		_tlbiel_pwc(pid);
>  
>  	preempt_enable();
>  }
> @@ -222,7 +240,7 @@ void radix__flush_tlb_pwc(struct mmu_gather *tlb,
> unsigned long addr) if (lock_tlbie)
>  			raw_spin_unlock(&native_tlbie_lock);
>  	} else
> -		_tlbiel_pid(pid, RIC_FLUSH_PWC);
> +		_tlbiel_pwc(pid);
>  no_context:
>  	preempt_enable();
>  }
