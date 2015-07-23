Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0B5C1A023A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 10:24:54 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 22 Jul 2015 20:24:51 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4DBC638C8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 20:24:49 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N0Om9762849160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 00:24:49 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N0OmVt015899
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 20:24:48 -0400
Message-ID: <55B0344F.3060008@linux.vnet.ibm.com>
Date: Wed, 22 Jul 2015 17:24:47 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>, linuxppc-dev@lists.ozlabs.org
CC: paulus@samba.org
Subject: Re: [PATCH] powerpc/rtas: Replace magic values with defines
References: <1437584207-20677-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1437584207-20677-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2015 09:56 AM, Thomas Huth wrote:
> rtas.h already has some nice #defines for RTAS return status
> codes - let's use them instead of hard-coded "magic" values!
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/rtas.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 7a488c1..10fb402 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -478,8 +478,9 @@ unsigned int rtas_busy_delay_time(int status)
>  
>  	if (status == RTAS_BUSY) {
>  		ms = 1;
> -	} else if (status >= 9900 && status <= 9905) {
> -		order = status - 9900;
> +	} else if (status >= RTAS_EXTENDED_DELAY_MIN &&
> +		   status <= RTAS_EXTENDED_DELAY_MAX) {
> +		order = status - RTAS_EXTENDED_DELAY_MIN;
>  		for (ms = 1; order > 0; order--)
>  			ms *= 10;
>  	}
> @@ -641,7 +642,8 @@ int rtas_set_indicator_fast(int indicator, int index, int new_value)
>  
>  	rc = rtas_call(token, 3, 1, NULL, indicator, index, new_value);
>  
> -	WARN_ON(rc == -2 || (rc >= 9900 && rc <= 9905));
> +	WARN_ON(rc == RTAS_BUSY || (rc >= RTAS_EXTENDED_DELAY_MIN &&
> +				    rc <= RTAS_EXTENDED_DELAY_MAX));
>  
>  	if (rc < 0)
>  		return rtas_error_rc(rc);
> 
