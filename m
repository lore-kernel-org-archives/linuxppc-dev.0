Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LMGr5MvszF1NW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 23:27:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bharat Bhushan <Bharat.Bhushan@nxp.com>, benh@kernel.crashing.org,
 paulus@samba.org, robh@kernel.org, geoff@infradead.org,
 tyreld@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: Re: [PATCH] powerpc/mpic: Cleanup irq vector accounting
In-Reply-To: <1530267872-31244-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1530267872-31244-1-git-send-email-Bharat.Bhushan@nxp.com>
Date: Wed, 04 Jul 2018 23:27:15 +1000
Message-ID: <87efgjku6k.fsf@concordia.ellerman.id.au>
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

Bharat Bhushan <Bharat.Bhushan@nxp.com> writes:

> Available vector space accounts ipis and timer interrupts
> while spurious vector was not accounted.

OK. What is the symptom of that? Nothing? Total system crash?

Looks like this can be tagged:

Fixes: 0a4081641d72 ("powerpc/mpic: FSL MPIC error interrupt support.")

Which added the code that uses "12".

> Also later
> mpic_setup_error_int() escape one more vector, seemingly it
> assumes one spurious vector.

Ah right, I get it now.

So there is no bug. It's just a disagreement about whether the "intvec"
argument to mpic_setup_error_int() indicates the first number that's
free to use or the last number that has been allocated.

Right?

cheers

> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
>  arch/powerpc/sysdev/fsl_mpic_err.c | 2 +-
>  arch/powerpc/sysdev/mpic.c         | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c b/arch/powerpc/sysdev/fsl_mpic_err.c
> index 488ec45..2a98837 100644
> --- a/arch/powerpc/sysdev/fsl_mpic_err.c
> +++ b/arch/powerpc/sysdev/fsl_mpic_err.c
> @@ -76,7 +76,7 @@ int mpic_setup_error_int(struct mpic *mpic, int intvec)
>  	mpic->flags |= MPIC_FSL_HAS_EIMR;
>  	/* allocate interrupt vectors for error interrupts */
>  	for (i = MPIC_MAX_ERR - 1; i >= 0; i--)
> -		mpic->err_int_vecs[i] = --intvec;
> +		mpic->err_int_vecs[i] = intvec--;
>  
>  	return 0;
>  }
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 1d4e0ef6..e098d1e 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1380,12 +1380,12 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  		 * global vector number space, as in case of ipis
>  		 * and timer interrupts.
>  		 *
> -		 * Available vector space = intvec_top - 12, where 12
> +		 * Available vector space = intvec_top - 13, where 13
>  		 * is the number of vectors which have been consumed by
> -		 * ipis and timer interrupts.
> +		 * ipis, timer interrupts and spurious.
>  		 */
>  		if (fsl_version >= 0x401) {
> -			ret = mpic_setup_error_int(mpic, intvec_top - 12);
> +			ret = mpic_setup_error_int(mpic, intvec_top - 13);
>  			if (ret)
>  				return NULL;
>  		}
> -- 
> 1.9.3
