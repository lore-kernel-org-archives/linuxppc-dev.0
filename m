Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B5811A0041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 13:10:16 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 4 Jun 2014 23:10:13 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A65C46E8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 23:10:02 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s553AApT1245538
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 03:10:10 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s553AAcM006746
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jun 2014 23:10:10 -0400
Message-ID: <538FDE82.2020105@linux.vnet.ibm.com>
Date: Thu, 05 Jun 2014 08:35:38 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] powerpc/cpuidle: Only clear LPCR decrementer wakeup
 bit on fast sleep entry
References: <1401692223-28337-1-git-send-email-mikey@neuling.org>
In-Reply-To: <1401692223-28337-1-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/2014 12:27 PM, Michael Neuling wrote:
> Currently when entering fastsleep we clear all LPCR PECE bits.
> 
> This patch changes it to only clear the decrementer bit (ie. PECE1), which is
> the only bit we really need to clear here.  This is needed if we want to set
> other wakeup causes like the PECEDH bit so we can use hypervisor doorbells on
> powernv.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 719f6fb..7f7798e 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -73,7 +73,7 @@ static int fastsleep_loop(struct cpuidle_device *dev,
>  		return index;
>  
>  	new_lpcr = old_lpcr;
> -	new_lpcr &= ~(LPCR_MER | LPCR_PECE); /* lpcr[mer] must be 0 */
> +	new_lpcr &= ~(LPCR_MER | LPCR_PECE1); /* lpcr[mer] must be 0 */
>  
>  	/* exit powersave upon external interrupt, but not decrementer
>  	 * interrupt.
You might want to remove this comment and instead simply add
/* Do not exit powersave upon decrementer interrupt */

Besides this, the following line which clears the wakeup from external
interrupt bit can be removed as well, since we are not clearing it anyway ?

 new_lpcr |= LPCR_PECE0
 ^^^

Regards
Preeti U Murthy

> 
