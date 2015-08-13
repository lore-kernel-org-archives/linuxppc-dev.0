Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0142.outbound.protection.outlook.com [207.46.100.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8C5B1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 04:45:00 +1000 (AEST)
Message-ID: <1439491483.4099.101.camel@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/e6500: hw tablewalk: optimize a bit for tcd
 lock acquiring codes
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 13 Aug 2015 13:44:43 -0500
In-Reply-To: <1439466697-18989-2-git-send-email-haokexin@gmail.com>
References: <1439466697-18989-1-git-send-email-haokexin@gmail.com>
 <1439466697-18989-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-13 at 19:51 +0800, Kevin Hao wrote:
> It makes no sense to put the instructions for calculating the lock
> value (cpu number + 1) and the clearing of eq bit of cr1 in lbarx/stbcx
> loop. And when the lock is acquired by the other thread, the current
> lock value has no chance to equal with the lock value used by current
> cpu. So we can skip the comparing for these two lock values in the
> lbz/bne loop.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  arch/powerpc/mm/tlb_low_64e.S | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
> index 765b419883f2..e4185581c5a7 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -308,11 +308,11 @@ BEGIN_FTR_SECTION               /* CPU_FTR_SMT */
>        *
>        * MAS6:IND should be already set based on MAS4
>        */
> -1:   lbarx   r15,0,r11
>       lhz     r10,PACAPACAINDEX(r13)
> -     cmpdi   r15,0
> -     cmpdi   cr1,r15,1       /* set cr1.eq = 0 for non-recursive */
>       addi    r10,r10,1
> +     crclr   cr1*4+eq        /* set cr1.eq = 0 for non-recursive */
> +1:   lbarx   r15,0,r11
> +     cmpdi   r15,0
>       bne     2f

You're optimizing the contended case at the expense of introducing stalls in 
the uncontended case.  Does it really matter if there are more instructions 
in the loop?  This change just means that you'll spin in the loop for more 
iterations (if it even does that -- I think the cycles per loop iteration 
might be the same before and after, due to load latency and pairing) while 
waiting for the other thread to release the lock.

Do you have any benchmark results for this patch?

-Scott
