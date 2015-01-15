Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7ABF41A0C33
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 06:44:22 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 14:44:17 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 254316E8047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 14:36:09 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0FJiG1u24510494
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 19:44:16 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0FJiF15012728
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 14:44:15 -0500
Message-ID: <54B8188D.1060907@linux.vnet.ibm.com>
Date: Thu, 15 Jan 2015 11:44:13 -0800
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH] pseries/le: Fix another endiannes issue in RTAS call
 from xmon
References: <1421295950.11409.3.camel@ellerman.id.au>
 <1421342627-7214-1-git-send-email-ldufour@linux.vnet.ibm.com>
In-Reply-To: <1421342627-7214-1-git-send-email-ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/15/2015 09:23 AM, Laurent Dufour wrote:
> The commit 3b8a3c010969 ("powerpc/pseries: Fix endiannes issue in RTAS
> call from xmon") was fixing an endianness issue in the call made from
> xmon to RTAS.
> 
> However, as Michael Ellerman noticed, this fix was not complete, the
> token value was not byte swapped. This lead to call an unexpected and
> most of the time unexisting RTAS function, which is silently ignored
> by RTAS.

Nit. Not so much that is silently ignored by RTAS as much as
disable_surveillance silently doesn't check the return status of the
RTAS call. Maybe a check is warranted and reporting of non-success.

-Tyrel

> 
> This fix addresses this hole.
> 
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Cc: stable@vger.kernel.org
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  arch/powerpc/xmon/xmon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 5b150f0c5df9..13c6e200b24e 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -337,6 +337,7 @@ static inline void disable_surveillance(void)
>  	args.token = rtas_token("set-indicator");
>  	if (args.token == RTAS_UNKNOWN_SERVICE)
>  		return;
> +	args.token = cpu_to_be32(args.token);
>  	args.nargs = cpu_to_be32(3);
>  	args.nret = cpu_to_be32(1);
>  	args.rets = &args.args[3];
> 
