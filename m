Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BA7B1A0010
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 20:47:50 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 12 Feb 2015 19:47:48 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5AA8C3578068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 20:47:45 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1C9lb6V18022578
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 20:47:45 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1C9lBcq017952
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 20:47:11 +1100
Message-ID: <54DC768F.1090504@linux.vnet.ibm.com>
Date: Thu, 12 Feb 2015 15:16:55 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH 2/3] powerpc/powernv: only call OPAL_ELOG_RESEND if
 firmware supports it
References: <1423718729-17992-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1423718729-17992-3-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1423718729-17992-3-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/12/2015 10:55 AM, Stewart Smith wrote:
> Otherwise firmware complains: "OPAL: Called with bad token 74 !"
> as not all OPAL systems have the ability to resend error logs.
> 
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>


Acked-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

-Vasant



> ---
>  arch/powerpc/platforms/powernv/opal-elog.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
> index 518fe95..38ce757 100644
> --- a/arch/powerpc/platforms/powernv/opal-elog.c
> +++ b/arch/powerpc/platforms/powernv/opal-elog.c
> @@ -313,7 +313,8 @@ int __init opal_elog_init(void)
>  	}
>  
>  	/* We are now ready to pull error logs from opal. */
> -	opal_resend_pending_logs();
> +	if (opal_check_token(OPAL_ELOG_RESEND))
> +		opal_resend_pending_logs();
>  
>  	return 0;
>  }
> 
