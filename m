Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BA301A05F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 13:21:05 +1100 (AEDT)
Message-ID: <1449800465.21866.6.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/powernv: pr_warn_once on unsupported OPAL_MSG type
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: =?UTF-8?Q?=E8=92=B2=E6=96=87?= <wen.pu@powercore.com.cn>
Date: Fri, 11 Dec 2015 13:21:05 +1100
In-Reply-To: <1449796103-7700-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1449796103-7700-1-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-12-11 at 12:08 +1100, Stewart Smith wrote:
> When running on newer OPAL firmware that supports sending extra
> OPAL_MSG types, we would print a warning on *every* message received.
> 
> This could be a problem for kernels that don't support OPAL_MSG_OCC
> on machines that are running real close to thermal limits and the
> OCC is throttling the chip. For a kernel that is paying attention to
> the message queue, we could get these notifications quite often.
> 
> Conceivably, future message types could also come fairly often,
> and printing that we didn't understand them 10,000 times provides
> no further information than printing them once.
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 4296d55e88f3..57cffb80bc36 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -278,7 +278,7 @@ static void opal_handle_message(void)
>  
>  	/* Sanity check */
>  	if (type >= OPAL_MSG_TYPE_MAX) {
> -		pr_warning("%s: Unknown message type: %u\n", __func__, type);
> +		pr_warn_once("%s: Unknown message type: %u\n", __func__, type);
>  		return;

This will only print once, even if there are multiple unknown message types,
are we happy with that?

cheers
