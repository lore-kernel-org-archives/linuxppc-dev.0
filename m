Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZFdb6xGdzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 02:52:03 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 29 Mar 2016 11:52:01 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 350F9C90045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 11:51:54 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2TFpwlM38142012
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 15:51:58 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2TFpviw021903
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 11:51:57 -0400
Subject: Re: [PATCH V2 2/2] pseries/eeh: Handle RTAS delay requests in
 configure_bridge
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <1459219911-14110-1-git-send-email-ruscur@russell.cc>
 <1459219911-14110-2-git-send-email-ruscur@russell.cc>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Message-ID: <56FAA49A.6050703@linux.vnet.ibm.com>
Date: Tue, 29 Mar 2016 08:51:54 -0700
MIME-Version: 1.0
In-Reply-To: <1459219911-14110-2-git-send-email-ruscur@russell.cc>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/28/2016 07:51 PM, Russell Currey wrote:
> In the configure_pe and configure_bridge RTAS calls, the spec states
> that values of 9900-9905 can be returned, indicating that software
> should delay for 10^x (where x is the last digit, i.e. 990x)
> milliseconds and attempt the call again. Currently, the kernel doesn't
> know about this, and respecting it fixes some PCI failures when the
> hypervisor is busy.
> 
> The delay is capped at 0.2 seconds.
> 
> Cc: <stable@vger.kernel.org> # 3.10-
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
> V2: Use rtas_busy_delay and the new ibm_configure_pe token, refactoring
> ---
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 35 +++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index 231b1df..c442b11 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -619,20 +619,43 @@ static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
>  {
>  	int config_addr;
>  	int ret;
> +	/* Waiting 0.2s maximum before skipping configuration */
> +	int max_wait = 200;
> +	int mwait;
>  
>  	/* Figure out the PE address */
>  	config_addr = pe->config_addr;
>  	if (pe->addr)
>  		config_addr = pe->addr;
>  
> -	ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
> -			config_addr, BUID_HI(pe->phb->buid),
> -			BUID_LO(pe->phb->buid));
> +	while (max_wait > 0) {
> +		ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
> +				config_addr, BUID_HI(pe->phb->buid),
> +				BUID_LO(pe->phb->buid));
>  
> -	if (ret)
> -		pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
> -			__func__, pe->phb->global_number, pe->addr, ret);
> +		/*
> +		 * RTAS can return a delay value of up to 10^5 milliseconds
> +		 * (RTAS_EXTENDED_DELAY_MAX), which is too long.  Only respect
> +		 * the delay if it's 100ms or less.
> +		 */

Your changelog says the delay is capped at 0.2s. However, your comment
in the code mentions the full 10^5ms based on the 9900-9905 codes. It
would probably be best to expand you comment to mention in the code that
you are only handling 9900-9902 to eliminate the confusion of looking at
the above comment vs below implementation.

Further, despite PAPRs software note that the long busy should be
limited to 9900-9902 you might want to add a catch to your switch to log
any unexpected 9903-9905 or just treat them as max 0.2s delay. Firmware
has been know to do things on occasion that the spec says it shouldn't,
and it might not be obvious at first should you receive one of the
longer delay codes why we are going down the error path.

-Tyrel

>  
> +		switch (ret) {
> +		case 0:
> +			return ret;
> +		case RTAS_EXTENDED_DELAY_MIN:
> +		case RTAS_EXTENDED_DELAY_MIN+1:
> +		case RTAS_EXTENDED_DELAY_MIN+2:
> +			mwait = rtas_busy_delay(ret);
> +			break;
> +		default:
> +			goto err;
> +		}
> +
> +		max_wait -= mwait;
> +	}
> +err:
> +	pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
> +		__func__, pe->phb->global_number, pe->addr, ret);
>  	return ret;
>  }
>  
> 
