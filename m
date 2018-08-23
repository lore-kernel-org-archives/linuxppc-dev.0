Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wvzH1V0FzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 16:44:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RESEND PATCH v2] powerpc/mce: Fix SLB rebolting during MCE
 recovery path.
In-Reply-To: <153500619258.20614.8965724795728734200.stgit@jupiter.in.ibm.com>
References: <153500619258.20614.8965724795728734200.stgit@jupiter.in.ibm.com>
Date: Thu, 23 Aug 2018 16:44:42 +1000
Message-ID: <87d0u9lgyt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> With the powerpc next commit e7e81847478 (powerpc/mce: Fix SLB rebolting
> during MCE recovery path.),

That commit description is wrong, I'll fix it up.

cheers

> the SLB error recovery is broken. The new
> change now does not add index value to RB[52-63] that selects the SLB
> entry while rebolting, instead it assumes that the shadow save area
> already have index embeded correctly in esid field. While all valid bolted
> save areas do contain index value set correctly, there is a case where
> 3rd (KSTACK_INDEX) entry for kernel stack does not embed index for NULL
> esid entry. This patch fixes that.
>
> Without this patch the SLB rebolt code overwrites the 1st entry of kernel
> linear mapping and causes SLB recovery to fail.
>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/slb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 0b095fa54049..9f574e59d178 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -70,7 +70,7 @@ static inline void slb_shadow_update(unsigned long ea, int ssize,
>  
>  static inline void slb_shadow_clear(enum slb_index index)
>  {
> -	WRITE_ONCE(get_slb_shadow()->save_area[index].esid, 0);
> +	WRITE_ONCE(get_slb_shadow()->save_area[index].esid, cpu_to_be64(index));
>  }
>  
>  static inline void create_shadowed_slbe(unsigned long ea, int ssize,
