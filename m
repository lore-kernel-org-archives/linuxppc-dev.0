Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28A551A0508
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 14:14:39 +1100 (AEDT)
Message-ID: <1423624478.12568.2.camel@ellerman.id.au>
Subject: Re: [PATCH 1/2] opal: Fix the overflow of message notifiers head array
From: Michael Ellerman <mpe@ellerman.id.au>
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Wed, 11 Feb 2015 14:14:38 +1100
In-Reply-To: <20150210171245.28320.53659.stgit@localhost.localdomain>
References: <20150210171245.28320.53659.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-10 at 22:44 +0530, Neelesh Gupta wrote:

You forgot to write the changelog.

> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/opal.c |   12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index f10b9ec..2651e22 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -305,16 +305,12 @@ void opal_notifier_disable(void)
>  int opal_message_notifier_register(enum OpalMessageType msg_type,
>  					struct notifier_block *nb)
>  {
> -	if (!nb) {
> -		pr_warning("%s: Invalid argument (%p)\n",
> -			   __func__, nb);
> -		return -EINVAL;
> -	}
> -	if (msg_type > OPAL_MSG_TYPE_MAX) {
> -		pr_warning("%s: Invalid message type argument (%d)\n",
> +	if (!nb || msg_type >= OPAL_MSG_TYPE_MAX) {
> +		pr_warning("%s: Invalid arguments, msg_type:%d\n",
>  			   __func__, msg_type);
>  		return -EINVAL;
>  	}
> +
>  	return atomic_notifier_chain_register(
>  				&opal_msg_notifier_head[msg_type], nb);
>  }
> @@ -351,7 +347,7 @@ static void opal_handle_message(void)
>  	type = be32_to_cpu(msg.msg_type);
>  
>  	/* Sanity check */
> -	if (type > OPAL_MSG_TYPE_MAX) {
> +	if (type >= OPAL_MSG_TYPE_MAX) {
>  		pr_warning("%s: Unknown message type: %u\n", __func__, type);
>  		return;
>  	}
> 
